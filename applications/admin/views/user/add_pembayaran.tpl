{extends file='../layout.tpl'}
{block name='head'}
	<link href="{base_url('../assets/js/jquery-ui-1.12.1/jquery-ui.min.css')}" rel="stylesheet">
{/block}
{block name='content'}
	<h2 class="page-header">Daftar Pembayaran</h2>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<input type="hidden" name="id_user" value="{$user->id_user}" />
		<fieldset>

			<!-- Form Name -->
			<legend><h4>Tambah Pembayaran Tes - [{$user->nama}]</h4></legend>
			
			<!-- Select Basic -->
			<div class="form-group kelompok-soal">
				<label class="col-md-2 control-label" for="id_jadwal_test" >Jadwal Tes</label>
				<div class="col-md-5">
					<select id="id_jadwal_test" name="id_jadwal_test" class="form-control">
						<option value="">-- Pilih Jadwal Tes --</option>
						{html_options options=$jadwal_set_combo}
					</select>
				</div>
			</div>
					
			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="tanggal_bayar">Tanggal Bayar</label>  
				<div class="col-lg-2">
					<input id="tanggal_bayar" name="tanggal_bayar" class="form-control input-md" type="text" required="">
				</div>
			</div>
			
			<!-- Button (Double) -->
			<div class="form-group">
				<div class="col-md-4 col-md-offset-2">
					<a href="{site_url('user')}" class="btn btn-default">Batal</a>
					<input type="submit" value="Tambah" class="btn btn-primary"/>
				</div>
			</div>
			
		</fieldset>
	</form>
{/block}
{block name='footer-script'}
	<script src="{base_url('../assets/js/jquery-ui-1.12.1/jquery-ui.min.js')}"></script>
	<script>
		$('input[name="tanggal_bayar"]').datepicker({ dateFormat: "dd/mm/yy" });
	</script>
{/block}