<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_query_builder $db 
 */
class Jawaban_user_model extends CI_Model
{
	function get_single($id_user, $id_user_paket_soal, $id_form_soal, $id_soal)
	{
		return $this->db->get_where('jawaban_user', array(
			'id_user' => $id_user,
			'id_user_paket_soal' => $id_user_paket_soal,
			'id_form_soal' => $id_form_soal,
			'id_soal' => $id_soal
		))->first_row();
	}
	
	function count($id_user, $id_user_paket_soal, $id_form_soal)
	{
		return $this->db
			->from('jawaban_user')
			->where(array(
				'id_user' => $id_user,
				'id_user_paket_soal' => $id_user_paket_soal,
				'id_form_soal' => $id_form_soal
			))->count_all_results();
	}
	
	function list_jawaban_user($id_user, $id_user_paket_soal, $id_form_soal)
	{
		return $this->db
			->select('jawaban_user.*, soal.no_soal')
			->from('jawaban_user')
			->join('soal', 'soal.id_soal = jawaban_user.id_soal', 'LEFT')
			->where(array(
				'id_user' => $id_user,
				'id_user_paket_soal' => $id_user_paket_soal,
				'jawaban_user.id_form_soal' => $id_form_soal
			))
			->get()->result();
	}
	
	function add(stdClass $jawaban_user)
	{
		return $this->db->insert('jawaban_user', $jawaban_user);
	}
	
	function update($id_jawaban_user, stdClass $model)
	{
		return $this->db->update('jawaban_user', $model, array('id_jawaban_user' => $id_jawaban_user));
	}
}
