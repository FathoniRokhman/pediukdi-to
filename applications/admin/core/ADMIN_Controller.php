<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_Config $config
 * @property Smarty_wrapper $smarty
 * @property CI_Form_validation $form_validation
 * @property CI_Input $input
 * @property CI_Loader $load
 * @property CI_DB_driver $db
 * @property CI_DB_query_builder $db
 * @property CI_DB_result $query
 * @property CI_Email $email
 * @property CI_Session $session
 * @property CI_Upload $upload
 * @property CI_Output $output
 * @property CI_URI $uri
 */
class ADMIN_Controller extends CI_Controller 
{
	public function __construct()
	{
		parent::__construct();
		
		// Jika tidak ada session langsung Keluar
		if ($this->session->userdata('logged_admin') != TRUE)
		{
			redirect($this->config->item('app_site_url'));
			
			exit();
		}
		
		date_default_timezone_set('Asia/Jakarta');
		
		// disable cache page
		header('Access-Control-Allow-Origin: *');  // untuk keperluan ajax
		header('Last-Modified:'.gmdate('D, d M Y H:i:s').'GMT');
		header('Cache-Control: no-store, no-cache, must-revalidate');
		header('Cache-Control: post-check=0, pre-check=0',false);
		header('Pragma: no-cache');
	}
}
