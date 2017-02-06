<?php

/**
 * Description of Pembayaran_model
 *
 * @author Putre Rieskha <rieskha@gmail.com>
 * @property CI_DB_query_builder $db Description
 */
class Elearning_model extends CI_Model{

	function listVideo($limitation,$offset){
		if($offset == null) $offset = 0;
		return $this->db->limit($limitation,$offset)->get('elearning_video')->result_array();
		#return $this->query->result_array();
	}

	function listVideoA($limitation,$offset){
		if($offset == null) $offset = 0;
		return $this->db->limit($limitation,$offset)->get('elearning_video')->result_array();
		//return $this->query->result_array();
	}

	function getElearning ($idElearningVideo){
		return $this->db->get_where('elearning_video',array('idElearningVideo' => $idElearningVideo))->row_array();
	}

	function addVideo($data){
		return $this->db->insert('elearning_video',$data);
	}

	function updateVideo($dataUpdate,$id){
		return $this->db->where('idElearningVideo',$id)->update('elearning_video',$dataUpdate);
	}

	function deleteVideo($idElearningVideo){
		$this->db->where('idElearningVideo',$idElearningVideo)->delete('elearning_video');
	}

	function isPremiumFiture($idUser){
		return $this->db->get_where('premium_fiture',array('idUser' => $idUser))->num_rows();
	}


}