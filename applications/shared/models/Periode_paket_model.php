<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_query_builder $db	
 */
class Periode_paket_model extends CI_Model
{
	public function list_all($id_periode)
	{
		return $this->db->get_where('periode_paket', ['id_periode' => $id_periode])->result();
	}
	
	public function add(stdClass $model)
	{
		return $this->db->insert('periode_paket', $model);
	}
	
	public function get_single($id)
	{
		return $this->db->get_where('periode_paket', ['id_periode_paket' => $id], 1)->row();
	}
	
	public function update($id, stdClass $model)
	{
		return $this->db->update('periode_paket', $model, ['id_periode_paket' => $id]);
	}
	
	public function delete($id)
	{
		return $this->db->delete('periode_paket', ['id_periode_paket' => $id], 1);
	}
}
