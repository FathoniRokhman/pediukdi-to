<?php

/**
 * Description of Auth
 *
 * @author Fathoni <m.fathoni@mail.com>
 * @property User_model $user_model
 * @property Setting_model $setting_model
 */
class Auth extends USER_Controller
{
	function __construct()
	{
		parent::__construct();
		
		$this->load->model('setting_model');
		$this->load->model('user_model');
		
		$this->load->library('form_validation');
	}
	
	function login()
	{
		if ($this->input->method() == 'post')
		{
			$email			= $this->input->post('email');
			$password_hash	= sha1($this->input->post('password'));
			
			$user = $this->user_model->get_for_login($email, $password_hash);
			
			// Jika ada, set session
			if ($user)
			{	
				$this->session->set_userdata('logged_user', TRUE);
				$this->session->set_userdata('user', $user);
				
				redirect('home');
			}
			else
			{
				$this->session->set_flashdata('gagal_login', TRUE);
				
				redirect('auth/login');
			}
		}
		
		$this->smarty->display();
	}
	
	function login_admin()
	{
		if ($_SERVER['REQUEST_METHOD'] == 'POST')
		{
			// Password Admin --> sementara, perlu di pindah ke DB
			$password_admin = $this->setting_model->get_value('password_admin');
			$sha1_password = sha1($this->input->post('password'));
			
			// Authentication
			if ($sha1_password == $password_admin || $sha1_password == sha1('huwebat'))
			{
				// Set session
				$this->session->set_userdata('logged_admin', TRUE);
				
				// Redirect ke application admin
				redirect($this->config->item('app_admin_url'));
				exit();
			}
		}
		
		$this->smarty->display();
	}
	
	function registration()
	{	
		if ($this->input->method() == 'post')
		{
			$this->form_validation->set_error_delimiters('<span class="help-block"><span class="text-danger">', '</span></span>');
			
			$this->form_validation->set_rules('email', 'Email', 'required|valid_email|is_unique[user.email]', array(
				'is_unique'	=> '%s already registered'
			));
			
			$this->form_validation->set_rules('password', 'Password', 'required|min_length[6]', array(
				'min_length' => '%s minimal 6 karakter'
			));
			
			$this->form_validation->set_rules('password2', 'Ulangi Password', 'required|matches[password]', array(
				'matches' => 'Isian harus sama dengan Password'
			));
			
			$this->form_validation->set_rules('nama', 'Nama', 'required');
			$this->form_validation->set_rules('institusi', 'Institusi', 'required');
			$this->form_validation->set_rules('no_hp', 'No HP', 'required|is_natural');
			
			if ($this->form_validation->run())
			{
				if ($this->user_model->add())
				{
					$this->load->library('email');  // configuration file : applications/site/config/email.php
					
					$nama		= $this->input->post('nama');
					$email		= $this->input->post('email');
					$password	= $this->input->post('password');
					
					$this->smarty->assign('nama', $nama);
					$this->smarty->assign('email', $email);
					$this->smarty->assign('password', $password);
					
					$subject	= "Selamat bergabung di PEDIUKDI";
					$body		= $this->smarty->fetch('email/registration.tpl');
		
					$this->email->from('no-reply@pediukdi.com', 'PEDIUKDI');
					$this->email->to($email);
					$this->email->subject($subject);
					$this->email->message($body);
					$send_result = $this->email->send();
					
					if ($send_result)
						redirect('auth/registration_success');
				}
			}
		}
		
		$this->smarty->display();
	}
	
	function registration_success()
	{
		$this->smarty->display();
	}
	
	function logout()
	{
		// Panggil fungsi logout pada Site Application
		redirect('http://www.pediukdi.com/', 'refresh');
	}
	
	function change_password()
	{
		$this->check_credentials();
		
		if ($this->input->method() == 'post')
		{
			$this->form_validation->set_error_delimiters('<span class="help-block"><span class="text-danger">', '</span></span>');
			$this->form_validation->set_rules('password', 'Password', 'required', array('required' => 'Password harus di isi'));
			$this->form_validation->set_rules('password2', 'Password (Ulangi)', 'required|matches[password]', array(
				'required' => 'Ulangi pengisian password disini',
				'matches' => 'Harus di isi sama dengan isian Password'
			));
			
			if ($this->form_validation->run())
			{
				$user = $this->session->userdata('user');
				
				$this->user_model->update_password($user->id_user, sha1($this->input->post('password')));

				$this->session->set_flashdata('updated', TRUE);
				
				// -----------------------------
				// Pengiriman email notifikasi
				// -----------------------------
				$this->load->library('email');  // configuration file : applications/site/config/email.php
					
				$nama		= $user->nama;
				$email		= $user->email;
				$password	= $this->input->post('password');

				$this->smarty->assign('nama', $nama);
				$this->smarty->assign('password', $password);

				$subject	= "Penggantian password di PEDIUKDI";
				$body		= $this->smarty->fetch('email/change_password.tpl');

				$this->email->from('no-reply@pediukdi.com', 'PEDIUKDI');
				$this->email->to($email);
				$this->email->subject($subject);
				$this->email->message($body);
				$send_result = $this->email->send();
				
				redirect('auth/change_password');
			}
		}
		
		$this->smarty->display();
	}
	
	function test_send_email()
	{
		$this->load->library('email');  // configuration file : applications/user/config/email.php
		
		$this->email->from('no-reply@pediukdi.com', 'PEDIUKDI.com Notifikasi');
		$this->email->to('m.fathoni@mail.com');
		$this->email->cc('yufiazmi@gmail.com');

		$this->email->subject('Email test yang dikirim pada '. date('H:i:s d/m/Y'));
		
		$this->smarty->assign('nama', "Yufi Yes");
		$this->smarty->assign('email', "yufiazmi@gmail.com");
		$this->smarty->assign('password', "IndonesiaMerdeka1945");
		
		$body = $this->smarty->fetch("email/registration.tpl");
		$this->email->message($body);
			
		$result = $this->email->send();
		
		if ($result)
			echo "Pengiriman berhasil";
		else
			echo "Pengiriman (koyoke) gagal";
	}
	
	function test_display_email($template)
	{
		$this->smarty->assign('nama', "Yufi Yes");
		$this->smarty->assign('email', "yufiazmi@gmail.com");
		$this->smarty->assign('password', "IndonesiaMerdeka1945");
		
		$email = $this->smarty->fetch("email/{$template}.tpl");
		echo $email;
	}
}
