<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_query_builder $db 
 */
class User_paket_soal_model extends CI_Model
{	
	public $id_user_paket_soal;
	public $id_user_paket;
	public $id_periode_soal;
	public $start_time;
	public $is_finished;
	public $email_sent;
	public $created;
	
	/**
	 * @var Periode_soal_model 
	 */
	public $periode_soal;
	
	/**
	 * @param int $id
	 * @return User_paket_soal_model
	 */
	public function get_single($id)
	{
		return $this->db->get_where('user_paket_soal', ['id_user_paket_soal' => $id], 1)->row();
	}
	
	public function add(stdClass $model)
	{
		return $this->db->insert('user_paket_soal', $model);
	}
	
	public function update($id, stdClass $model)
	{
		return $this->db->update('user_paket_soal', $model, ['id_user_paket_soal' => $id]);
	}
	
	public function set_finished($id)
	{
		return $this->db->update('user_paket_soal', array(
			'is_finished' => 1
		), array('id_user_paket_soal' => $id));
	}
	
	public function list_all($id_user_paket)
	{
		return $this->db->get_where('user_paket_soal', ['id_user_paket' => $id_user_paket])->result();
	}
	
	public function list_all_with_form_soal($id_user_paket)
	{
		return $this->db
			->select('ups.id_user_paket_soal, ps.tgl_mulai, fs.nama_form, ups.is_finished, ups.start_time')
			->from('user_paket_soal ups')
			->join('periode_soal ps', 'ps.id_periode_soal = ups.id_periode_soal')
			->join('form_soal fs', 'fs.id_form_soal = ps.id_form_soal')
			->where('ups.id_user_paket', $id_user_paket)
			->get()->result();
	}
	
	public function list_all_with_result($id_user_paket)
	{
		// SAMPAI SINI
		return $this->db
			->select('ups.id_user_paket_soal, ps.tgl_mulai, fs.nama_form, ups.is_finished, ups.start_time, fs.nilai_kkm')
			->select('0 as jumlah_dijawab, 0 as jumlah_kosong, 0 as jumlah_ragu, 0 as skor_akhir, 0 as id_pembayaran', false)
			->select('(select count(*) from soal s where s.id_form_soal = fs.id_form_soal) as jumlah_soal', false)
			->from('user_paket_soal ups')
			->join('periode_soal ps', 'ps.id_periode_soal = ups.id_periode_soal')
			->join('form_soal fs', 'fs.id_form_soal = ps.id_form_soal')
			->where('ups.id_user_paket', $id_user_paket)
			->get()->result();
	}
}
