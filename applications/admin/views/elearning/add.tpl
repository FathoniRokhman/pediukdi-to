{extends file='../layout.tpl'}
{block name='content'}
	<h2 class="page-header">Master Video E-learning</h2>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<fieldset>

			<!-- Form Name -->
			<legend><h4>Tambah Video <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></h4></legend>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Judul Video</label>  
				<div class="col-lg-6">
					<input id="judulVideo" name="judulVideo" placeholder="Judul Video" class="form-control input-md" type="text">
					{form_error('judulVideo')}
				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Deskripsi Video</label>  
				<div class="col-lg-6">
					<textarea id="deskripsiVideo" name="deskripsiVideo" placeholder="Deskripsi Video" class="form-control input-md"></textarea> 
					{form_error('judulVideo')}
				</div>
			</div>


			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Link Video</label>  
				<div class="col-lg-6">
					<input id="linkVideo" name="linkVideo" placeholder="Link Video" class="form-control input-md" type="text">
					{form_error('linkVideo')}
				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Status Video</label>  
				<div class="col-lg-6">
					<input type="radio" name="statusVideo" class="input-md" value="1"> Aktif
					<input type="radio" name="statusVideo" class="input-md" value="0"> Non-Aktif
					{form_error('statusVideo')}
				</div>
			</div>
			

			<!-- Button (Double) -->
			<div class="form-group">
				<div class="col-lg-6 col-lg-offset-2">
					<button id="button1id" name="save" class="btn btn-primary">Simpan</button>
					<a href="{site_url('elearning/index')}" class="btn btn-default">Batal</a>
				</div>
			</div>

		</fieldset>
	</form>
{/block}
