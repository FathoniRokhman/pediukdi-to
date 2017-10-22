{extends file='../layout.tpl'}
{block name='content'}
	<h2 class="page-header">Daftar Biaya Paket <small>{$periode->nama_periode}</small></h2>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<fieldset>

			<!-- Form Name -->
			<legend><h4>Tambah paket</h4></legend>
			
			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Nama Paket</label>  
				<div class="col-lg-6">
					<input name="nama_paket" placeholder="Nama paket" class="form-control input-md" type="text">
				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Jumlah Soal</label>  
				<div class="col-lg-2">
					<input name="jumlah" placeholder="Jumlah soal" class="form-control input-md" type="text">
				</div>
			</div>
			
			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Biaya</label>  
				<div class="col-lg-2">
					<input name="biaya" placeholder="Biaya" class="form-control input-md" type="text">
				</div>
			</div>
			
			<!-- Button (Double) -->
			<div class="form-group">
				<div class="col-lg-6 col-lg-offset-2">
					<button id="button1id" name="save" class="btn btn-primary">Simpan</button>
					<a href="{site_url('periode-paket/index')}/{$periode->id_periode}" class="btn btn-default">Batal</a>
				</div>
			</div>
			
		</fieldset>
	</form>
{/block}