<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property Pembayaran_model $pembayaran_model
 * @property Jadwal_model $jadwal_model
 * @property User_model $user_model
 * @property User_paket_model $user_paket_model
 * @property Elearning_model $elearning_model
 * @property Test_session_model $test_session_model
 */
class Home extends USER_Controller
{
	function __construct()
	{
		parent::__construct();
		
		$this->check_credentials();
	}
	
	function index()
	{
		// Lokal indonesia
		setlocale(LC_TIME, 'id_ID');
		
		$user = $this->session->userdata('user');
				
		// Ambil paket user aktif
		$user_paket = $this->user_paket_model->get_active($user->id_user);
		
		if ($user_paket != NULL)
		{	
			$user_paket->periode_paket = $this->periode_paket_model->get_single($user_paket->id_periode_paket);
			$user_paket->periode_paket->periode = $this->periode_model->get_single($user_paket->periode_paket->id_periode);
			$this->smarty->assign('user_paket', $user_paket);
			
			// $jadwal_test = $this->jadwal_model->get_jadwal($pembayaran_aktif->id_jadwal_test);
			// $this->smarty->assign('jadwal_test', $jadwal_test);
		}
		
		$test_session = $this->test_session_model->get_active_session($user->id_user);
		
		// Jika masih punya session langsung redirect ke 
		if ($test_session)
		{
			redirect('test/soal/1/');
		}
		
		$this->smarty->assign('user', $user);
		$this->smarty->display();
	}
	
	function jadwal_test()
	{
		$this->smarty->display();
	}

	function elearning()
	{
		// get list video
		$user = $this->session->userdata('user');
		$isPremiumFiture = $this->elearning_model->isPremiumFiture($user->id_user) > 0 ? 1 : 0;
		$offset = 0;
		$limitation = 6;
		
		$this->load->library('pagination');
		$config['base_url'] = site_url('home/elearning');
		$config['total_rows'] = $this->db->get('elearning_video')->num_rows();
		$config['per_page'] = 6;
		$config["uri_segment"] = 3;
		$choice = $config["total_rows"] / $config["per_page"];
		$config["num_links"] = floor($choice);

        //config for bootstrap pagination class integration
        $config['full_tag_open'] = '<ul class="pagination">';
        $config['full_tag_close'] = '</ul>';
        $config['first_link'] = false;
        $config['last_link'] = false;
        $config['first_tag_open'] = '<li>';
        $config['first_tag_close'] = '</li>';
        $config['prev_link'] = '&laquo';
        $config['prev_tag_open'] = '<li class="prev">';
        $config['prev_tag_close'] = '</li>';
        $config['next_link'] = '&raquo';
        $config['next_tag_open'] = '<li>';
        $config['next_tag_close'] = '</li>';
        $config['last_tag_open'] = '<li>';
        $config['last_tag_close'] = '</li>';
        $config['cur_tag_open'] = '<li class="active"><a href="#">';
        $config['cur_tag_close'] = '</a></li>';
        $config['num_tag_open'] = '<li>';
        $config['num_tag_close'] = '</li>';

        $this->pagination->initialize($config);

        $page = ($this->uri->segment(3)) ? $this->uri->segment(3) : 0;

        $data_video = $this->elearning_model->listVideo($config['per_page'],$page);
        foreach ($data_video as $key => $value) 
		{
        	$data_video[$key]['linkVideo'] = str_replace('watch?v=', 'embed/', $data_video[$key]['linkVideo']);;//'https://www.youtube.com/watch?v=4T5g-9E6PUs';
        }
		
		$linkPaging = $this->pagination->create_links();

		$this->smarty->assign('linkPaging', $linkPaging);
		$this->smarty->assign('list_video', $data_video);
		$this->smarty->assign('isAllowVideo', $isPremiumFiture);
		$this->smarty->display('home/elearning.tpl');
	}

}
