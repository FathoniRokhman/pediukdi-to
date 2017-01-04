{extends file='../layout.tpl'}
{block name='head'}
	<link href="{site_url('../assets/css/dataTables.bootstrap.min.css')}" rel="stylesheet" />
	<style>
		.table tbody tr td:last-child {
			text-align: right;
		}
	</style>
{/block}
{block name='content'}
	<h2 class="page-header">Daftar Pembayaran</h2>
	<p>Untuk menambah pembayaran, masuk ke menu <code>Daftar User &gt; Tambah Pembayaran Tes</code></p>
	<table id="tablePembayaran" class="table table-bordered table-condensed">
		<thead>
			<tr>
				<th>Nama User</th>
				<th>Jadwal Tes</th>
				<th>Tanggal Bayar</th>
				<th>Besar Bayar</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			{foreach $data_set as $data}
			<tr>
				<td>{$data->nama}</td>
				<td>{$data->tanggal_test|date_format:'%d %B %Y'} - {$data->nama_form}</td>
				<td>{$data->tanggal_bayar|date_format:'%d %B %Y'}</td>
				<td>{$data->biaya|number_format}</td>
				<td>
					<a href="" class="text-danger" data-toggle="modal" data-target="#deleteModal" data-id="{$data->id_pembayaran}"><strong>Hapus</strong></a>
				</td>
			</tr>
			{foreachelse}
			<tr>
				<td colspan="4"><i>Tidak ada data pembayaran</i></td>
				<td></td>
			</tr>
			{/foreach}
		</tbody>
	</table>
			
	<!-- Modal Konfirmasi -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<h4>Apakah Pembayaran akan dihapus ?</h4>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Batal</button>
					<form method="post" id="formDelete" style="display: inline">
					<input type="submit" class="btn btn-danger" value="Hapus" />
					</form>
				</div>
			</div>
		</div>
	</div>
{/block}
{block name='footer-script'}
	<script src="{site_url('../assets/js/jquery.dataTables.min.js')}"></script>
	<script src="{site_url('../assets/js/dataTables.bootstrap.min.js')}"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			{if count($data_set) > 0}
			$('#tablePembayaran').DataTable({
				columnDefs: [
					{ orderable: false, targets: [-1] }
				]
			});
			{/if}
				
			$('#deleteModal').on('show.bs.modal', function(event) {
				var button = $(event.relatedTarget);
				$(this).find('#formDelete').attr('action', "{site_url('pembayaran/delete/')}" + button.data('id'));
			});
		});
	</script>
{/block}