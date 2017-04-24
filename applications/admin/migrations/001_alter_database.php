<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_forge $dbforge
 * @property CI_DB_query_builder $db
 */
class Migration_alter_database extends CI_Migration
{
	function up()
	{		
		// Alter table form_soal
		echo "--> alter table form_soal ... ";
		$this->dbforge->add_column('form_soal', array(
			'COLUMN nilai_kkm INT NOT NULL DEFAULT \'0\' AFTER nama_form',
		));
		echo "OK<br/>";
	}
	
	function down()
	{
		// Alter table form_soal
		echo "--> alter table form_soal ... ";
		$this->dbforge->drop_column('form_soal', 'nilai_kkm');
		echo "OK<br/>";
	}
}
