<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 */
class Migrate extends CI_Controller
{
	public function __construct()
	{
		parent::__construct();
		
		$this->load->library('migration');
	}
	
	public function index()
	{
		echo "<html><body><pre>";
				
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
		
		echo "</pre></body></html>";
	}
	
	public function up($version = null)
	{
		echo "<html><body><pre>";
		
		if ($version != null)
			$result = $this->migration->version($version);
		else
			$result = $this->migration->latest();
		
		if ($result === FALSE)
		{
			show_error($this->migration->error_string());
		}
		else
		{
			echo "Berhasil di migrate ke versi " . $result . "<br/>";
		}
		
		echo "</pre></body></html>";
	}
	
	public function down($target_version = null)
	{
		echo "<html><body><pre>";
		
		// get all migration
		$migrations = $this->migration->find_migrations();
		
		// get latest version
		$latest_version = count($migrations);
		
		// rollback 1 version
		if ($target_version == null)
			$target_version = $latest_version - 1;
		
		// do rollback
		$result = $this->migration->version($target_version);
		
		if ($result == TRUE)
			echo "Berhasil di migrate down ke versi " . $target_version . "<br/>";
		
		echo "</pre></body></html>";
	}
	
	public function trial()
	{
		echo "<html><body><pre>";
		
		echo "Trial data";
		
		
		
		echo "</pre></body></html>";
	}
}
