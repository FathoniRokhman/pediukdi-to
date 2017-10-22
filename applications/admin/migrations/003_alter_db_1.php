<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_forge $dbforge
 * @property CI_DB_query_builder $db
 */
class Migration_Alter_db_1 extends CI_Migration
{
	function up()
	{
		$table_set = array(
			'periode', 'periode_paket', 'periode_soal', 'user_paket', 'user_paket_soal'
		);
		
		foreach ($table_set as $table)
		{
			echo "Create table {$table} ... ";
			$this->db->query(file_get_contents(APPPATH."migrations/sql/003_{$table}.sql"));
			echo "OK<br/>";
		}
	}
	
	function down()
	{
		$table_set = array(
			'periode', 'periode_paket', 'periode_soal', 'user_paket', 'user_paket_soal'
		);
		
		foreach (array_reverse($table_set) as $table)
		{
			echo "Drop table {$table} ... ";
			$this->dbforge->drop_table($table);
			echo "OK<br/>";
		}
	}
}