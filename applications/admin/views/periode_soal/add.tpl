{extends file='../layout.tpl'}
{block name='content'}
	<h2 class="page-header">Daftar Soal <small>{$periode->nama_periode}</small></h2>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<fieldset>

			<!-- Form Name -->
			<legend><h4>Tambah soal</h4></legend>
			
			<!-- Text input -->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Tanggal Mulai</label>  
				<div class="col-lg-6">
					{html_select_date prefix="tgl_mulai_" field_order="DMY" end_year="+5" all_extra='class="form-control" style="width: auto; display: inline-block"'}
				</div>
			</div>
				
			<!-- Text input -->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Form Soal</label>  
				<div class="col-lg-6">
					<select name="id_form_soal" class="form-control" style="width: auto">
						{foreach $form_soal_set as $form_soal}
						<option value="{$form_soal->id_form_soal}">{$form_soal->nama_form}</option>
						{/foreach}
					</select>
				</div>
			</div>
				
			<!-- Button (Double) -->
			<div class="form-group">
				<div class="col-lg-6 col-lg-offset-2">
					<button id="button1id" name="save" class="btn btn-primary">Simpan</button>
					<a href="{site_url('periode-soal/index')}/{$periode->id_periode}" class="btn btn-default">Batal</a>
				</div>
			</div>
			
		</fieldset>
	</form>
{/block}