{extends file='../layout.tpl'}
{block name='head'}
	<link href="{site_url('../assets/DataTables/datatables.min.css')}" rel="stylesheet" />
	<style>
		legend { margin-bottom: 10px; }
		form { margin-bottom: 20px; }
	</style>
{/block}
{block name='content'}
	<h2 class="page-header">Pendaftaran Tes</h2>
	<h4>Periode {$periode->nama_periode} - {$periode_paket->nama_paket}</h4>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<fieldset>
			
			<legend><h4>Pilih User</h4></legend>

			<table id="tableUser" class="table-bordered table-condensed table-hover" style="width: 100%">
				<thead>
					<tr>
						<th></th>
						<th>Nama</th>
						<th>Asal</th>
						<th>Rotasi Klinik</th>
						<th>Telp</th>
						<th>Email</th>
					</tr>
				</thead>
			</table>
		</fieldset>
		
		<fieldset>
			<legend><h4>Pilih Soal : {$periode_paket->jumlah} soal</h4></legend>
			
			<table id="tableSoal" class="table-bordered table-condensed table-hover" style="width: 100%">
				<thead>
					<tr>
						<th></th>
						<th>Tanggal Mulai</th>
						<th>Form Soal</th>
						<th>Waktu Pengerjaan</th>
					</tr>
				</thead>
			</table>
		</fieldset>
		
				
		<fieldset>
			<input type="hidden" name="mode" value="preview" />
			<input type="hidden" name="id_periode" value="{$ci->input->post('id_periode')}" />
			<input type="hidden" name="id_periode_paket" value="{$ci->input->post('id_periode_paket')}" />
			<input type="hidden" name="jumlah_soal" value="{$periode_paket->jumlah}" />
			<button name="preview" class="btn btn-primary" disabled="disabled">Preview</button>
			<a href="{site_url('user-paket/index')}" class="btn btn-default">Batal</a>
		</fieldset>
		
	</form>
{/block}
{block name='footer-script'}
	<script src="{site_url('../assets/DataTables/datatables.min.js')}"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var tableUser = $('#tableUser').DataTable({
				ajax: '{site_url('user/index-data')}',
				columnDefs: [ {
					orderable: false,
					className: 'select-checkbox',
					targets: 0
				} ],
				columns: [
					{ data: null, defaultContent: '' },
					{ data: 'nama' },
					{ data: 'institusi' },
					{ data: 'last_rotasi_klinik' },
					{ data: 'no_hp' },
					{ data: 'email' }
				],
				order: [],
				select: {
					style: 'multi'
				}
			});
			
			var tableSoal = $('#tableSoal').DataTable({
				filter: false, paging: false, ordering: false, info: false,
				ajax: '{site_url('periode-soal/index-data')}?id_periode=' + $('input[name="id_periode"]').val(),
				columnDefs: [ {
					orderable: false,
					className: 'select-checkbox',
					targets: 0
				} ],
				columns: [ 
					{ data: null, defaultContent: '' },
					{ data: 'tgl_mulai_display' },
					{ data: 'nama_form' },
					{ data: 'waktu_pengerjaan' }
				],
				select: {
					style: 'multi'
				}
			});
			
			// On-Select create hidden id_user
			tableUser.on('select', function (e, dt, type, indexes) {
				if (type === 'row') {
					var data = tableUser.rows(indexes).data()[0];
					$('input[name="id_periode_paket"]').after('<input type="hidden" name="id_user_set[]" value="'+data.id_user+'" />');
				}
			});
			
			// On-deselect remove hidden id_user
			tableUser.on('deselect', function (e, dt, type, indexes) {
				if (type === 'row') {
					var data = tableUser.rows(indexes).data()[0];
					$('input[name="id_user_set[]"][value="'+data.id_user+'"]').remove();
				}
			});
			
			// Jumlah yg harus di select
			var jumlahSoal = parseInt($('input[name=jumlah_soal]').val());
			
			// On-Select create hidden id_periode_soal
			tableSoal.on('select', function (e, dt, type, indexes) {
				if (type === 'row') {
					var data = tableSoal.rows(indexes).data()[0];
					$('button[name="preview"]').before('<input type="hidden" name="id_periode_soal_set[]" value="'+data.id_periode_soal+'" />');
				}
				// Jika jumlah tepat, boleh lanjut
				if (tableSoal.rows({ selected: true }).count() === jumlahSoal)
					$('button[name="preview"]').removeAttr('disabled');
				else
					$('button[name="preview"]').attr('disabled', 'disabled');
			});
			
			// On-deselect remove hidden id_periode_soal
			tableSoal.on('deselect', function (e, dt, type, indexes) {
				if (type === 'row') {
					var data = tableSoal.rows(indexes).data()[0];
					$('input[name="id_periode_soal_set[]"][value="'+data.id_periode_soal+'"]').remove();
				}
				
				// Jika jumlah tepat, boleh lanjut
				if (tableSoal.rows({ selected: true }).count() === jumlahSoal)
					$('button[name="preview"]').removeAttr('disabled');
				else
					$('button[name="preview"]').attr('disabled', 'disabled');
			});
		});
	</script>
{/block}