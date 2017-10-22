<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_query_builder $db Description
 */
class Periode_model extends CI_Model
{
	public function list_all()
	{
		return $this->db
			->select('periode.*')
			->select("(select count(*) from periode_paket pp where pp.id_periode = periode.id_periode) as jumlah_paket", FALSE)
			->select("(select count(*) from periode_soal ps where ps.id_periode = periode.id_periode) as jumlah_soal", FALSE)
			->get('periode')->result();
	}
	
	public function add(stdClass $model)
	{
		return $this->db->insert('periode', $model);
	}
	
	public function get_single($id)
	{
		return $this->db->get_where('periode', ['id_periode' => $id], 1)->row();
	}
	
	public function update($id, stdClass $model)
	{
		return $this->db->update('periode', $model, ['id_periode' => $id]);
	}
	
	public function delete($id)
	{
		return $this->db->delete('periode', ['id_periode' => $id], 1);
	}
}
