<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property Pembayaran_model $pembayaran_model
 * @property Jadwal_model $jadwal_model Description
 * @property User_model $user_model
 */
class Home extends USER_Controller
{
	function __construct()
	{
		parent::__construct();
		
		$this->check_credentials();
		
		$this->load->model('pembayaran_model');
		$this->load->model('jadwal_model');
		$this->load->model('user_model');
	}
	
	function index()
	{
		// Lokal indonesia
		setlocale(LC_TIME, 'id_ID');
		
		$user = $this->session->userdata('user');
		
		// Ambil Pembayaran Aktif
		$pembayaran_aktif = $this->pembayaran_model->get_pembayaran_aktif($user->id_user);
		
		if ($pembayaran_aktif != NULL)
		{
			$this->smarty->assign('pembayaran_aktif', $pembayaran_aktif);
			
			$jadwal_test = $this->jadwal_model->get_jadwal($pembayaran_aktif->id_jadwal_test);
			
			$this->smarty->assign('jadwal_test', $jadwal_test);
		}
		
		$test_session = $this->user_model->get_test_session($user->id_user);
		
		// Jika masih punya session langsung redirect ke 
		if ($test_session)
		{
			redirect('test/soal/1/');
		}
		
		$this->smarty->assign('user', $user);
		$this->smarty->display();
	}
	
	function jadwal_test()
	{
		$this->smarty->display();
	}
}
