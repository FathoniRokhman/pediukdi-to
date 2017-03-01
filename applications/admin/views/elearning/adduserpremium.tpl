{extends file='../layout.tpl'}
{block name='content'}
	<h2 class="page-header">Master Premium User</h2>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<fieldset>

			<!-- Form Name -->
			<legend><h4>Tambah Premium User <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></h4></legend>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Nama User</label>  
				<div class="col-lg-6">
				{if $is_user == '0'}
					<select class="form-control input-md" name="idUser">
						<option value="">-- Semua user Sudah ditambahkan ke Premium User --</option>
					</select>
					{form_error('idUser')}
				{else}
					<select class="form-control input-md" name="idUser">
						<option value="">-- Pilih User --</option>
						{foreach $dt_user as $data}
						<option value="{$data.id_user}">{$data.nama} ({$data.email})</option>
						{/foreach}
					</select>
					{form_error('idUser')}
				{/if}
				</div>
			</div>

			

			<!-- Button (Double) -->
			<div class="form-group">
				<div class="col-lg-6 col-lg-offset-2">
					<button id="button1id" name="save" class="btn btn-primary">Simpan</button>
					<a href="{site_url('elearning/userpremium')}" class="btn btn-default">Batal</a>
				</div>
			</div>

		</fieldset>
	</form>
{/block}
