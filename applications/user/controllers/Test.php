<?php

/**
 * Description of Test
 *
 * @author Fathoni
 * @property Pembayaran_model $pembayaran_model Description
 * @property User_model $user_model Description
 * @property Soal_model $soal_model
 */
class Test extends USER_Controller
{
	public function __construct()
	{
		parent::__construct();
		
		$this->check_credentials();
		
		$this->load->model('user_model');
		$this->load->model('pembayaran_model');
		$this->load->model('soal_model');
	}
	
	function pre_start()
	{
		if ($this->input->method() == 'post')
		{
			$user = $this->session->userdata('user');
			
			// Ambil Pembayaran Aktif
			$pembayaran_aktif = $this->pembayaran_model->get_pembayaran_aktif($user->id_user);
			
			$start_time = date('Y-m-d H:i:s');
			
			// Start Session
			$this->user_model->start_test_session($pembayaran_aktif->id_jadwal_test, $user->id_user, $start_time);
			
			redirect('test/soal');
		}
		
		$this->smarty->display();
	}
	
	function soal($no_soal = 1)
	{
		$user = $this->session->userdata('user');
		$test_session = $this->user_model->get_test_session($user->id_user);
		
		// Jika ada Test Session : bisa ditampilkan
		if ($test_session != NULL)
		{
			$soal = $this->soal_model->get_soal_by_no($test_session->id_form_soal, $no_soal);
			
			$jumlah_soal = $this->soal_model->count_soal($test_session->id_form_soal);
			
			$jawaban_user = $this->user_model->get_jawaban_user($user->id_user, $test_session->id_jadwal_test, $test_session->id_form_soal, $soal->id_soal);
			
			$test_session->jumlah_dijawab = $this->user_model->count_jawaban_user($user->id_user, $test_session->id_jadwal_test,  $test_session->id_form_soal);
			$test_session->jawaban_user_set = $this->user_model->list_jawaban_user($user->id_user, $test_session->id_jadwal_test, $test_session->id_form_soal);
			
			$this->smarty->assign('no_soal', $no_soal);
			$this->smarty->assign('no_soal_prev', $no_soal - 1);
			$this->smarty->assign('no_soal_next', $no_soal + 1);
			
			$this->smarty->assign('soal', $soal);
			$this->smarty->assign('jumlah_soal', $jumlah_soal);
			$this->smarty->assign('jawaban_user', $jawaban_user);
			$this->smarty->assign('test_session', $test_session);
			$this->smarty->assign('user', $user);
			
			$this->smarty->assign('end_session_url', site_url('test/end-session'));
			$this->smarty->assign('soal_url', site_url('test/soal'));
			$this->smarty->assign('jawab_soal_url', site_url('test/jawab-soal'));
			$this->smarty->assign('set_ragu_url', site_url('test/set-ragu'));
			
			$this->smarty->display();
		}
		else
		{
			redirect('home');
		}
	}
	
	function jawab_soal()
	{
		if ($this->input->method() == 'post')
		{
			$user = $this->session->userdata('user');
			
			$test_session = $this->user_model->get_test_session($user->id_user);
			
			$waktu_jawab = date('Y-m-d H:i:s');
			
			$jawaban_user = new stdClass();
			$jawaban_user->id_user			= $user->id_user;
			$jawaban_user->id_jadwal_test	= $test_session->id_jadwal_test;
			$jawaban_user->id_form_soal		= $test_session->id_form_soal;
			$jawaban_user->id_soal			= $this->input->post('id_soal');
			$jawaban_user->id_jawaban_soal	= $this->input->post('id_jawaban_soal');
			$jawaban_user->waktu_jawab		= $waktu_jawab;
			
			// Ambil jawaban sebelumnya
			$jawaban_user_exist = $this->user_model->get_jawaban_user(
				$jawaban_user->id_user,
				$jawaban_user->id_jadwal_test,
				$jawaban_user->id_form_soal,
				$jawaban_user->id_soal);
			
			// Jika belum ada, maka INSERT
			if ($jawaban_user_exist == NULL)
			{
				$result = $this->user_model->add_jawaban($jawaban_user);
			}
			// Jika sudah ada, maka UPDATE
			else
			{
				$result = $this->user_model->update_jawaban($jawaban_user_exist->id_jawaban_user, $jawaban_user);
			}
			
			// Ambil jumlah soal terjawab
			$jumlah_dijawab = $this->user_model->count_jawaban_user($jawaban_user->id_user, $jawaban_user->id_jadwal_test, $jawaban_user->id_form_soal);
			
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
			$user = $this->session->userdata('user');
			
			$test_session = $this->user_model->get_test_session($user->id_user);
			
			// Update sesuai checked-nya
			$is_ragu = $this->input->post('checked') == 'true' ? 1 : 0;
			
			// Ambil jawaban sebelumnya
			$jawaban_user = $this->user_model->get_jawaban_user(
				$user->id_user, 
				$test_session->id_jadwal_test, 
				$test_session->id_form_soal, 
				$this->input->post('id_soal'));
			
			// Update is ragu
			$jawaban_user->is_ragu = $is_ragu;
			$jawaban_user->waktu_jawab = date('Y-m-d H:i:s');
			
			// Update ke db
			$this->user_model->update_jawaban($jawaban_user->id_jawaban_user, $jawaban_user);
			
			// Force as json
			header("Content-type: application/json");
		
			echo json_encode($jawaban_user);
		}
	}
	
	function end_session()
	{
		$user = $this->session->userdata('user');
			
		$test_session = $this->user_model->get_test_session($user->id_user);
		
		// Send email
		$this->send_test_result($test_session->id_test_session);
		
		$this->user_model->end_session($test_session->id_test_session);
		
		redirect('test/test-result');
	}
	
	function test_result()
	{
		// lokal indonesia
		setlocale(LC_TIME, 'id_ID');
		
		$user = $this->session->userdata('user');
		
		$test_session_set = $this->user_model->list_test_session_finished($user->id_user);
		$this->smarty->assign('test_session_set', $test_session_set);
		
		$this->smarty->display();
	}
	
	private function send_test_result($id_test_session)
	{	
		$this->load->library('email');
		
		$user = $this->session->userdata('user');
		
		$test_session_set = $this->user_model->list_test_session_finished($user->id_user, $id_test_session);
		$this->smarty->assign('test_session_set', $test_session_set);
		
		$email = $test_session_set[0]->email;
		$subject = "Hasil pengerjaan ".$test_session_set[0]->form_soal->nama_form;
		$body = $this->smarty->fetch('email/result_test.tpl');
		
		$this->email->from('no-reply@pediukdi.com', 'PEDIUKDI');
		$this->email->to($email);
		$this->email->subject($subject);
		$this->email->message($body);
		return $this->email->send();
	}
}
