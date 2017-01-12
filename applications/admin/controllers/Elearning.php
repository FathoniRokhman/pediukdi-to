<?php

/**
 * @author Putra Rieskha <rieksha@gmail.com>
 * @property Jadwal_model $jadwal_model Description
 */
class Elearning extends ADMIN_Controller{

	public function __construct(){
		parent::__construct();
		
		$this->load->model('jadwal_model');
		$this->load->model('elearning_model');
	}
	
	function index(){
		setlocale(LC_TIME, 'id_ID');

		$data_set =  $this->elearning_model->listVideo(null,null);
		$this->smarty->assignByRef('data_set', $data_set);
		$this->smarty->display();
	}

	function add(){

		$this->form_validation->set_error_delimiters('<p style="margin:0 0 0 0; color:red; font-style:italic;">', '</p>');
		if ($this->input->method() == 'post'){

			$this->form_validation->set_rules('judulVideo','judulVideo','required|min_length[5]');
			$this->form_validation->set_rules('deskripsiVideo','deskripsiVideo','required|min_length[10]');
			$this->form_validation->set_rules('linkVideo','linkVideo','required|min_length[10]');
			$this->form_validation->set_rules('statusVideo','statusVideo','required');
			if($this->form_validation->run() == true){

				$dataInsert['judulVideo'] = $this->input->post('judulVideo');
				$dataInsert['deskripsiVideo'] = $this->input->post('deskripsiVideo');
				$dataInsert['linkVideo'] = $this->input->post('linkVideo');
				$dataInsert['statusVideo'] = $this->input->post('statusVideo');
				$this->elearning_model->addVideo($dataInsert);
				$this->session->set_flashdata('inserted', TRUE);
				redirect('elearning/index');
			}			
		}
		$this->smarty->display();
	}

	function edit($idElearningVideo){

		$this->form_validation->set_error_delimiters('<p style="margin:0 0 0 0; color:red; font-style:italic;">', '</p>');
		if ($this->input->method() == 'post'){

			$this->form_validation->set_rules('judulVideo','judulVideo','required|min_length[5]');
			$this->form_validation->set_rules('deskripsiVideo','deskripsiVideo','required|min_length[10]');
			$this->form_validation->set_rules('linkVideo','linkVideo','required|min_length[10]');
			$this->form_validation->set_rules('statusVideo','statusVideo','required');
			if($this->form_validation->run() == true){

				$idElearningVideo = $this->input->post('idElearningVideo');
				$dataUpdate['judulVideo'] = $this->input->post('judulVideo');
				$dataUpdate['deskripsiVideo'] = $this->input->post('deskripsiVideo');
				$dataUpdate['linkVideo'] = $this->input->post('linkVideo');
				$dataUpdate['statusVideo'] = $this->input->post('statusVideo');
				$this->elearning_model->updateVideo($dataUpdate,$idElearningVideo);
				$this->session->set_flashdata('updated', TRUE);
				redirect('elearning/index');
			}
			
		}

		$dataElearningVideo = $this->elearning_model->getElearning((int)$idElearningVideo);
		$this->smarty->assignByRef('dataElearningVideo', $dataElearningVideo);
		$this->smarty->display();
	}

	function delete($idElearningVideo){

		if ($this->input->method() == 'post'){
			$this->elearning_model->deleteVideo($idElearningVideo);
			redirect('elearning/index');
		}
	}
	

}
