{extends file='../layout.tpl'}
{block name='content'}
	<h2 class="page-header">Periode Tes</h2>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<fieldset>

			<!-- Form Name -->
			<legend><h4>Edit periode tes</h4></legend>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Nama Periode</label>  
				<div class="col-lg-6">
					<input name="nama_periode" placeholder="Nama periode" class="form-control input-md" type="text" value="{$data->nama_periode}">
				</div>
			</div>
			
			<!-- Text input -->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Waktu Mulai</label>  
				<div class="col-lg-6">
					{html_select_date prefix="waktu_mulai_" field_order="DMY" end_year="+5" time=$data->waktu_mulai_Date all_extra='class="form-control" style="width: auto; display: inline-block"'}
					<input type="text" name="waktu_mulai_Time" class="form-control" value="{$data->waktu_mulai_Time}" style="width: 80px; display: inline" />
				</div>
			</div>
					
			<!-- Text input -->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Waktu Selesai</label>  
				<div class="col-lg-6">
					{html_select_date prefix="waktu_selesai_" field_order="DMY" end_year="+5" time=$data->waktu_selesai_Date all_extra='class="form-control" style="width: auto; display: inline-block"'}
					<input type="text" name="waktu_selesai_Time" class="form-control" value="{$data->waktu_selesai_Time}" style="width: 80px; display: inline" />
				</div>
			</div>
					
			<!-- Text input -->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Status Aktif</label>  
				<div class="col-lg-2">
					<select name="is_aktif" class="form-control">
						<option value="1">Aktif</option>
						<option value="0">Tidak Aktif</option>
					</select>
				</div>
			</div>
			
			<!-- Button (Double) -->
			<div class="form-group">
				<div class="col-lg-6 col-lg-offset-2">
					<button id="button1id" name="save" class="btn btn-primary">Simpan</button>
					<a href="{site_url('periode/index')}" class="btn btn-default">Batal</a>
				</div>
			</div>
			
		</fieldset>
	</form>
{/block}