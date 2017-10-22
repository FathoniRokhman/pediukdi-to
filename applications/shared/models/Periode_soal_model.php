<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_query_builder $db
 */
class Periode_soal_model extends CI_Model
{
	public $id_periode_soal;
	public $id_periode;
	public $id_form_soal;
	public $tgl_mulai;
	public $created;
	
	/**
	 * @var Form_soal_model 
	 */
	public $form_soal;
	
	public function list_all($id_periode)
	{	
		return $this->db
			->select('ps.id_periode_soal, ps.tgl_mulai, fs.nama_form, fs.waktu_pengerjaan')
			->from('periode_soal ps')
			->join('form_soal fs', 'fs.id_form_soal = ps.id_form_soal')
			->where('id_periode', $id_periode)
			->order_by('ps.tgl_mulai', 'asc')
			->get()
			->result();
	}
	
	public function list_by_id(array $id_periode_soal)
	{
		return $this->db
			->select('ps.id_periode_soal, ps.tgl_mulai, fs.nama_form, fs.waktu_pengerjaan')
			->from('periode_soal ps')
			->join('form_soal fs', 'fs.id_form_soal = ps.id_form_soal')
			->where_in('id_periode_soal', $id_periode_soal)
			->order_by('ps.tgl_mulai', 'asc')
			->get()
			->result();
	}
	
	public function add(stdClass $model)
	{
		return $this->db->insert('periode_soal', $model);
	}
	
	public function get_single($id)
	{
		return $this->db->get_where('periode_soal', ['id_periode_soal' => $id], 1)->row();
	}
	
	public function update($id, stdClass $model)
	{
		return $this->db->update('periode_soal', $model, ['id_periode_soal' => $id]);
	}
}
