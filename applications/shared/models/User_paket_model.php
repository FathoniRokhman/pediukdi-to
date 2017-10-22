<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_query_builder $db
 * @property CI_DB_mysqli_driver $db
 */
class User_paket_model extends CI_Model
{
	public function list_all()
	{
		$sql = 
			"select up.id_user_paket, u.nama, u.no_hp, u.institusi, p.nama_periode, p.waktu_mulai, pp.nama_paket
			from user_paket up
			join user u on u.id_user = up.id_user
			join periode_paket pp on pp.id_periode_paket = up.id_periode_paket
			join periode p on p.id_periode = pp.id_periode";
		
		return $this->db->query($sql)->result();
	}
	
	public function get_active($id_user)
	{
		$current_time = date('Y-m-d H:i:s');
		
		return $this->db
			->select('up.*')
			->from('user_paket up')
			->join('periode_paket pp', 'pp.id_periode_paket = up.id_periode_paket')
			->join('periode p', 'p.id_periode = pp.id_periode')
			->where('up.id_user', $id_user)
			->where("cast('{$current_time}' as datetime) between waktu_mulai and waktu_selesai", NULL, FALSE)
			->order_by('waktu_mulai', 'asc')
			->limit(1)
			->get()
			->row();
	}
	
	public function add(stdClass &$model)
	{
		$result = $this->db->insert('user_paket', $model);
		
		// get PK
		$model->id_user_paket = $this->db->insert_id();
		
		return $result;
	}
		
	public function get_single($id)
	{
		return $this->db->get_where('user_paket', ['id_user_paket' => $id], 1)->row();
	}
	
	public function delete($id)
	{
		$this->db->trans_begin();
		
		$this->db->delete('user_paket_soal', ['id_user_paket' => $id]);
		
		$this->db->delete('user_paket', ['id_user_paket' => $id]);
		
		return $this->db->trans_commit();
	}
}
