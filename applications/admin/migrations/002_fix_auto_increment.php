<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_forge $dbforge
 * @property CI_DB_query_builder $db
 */
class Migration_fix_auto_increment extends CI_Migration
{
	function up()
	{
		$table_set = array(
			'user', 'form_soal', 'kelompok_soal', 'soal', 'jawaban_soal', 'jadwal_test', 'pembayaran',
			'test_session', 'jawaban_user', 'guest_session', 'jawaban_guest', 'elearning_video', 'premium_fiture'
		);
		
		foreach ($table_set as $table)
		{
			if ($table == 'elearning_video')
				$column = 'idElearningVideo';
			else if ($table == 'premium_fiture')
				$column = 'idPremiunFiture';
			else
				$column = 'id_'.$table;
			
			echo "Fixing auto increment value of {$table} ... ";
			$row = $this->db->select_max($column)->get($table)->row_array();
			$next_value = $row[$column] + 1;
			$this->db->query("ALTER TABLE {$table} AUTO_INCREMENT = {$next_value}");
			echo "OK<br/>";
		}
	}
	
	function down()
	{
		echo "OK<br/>";
	}
}