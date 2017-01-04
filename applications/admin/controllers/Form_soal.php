<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property Soal_model $soal_model
 */
class Form_soal extends ADMIN_Controller
{
	function __construct()
	{
		parent::__construct();
		
		$this->load->model('soal_model');
	}
	
	function index()
	{
		// Ambil data Master Form
		$this->smarty->assign('data_set', $this->soal_model->list_form_soal());
		
		$this->smarty->display();
	}
	
	function add()
	{
		if ($this->input->method() == 'post')
		{
			$this->soal_model->add_form_soal();
			
			$this->session->set_flashdata('inserted', TRUE);
			
			redirect('form-soal/index');
		}
		
		$this->smarty->display();
	}
	
	function edit($id_form_soal)
	{
		if ($this->input->method() == 'post')
		{
			$result = $this->soal_model->update_form_soal($id_form_soal);
			
			if ($result)
			{
				$this->session->set_flashdata('updated', TRUE);
				
				redirect('form-soal/index');
			}
		}
		
		$form_soal = $this->soal_model->get_form_soal((int)$id_form_soal);
		$this->smarty->assignByRef('form_soal', $form_soal);
		
		$this->smarty->display();
	}
	
	function delete($id_form_soal)
	{
		if ($this->input->method() == 'post')
		{
			$this->soal_model->delete_form_soal($id_form_soal);
			
			redirect('form-soal/index');
		}
	}
}
