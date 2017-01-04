<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_query_builder $db
 */
class Jadwal_model extends CI_Model
{
	function list_jadwal()
	{	
		return $this->db
			->select('jt.id_jadwal_test, tanggal_test, nama_form, waktu_pengerjaan, biaya, count(p.id_pembayaran) as jumlah_pendaftar')
			->from('jadwal_test jt')
			->join('form_soal fs', 'fs.id_form_soal = jt.id_form_soal')
			->join('pembayaran p', 'p.id_jadwal_test = jt.id_jadwal_test', 'LEFT')
			->group_by('jt.id_jadwal_test, tanggal_test, nama_form, waktu_pengerjaan, biaya')
			->order_by('tanggal_test')
			->get()
			->result();
	}
	
	function get_jadwal($id_jadwal_test)
	{
		return $this->db->get_where('jadwal_test', array('id_jadwal_test' => $id_jadwal_test), 1)->row();
	}
	
	function add()
	{
		$tanggal_test = date_create_from_format('d/m/Y', $this->input->post('tanggal_test'));
		
		$jadwal_test = new stdClass();
		$jadwal_test->tanggal_test = date_format($tanggal_test, 'Y-m-d');
		$jadwal_test->id_form_soal = $this->input->post('id_form_soal');
		$jadwal_test->biaya = $this->input->post('biaya');
		$jadwal_test->created = date('Y-m-d H:i:s');
		
		return $this->db->insert('jadwal_test', $jadwal_test);
	}
	
	function update($id_jadwal_test)
	{
		$tanggal_test = date_create_from_format('d/m/Y', $this->input->post('tanggal_test'));
		
		$jadwal_test = new stdClass();
		$jadwal_test->tanggal_test = date_format($tanggal_test, 'Y-m-d');
		$jadwal_test->id_form_soal = $this->input->post('id_form_soal');
		$jadwal_test->biaya = $this->input->post('biaya');
		$jadwal_test->updated = date('Y-m-d H:i:s');
		
		return $this->db->update('jadwal_test', $jadwal_test, array('id_jadwal_test' => $id_jadwal_test));
	}
	
	function delete($id_jadwal_test)
	{
		return $this->db->delete('jadwal_test', array('id_jadwal_test' => $id_jadwal_test));
	}
	
	function list_jadwal_selesai_blm_email()
	{
		return $this->db
			->select('*')
			->from('jadwal_test')
			->where('tanggal_test <=', date('Y-m-d H:i:s'))
			->where('email_sent IS NULL', null, TRUE)
			->order_by('tanggal_test', 'DESC')  // terbaru first
			->get()
			->result();
	}
	
	function list_peserta_of_jadwal(stdClass $jadwal_test)
	{
		return $this->db
			->select('ts.id_test_session, u.id_user, u.nama, u.email')
			->from('jadwal_test jt')
			->join('test_session ts', 'ts.id_jadwal_test = jt.id_jadwal_test')
			->join('user u', 'u.id_user = ts.id_user')
			->where('jt.id_jadwal_test', $jadwal_test->id_jadwal_test)
			->where('ts.email_sent IS NULL', NULL, FALSE)
			->get()
			->result();
	}
	
	function update_sent_email(stdClass $jadwal_test)
	{
		return $this->db->update('jadwal_test', 
			array('email_sent' => date('Y-m-d H:i:s')), 
			array('id_jadwal_test' => $jadwal_test->id_jadwal_test));
	}
}
