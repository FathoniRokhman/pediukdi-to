<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property Periode_soal_model $periode_soal_model
 * @property Periode_model $periode_model
 * @property Soal_model $soal_model
 */
class Periode_soal extends ADMIN_Controller
{
	public function __construct()
	{
		parent::__construct();
		
		$this->load->model('periode_soal_model', 'periode_soal_model');
		$this->load->model('periode_model');
		$this->load->model('soal_model');
	}
	
	public function index($id_periode)
	{
		$data_set = $this->periode_soal_model->list_all($id_periode);
		$periode = $this->periode_model->get_single($id_periode);
		
		foreach ($data_set as &$data)
		{
			$data->tgl_mulai_display = strftime('%d %B %Y', strtotime($data->tgl_mulai));
		}
		
		$this->smarty->assign('data_set', $data_set);
		$this->smarty->assign('periode', $periode);
		$this->smarty->display();
	}
	
	public function index_data()
	{
		$id_periode = $this->input->get('id_periode');
		$data_set = $this->periode_soal_model->list_all($id_periode);
		
		foreach ($data_set as &$data)
			$data->tgl_mulai_display = strftime('%d %B %Y', strtotime($data->tgl_mulai));
		
		echo json_encode(array('data' => $data_set));
	}
	
	public function add($id_periode)
	{
		$periode = $this->periode_model->get_single($id_periode);
		
		if ($this->input->method() == 'post')
		{	
			$data				= new stdClass();
			$data->id_periode	= $id_periode;
			$data->id_form_soal	= $this->input->post('id_form_soal');
			$data->tgl_mulai	= sprintf("%d-%d-%d", $this->input->post('tgl_mulai_Year'), $this->input->post('tgl_mulai_Month'), $this->input->post('tgl_mulai_Day'));
			$data->created		= date('Y-m-d H:i:s');
			
			$result = $this->periode_soal_model->add($data);
			
			if ($result)
			{
				$this->session->set_flashdata('inserted', TRUE);
				redirect(site_url('periode-soal/index/'.$id_periode));
				exit();
			}
		}
		
		$form_soal_set = $this->soal_model->list_form_soal_not_in_periode($id_periode);
		
		$this->smarty->assign('periode', $periode);
		$this->smarty->assign('form_soal_set', $form_soal_set);
		$this->smarty->display();
	}
	
	public function edit($id)
	{
		$data	= $this->periode_soal_model->get_single($id);
		
		if ($this->input->method() == 'post')
		{	
			$data->id_form_soal	= $this->input->post('id_form_soal');
			$data->tgl_mulai	= sprintf("%d-%d-%d", $this->input->post('tgl_mulai_Year'), $this->input->post('tgl_mulai_Month'), $this->input->post('tgl_mulai_Day'));
			$data->created		= date('Y-m-d H:i:s');
			
			$result = $this->periode_soal_model->update($id, $data);
			
			if ($result)
			{
				$this->session->set_flashdata('updated', TRUE);
				redirect(site_url('periode-soal/index/'.$data->id_periode));
				exit();
			}
		}
		
		$periode = $this->periode_model->get_single($data->id_periode);
		$form_soal_set = $this->soal_model->list_form_soal_not_in_periode($data->id_periode, $data->id_form_soal);
		
		$this->smarty->assign('periode', $periode);
		$this->smarty->assign('data', $data);
		$this->smarty->assign('form_soal_set', $form_soal_set);
		$this->smarty->display();
	}
}
