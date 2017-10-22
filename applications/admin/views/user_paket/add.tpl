{extends file='../layout.tpl'}
{block name='content'}
	<h2 class="page-header">Pendaftaran Tes</h2>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<fieldset>

			<!-- Form Name -->
			<legend><h4>Pendaftaran baru</h4></legend>
				
			<!-- Text input -->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Periode</label>  
				<div class="col-lg-6">
					<select name="id_periode" class="form-control" style="width: auto">
						{foreach $periode_set as $periode}
						<option value="{$periode->id_periode}">{$periode->nama_periode}</option>
						{/foreach}
					</select>
				</div>
			</div>
					
			<!-- Text input -->
			<div class="form-group">
				<label class="col-lg-2 control-label" for="textinput">Paket</label>  
				<div class="col-lg-6">
					<select name="id_periode_paket" class="form-control" style="width: auto"></select>
				</div>
			</div>
				
			<!-- Button (Double) -->
			<div class="form-group">
				<div class="col-lg-6 col-lg-offset-2">
					<input type="hidden" name="mode" value="pilih" />
					<button name="pilih" class="btn btn-primary">Lanjut Pilih User &amp; Soal</button>
					<a href="{site_url('user-paket/index')}" class="btn btn-default">Batal</a>
				</div>
			</div>
			
		</fieldset>
	</form>
{/block}
{block name='footer-script'}
	<script type="text/javascript">
		$(document).ready(function() {
			$('select[name="id_periode"]').on('change', function() {
				$('select[name="id_periode_paket"]').html(null);
				$.getJSON('{site_url('user-paket/data-paket')}', { id_periode: this.value }, function(data) {
					$.each(data, function(key, val) {
						$('select[name="id_periode_paket"]').append('<option value="'+val.id_periode_paket+'">'+val.nama_paket+'</option>');
					});
				});
			});
			
			$('select[name="id_periode"]').trigger('change');
		});
	</script>
{/block}