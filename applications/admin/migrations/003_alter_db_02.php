<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_forge $dbforge
 * @property CI_DB_query_builder $db
 */
class Migration_alter_db_02 extends CI_Migration
{
	function up()
	{		
		// -------------------------------
		// Tabel test_session
		// -------------------------------
		// add foreign key
		echo "  &gt; add foreign key test_session (id_jadwal_test, id_user) ... ";
		$this->db->query("ALTER TABLE test_session ADD FOREIGN KEY jadwal_test_fk (id_jadwal_test) REFERENCES jadwal_test (id_jadwal_test) ON DELETE NO ACTION ON UPDATE NO ACTION");
		$this->db->query("ALTER TABLE test_session ADD FOREIGN KEY user_fk (id_user) REFERENCES user (id_user) ON DELETE NO ACTION ON UPDATE NO ACTION");
		echo "OK<br/>";
	}
	
	function down()
	{
		// -------------------------------
		// Tabel test_session
		// -------------------------------
		// drop foreign key
		echo "  &gt; drop foreign key test_session (id_jadwal_test, id_user) ... ";
		$this->db->query("ALTER TABLE test_session DROP FOREIGN KEY jadwal_test_fk");
		$this->db->query("ALTER TABLE test_session DROP FOREIGN KEY user_fk");
		echo "OK<br/>";
	}
}
