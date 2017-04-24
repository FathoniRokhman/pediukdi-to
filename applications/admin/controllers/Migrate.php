<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 */
class Migrate extends ADMIN_Controller
{
	public function __construct()
	{
		parent::__construct();
		
		$this->load->library('migration');
	}
	
	public function index()
	{
		// Get current version
		$migration = $this->db->get('migrations')->row();
		
		echo "Current Version : {$migration->version}<br/>";
		
		echo "List Migration :<br/>";
		
		$migrations = $this->migration->find_migrations();
		
		$i = 1;
		
		foreach ($migrations as $mig_ver => $mig_file)
		{
			$mig_file = str_replace(APPPATH.'migrations/', '', $mig_file);
			echo "[{$i}] {$mig_file}<br/>";
			$i++;
		}
	}
	
	public function up()
	{
		// try migrate to latest version
		$result = $this->migration->latest();
		
		if ($result === FALSE)
		{
			show_error($this->migration->error_string());
		}
		else
		{
			echo "--> Berhasil di migrate ke versi " . $result . "<br/>";
		}
	}
	
	public function down($target_version = null)
	{
		// get all migration
		$migrations = $this->migration->find_migrations();
		
		// get latest version
		$latest_version = count($migrations);
		
		// rollback 1 version
		if ($target_version == null)
			$target_version = $latest_version - 1;
		
		// do rollback
		$this->migration->version($target_version);
	}
}
