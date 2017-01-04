<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property Pembayaran_model $pembayaran_model Description
 * @property Jadwal_model $jadwal_model
 */
class Pembayaran extends ADMIN_Controller
{
	function __construct()
	{
		parent::__construct();
		
		$this->load->model('pembayaran_model');
		$this->load->model('jadwal_model');
	}
	
	function index()
	{
		$data_set = $this->pembayaran_model->list_pembayaran();
		$this->smarty->assignByRef('data_set', $data_set);
		
		$this->smarty->display();
	}
	
	function delete($id_pembayaran)
	{
		$this->pembayaran_model->delete($id_pembayaran);
		
		redirect('pembayaran');
	}
}
