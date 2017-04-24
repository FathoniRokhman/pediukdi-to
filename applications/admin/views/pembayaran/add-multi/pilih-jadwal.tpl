{extends file='../../layout.tpl'}
{block name='head'}
	<link href="{site_url('../assets/css/datatables.min.css')}" rel="stylesheet" />
	<style>
		.table tbody tr td:last-child {
			text-align: right;
		}
	</style>
{/block}
{block name='content'}
	<h2 class="page-header">Tambah Pembayaran Multi</h2>
	<h3>Pilih Jadwal Test :</h3>
	<form action="{site_url('pembayaran/add-multi/pilih-peserta')}" method="post">
		<input type="hidden" name="ijt" value="" />
		<table class="table table-bordered table-extra-condensed" id="table" data-order='[[ 1, "desc" ]]'>
			<thead>
				<tr>
					<th></th>
					<th>Tanggal Tes</th>
					<th>Lembar Soal dipakai</th>
					<th>Waktu</th>
					<th>Jumlah Pendaftar</th>
				</tr>
			</thead>
			<tbody>
				{foreach $data_set as $data}
					<tr id="ijt{$data->id_jadwal_test}">
						<td></td>
						<td data-order="{$data->tanggal_test|date_format:"%Y%m%d"}">{$data->tanggal_test|date_format:"%d %B %Y"}</td>
						<td>{$data->nama_form}</td>
						<td>{$data->waktu_pengerjaan}</td>
						<td>{$data->jumlah_pendaftar}</td>
					</tr>
				{foreachelse}
					<tr>
						<td colspan="5"><i>Tidak ada data ditampilkan</i></td>
					</tr>
				{/foreach}
			</tbody>
			<tfoot>
				<tr>
					<td colspan="5">
						<input type="submit" class="btn btn-sm btn-primary" value="Lanjut pilih peserta" />
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
{/block}
{block name='footer-script'}
	<script src="{site_url('../assets/js/datatables.min.js')}"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			{if count($data_set) > 0}
			var table = $('#table').DataTable({
				columnDefs: [
					{ targets: 0, className: 'select-checkbox', orderable: false }
				],
				select : { style: 'single' }
			});
			$('#table').on('click', 'tr', function() {
				var id = table.row(this).id().toString().replace('ijt', '');
				$('input[name="ijt"]').val(id);
			});
			{/if}
		});
	</script>
{/block}