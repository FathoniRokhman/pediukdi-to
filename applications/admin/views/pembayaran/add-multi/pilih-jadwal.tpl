{extends file='../../layout.tpl'}
{block name='head'}
	<link href="{site_url('../assets/css/dataTables.bootstrap.min.css')}" rel="stylesheet" />
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
		<table class="table table-bordered table-extra-condensed" id="tablePembayaran">
			<thead>
				<tr>
					<th style="width: 40px"></th>
					<th>Tanggal Tes</th>
					<th>Lembar Soal dipakai</th>
					<th>Waktu</th>
					<th>Jumlah Pendaftar</th>
				</tr>
			</thead>
			<tbody>
				{foreach $data_set as $data}
					<tr>
						<td><input type="radio" name="ijt" value="{$data->id_jadwal_test}" /></td>
						<td>{$data->tanggal_test|date_format:"%d %B %Y"}</td>
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
	<script src="{site_url('../assets/js/jquery.dataTables.min.js')}"></script>
	<script src="{site_url('../assets/js/dataTables.bootstrap.min.js')}"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			{if count($data_set) > 0}
			$('#tablePembayaran').DataTable({
				bLengthChange: false,
				ordering: false
			});
			{/if}
				/* Coloring Script */
			$('input[type=radio]').on('change', function() {
				/* clear other colored */
				$('tr').removeClass('success');
				
				if ($(this).is(':checked'))
					$(this).parent().parent().addClass('success');
			});
		});
	</script>
{/block}