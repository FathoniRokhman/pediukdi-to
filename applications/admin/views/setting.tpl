{extends file='layout.tpl'}
{block name='content'}
	<h2 class="page-header">Setting Aplikasi</h2>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<fieldset>

			<!-- Form Name -->
			<legend>Main Setting</legend>

			<!-- Password input-->
			<div class="form-group">
				<label class="col-md-2 control-label" for="psw_adm">Password Admin</label>
				<div class="col-md-4">
					<input id="psw_adm" name="psw_adm" class="form-control" type="text" autocomplete="off"/>
					<span class="help-block">Password untuk masuk ke halaman administrator. Tidak perlu di isi jika tidak ingin mengganti</span>
				</div>
			</div>

			<!-- Select Basic -->
			<div class="form-group">
				<label class="col-md-2 control-label" for="id_form_soal">Lembar Soal Ujicoba </label>
				<div class="col-md-4">
					<select id="id_form_soal" name="id_form_soal" class="form-control input-md">
						<option value="">-- Pilih Lembar Soal--</option>
						{html_options options=$form_soal_set selected=$id_form_soal_contoh}
					</select>
					<span class="help-block">Pilihan soal yang akan di tampilkan di halaman depan</span>
				</div>
			</div>

			<!-- Button -->
			<div class="form-group">
				<div class="col-md-offset-2 col-md-2">
					<button class="btn btn-primary">Simpan</button>
				</div>
			</div>

		</fieldset>
	</form>
						
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">Informasi</h4>
				</div>
				<div class="modal-body">
					{if $ci->session->flashdata('updated')}
						Setting berhasil di simpan
					{/if}
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
{/block}
{block name='footer-script'}
	{if $ci->session->flashdata('updated')}
		<script type="text/javascript">$('#myModal').modal();</script>
	{/if}
{/block}