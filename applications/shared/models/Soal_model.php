<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property CI_DB_query_builder $db Description
 */
class Soal_model extends CI_Model
{

	function list_form_soal()
	{
		$this->query = $this->db->order_by(1)->get('form_soal');
		return $this->query->result();
	}

	function get_form_soal($id_form_soal)
	{
		return $this->db->get_where('form_soal', array('id_form_soal' => $id_form_soal), 1)->first_row();
	}

	function add_form_soal()
	{
		$form_soal = new stdClass();
		$form_soal->nama_form = $this->input->post('nama_form');
		$form_soal->nilai_kkm = $this->input->post('nilai_kkm');
		$form_soal->waktu_pengerjaan = $this->input->post('waktu_pengerjaan');
		$form_soal->created = date('Y-m-d H:i:s');

		return $this->db->insert('form_soal', $form_soal);
	}

	function update_form_soal($id_form_soal)
	{
		$form_soal = new stdClass();
		$form_soal->nama_form = $this->input->post('nama_form');
		$form_soal->nilai_kkm = $this->input->post('nilai_kkm');
		$form_soal->waktu_pengerjaan = $this->input->post('waktu_pengerjaan');
		$form_soal->updated = date('Y-m-d H:i:s');

		return $this->db->update('form_soal', $form_soal, array('id_form_soal' => $id_form_soal));
	}

	function delete_form_soal($id_form_soal)
	{
		$this->db->trans_start();

		// Hapus Soal
		$this->db->delete('soal', array('id_form_soal' => $id_form_soal));

		// Hapus Form Soal
		$this->db->delete('form_soal', array('id_form_soal' => $id_form_soal));

		return $this->db->trans_complete();
	}

	function list_soal($id_form_soal)
	{
		$this->query = $this->db
			->select('soal.*, kelompok_soal.nama_kelompok', TRUE)
			->from('soal')
			->join('kelompok_soal', 'soal.id_kelompok_soal = kelompok_soal.id_kelompok_soal', 'LEFT')
			->where('id_form_soal', $id_form_soal)
			->order_by('no_soal')->get();
		
		return $this->query->result();
	}
	
	function get_soal($id_soal)
	{
		$soal = $this->db->get_where('soal', array('id_soal' => $id_soal), 1)->row();
		
		$huruf_set = array('a','b','c','d','e');
		
		foreach ($huruf_set as $huruf)
		{
			$soal->jawaban[$huruf] = $this->db->get_where('jawaban_soal', array('id_soal' => $id_soal, 'huruf' => $huruf))->row();
			
			// Handle row kosong
			if (is_null($soal->jawaban[$huruf]))
			{
				$soal->jawaban[$huruf] = new stdClass();
				$soal->jawaban[$huruf]->jawaban = '';
				$soal->jawaban[$huruf]->is_kunci = 0;
			}
		}
		
		return $soal;
	}
	
	function get_soal_by_no($id_form_soal, $no_soal)
	{
		// get id_soal
		$id_soal = $this->db->select('id_soal')
			->get_where('soal', array('id_form_soal' => $id_form_soal, 'no_soal' => $no_soal))
			->first_row()
			->id_soal;
		
		return $this->get_soal($id_soal);
	}
	
	function count_soal($id_form_soal)
	{
		return $this->db
			->where(array('id_form_soal' => $id_form_soal))
			->count_all_results('soal');
	}
	
	function add_soal()
	{
		$this->db->trans_begin();
		
		$created = date('Y-m-d H:i:s');
		
		$soal					= new stdClass();
		$soal->id_form_soal		= $this->input->post('id_form_soal');
		$soal->no_soal			= trim($this->input->post('no_soal'));
		$soal->isi_soal			= trim($this->input->post('isi_soal'));
		$soal->pembahasan_soal	= trim($this->input->post('pembahasan_soal'));
		$soal->id_kelompok_soal = $this->input->post('id_kelompok_soal');
		$soal->created			= $created;
		
		$this->db->insert('soal', $soal);
		
		// Dapatkan ID setelah insert
		$soal->id_soal = $this->db->insert_id();
		
		foreach ($this->input->post('jawaban') as $key => $value)
		{
			$jawaban_soal			= new stdClass();
			$jawaban_soal->id_soal	= $soal->id_soal;
			$jawaban_soal->huruf	= $key;
			$jawaban_soal->jawaban	= trim($value);
			$jawaban_soal->is_kunci	= ($key == $this->input->post('kunci')) ? 1 : 0;
			$jawaban_soal->created	= $created;
			
			$this->db->insert('jawaban_soal', $jawaban_soal);
		}
		
		return $this->db->trans_commit();
	}
	
	function update_soal($id_soal)
	{
		$this->db->trans_begin();
		
		$updated = date('Y-m-d H:i:s');
		
		$soal					= new stdClass();
		$soal->no_soal			= trim($this->input->post('no_soal'));
		$soal->isi_soal			= trim($this->input->post('isi_soal'));
		$soal->pembahasan_soal	= trim($this->input->post('pembahasan_soal'));
		$soal->id_kelompok_soal = $this->input->post('id_kelompok_soal');
		$soal->updated			= $updated;
		
		$this->db->update('soal', $soal, array('id_soal' => $id_soal));
		
		// Reset Kunci
		$this->db->update('jawaban_soal', array('is_kunci' => 0), array('id_soal' => $id_soal));
		
		foreach ($this->input->post('jawaban') as $key => $value)
		{
			$jawaban_soal			= new stdClass();
			$jawaban_soal->huruf	= $key;
			$jawaban_soal->jawaban	= trim($value);
			$jawaban_soal->is_kunci	= ($key == $this->input->post('kunci')) ? 1 : 0;
			$jawaban_soal->updated	= $updated;
			
			$this->db->update('jawaban_soal', $jawaban_soal, array('id_soal' => $id_soal, 'huruf' => $key));
		}
		
		return $this->db->trans_commit();
	}
	
	function delete_soal($id_soal)
	{
		return $this->db->delete('soal', array('id_soal' => $id_soal));
	}
	
	function list_kelompok_soal()
	{
		return $this->db->order_by('1')->get('kelompok_soal')->result();
	}
	
	function get_kelompok_soal($id_kelompok_soal)
	{
		return $this->db->get_where('kelompok_soal', array('id_kelompok_soal' => $id_kelompok_soal), 1)->row();
	}
	
	function add_kelompok_soal()
	{
		$kelompok_soal = new stdClass();
		$kelompok_soal->nama_kelompok = $this->input->post('nama_kelompok');
		$kelompok_soal->created = date('Y-m-d H:i:s');

		return $this->db->insert('kelompok_soal', $kelompok_soal);
	}
	
	function update_kelompok_soal($id_kelompok_soal)
	{
		$kelompok_soal = new stdClass();
		$kelompok_soal->nama_kelompok = $this->input->post('nama_kelompok');
		$kelompok_soal->updated = date('Y-m-d H:i:s');
		
		return $this->db->update('kelompok_soal', $kelompok_soal, array('id_kelompok_soal' => $id_kelompok_soal));
	}
	
	function delete_kelompok_soal($id_kelompok_soal)
	{
		return $this->db->delete('kelompok_soal', array('id_kelompok_soal' => $id_kelompok_soal));
	}
	
	function list_jawaban_of_soal($id_soal)
	{
		return $this->db->order_by('huruf')->get_where('jawaban_soal', array('id_soal' => $id_soal))->result();
	}
}
