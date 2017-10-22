<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_query_builder $db
 * @property CI_Input $input
 */
class Test_session_model extends CI_Model
{
	public $id_user_paket_soal;
	public $nama;
	public $id_periode_soal;
	public $id_form_soal;
	public $waktu_pengerjaan;
	public $start_time;
	public $end_time;
	public $sisa;
	public $sisa_detik;
	
	/**
	 * Mendapatkan session test berjalan
	 */
	function get_active_session($id_user)
	{
		$current_time = date('Y-m-d H:i:s');
		
		return $this->db
			->select('ups.id_user_paket_soal, u.nama, ps.id_periode_soal, ps.id_form_soal, fs.waktu_pengerjaan, ups.start_time')
			->select('date_add(ups.start_time, interval fs.waktu_pengerjaan minute) as end_time', FALSE)
			->select("timediff(date_add(ups.start_time, interval fs.waktu_pengerjaan minute), '{$current_time}') as sisa", FALSE)
			->select("time_to_sec(timediff(date_add(ups.start_time, interval fs.waktu_pengerjaan minute), '{$current_time}')) as sisa_detik", FALSE)
			->from('user_paket_soal ups')
			->join('user_paket up', 'up.id_user_paket = ups.id_user_paket')
			->join('user u', 'u.id_user = up.id_user')
			->join('periode_soal ps', 'ps.id_periode_soal = ups.id_periode_soal')
			->join('form_soal fs', 'fs.id_form_soal = ps.id_form_soal')
			->where('up.id_user', $id_user)
			->where('ups.start_time IS NOT NULL', NULL, FALSE)
			->where('ups.is_finished', 0)
			->where("date_add(ups.start_time, INTERVAL fs.waktu_pengerjaan MINUTE) > '{$current_time}'", NULL, FALSE)
			->limit(1)->get()->row();
	}
	
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
	
	function list_test_session_finished($id_user, $id_user_paket_soal = 0)
	{
		// All session
		if ($id_user_paket_soal == 0)
		{
			$user_paket_soal_set = $this->db
				->select('ups.*, fs.nama_form')->from('user_paket_soal ups')
				->join('user_paket up', 'up.id_user_paket = ups.id_user_paket')
				->join('periode_soal ps', 'ps.id_periode_soal = ups.id_periode_soal')
				->join('form_soal fs', 'fs.id_form_soal = ps.id_form_soal')
				->where('up.id_user', $id_user)
				->where('ups.is_finished', 1)
				->order_by('start_time', 'DESC')
				->get()
				->result();
		}
		// selecte single session
		else
		{
			$user_paket_soal_set = $this->db
				->select('ups.*, u.nama, u.email, fs.nama_form')
				->from('user_paket_soal ups')
				->join('user_paket up', 'up.id_user_paket = ups.id_user_paket')
				->join('user u', 'u.id_user = up.id_user')
				->join('periode_soal ps', 'ps.id_periode_soal = ups.id_periode_soal')
				->join('form_soal fs', 'fs.id_form_soal = ps.id_form_soal')
				->where('id_user_paket_soal', $id_user_paket_soal)
				->order_by('start_time', 'DESC')
				->get()
				->result();
		}
		
		// SAMPAI SINI
		
		foreach ($user_paket_soal_set as &$user_paket_soal)
		{			
			$user_paket_soal->form_soal = $this->db->query(
				"SELECT ups.id_user_paket_soal, nama_form, 
					COUNT(s.id_soal) AS jumlah_soal, 
					COUNT(ju.id_jawaban_soal) AS jumlah_dijawab,
					SUM(ju.is_ragu) AS jumlah_ragu,
					(SUM(js.is_kunci)/COUNT(s.id_soal))*100 AS skor_akhir
				FROM user_paket_soal ups
				JOIN user_paket up ON up.id_user_paket = ups.id_user_paket
				JOIN periode_soal ps ON ps.id_periode_soal = ups.id_periode_soal
				JOIN form_soal fs ON fs.id_form_soal = ps.id_form_soal
				JOIN soal s ON s.id_form_soal = fs.id_form_soal
				LEFT JOIN jawaban_user ju ON 
					ju.id_user = up.id_user AND
					ju.id_user_paket_soal = ups.id_user_paket_soal AND
					ju.id_form_soal = fs.id_form_soal AND
					ju.id_soal = s.id_soal AND
					ju.id_jawaban_soal IS NOT NULL
				LEFT JOIN jawaban_soal js ON js.id_jawaban_soal = ju.id_jawaban_soal
				WHERE ups.id_user_paket_soal = {$user_paket_soal->id_user_paket_soal} 
				GROUP BY ups.id_user_paket_soal")->row();
				
			$user_paket_soal->kelompok_soal_set = $this->db->query(
				"SELECT ks.id_kelompok_soal, ks.nama_kelompok, SUM(js.is_kunci) AS jumlah_benar, SUM(IF(js.is_kunci=0, 1, 0)) AS jumlah_salah
				FROM user_paket_soal ups
				JOIN user_paket up ON up.id_user_paket = ups.id_user_paket
				JOIN periode_soal ps ON ps.id_periode_soal = ups.id_periode_soal
				JOIN form_soal fs ON fs.id_form_soal = ps.id_form_soal
				JOIN soal s ON s.id_form_soal = fs.id_form_soal
				JOIN kelompok_soal ks ON ks.id_kelompok_soal = s.id_kelompok_soal
				LEFT JOIN jawaban_user ju ON 
					ju.id_user = up.id_user AND
					ju.id_user_paket_soal = ups.id_user_paket_soal AND
					ju.id_form_soal = fs.id_form_soal AND
					ju.id_soal = s.id_soal AND
					ju.id_jawaban_soal IS NOT NULL
				LEFT JOIN jawaban_soal js ON js.id_jawaban_soal = ju.id_jawaban_soal
				WHERE ups.id_user_paket_soal = {$user_paket_soal->id_user_paket_soal} 
				GROUP BY ks.id_kelompok_soal, ks.nama_kelompok
				ORDER BY ks.nama_kelompok")->result();
		}
		
		return $user_paket_soal_set;
	}
}