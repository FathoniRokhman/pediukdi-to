<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property User_model $user_model
 * @property User_paket_model $user_paket_model
 * @property User_paket_soal_model $user_paket_soal_model 
 * @property Periode_model $periode_model
 * @property Periode_paket_model $periode_paket_model
 * @property Periode_soal_model $periode_soal_model
 */
class User_paket extends ADMIN_Controller
{
	
	public function __construct()
	{
		parent::__construct();
		
		$this->load->model('user_model');
		$this->load->model('user_paket_model');
		$this->load->model('user_paket_soal_model');
		$this->load->model('periode_model');
		$this->load->model('periode_paket_model');
		$this->load->model('periode_soal_model');
	}
	
	public function index()
	{
		$this->smarty->display();
	}
	
	public function index_data()
	{
		$data_set = $this->user_paket_model->list_all();
		echo json_encode(array('data' => $data_set));
	}
	
	public function add()
	{
		if ($this->input->method() == 'post')
		{
			$mode = $this->input->post('mode');
			$id_periode = $this->input->post('id_periode');
			$id_periode_paket = $this->input->post('id_periode_paket');
			$periode = $this->periode_model->get_single($id_periode);
			$periode_paket = $this->periode_paket_model->get_single($id_periode_paket);
			
			if ($mode == 'preview')
			{
				$user_set = $this->user_model->list_user_by_id($this->input->post('id_user_set'));
				$this->smarty->assign('user_set', $user_set);
				
				$periode_soal_set = $this->periode_soal_model->list_by_id($this->input->post('id_periode_soal_set'));
				foreach ($periode_soal_set as &$periode_soal)
					$periode_soal->tgl_mulai_display = strftime('%d %B %Y', strtotime($periode_soal->tgl_mulai));
				$this->smarty->assign('periode_soal_set', $periode_soal_set);
			}
			
			if ($mode == 'submit')
			{
				$this->db->trans_begin();
				
				$user_paket_set = array();
				
				foreach ($this->input->post('id_user_set') as $id_user)
				{
					$user_paket	= new stdClass();
					$user_paket->id_user = $id_user;
					$user_paket->id_periode_paket = $this->input->post('id_periode_paket');
					$user_paket->created = date('Y-m-d H:i:s');
					
					$this->user_paket_model->add($user_paket);
					
					foreach ($this->input->post('id_periode_soal_set') as $id_periode_soal)
					{
						$user_paket_soal = new stdClass();
						$user_paket_soal->id_user_paket = $user_paket->id_user_paket;
						$user_paket_soal->id_periode_soal = $id_periode_soal;
						$user_paket_soal->created = date('Y-m-d H:i:s');
						
						$this->user_paket_soal_model->add($user_paket_soal);
					}
				}
				
				$result = $this->db->trans_commit();
				
				if ($result)
					$this->session->set_flashdata('inserted', TRUE);
				redirect(site_url('user-paket/index'));
				exit();
			}
			
			$this->smarty->assign('periode', $periode);
			$this->smarty->assign('periode_paket', $periode_paket);
			$this->smarty->display("user_paket/add-{$mode}.tpl");
			exit();
		}
		
		$periode_set = $this->periode_model->list_all();
		
		$this->smarty->assign('periode_set', $periode_set);
		$this->smarty->display();
	}
	
	public function data_paket()
	{		
		$id_periode = $this->input->get('id_periode');
		$data_set = $this->periode_paket_model->list_all($id_periode);
		echo json_encode($data_set);
	}
	
	public function delete($id)
	{
		if ($this->input->method() == 'post')
		{
			$result = $this->user_paket_model->delete($id);
			if ($result)
				$this->session->set_flashdata('deleted', TRUE);
			redirect(site_url('user-paket/index'));
		}
	}
}
