<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property Soal_model $soal_model Description
 * @property Setting_model $setting_model Description
 */
class Home extends ADMIN_Controller
{
	function __construct()
	{
		parent::__construct();
		
		$this->load->model('soal_model');
		$this->load->model('setting_model');
	}
	
	function index()
	{
		$this->smarty->display('index.tpl');
	}
	
	function setting()
	{
		if ($this->input->method() == 'post')
		{
			// Jika Password Admin ada isinya, perlu diupdate
			if ($this->input->post('psw_adm'))
			{
				$password_admin_hash = sha1($this->input->post('psw_adm'));
				$this->setting_model->set_value('password_admin', $password_admin_hash, 'string');
			}
			
			if ($this->input->post('id_form_soal'))
			{
				$this->setting_model->set_value('id_form_soal_contoh', $this->input->post('id_form_soal'), 'integer');
			}
			
			$this->session->set_flashdata('updated', TRUE);
			
			redirect('home/setting');
		}
		
		$id_form_soal_contoh = $this->setting_model->get_value('id_form_soal_contoh');
		$this->smarty->assign('id_form_soal_contoh', $id_form_soal_contoh);
		
		$this->smarty->assignForCombo('form_soal_set', $this->soal_model->list_form_soal(), 'id_form_soal', 'nama_form');
		$this->smarty->display('setting.tpl');
	}
	
	function logout()
	{
		// Panggil fungsi logout pada Site Application
		redirect($this->config->item('app_site_url') . 'auth/logout/', 'refresh');
	}
}
