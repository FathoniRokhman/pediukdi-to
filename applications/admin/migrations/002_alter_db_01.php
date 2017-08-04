<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_forge $dbforge
 * @property CI_DB_query_builder $db
 */
class Migration_alter_db_01 extends CI_Migration
{
	function up()
	{		
		// Alter table form_soal
		echo "--&gt; alter table soal ... ";
		$this->dbforge->add_column('soal', array(
			'COLUMN pembahasan_soal text NULL AFTER isi_soal',
		));
		echo "OK<br/>";
	}
	
	function down()
	{
		// Alter table form_soal
		echo "--&gt; alter table soal ... ";
		$this->dbforge->drop_column('soal', 'pembahasan_soal');
		echo "OK<br/>";
	}
}
