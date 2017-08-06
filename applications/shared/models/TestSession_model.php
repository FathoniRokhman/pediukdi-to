<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_query_builder $db
 * @property CI_Input $input
 */
class TestSession_model extends CI_Model
{
	function get($id_test_session)
	{
		$test_session = $this->db->get_where('test_session', ['id_test_session' => $id_test_session], 1)->row();
		$test_session->jadwal_test = $this->db->get_where('jadwal_test', ['id_jadwal_test' => $test_session->id_jadwal_test], 1)->row();
		$test_session->user = $this->db->get_where('user', ['id_user' => $test_session->id_user], 1)->row();
		return $test_session;
	}
	
	function get_by_user_jadwal($id_user, $id_jadwal_test)
	{
		return $this->db->get_where('test_session', ['id_user'=>$id_user, 'id_jadwal_test' => $id_jadwal_test], 1)->row();
	}
	
	function list_test_session($id_user)
	{	
		return $this->db->query(
			"select p.id_pembayaran, jt.tanggal_test, fs.nama_form, fs.nilai_kkm, 
				ts.is_finished,
				count(s.id_soal) as jumlah_soal,
				count(ju.id_jawaban_user) as jumlah_dijawab,
				count(s.id_soal) - count(ju.id_jawaban_user) as jumlah_kosong,
				SUM(ju.is_ragu) AS jumlah_ragu,
				(SUM(ifnull(js.is_kunci,0))/COUNT(s.id_soal))*100 AS skor_akhir
			from pembayaran p
			join user u on u.id_user = p.id_user
			join jadwal_test jt on jt.id_jadwal_test = p.id_jadwal_test
			join form_soal fs on fs.id_form_soal = jt.id_form_soal
			join soal s on s.id_form_soal = fs.id_form_soal
			left join test_session ts on ts.id_jadwal_test = jt.id_jadwal_test and ts.id_user = u.id_user
			left join jawaban_user ju on
				ju.id_user = u.id_user and
				ju.id_jadwal_test = jt.id_jadwal_test and
				ju.id_form_soal = fs.id_form_soal and
				ju.id_soal = s.id_soal and
				ju.id_jawaban_soal is not null
			left join jawaban_soal js on js.id_jawaban_soal = ju.id_jawaban_soal
			where p.id_user = {$id_user}
			group by p.id_pembayaran, jt.tanggal_test, fs.nama_form, fs.nilai_kkm
			order by jt.tanggal_test")->result();
	}
	
	function get_by_pembayaran($id_user, $id_pembayaran)
	{
		return $this->db->query(
			"select p.id_pembayaran, ts.id_test_session, jt.tanggal_test, fs.nama_form, fs.nilai_kkm, 
				ts.is_finished,
				count(s.id_soal) as jumlah_soal,
				count(ju.id_jawaban_user) as jumlah_dijawab,
				count(s.id_soal) - count(ju.id_jawaban_user) as jumlah_kosong,
				SUM(ju.is_ragu) AS jumlah_ragu,
				(SUM(ifnull(js.is_kunci,0))/COUNT(s.id_soal))*100 AS skor_akhir
			from pembayaran p
			join user u on u.id_user = p.id_user
			join jadwal_test jt on jt.id_jadwal_test = p.id_jadwal_test
			join form_soal fs on fs.id_form_soal = jt.id_form_soal
			join soal s on s.id_form_soal = fs.id_form_soal
			left join test_session ts on ts.id_jadwal_test = jt.id_jadwal_test and ts.id_user = u.id_user
			left join jawaban_user ju on
				ju.id_user = u.id_user and
				ju.id_jadwal_test = jt.id_jadwal_test and
				ju.id_form_soal = fs.id_form_soal and
				ju.id_soal = s.id_soal and
				ju.id_jawaban_soal is not null
			left join jawaban_soal js on js.id_jawaban_soal = ju.id_jawaban_soal
			where p.id_pembayaran = {$id_pembayaran} and p.id_user = {$id_user}
			group by p.id_pembayaran, ts.id_test_session, jt.tanggal_test, fs.nama_form, fs.nilai_kkm
			order by jt.tanggal_test")->row();
	}
	
	function get_detail_per_kelompok_soal($id_test_session)
	{
		return $this->db->query(
			"SELECT ks.id_kelompok_soal, ks.nama_kelompok, SUM(js.is_kunci) AS jumlah_benar, SUM(IF(js.is_kunci=0, 1, 0)) AS jumlah_salah
			FROM test_session ts
			JOIN jadwal_test jt ON jt.id_jadwal_test = ts.id_jadwal_test
			JOIN form_soal fs ON fs.id_form_soal = jt.id_form_soal
			JOIN soal s ON s.id_form_soal = fs.id_form_soal
			JOIN kelompok_soal ks ON ks.id_kelompok_soal = s.id_kelompok_soal
			LEFT JOIN jawaban_user ju ON 
				ju.id_user = ts.id_user AND
				ju.id_jadwal_test = jt.id_jadwal_test AND
				ju.id_form_soal = fs.id_form_soal AND
				ju.id_soal = s.id_soal AND
				ju.id_jawaban_soal IS NOT NULL
			LEFT JOIN jawaban_soal js ON js.id_jawaban_soal = ju.id_jawaban_soal
			WHERE ts.id_test_session = {$id_test_session}
			GROUP BY ks.id_kelompok_soal, ks.nama_kelompok
			ORDER BY ks.nama_kelompok")->result();
	}
	
	function list_test_session_finished($id_user, $id_test_session_selected = 0)
	{
		// All session
		if ($id_test_session_selected == 0)
		{
			$test_session_set = $this->db
				->order_by('start_time', 'DESC')
				->get_where('test_session', array('id_user' => $id_user))
				->result();
		}
		// selecte single session
		else
		{
			$test_session_set = $this->db
				->select('test_session.*, user.nama, user.email')
				->from('test_session')
				->join('user', 'user.id_user = test_session.id_user')
				->where(array('id_test_session' => $id_test_session_selected))
				->order_by('start_time', 'DESC')
				->get()
				->result();
		}
		
		foreach ($test_session_set as &$test_session)
		{			
			$test_session->form_soal = $this->db->query(
				"SELECT ts.id_test_session, nama_form, 
					COUNT(s.id_soal) AS jumlah_soal, 
					COUNT(ju.id_jawaban_soal) AS jumlah_dijawab,
					SUM(ju.is_ragu) AS jumlah_ragu,
					(SUM(js.is_kunci)/COUNT(s.id_soal))*100 AS skor_akhir
				FROM test_session ts
				JOIN jadwal_test jt ON jt.id_jadwal_test = ts.id_jadwal_test
				JOIN form_soal fs ON fs.id_form_soal = jt.id_form_soal
				JOIN soal s ON s.id_form_soal = fs.id_form_soal
				LEFT JOIN jawaban_user ju ON 
					ju.id_user = ts.id_user AND
					ju.id_jadwal_test = jt.id_jadwal_test AND
					ju.id_form_soal = fs.id_form_soal AND
					ju.id_soal = s.id_soal AND
					ju.id_jawaban_soal IS NOT NULL
				LEFT JOIN jawaban_soal js ON js.id_jawaban_soal = ju.id_jawaban_soal
				WHERE ts.id_test_session = {$test_session->id_test_session} 
				GROUP BY ts.id_test_session")->row();
				
			$test_session->kelompok_soal_set = $this->db->query(
				"SELECT ks.id_kelompok_soal, ks.nama_kelompok, SUM(js.is_kunci) AS jumlah_benar, SUM(IF(js.is_kunci=0, 1, 0)) AS jumlah_salah
				FROM test_session ts
				JOIN jadwal_test jt ON jt.id_jadwal_test = ts.id_jadwal_test
				JOIN form_soal fs ON fs.id_form_soal = jt.id_form_soal
				JOIN soal s ON s.id_form_soal = fs.id_form_soal
				JOIN kelompok_soal ks ON ks.id_kelompok_soal = s.id_kelompok_soal
				LEFT JOIN jawaban_user ju ON 
					ju.id_user = ts.id_user AND
					ju.id_jadwal_test = jt.id_jadwal_test AND
					ju.id_form_soal = fs.id_form_soal AND
					ju.id_soal = s.id_soal AND
					ju.id_jawaban_soal IS NOT NULL
				LEFT JOIN jawaban_soal js ON js.id_jawaban_soal = ju.id_jawaban_soal
				WHERE ts.id_test_session = {$test_session->id_test_session}
				GROUP BY ks.id_kelompok_soal, ks.nama_kelompok
				ORDER BY ks.nama_kelompok")->result();
		}
		
		return $test_session_set;
	}
}