<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property User_model $user_model 
 * @property Jadwal_model $jadwal_model Description
 * @property Pembayaran_model $pembayaran_model
 */
class User extends ADMIN_Controller
{
	function __construct()
	{
		parent::__construct();
		
		$this->load->model('user_model');
		$this->load->model('jadwal_model');
		$this->load->model('pembayaran_model');
	}
	
	function index()
	{
		// $data_set = $this->user_model->list_user();
		// $this->smarty->assign('data_set', $data_set);
		
		$this->smarty->display();
	}
	
	function index_data()
	{
		$data_set = $this->user_model->list_user();
		echo json_encode(array('data' => $data_set));
	}
	
	function add_pembayaran($id_user)
	{
		if ($this->input->method() == 'post')
		{
			$this->pembayaran_model->add();
			
			redirect('pembayaran');
		}
		
		$user = $this->user_model->get_user($id_user);
		$this->smarty->assignByRef('user', $user);
		
		$jadwal_set = $this->jadwal_model->list_jadwal();
		
		foreach ($jadwal_set as $jadwal)
			$jadwal_set_combo[$jadwal->id_jadwal_test] = strftime('%d %B %Y', strtotime($jadwal->tanggal_test)) .' - '. $jadwal->nama_form . ' (Rp ' . $jadwal->biaya . ')';
		
		$this->smarty->assignByRef('jadwal_set_combo', $jadwal_set_combo);
		
		$this->smarty->display();
	}
}
