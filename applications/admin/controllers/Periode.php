<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property Periode_model $periode_model
 */
class Periode extends ADMIN_Controller
{
	public function __construct()
	{
		parent::__construct();
		
		$this->load->model('periode_model');
	}
	
	public function index()
	{
		$data_set = $this->periode_model->list_all();
		
		foreach ($data_set as &$data)
		{
			$data->waktu_mulai_display = strftime('%d %B %Y %H:%M:%S', strtotime($data->waktu_mulai));
			$data->waktu_selesai_display = strftime('%d %B %Y %H:%M:%S', strtotime($data->waktu_selesai));
		}
		
		$this->smarty->assign('data_set', $data_set);
		$this->smarty->display();
	}
	
	public function add()
	{
		if ($this->input->method() == 'post')
		{
			// pre-processing data
			$waktu_mulai = sprintf("%d-%d-%d %s:00", $this->input->post('waktu_mulai_Year'), $this->input->post('waktu_mulai_Month'), $this->input->post('waktu_mulai_Day'), $this->input->post('waktu_mulai_Time'));
			$waktu_selesai = sprintf("%d-%d-%d %s:00", $this->input->post('waktu_selesai_Year'), $this->input->post('waktu_selesai_Month'), $this->input->post('waktu_selesai_Day'), $this->input->post('waktu_selesai_Time'));
			
			$data					= new stdClass();
			$data->nama_periode		= $this->input->post('nama_periode');
			$data->waktu_mulai		= $waktu_mulai;
			$data->waktu_selesai	= $waktu_selesai;
			$data->is_aktif			= $this->input->post('is_aktif');
			$data->created			= date('Y-m-d H:i:s');
			
			$result = $this->periode_model->add($data);
			
			if ($result)
			{
				$this->session->set_flashdata('inserted', TRUE);
				redirect(site_url('periode'));
				exit();
			}
		}
		
		$this->smarty->display();
	}
	
	public function edit($id)
	{
		$data = $this->periode_model->get_single($id);
		
		if ($this->input->method() == 'post')
		{
			// pre-processing data
			$waktu_mulai = sprintf("%d-%d-%d %s:00", $this->input->post('waktu_mulai_Year'), $this->input->post('waktu_mulai_Month'), $this->input->post('waktu_mulai_Day'), $this->input->post('waktu_mulai_Time'));
			$waktu_selesai = sprintf("%d-%d-%d %s:00", $this->input->post('waktu_selesai_Year'), $this->input->post('waktu_selesai_Month'), $this->input->post('waktu_selesai_Day'), $this->input->post('waktu_selesai_Time'));
			
			$data->nama_periode		= $this->input->post('nama_periode');
			$data->waktu_mulai		= $waktu_mulai;
			$data->waktu_selesai	= $waktu_selesai;
			$data->is_aktif			= $this->input->post('is_aktif');
			$data->updated			= date('Y-m-d H:i:s');
			
			$result = $this->periode_model->update($id, $data);
			
			if ($result)
			{
				$this->session->set_flashdata('updated', TRUE);
				redirect(site_url('periode'));
				exit();
			}
		}
		
		// pre-processing
		$data->waktu_mulai_Date = date('Y-m-d', strtotime($data->waktu_mulai));
		$data->waktu_mulai_Time = date('H:i', strtotime($data->waktu_mulai));
		$data->waktu_selesai_Date = date('Y-m-d', strtotime($data->waktu_selesai));
		$data->waktu_selesai_Time = date('H:i', strtotime($data->waktu_selesai));
		
		$this->smarty->assign('data', $data);
		$this->smarty->display();
	}
	
	public function delete($id)
	{
		if ($this->input->method() == 'post')
		{
			$result = $this->periode_model->delete($id);
			
			if ($result)
				$this->session->set_flashdata('deleted', TRUE);
			
			redirect(site_url('periode'));
			exit();
		}
	}
}
