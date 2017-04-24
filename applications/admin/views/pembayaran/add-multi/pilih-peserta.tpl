{extends file='../../layout.tpl'}
{block name='head'}
	<link href="{site_url('../assets/css/datatables.min.css')}" rel="stylesheet" />
{/block}
{block name='content'}
	<h2 class="page-header">Tambah Pembayaran Multi</h2>
	<h3>Pilih Peserta untuk jadwal tes : {$jadwal_test->tanggal_test|date_format:"%d %B %Y"}</h3>
	<form action="{site_url('pembayaran/add-multi/cek-akhir')}" method="post">
		<input type="hidden" name="ijt" value="{$jadwal_test->id_jadwal_test}" />
		<table id="table" class="table table-bordered table-condensed" style="display: none">
			<thead>
				<tr>
					<th></th>
					<th>Nama</th>
					<th>Asal</th>
					<th>Email</th>
				</tr>
			</thead>
			<tbody>
				{foreach $data_set as $data}
					<tr id="iu{$data->id_user}">
						<td></td>
						<td>{$data->nama}</td>
						<td>{$data->institusi}</td>
						<td>{$data->email}
							{if $data->is_verified == 1}<span class="glyphicon glyphicon-ok-circle" aria-hidden="true" title="Verified"></span>{/if}
						</td>
					</tr>
				{foreachelse}
					<tr>
						<td colspan="4">Tidak ada data ditampilkan</td>
					</tr>
				{/foreach}
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4">
						<a href="{site_url('pembayaran/add-multi')}" class="btn btn-sm btn-default">Kembali</a>
						<input type="submit" class="btn btn-sm btn-primary" value="Cek Akhir" />
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
{/block}
{block name='footer-script'}
	<script src="{site_url('../assets/js/datatables.min.js')}"></script>
	<script type="text/javascript">
		$(document).ready(function () {
		{if count($data_set) > 0}
			var table = $('#table').DataTable({
				columnDefs: [
					{ targets: 0, className: 'select-checkbox', orderable: false }
				],
				select: { style: 'multi' }
			});
		{/if}

			$('#table').show();

			table
				.on('select', function (e, dt, type, indexes) {
					var id = dt.id().toString().replace('iu', '');
					$('input[name="ijt"]').after('<input type="hidden" name="iu[]" value="'+id+'" />');
				})
				.on('deselect', function (e, dt, type, indexes) {
					var id = dt.id().toString().replace('iu', '');
					$('input[name="iu[]"][value="'+id+'"]').remove();
				});
		});
	</script>
{/block}