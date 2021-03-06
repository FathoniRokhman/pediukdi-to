<?php 
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . '../../vendor/smarty/smarty/libs/Smarty.class.php';

class Smarty_wrapper extends Smarty 
{ 
	
	function __construct()
	{
		parent::__construct();
		
		$CI =& get_instance();
		
		// Config Initialize
		$this->setTemplateDir(APPPATH.'views');
		$this->setCompileDir(APPPATH.'views_compiled');
		$this->assignByRef('ci', $CI);
	}
	
	/**
     * Override fungsi 'display()' dari Smarty, dengan melakukan automatisasi pada class & method dengan cara memanggil file nama_class/nama_method.tpl
     *
     * @param string $template   the resource handle of the template file or template object
     * @param mixed  $cache_id   cache id to be used with this template
     * @param mixed  $compile_id compile id to be used with this template
     * @param object $parent     next higher level of Smarty variables
     */
	public function display($template = null, $cache_id = null, $compile_id = null, $parent = null)
	{		
		// Di olah hanya ketika null
		if ($template == NULL)
		{
			$CI =& get_instance();
			
			$class_name	 = $CI->uri->rsegment(1);			// Class name sebagai nama folder
			$method_name = $CI->uri->rsegment(2, 'index');	// Method sebagai nama file tpl
			
			$template = APPPATH.'views'.DIRECTORY_SEPARATOR.$class_name.DIRECTORY_SEPARATOR.$method_name.'.tpl';
			
			if (file_exists($template))
			{
				parent::display($template, $cache_id, $compile_id, $parent);
			}
			else
			{
				show_error("Template \"{$template}\" not found.");
			}
		}
		else
		{
			parent::display($template, $cache_id, $compile_id, $parent);
		}
	}
	
	public function assignForCombo($tpl_var, $rows_object, $value_column, $display_column)
	{
		$value = array();
		
		foreach ($rows_object as $row)
			$value[$row->{$value_column}] = $row->{$display_column};
			
		parent::assign($tpl_var, $value);
	}
}

/* End of file Smarty_wrapper.php */