<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_query_builder $db
 */
class Form_soal_model extends CI_Model
{
	public $id_form_soal;
	public $nama_form;
	public $nilai_kkm;
	public $waktu_pengerjaan;
	public $created;
	public $updated;
	
	function get_single($id_form_soal)
	{
		return $this->db->get_where('form_soal', array('id_form_soal' => $id_form_soal), 1)->first_row();
	}
	
	function add()
	{
		$form_soal = new stdClass();
		$form_soal->nama_form = $this->input->post('nama_form');
		$form_soal->nilai_kkm = $this->input->post('nilai_kkm');
		$form_soal->waktu_pengerjaan = $this->input->post('waktu_pengerjaan');
		$form_soal->created = date('Y-m-d H:i:s');

		return $this->db->insert('form_soal', $form_soal);
	}
	
	function update($id_form_soal)
	{
		$form_soal = new stdClass();
		$form_soal->nama_form = $this->input->post('nama_form');
		$form_soal->nilai_kkm = $this->input->post('nilai_kkm');
		$form_soal->waktu_pengerjaan = $this->input->post('waktu_pengerjaan');
		$form_soal->updated = date('Y-m-d H:i:s');

		return $this->db->update('form_soal', $form_soal, array('id_form_soal' => $id_form_soal));
	}
	
	function delete($id_form_soal)
	{
		$this->db->trans_start();

		// Hapus Soal
		$this->db->delete('soal', array('id_form_soal' => $id_form_soal));

		// Hapus Form Soal
		$this->db->delete('form_soal', array('id_form_soal' => $id_form_soal));

		return $this->db->trans_complete();
	}
}
