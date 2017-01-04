<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property Soal_model $soal_model Description
 */
class Kelompok_soal extends ADMIN_Controller
{
	function __construct()
	{
		parent::__construct();
		
		$this->load->model('soal_model');
	}
	
	function index()
	{
		// Ambil data Kelompok Soal
		$this->smarty->assign('data_set', $this->soal_model->list_kelompok_soal());
		
		$this->smarty->display();
	}
	
	function add()
	{
		if ($this->input->method() == 'post')
		{
			$this->soal_model->add_kelompok_soal();
			
			$this->session->set_flashdata('inserted', TRUE);
			
			redirect('kelompok-soal/index');
		}
		
		$this->smarty->display();
	}
	
	function edit($id_kelompok_soal)
	{
		if ($this->input->method() == 'post')
		{
			$this->soal_model->update_kelompok_soal($id_kelompok_soal);
			
			$this->session->set_flashdata('updated', TRUE);
			
			redirect('kelompok-soal/index');
		}
		
		$kelompok_soal = $this->soal_model->get_kelompok_soal($id_kelompok_soal);
		$this->smarty->assignByRef('kelompok_soal', $kelompok_soal);
		
		$this->smarty->display();
	}
	
	function delete($id_kelompok_soal)
	{
		if ($this->input->method() == 'post')
		{
			$this->soal_model->delete_kelompok_soal($id_kelompok_soal);
			
			redirect('kelompok-soal/index');
		}
	}
}
