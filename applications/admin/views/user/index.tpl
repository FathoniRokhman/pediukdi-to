{extends file='../layout.tpl'}
{block name='head'}
	<link href="{site_url('../assets/css/dataTables.bootstrap.min.css')}" rel="stylesheet" />
{/block}
{block name='content'}
	<h2 class="page-header">Daftar User</h2>
	<table id="tableUser" class="table table-bordered table-condensed" style="display: none">
		<thead>
			<tr>
				<th>Nama</th>
				<th>Asal</th>
				<th>Rotasi Klinik</th>
				<th>Telp</th>
				<th>Email</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			{foreach $data_set as $data}
				<tr>
					<td>{$data->nama}</td>
					<td>{$data->institusi}</td>
					<td>{$data->last_rotasi_klinik}</td>
					<td>{$data->no_hp}</td>
					<td>{$data->email}
						{if $data->is_verified == 1}<span class="glyphicon glyphicon-ok-circle" aria-hidden="true" title="Verified"></span>{/if}
					</td>
					<td class="text-right">
						<a href="{site_url('user/add_pembayaran/')}{$data->id_user}" class="btn btn-xs btn-success">Tambah Pembayaran Tes</a>
					</td>
				</tr>
			{foreachelse}
				<tr>
					<td colspan="6">Tidak ada data ditampilkan</td>
				</tr>
			{/foreach}
		</tbody>
	</table>
{/block}
{block name='footer-script'}
	<script src="{site_url('../assets/js/jquery.dataTables.min.js')}"></script>
	<script src="{site_url('../assets/js/dataTables.bootstrap.min.js')}"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			{if count($data_set) > 0}
			$('#tableUser').DataTable({
				columnDefs: [
					{ orderable: false, targets: [-1] }
				]
			});
			{/if}
			$('#tableUser').show('fast');
		});
	</script>
{/block}