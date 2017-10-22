<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property Periode_paket_model $periode_paket_model
 * @property Periode_model $periode_model
 */
class Periode_paket extends ADMIN_Controller
{
	public function __construct()
	{
		parent::__construct();
		
		$this->load->model('periode_paket_model');
		$this->load->model('periode_model');
	}
	
	public function index($id_periode)
	{
		$data_set = $this->periode_paket_model->list_all($id_periode);
		$periode = $this->periode_model->get_single($id_periode);
		
		$this->smarty->assign('data_set', $data_set);
		$this->smarty->assign('periode', $periode);
		$this->smarty->display();
	}
	
	public function add($id_periode)
	{
		if ($this->input->method() == 'post')
		{	
			$data				= new stdClass();
			$data->id_periode	= $id_periode;
			$data->nama_paket	= $this->input->post('nama_paket');
			$data->jumlah		= $this->input->post('jumlah');
			$data->biaya		= $this->input->post('biaya');
			$data->created		= date('Y-m-d H:i:s');
			
			$result = $this->periode_paket_model->add($data);
			
			if ($result)
			{
				$this->session->set_flashdata('inserted', TRUE);
				redirect(site_url('periode-paket/index/'.$id_periode));
				exit();
			}
		}
		
		$periode = $this->periode_model->get_single($id_periode);
		
		$this->smarty->assign('periode', $periode);
		$this->smarty->display();
	}
	
	public function edit($id)
	{
		$data = $this->periode_paket_model->get_single($id);
		$periode = $this->periode_model->get_single($data->id_periode);
		
		if ($this->input->method() == 'post')
		{
			$data->nama_paket	= $this->input->post('nama_paket');
			$data->jumlah		= $this->input->post('jumlah');
			$data->biaya		= $this->input->post('biaya');
			$data->updated		= date('Y-m-d H:i:s');
			
			$result = $this->periode_paket_model->update($id, $data);
			
			if ($result)
			{
				$this->session->set_flashdata('updated', TRUE);
				redirect(site_url('periode-paket/index/'.$data->id_periode));
				exit();
			}
		}
		
		$this->smarty->assign('periode', $periode);
		$this->smarty->assign('data', $data);
		$this->smarty->display();
	}
	
	public function delete($id)
	{
		if ($this->input->method() == 'post')
		{
			$data = $this->periode_paket_model->get_single($id);
			
			$result = $this->periode_paket_model->delete($id);
			
			if ($result)
				$this->session->set_flashdata('deleted', TRUE);
			
			redirect(site_url('periode-paket/index/'.$data->id_periode));
			exit();
		}
	}
}
