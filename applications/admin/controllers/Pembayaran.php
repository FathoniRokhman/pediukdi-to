<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property Pembayaran_model $pembayaran_model Description
 * @property Jadwal_model $jadwal_model
 * @property User_model $user_model
 * @property Soal_model $soal_model
 */
class Pembayaran extends ADMIN_Controller
{
	function __construct()
	{
		parent::__construct();
		
		$this->load->model('pembayaran_model');
		$this->load->model('jadwal_model');
		$this->load->model('user_model');
		$this->load->model('soal_model');
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
	
	function add_multi($mode = 'pilih-jadwal')
	{
		// Ambil daftar test -> Beserta centang -> submit
		if ($mode == 'pilih-jadwal')
		{
			$data_set = $this->jadwal_model->list_jadwal();
			$this->smarty->assignByRef('data_set', $data_set);
		}
		else if ($mode == 'pilih-peserta' && $_SERVER['REQUEST_METHOD'] == 'POST')
		{
			$id_jadwal_test = $this->input->post('ijt');
			
			$jadwal_test = $this->jadwal_model->get_jadwal($id_jadwal_test);
			$this->smarty->assign('jadwal_test', $jadwal_test);
			
			$data_set = $this->user_model->list_user();
			$this->smarty->assign('data_set', $data_set);
		}
		else if ($mode == 'cek-akhir' && $_SERVER['REQUEST_METHOD'] == 'POST')
		{
			$id_jadwal_test = $this->input->post('ijt');
			$id_user = $this->input->post('iu');	// array
			
			$jadwal_test = $this->jadwal_model->get_jadwal($id_jadwal_test);
			$jadwal_test->form_soal = $this->soal_model->get_form_soal($jadwal_test->id_form_soal);
			$this->smarty->assign('jadwal_test', $jadwal_test);
			
			$data_set = $this->user_model->list_user_by_id($id_user);
			$this->smarty->assign('data_set', $data_set);
		}
		else if ($mode == 'proses' && $_SERVER['REQUEST_METHOD'] == 'POST')
		{
			$id_jadwal_test = $this->input->post('ijt');
			$id_user = implode(',', $this->input->post('iu'));
			
			$today	= date('Y-m-d');
			$created = date('Y-m-d H:i:s');
			
			$result = $this->db->query(
				"insert into pembayaran (id_jadwal_test, id_user, tanggal_bayar, is_aktif, created)
				select jt.id_jadwal_test, u.id_user, '{$today}' as tanggal_bayar, 1 as is_aktif, '{$created}' as created
				from user u
				cross join jadwal_test jt
				left join pembayaran p on p.id_jadwal_test = jt.id_jadwal_test and p.id_user = u.id_user
				where u.id_user in ({$id_user}) and jt.id_jadwal_test = {$id_jadwal_test} and p.id_pembayaran is null");
			
			if ($result)
				$this->session->set_flashdata('pesan', 'Pembayaran berhasil ditambah');
			else
				$this->session->set_flashdata('pesan', 'Pembayaran gagal ditambah');
			
			redirect('pembayaran/add-multi/hasil');
			
			exit();
		}
		else if ($mode == 'hasil')
		{
			$this->smarty->assign('pesan', $this->session->flashdata('pesan'));
		}
		else
		{
			redirect(site_url('pembayaran/add-multi/pilih-jadwal'));
		}
		
		$this->smarty->display("pembayaran/add-multi/{$mode}.tpl");
	}
}
