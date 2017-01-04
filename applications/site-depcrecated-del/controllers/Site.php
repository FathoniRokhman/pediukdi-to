<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * @author Fathoni <m.fathoni@mail.com>
 */
class Site extends SITE_Controller
{
	function __construct()
	{
		parent::__construct();
	}
	
	function index()
	{
		$this->smarty->display();
	}
	
	function about()
	{
		$this->smarty->display();
	}
	
	function coba_soal()
	{
		// Batas 30 Menit dr sekarang
		$this->smarty->display();
	}
	
	function jadwal()
	{
		$this->smarty->display();
	}
	
	function contact_us()
	{
		$this->smarty->display();
	}
}
