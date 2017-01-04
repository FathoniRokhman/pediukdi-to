<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * @author Fathoni <m.fathoni@mail.com>
 */
class Admin extends SITE_Controller
{
	function __construct() 
	{
		parent::__construct();
	}
	
	function index()
	{
		$this->smarty->display('Admin/index.tpl');
	}
}
