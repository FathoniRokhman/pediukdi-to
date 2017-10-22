<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_forge $dbforge
 * @property CI_DB_query_builder $db
 */
class Migration_init_db extends CI_Migration
{
	function up()
	{			
		$table_set = array(
			'setting', 'user', 'form_soal', 'kelompok_soal', 'soal', 'jawaban_soal', 'jadwal_test', 'pembayaran',
			'test_session', 'jawaban_user', 'guest_session', 'jawaban_guest', 'elearning_video', 'premium_fiture'
		);
		
		foreach ($table_set as $table)
		{
			echo "Create table {$table} ... ";
			$this->db->query(file_get_contents(APPPATH."migrations/sql/001_{$table}.sql"));
			echo "OK<br/>";
		}
	}
	
	function down()
	{

		// reserved order
		$table_set = array(
			'setting', 'user', 'form_soal', 'kelompok_soal', 'soal', 'jawaban_soal', 'jadwal_test', 'pembayaran',
			'test_session', 'jawaban_user', 'guest_session', 'jawaban_guest', 'elearning_video', 'premium_fiture'
		);
		
		foreach (array_reverse($table_set) as $table)
		{
			echo "Drop table {$table} ... ";
			$this->dbforge->drop_table($table);
			echo "OK<br/>";
		}
	}
}
