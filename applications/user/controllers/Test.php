<?php

/**
 * Description of Test
 *
 * @author Fathoni
 * @property Pembayaran_model $pembayaran_model Description
 * @property User_model $user_model Description
 * @property User_paket_model $user_paket_model
 * @property User_paket_soal_model $user_paket_soal_model
 * @property Soal_model $soal_model
 * @property Test_session_model $test_session_model
 * @property Periode_model $periode_model
 * @property Periode_paket_model $periode_paket_model
 * @property Jawaban_user_model $jawaban_user_model
 */
class Test extends USER_Controller
{
	public function __construct()
	{
		parent::__construct();
		
		$this->check_credentials();
	}
	
	function list_test()
	{
		$user = $this->session->userdata('user');
		
		// Mendapatkan paket user yg aktif (berdasarkan waktu yg ada di periode)
		$user_paket = $this->user_paket_model->get_active($user->id_user);
		
		if ($user_paket != null)
		{
			$user_paket->periode_paket = $this->periode_paket_model->get_single($user_paket->id_periode_paket);
			$user_paket->periode_paket->periode = $this->periode_model->get_single($user_paket->periode_paket->id_periode);
			$user_paket->user_paket_soal_set = $this->user_paket_soal_model->list_all_with_result($user_paket->id_user_paket);

			foreach ($user_paket->user_paket_soal_set as &$user_paket_soal)
				$user_paket_soal->tgl_mulai_display = strftime('%d %B %Y', strtotime($user_paket_soal->tgl_mulai));
		}
		else
		{
			redirect(site_url('home'));
			exit();
		}
		
		$this->smarty->assign('user_paket', $user_paket);
		$this->smarty->display();
	}
	
	function detail_result($id_pembayaran)
	{
		$user = $this->session->userdata('user');
		
		$test_session = $this->test_session_model->get_by_pembayaran($user->id_user, $id_pembayaran);
		$this->smarty->assign('test_session', $test_session);
		
		$kelompok_soal_set = $this->test_session_model->get_detail_per_kelompok_soal($test_session->id_test_session);
		$this->smarty->assign('kelompok_soal_set', $kelompok_soal_set);
	
		$this->smarty->display();
	}
	
	function pre_start()
	{	
		$user = $this->session->userdata('user');
			
		// Mendapatkan paket user yg aktif (berdasarkan waktu yg ada di periode)
		$user_paket = $this->user_paket_model->get_active($user->id_user);
		
		if ($user_paket != null)
		{
			// Ambil paket user yg didapat
			$user_paket_soal_set = $this->user_paket_soal_model->list_all_with_form_soal($user_paket->id_user_paket);
			$this->smarty->assign('user_paket_soal_set', $user_paket_soal_set);
		}
		
		$this->smarty->display();
	}
	
	function start_session()
	{
		if ($this->input->method() == 'post')
		{
			$id_user_paket_soal = $this->input->post('id_user_paket_soal');
			
			$user_paket_soal = $this->user_paket_soal_model->get_single($id_user_paket_soal);
			
			// jika belum dimulai, di update start time-nya
			if ($user_paket_soal->start_time == null)
			{
				$user_paket_soal->start_time = date('Y-m-d H:i:s');
				$user_paket_soal->is_finished = 0;
			}
			
			$this->user_paket_soal_model->update($id_user_paket_soal, $user_paket_soal);
			
			// Menuju halaman pengerjaan soal
			redirect('test/soal');
		}
	}
	
	function soal($no_soal = 1)
	{
		$user = $this->session->userdata('user');
		
		$test_session = $this->test_session_model->get_active_session($user->id_user);
		
		// Jika ada Test Session : bisa ditampilkan
		if ($test_session != NULL)
		{
			$soal = $this->soal_model->get_soal_by_no($test_session->id_form_soal, $no_soal);
			
			$jumlah_soal = $this->soal_model->count_soal($test_session->id_form_soal);
			
			$jawaban_user = $this->jawaban_user_model->get_single($user->id_user, $test_session->id_user_paket_soal, $test_session->id_form_soal, $soal->id_soal);
			
			$test_session->jumlah_dijawab = $this->jawaban_user_model->count($user->id_user, $test_session->id_user_paket_soal, $test_session->id_form_soal);
			$test_session->jawaban_user_set = $this->jawaban_user_model->list_jawaban_user($user->id_user, $test_session->id_user_paket_soal, $test_session->id_form_soal);
			
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
	
	function bahas_soal($id_test_session, $no_soal = 1)
	{
		$user = $this->session->userdata('user');
		
		$test_session	= $this->test_session_model->get($id_test_session);
		$soal			= $this->soal_model->get_soal_by_no($test_session->jadwal_test->id_form_soal, $no_soal);
		$jumlah_soal	= $this->soal_model->count_soal($test_session->jadwal_test->id_form_soal);
		$jawaban_user	= $this->user_model->get_jawaban_user($user->id_user, $test_session->id_jadwal_test, $test_session->jadwal_test->id_form_soal, $soal->id_soal);
		
		$test_session->jumlah_dijawab = $this->user_model->count_jawaban_user($user->id_user, $test_session->id_jadwal_test,  $test_session->jadwal_test->id_form_soal);
		$test_session->jawaban_user_set = $this->user_model->list_jawaban_user($user->id_user, $test_session->id_jadwal_test, $test_session->jadwal_test->id_form_soal);
		
		$this->smarty->assign('no_soal', $no_soal);
		$this->smarty->assign('no_soal_prev', $no_soal - 1);
		$this->smarty->assign('no_soal_next', $no_soal + 1);
		
		$this->smarty->assign('soal', $soal);
		$this->smarty->assign('jumlah_soal', $jumlah_soal);
		$this->smarty->assign('jawaban_user', $jawaban_user);
		$this->smarty->assign('test_session', $test_session);
		$this->smarty->assign('user', $user);
		
		$this->smarty->assign('end_session_url', site_url('test/end-session'));
		$this->smarty->assign('soal_url', site_url('test/bahas-soal/'.$id_test_session));
		
		$this->smarty->display();
	}
	
	function jawab_soal()
	{
		if ($this->input->method() == 'post')
		{
			$user = $this->session->userdata('user');
			
			$test_session = $this->test_session_model->get_active_session($user->id_user);
			
			$waktu_jawab = date('Y-m-d H:i:s');
			
			$jawaban_user = new stdClass();
			$jawaban_user->id_user				= $user->id_user;
			$jawaban_user->id_user_paket_soal	= $test_session->id_user_paket_soal;
			$jawaban_user->id_form_soal			= $test_session->id_form_soal;
			$jawaban_user->id_soal				= $this->input->post('id_soal');
			$jawaban_user->id_jawaban_soal		= $this->input->post('id_jawaban_soal');
			$jawaban_user->waktu_jawab			= $waktu_jawab;
			
			// Ambil jawaban sebelumnya
			$jawaban_user_exist = $this->jawaban_user_model->get_single($jawaban_user->id_user, $jawaban_user->id_user_paket_soal, $jawaban_user->id_form_soal, $jawaban_user->id_soal);
			
			// Jika belum ada, maka INSERT
			if ($jawaban_user_exist == NULL)
			{
				$result = $this->jawaban_user_model->add($jawaban_user);
			}
			// Jika sudah ada, maka UPDATE
			else
			{
				$result = $this->jawaban_user_model->update($jawaban_user_exist->id_jawaban_user, $jawaban_user);
			}
			
			// Ambil jumlah soal terjawab
			$jumlah_dijawab = $this->jawaban_user_model->count($jawaban_user->id_user, $jawaban_user->id_user_paket_soal, $jawaban_user->id_form_soal);
			
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
			
			$test_session = $this->test_session_model->get_active_session($user->id_user);
			
			// Update sesuai checked-nya
			$is_ragu = $this->input->post('checked') == 'true' ? 1 : 0;
			
			// Ambil jawaban sebelumnya
			$jawaban_user = $this->jawaban_user_model->get_single(
				$user->id_user, 
				$test_session->id_user_paket_soal, 
				$test_session->id_form_soal, 
				$this->input->post('id_soal'));
			
			// Update is ragu
			$jawaban_user->is_ragu = $is_ragu;
			$jawaban_user->waktu_jawab = date('Y-m-d H:i:s');
			
			// Update ke db
			$this->jawaban_user_model->update($jawaban_user->id_jawaban_user, $jawaban_user);
			
			// Force as json
			header("Content-type: application/json");
		
			echo json_encode($jawaban_user);
		}
	}
	
	function end_session()
	{
		$user = $this->session->userdata('user');
			
		$test_session = $this->test_session_model->get_active_session($user->id_user);
		
		// Send email
		$this->send_test_result($test_session->id_user_paket_soal);
		
		$this->user_paket_soal_model->set_finished($test_session->id_user_paket_soal);
		
		redirect('test/test-result');
	}
	
	function test_result()
	{
		// lokal indonesia
		setlocale(LC_TIME, 'id_ID');
		
		$user = $this->session->userdata('user');
		
		$test_session_set = $this->test_session_model->list_test_session_finished($user->id_user);
		$this->smarty->assign('test_session_set', $test_session_set);
		
		$this->smarty->display();
	}
	
	private function send_test_result($id_user_paket_soal)
	{	
		$this->load->library('email');
		
		$user = $this->session->userdata('user');
		
		$user_paket_soal_set = $this->test_session_model->list_test_session_finished($user->id_user, $id_user_paket_soal);
		$this->smarty->assign('user_paket_soal_set', $user_paket_soal_set);
		
		$email = $user_paket_soal_set[0]->email;
		$subject = "Hasil pengerjaan ".$user_paket_soal_set[0]->form_soal->nama_form;
		$body = $this->smarty->fetch('email/result_test.tpl');
		
		$this->email->from('no-reply@pediukdi.com', 'PEDIUKDI');
		$this->email->to($email);
		$this->email->subject($subject);
		$this->email->message($body);
		return $this->email->send();
	}
}
