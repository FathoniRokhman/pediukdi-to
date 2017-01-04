<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property Jadwal_model $jadwal_model
 * @property Soal_model $soal_model
 */
class Jadwal extends ADMIN_Controller
{
	function __construct()
	{
		parent::__construct();
		
		$this->load->model('jadwal_model');
		$this->load->model('soal_model');
	}
	
	function index()
	{
		$data_set = $this->jadwal_model->list_jadwal();
		$this->smarty->assignByRef('data_set', $data_set);
		
		$this->smarty->display();
	}
	
	function add()
	{
		if ($this->input->method() == 'post')
		{
			$this->jadwal_model->add();
			
			redirect('jadwal');
		}
		
		$form_soal_set = $this->soal_model->list_form_soal();
		$this->smarty->assignForCombo('form_soal_set', $form_soal_set, 'id_form_soal', 'nama_form');
		
		$this->smarty->display();
	}
	
	function edit($id_jadwal_test)
	{
		if ($this->input->method() == 'post')
		{
			$this->jadwal_model->update($id_jadwal_test);
			
			redirect('jadwal');
		}
		
		$jadwal_test = $this->jadwal_model->get_jadwal($id_jadwal_test);
		$this->smarty->assignByRef('jadwal_test', $jadwal_test);
		
		$form_soal_set = $this->soal_model->list_form_soal();
		$this->smarty->assignForCombo('form_soal_set', $form_soal_set, 'id_form_soal', 'nama_form');
		
		$this->smarty->display();
	}
	
	function delete($id_jadwal_test)
	{
		if ($this->input->method() == 'post')
		{
			$this->jadwal_model->delete($id_jadwal_test);
		}
		
		redirect('jadwal');
	}
}
