<?php

/**
 * @author Fathoni
 * @property CI_Email $email
 * @property CI_URI $uri Description
 * @property CI_Loader $load
 * @property Jadwal_model $jadwal_model
 * @property Report_model $report_model
 * @property User_model $user_model
 * @property Smarty_wrapper $smarty
 */
class Cron extends CI_Controller
{
	public function index()
	{
		$method_name = $_SERVER['argv'][2];
		$this->$method_name();
	}
	
	function send_test_result()
	{
		setlocale(LC_TIME, 'id_ID');
		
		$this->load->library('email');
		
		$this->load->model('jadwal_model');
		$this->load->model('report_model');
		$this->load->model('user_model');
		
		$jadwal_test_set = $this->jadwal_model->list_jadwal_selesai_blm_email();
		
		if (count($jadwal_test_set) > 0)
		{
			// Ambil satu terakhir
			$jadwal_test = $jadwal_test_set[0];
			$this->smarty->assignByRef('jadwal_test', $jadwal_test);
			
			// Daftar peserta yg belum di email
			$peserta_set = $this->jadwal_model->list_peserta_of_jadwal($jadwal_test);
			
			// counter terkirim
			$n_email_sent = 0;
			
			// Jika ada peserta
			if (count($peserta_set) > 0)
			{
				// Jadwal TEST
				echo "Pengiriman email hasil test untuk jadwal : " . $jadwal_test->tanggal_test . " Jumlah peserta ".count($peserta_set)."\r\n";
				
				// Data hasil test
				$data_set = $this->report_model->detail_peserta_per_jadwal($jadwal_test->id_jadwal_test);
				$this->smarty->assignByRef('data_set', $data_set);
				
				// Urutan kirim
				$i = 1;
				
				foreach ($peserta_set as $user)
				{
					// Masukkan informasi user
					$this->smarty->assignByRef('user', $user);

					$subject	= "Hai {$user->nama}, inilah hasil Try Out tanggal : ".strftime('%d %B %Y', strtotime($jadwal_test->tanggal_test));
					$body		= $this->smarty->fetch('send_test_result.tpl');
					$email		= $user->email;

					$this->email->from('no-reply@pediukdi.com', 'PEDIUKDI');
					$this->email->to($email);
					$this->email->subject($subject);
					$this->email->message($body);
					$send_result = $this->email->send();
					
					// Force TRUE
					//$send_result = true;
					
					if ($send_result)
					{
						$n_email_sent++;
						
						$this->user_model->update_sent_mail($user->id_test_session);
						
						echo "{$i}. Kirim {$email} Berhasil\r\n";
					}
					else
					{
						echo "{$i}. Kirim {$email} Gagal\r\n";
					}
					
					$i++;
				}
			}
			
			if ($n_email_sent == count($peserta_set))
			{
				// Update sudah selesai teremail semua
				$this->jadwal_model->update_sent_email($jadwal_test);
			}
		}
		else
		{
			echo "Tidak ada hasil test yang perlu dikirimkan";
		}
	}
}
