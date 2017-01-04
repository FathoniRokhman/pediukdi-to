{extends file='../layout.tpl'}
{block name='content'}
	<h2 class="page-header">Master Kelompok Soal</h2>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<fieldset>

			<!-- Form Name -->
			<legend><h4>Tambah Kelompok Soal <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></h4></legend>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Nama Kelompok Soal</label>  
				<div class="col-lg-6">
					<input id="textinput" name="nama_kelompok" placeholder="Nama kelompok soal" class="form-control input-md" type="text">
				</div>
			</div>

			<!-- Button (Double) -->
			<div class="form-group">
				<div class="col-lg-6 col-lg-offset-2">
					<button id="button1id" name="save" class="btn btn-primary">Simpan</button>
					<a href="{site_url('kelompok-soal/index')}" class="btn btn-default">Batal</a>
				</div>
			</div>

		</fieldset>
	</form>
{/block}