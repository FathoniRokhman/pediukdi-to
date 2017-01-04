{extends file='../layout.tpl'}
{block name='head'}
	<link href="{base_url('../assets/js/jquery-ui-1.12.1/jquery-ui.min.css')}" rel="stylesheet">
{/block}
{block name='content'}
	<h2 class="page-header">Jadwal Tes</h2>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<fieldset>

			<!-- Form Name -->
			<legend><h4>Tambah Jadwal Tes</h4></legend>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="tanggal_test">Tanggal Tes</label>  
				<div class="col-lg-2">
					<input id="tanggal_test" name="tanggal_test" class="form-control input-md" type="text" required="">
				</div>
			</div>
			
			<!-- Select Basic -->
			<div class="form-group">
				<label class="col-md-2 control-label" for="id_form_soal">Lembar Soal</label>
				<div class="col-md-4">
					<select id="id_form_soal" name="id_form_soal" class="form-control" required="">
						<option value="">-- Pilih Lembar Soal --</option>
						{html_options options=$form_soal_set}
					</select>
				</div>
			</div>
					
			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="biaya">Biaya Tes</label>  
				<div class="col-lg-2">
					<input id="biaya" name="biaya" class="form-control input-md" type="text" required="">
				</div>
			</div>

			<!-- Button (Double) -->
			<div class="form-group">
				<div class="col-lg-6 col-lg-offset-2">
					<button id="button1id" name="save" class="btn btn-primary">Simpan</button>
					<a href="{site_url('jadwal')}" class="btn btn-default">Batal</a>
				</div>
			</div>

		</fieldset>
	</form>
{/block}
{block name='footer-script'}
	<script src="{base_url('../assets/js/jquery-ui-1.12.1/jquery-ui.min.js')}"></script>
	<script>
		$('input[name="tanggal_test"]').datepicker({ dateFormat: "dd/mm/yy" });
	</script>
{/block}