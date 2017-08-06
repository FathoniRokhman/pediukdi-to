<?php

/**
 * Description of Pembayaran_model
 *
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_query_builder $db Description
 */
class Pembayaran_model extends CI_Model
{
	/**
	 * Get pembayaran, perlu id_user untuk memperkuat security
	 * @param int $id_pembayaran
	 * @param int $id_user
	 */
	function get($id_pembayaran, $id_user)
	{
		return $this->db->get_where('pembayaran', ['id_pembayaran' => $id_pembayaran, 'id_user' => $id_user], 1)->row();
	}
	
	function list_pembayaran()
	{
		$this->query = $this->db
			->select('p.id_pembayaran, u.nama, jt.tanggal_test, fs.nama_form, p.tanggal_bayar, jt.biaya')
			->from('pembayaran p')
			->join('user u', 'u.id_user = p.id_user')
			->join('jadwal_test jt', 'jt.id_jadwal_test = p.id_jadwal_test')
			->join('form_soal fs', 'fs.id_form_soal = jt.id_form_soal')
			->get();
		
		return $this->query->result();
	}
	
	function add()
	{
		$tanggal_bayar = date_create_from_format('d/m/Y', $this->input->post('tanggal_bayar'));
		
		$pembayaran = new stdClass();
		$pembayaran->id_jadwal_test = $this->input->post('id_jadwal_test');
		$pembayaran->id_user = $this->input->post('id_user');
		$pembayaran->tanggal_bayar = date_format($tanggal_bayar, 'Y-m-d');
		$pembayaran->is_aktif = 1;		// Status aktif = 1, soal bisa dikerjakan
		$pembayaran->created = date('Y-m-d H:i:s');
		
		return $this->db->insert('pembayaran', $pembayaran);
	}
	
	function delete($id_pembayaran)
	{
		// Hapus Pembayaran
		return $this->db->delete('pembayaran', array('id_pembayaran' => $id_pembayaran));
	}
	
	function get_pembayaran_aktif($id_user)
	{
		return $this->db->get_where('pembayaran', array(
			'id_user' => $id_user,
			'is_aktif' => 1
		))->row();
	}
}