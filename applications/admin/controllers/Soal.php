<?php

/**
 * @author Fathoni <m.fathoni@mail.com>
 * @property Form_soal_model $form_soal_model 
 * @property Soal_model $soal_model
 * @property CI_Output $output 
 */
class Soal extends ADMIN_Controller
{
	function __construct()
	{
		parent::__construct();
		
		$this->load->model('form_soal_model');
		$this->load->model('soal_model');
	}
	
	function index()
	{
		$this->load->helper('security');
		
		$this->smarty->assignForCombo('form_soal_set', $this->soal_model->list_form_soal(), 'id_form_soal', 'nama_form');
		
		// ifs : id_form_soal
		if ($this->input->get('ifs'))
		{
			$data_set = $this->soal_model->list_soal($this->input->get('ifs'));
			
			// Cleaning HTML Tag
			foreach ($data_set as &$data)
			{
				// Clear image
				$data->isi_soal = preg_replace("/<img[^>]+\>/i", " <i>(GAMBAR)</i> ", $data->isi_soal); 
				
				// Clear p tag
				$data->isi_soal = str_replace('<p>', '', $data->isi_soal);
				$data->isi_soal = str_replace('</p>', '', $data->isi_soal);
			}
			
			$this->smarty->assignByRef('data_set', $data_set);
		}
				
		$this->smarty->display();
	}
	
	function add()
	{
		if ($this->input->method() == 'post')
		{
			$result = $this->soal_model->add_soal();
			
			if ($result)
			{
				redirect('soal?ifs=' . $this->input->post('id_form_soal'));
			}
		}
		
		$form_soal = $this->form_soal_model->get_single($this->input->get('ifs'));
		$this->smarty->assignByRef('form_soal', $form_soal);
		
		$this->smarty->assignForCombo('kelompok_soal_set', $this->soal_model->list_kelompok_soal(), 'id_kelompok_soal', 'nama_kelompok');
		
		$this->smarty->display();
	}
	
	function edit($id_soal)
	{
		if ($this->input->method() == 'post')
		{
			$result = $this->soal_model->update_soal($id_soal);
			
			if ($result)
			{
				redirect('soal?ifs=' . $this->input->post('id_form_soal'));
			}
		}
		
		$soal = $this->soal_model->get_soal($id_soal);
		$this->smarty->assignByRef('soal', $soal);
		
		$form_soal = $this->form_soal_model->get_single($soal->id_form_soal);
		$this->smarty->assignByRef('form_soal', $form_soal);
		
		$this->smarty->assignForCombo('kelompok_soal_set', $this->soal_model->list_kelompok_soal(), 'id_kelompok_soal', 'nama_kelompok');
		
		$this->smarty->display();
	}
	
	function delete($id_soal, $ifs)
	{
		if ($this->input->method() == 'post')
		{
			$this->soal_model->delete_soal($id_soal);
			
			redirect('soal?ifs='.$ifs);
		}
	}
	
	/**
	 * Upload Files handle CKEditor
	 * Reference : http://docs.ckeditor.com/#!/guide/dev_file_upload
	 * Ref Article : http://derekmd.com/2013/03/ckeditor-image-upload-in-codeigniter/
	 */
	function upload_img()
	{	
		$url = ""; $msg = "";
		
		if ($_FILES['upload']['error'] == UPLOAD_ERR_OK)
		{
			$orig_name		= pathinfo($_FILES['upload']['name'], PATHINFO_BASENAME);
			$orig_ext		= pathinfo($_FILES['upload']['name'], PATHINFO_EXTENSION);
			$encrypted_name = md5(time() . '-' . $orig_name);
			
			if (move_uploaded_file($_FILES['upload']['tmp_name'], '../uploads/'.$encrypted_name.'.'.$orig_ext))
			{
				$url = $this->config->item('app_site_url') . 'uploads/' . $encrypted_name.'.'.$orig_ext;
				$msg = "Berhasil upload " . $_FILES['upload']['name'] . " sebagai file " . $encrypted_name.'.'.$orig_ext;
			}
		}
		else
		{
			$msg = "Gagal upload. Error Code : " . $_FILES['upload']['error'];
		}
		
		$callback	= $this->input->get('CKEditorFuncNum');
		
		// Callback function that inserts image into correct CKEditor instance
        $output = '<html><body><script type="text/javascript">' .
            'window.parent.CKEDITOR.tools.callFunction(' .
            $callback .
            ', "' .
            $url .
            '", "' .
            $msg .
            '");</script></body></html>';
 
        echo $output;
	}
}
