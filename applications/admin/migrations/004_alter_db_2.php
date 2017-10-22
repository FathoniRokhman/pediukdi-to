<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_forge $dbforge
 * @property CI_DB_query_builder $db
 */
class Migration_Alter_db_2 extends CI_Migration
{
	function up()
	{
		echo "Drop table jawaban_user ... ";
		$this->dbforge->drop_table('jawaban_user', TRUE);
		echo "OK<br/>";
				
		echo "Re-Create table jawaban_user ... ";
		$this->db->query(file_get_contents(APPPATH."migrations/sql/004_jawaban_user.sql"));
		echo "OK<br/>";
	}
	
	function down()
	{
		echo "Nothing<br/>";
	}
}