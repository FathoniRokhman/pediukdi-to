<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property Pembayaran_model $pembayaran_model
 * @property Jadwal_model $jadwal_model Description
 * @property User_model $user_model
 * @property Elearning_model $elearning_model
 */
class Home extends USER_Controller
{
	function __construct()
	{
		parent::__construct();
		
		$this->check_credentials();
		
		$this->load->model('pembayaran_model');
		$this->load->model('jadwal_model');
		$this->load->model('user_model');
		$this->load->model('elearning_model');
	}
	
	function index()
	{
		// Lokal indonesia
		setlocale(LC_TIME, 'id_ID');
		
		$user = $this->session->userdata('user');
		
		// Ambil Pembayaran Aktif
		$pembayaran_aktif = $this->pembayaran_model->get_pembayaran_aktif($user->id_user);
		
		if ($pembayaran_aktif != NULL)
		{
			$this->smarty->assign('pembayaran_aktif', $pembayaran_aktif);
			
			$jadwal_test = $this->jadwal_model->get_jadwal($pembayaran_aktif->id_jadwal_test);
			
			$this->smarty->assign('jadwal_test', $jadwal_test);
		}
		
		$test_session = $this->user_model->get_test_session($user->id_user);
		
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

	function elearning(){
		
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
        foreach ($data_video as $key => $value) {
        	$data_video[$key]['linkVideo'] = str_replace('watch?v=', 'embed/', $data_video[$key]['linkVideo']);;//'https://www.youtube.com/watch?v=4T5g-9E6PUs';
        	
        }
		$linkPaging = $this->pagination->create_links();

		$this->smarty->assign('linkPaging', $linkPaging);
		$this->smarty->assign('list_video', $data_video);
		$this->smarty->assign('isAllowVideo', $isPremiumFiture);
		$this->smarty->display('home/elearning.tpl');
	}

}
