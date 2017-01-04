<?php

/**
 * Description of TestDemo
 *
 * @author Fathoni
 * @property User_model $user_model
 * @property Setting_model $setting_model
 * @property Soal_model $soal_model Description
 * @property CI_Cache $cache Description
 */
class Test_guest extends USER_Controller
{
	const GUEST_SESSION = 'guest_session';
	
	function __construct()
	{
		parent::__construct();
		
		$this->load->driver('cache');
		
		$this->load->model('user_model');
		$this->load->model('setting_model');
		$this->load->model('soal_model');
	}
	
	function pre_start()
	{		
		// Ambil setting id_form_soal yang di set
		$id_form_soal = $this->setting_model->get_value('id_form_soal_contoh');
		
		if ($this->input->method() == 'post')
		{
			$guest_session = new stdClass();
			$guest_session->session_id	= session_id();
			$guest_session->ip_address	= $this->input->ip_address();
			$guest_session->nama		= $this->input->post('nama');
			$guest_session->email		= $this->input->post('email');
			$guest_session->id_form_soal = $id_form_soal;
			$guest_session->start_time	= date('Y-m-d H:i:s');
			
			// Start Session (DB)
			$this->user_model->save_guest_session($guest_session);
			
			// Simpan ke variabel session
			$this->session->set_userdata(Test_guest::GUEST_SESSION, $guest_session);
			
			redirect('test-guest/soal');
			exit();
		}
		
		$guest_session = $this->session->userdata(Test_guest::GUEST_SESSION);
		
		if ($guest_session != NULL)
		{
			$this->user_model->refresh_guest_session($guest_session);
			
			// Batalkan redirect jika telah lewat
			if (time() > strtotime($guest_session->end_time))
			{
				// Update DB
				$this->user_model->end_guest_session($guest_session->id_guest_session);
				// Remove Session
				$this->session->unset_userdata(Test_guest::GUEST_SESSION);
				// Remove object
				$guest_session = NULL;	
			}

		}	
		
		// Jika masih ada, redirect ke soal
		if ($guest_session)
		{
			redirect('test-guest/soal');
		}
		
		$this->smarty->display();
	}
	
	function soal($no_soal = 1)
	{
		// Ambil sesi guest yang sudah ada
		$guest_session = $this->session->userdata(Test_guest::GUEST_SESSION);
		
		// Refresh data dari db
		$this->user_model->refresh_guest_session($guest_session);
		
		if ($guest_session != NULL)
		{
			$soal = $this->soal_model->get_soal_by_no($guest_session->id_form_soal, $no_soal);

			$jumlah_soal = $this->soal_model->count_soal($guest_session->id_form_soal);
			
			$jawaban_guest = $this->user_model->get_jawaban_guest($guest_session->id_guest_session, $guest_session->id_form_soal, $soal->id_soal);
			
			$guest_session->jumlah_dijawab = $this->user_model->count_jawaban_guest($guest_session->id_guest_session,  $guest_session->id_form_soal);
			$guest_session->jawaban_user_set = $this->user_model->list_jawaban_guest($guest_session->id_guest_session, $guest_session->id_form_soal);
			
			// Nomer soal
			$this->smarty->assign('no_soal', $no_soal);
			$this->smarty->assign('no_soal_prev', $no_soal - 1);
			$this->smarty->assign('no_soal_next', $no_soal + 1);
			
			// variabel object
			$this->smarty->assign('soal', $soal);
			$this->smarty->assign('jumlah_soal', $jumlah_soal);
			$this->smarty->assign('jawaban_user', $jawaban_guest);
			$this->smarty->assign('test_session', $guest_session);
			
			// Link
			$this->smarty->assign('end_session_url', site_url('test-guest/end-session'));
			$this->smarty->assign('soal_url', site_url('test-guest/soal'));
			$this->smarty->assign('jawab_soal_url', site_url('test-guest/jawab-soal'));
			$this->smarty->assign('set_ragu_url', site_url('test-guest/set-ragu'));
			
			$this->smarty->display('test/soal.tpl');
		}
		else
		{
			redirect('test-guest/pre-start');
		}
		
	}
	
	function jawab_soal()
	{
		$guest_session = $this->session->userdata(Test_guest::GUEST_SESSION);
		
		// Pastikan punya session & method post
		if ($guest_session != NULL && $this->input->method() == 'post')
		{
			$waktu_jawab = date('Y-m-d H:i:s');
			
			$jawaban_guest = new stdClass();
			$jawaban_guest->id_guest_session	= $guest_session->id_guest_session;
			$jawaban_guest->id_form_soal		= $guest_session->id_form_soal;
			$jawaban_guest->id_soal				= $this->input->post('id_soal');
			$jawaban_guest->id_jawaban_soal		= $this->input->post('id_jawaban_soal');
			$jawaban_guest->waktu_jawab			= $waktu_jawab;
			
			$jawaban_guest_exist = $this->user_model->get_jawaban_guest($jawaban_guest->id_guest_session, $jawaban_guest->id_form_soal, $jawaban_guest->id_soal);
			
			// Jika belum ada, maka INSERT
			if ($jawaban_guest_exist == NULL)
			{
				$result = $this->user_model->add_jawaban_guest($jawaban_guest);
			}
			// Jika sudah ada, maka UPDATE
			else
			{
				$result = $this->user_model->update_jawaban_guest($jawaban_guest_exist->id_jawaban_guest, $jawaban_guest);
			}
			
			// Ambil jumlah soal terjawab
			$jumlah_dijawab = $this->user_model->count_jawaban_guest($guest_session->id_guest_session, $guest_session->id_form_soal);
			
		}
		
		// Force as json
		header("Content-type: application/json");
		
		if ($result)
			echo '{"status":1,"jumlah_dijawab":'.$jumlah_dijawab.'}';
		else
			echo '{"status":0,"jumlah_dijawab":'.$jumlah_dijawab.'}';
	}
	
	function set_ragu()
	{
		if ($this->input->method() == 'post')
		{
			$guest_session = $this->session->userdata(Test_guest::GUEST_SESSION);
			
			// Update sesuai checked-nya
			$is_ragu = $this->input->post('checked') == 'true' ? 1 : 0;
			
			$jawaban_guest = $this->user_model->get_jawaban_guest(
				$guest_session->id_guest_session, 
				$guest_session->id_form_soal, 
				$this->input->post('id_soal'));
			
			// Update is ragu
			$jawaban_guest->is_ragu = $is_ragu;
			$jawaban_guest->waktu_jawab = date('Y-m-d H:i:s');
			
			// Update ke db
			$this->user_model->update_jawaban_guest($jawaban_guest->id_jawaban_guest, $jawaban_guest);
			
			// Force as json
			header("Content-type: application/json");
		
			echo json_encode($jawaban_guest);
		}
	}
	
	function end_session()
	{
		$guest_session = $this->session->userdata(Test_guest::GUEST_SESSION);
		
		$this->user_model->end_guest_session($guest_session->id_guest_session);
		
		// Proses kirim email
		$this->send_test_guest_result($guest_session->id_guest_session);
		
		// Ambil ID, karena session akan di destroy
		$id_guest_sesion = $guest_session->id_guest_session;
		
		$this->session->unset_userdata(Test_guest::GUEST_SESSION);
		
		// url : /user/home/
		redirect('test-guest/test-result/'.$id_guest_sesion);
	}
	
	/**
	 * @param int $id guest_session.id_guest_session
	 */
	function test_result($id_guest_session)
	{
		$guest_session_set = $this->user_model->list_guest_session_finished($id_guest_session);
		$this->smarty->assign('test_session_set', $guest_session_set);
		
		$this->smarty->display();
	}
	
	function test_result_list()
	{
		setlocale(LC_TIME, 'id_ID');
		$guest_session_set = $this->user_model->list_guest_session_finished();
		
		foreach ($guest_session_set as &$gs)
		{
			// Format elapsed time
			$gs->start_time_elapsed = $this->time_elapsed_string($gs->start_time);
		}
		
		$this->smarty->assign('guest_session_set', $guest_session_set);
		$this->smarty->display();
	}
	
	private function time_elapsed_string($datetime, $full = false) 
	{
		$now = new DateTime;
		$ago = new DateTime($datetime);
		$diff = $now->diff($ago);

		$diff->w = floor($diff->d / 7);
		$diff->d -= $diff->w * 7;

		$string = array(
			'y' => 'thn',
			'm' => 'bln',
			'w' => 'minggu',
			'd' => 'hari',
			'h' => 'jam',
			'i' => 'menit',
			's' => 'detik',
		);
		foreach ($string as $k => &$v) {
			if ($diff->$k) {
				$v = $diff->$k . ' ' . $v . ($diff->$k > 1 ? '' : '');
			} else {
				unset($string[$k]);
			}
		}

		if (!$full) $string = array_slice($string, 0, 1);
		return $string ? implode(', ', $string) . ' yg lalu' : 'just now';
	}
	
	private function send_test_guest_result($id_guest_session)
	{
		$this->load->library('email');
		
		$guest_session_set = $this->user_model->list_guest_session_finished($id_guest_session);
		$this->smarty->assign('test_session_set', $guest_session_set);
		
		$email = $guest_session_set[0]->email;
		$subject = "Hasil pengerjaan ".$guest_session_set[0]->form_soal->nama_form;
		$body = $this->smarty->fetch('email/result_test_guest.tpl');
		
		$this->email->from('no-reply@pediukdi.com', 'PEDIUKDI');
		$this->email->to($email);
		$this->email->subject($subject);
		$this->email->message($body);
		return $this->email->send();
	}
}
