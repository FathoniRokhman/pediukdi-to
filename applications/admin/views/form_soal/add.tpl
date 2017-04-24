{extends file='../layout.tpl'}
{block name='content'}
	<h2 class="page-header">Master Lembar Soal</h2>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<fieldset>

			<!-- Form Name -->
			<legend><h4>Tambah Lembar Soal <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></h4></legend>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Nama Lembar Soal</label>  
				<div class="col-lg-6">
					<input id="textinput" name="nama_form" placeholder="Nama lembar soal" class="form-control input-md" type="text">
				</div>
			</div>
			
			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="nilai_kkm">Nilai Batas Lulus</label>  
				<div class="col-lg-1">
					<input id="nilai_kkm" name="nilai_kkm" class="form-control input-md" type="text">
				</div>
			</div>
			
			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="waktu_pengerjaan">Waktu Pengerjaan</label>  
				<div class="col-lg-2">
					<div class="input-group">
						<input id="waktu_pengerjaan" name="waktu_pengerjaan" class="form-control input-md" type="text">
						<span class="input-group-addon" id="basic-addon2">menit</span>
					</div>
				</div>
			</div>

			<!-- Button (Double) -->
			<div class="form-group">
				<div class="col-lg-6 col-lg-offset-2">
					<button id="button1id" name="save" class="btn btn-primary">Simpan</button>
					<a href="{site_url('form-soal/index')}" class="btn btn-default">Batal</a>
				</div>
			</div>

		</fieldset>
	</form>
{/block}