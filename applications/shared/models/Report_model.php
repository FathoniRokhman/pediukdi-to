<?php

/**
 * @author Fathoni
 */
class Report_model extends CI_Model
{
	function list_test_session_selesai()
	{
		$now = date('Y-m-d');
		
		$sql =
			"SELECT id_jadwal_test, tanggal_test, nama_form, 
				COUNT(id_user) AS peserta, AVG(skor) AS rata, MIN(skor) AS terendah, MAX(skor) AS tertinggi, STD(skor) AS deviasi
			FROM (
				SELECT jt.id_jadwal_test, jt.tanggal_test, fs.nama_form, 
					u.id_user, u.nama,
					COUNT(s.id_soal) AS jumlah_soal,
					COUNT(ju.id_jawaban_user) AS jumlah_benar,
					(COUNT(ju.id_jawaban_user)/COUNT(s.id_soal))*100 AS skor
				FROM jadwal_test jt
				JOIN form_soal fs ON fs.id_form_soal = jt.id_form_soal
				JOIN soal s ON s.id_form_soal = fs.id_form_soal
				JOIN jawaban_soal js ON js.id_soal = s.id_soal AND js.is_kunci = 1
				LEFT JOIN test_session ts ON ts.id_jadwal_test = jt.id_jadwal_test
				LEFT JOIN `user` u ON u.id_user = ts.id_user
				LEFT JOIN jawaban_user ju ON 
					ju.id_user = u.id_user AND
					ju.id_jadwal_test = jt.id_jadwal_test AND
					ju.id_form_soal = fs.id_form_soal AND
					ju.id_soal = s.id_soal AND
					ju.id_jawaban_soal = js.id_jawaban_soal
				WHERE jt.tanggal_test < '{$now}'
				GROUP BY jt.id_jadwal_test, jt.tanggal_test, fs.nama_form, u.id_user, u.nama
			) t1
			GROUP BY tanggal_test, nama_form
			ORDER BY tanggal_test DESC";
		
		return $this->db->query($sql)->result();
	}
	
	function detail_peserta_per_jadwal($id_jadwal_test)
	{
		$sql_data = 
			"SELECT 
				id_user, nama, start_time, 
				COUNT(DISTINCT id_soal) AS jumlah_soal,
				COUNT(id_jawaban_user) AS dijawab, 
				SUM(is_ragu) AS ragu, 
				SUM(IF(is_kunci=1,IF(ISNULL(id_jawaban_user),0,1),0)) AS benar
			FROM (
				SELECT jt.id_jadwal_test, fs.id_form_soal, s.id_soal, s.no_soal, js.is_kunci, ts.id_test_session, ts.start_time, u.id_user, u.nama, ju.id_jawaban_user, ju.is_ragu
				FROM jadwal_test jt
				JOIN form_soal fs ON fs.id_form_soal = jt.id_form_soal
				JOIN soal s ON s.id_form_soal = fs.id_form_soal
				LEFT JOIN jawaban_soal js ON js.id_soal = s.id_soal
				LEFT JOIN test_session ts ON ts.id_jadwal_test = jt.id_jadwal_test
				LEFT JOIN `user` u ON u.id_user = ts.id_user
				LEFT JOIN jawaban_user ju ON 
					ju.id_user = u.id_user AND
					ju.id_jadwal_test = jt.id_jadwal_test AND
					ju.id_form_soal = fs.id_form_soal AND
					ju.id_soal = s.id_soal AND
					ju.id_jawaban_soal = js.id_jawaban_soal
				WHERE jt.id_jadwal_test = ?
			) t1
			GROUP BY id_user, nama, start_time
			ORDER BY 7 DESC";
		
		return $this->db->query($sql_data, array($id_jadwal_test))->result();
	}
}
