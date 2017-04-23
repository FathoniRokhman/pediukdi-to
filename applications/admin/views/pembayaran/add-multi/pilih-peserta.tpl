{extends file='../../layout.tpl'}
{block name='head'}
	<link href="{site_url('../assets/css/dataTables.bootstrap.min.css')}" rel="stylesheet" />
{/block}
{block name='content'}
	<h2 class="page-header">Tambah Pembayaran Multi</h2>
	<h3>Pilih Peserta untuk jadwal tes : {$jadwal_test->tanggal_test|date_format:"%d %B %Y"}</h3>
	<form action="{site_url('pembayaran/add-multi/cek-akhir')}" method="post">
		<input type="hidden" name="ijt" value="{$jadwal_test->id_jadwal_test}" />
		<table id="tableUser" class="table table-bordered table-condensed" style="display: none">
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
					<tr>
						<td><input type="checkbox" name="iu[]" {* iu = id_user *} value="{$data->id_user}" /></td>
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
	<script src="{site_url('../assets/js/jquery.dataTables.min.js')}"></script>
	<script src="{site_url('../assets/js/dataTables.bootstrap.min.js')}"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			/* Coloring Script */
			$('input[type=checkbox]').on('change', function() {
				if ($(this).is(':checked'))
					$(this).parent().parent().addClass('success');
				else
					$(this).parent().parent().removeClass('success');
			});
			
			{if count($data_set) > 0}
			$('#tableUser').DataTable({
				columnDefs: [
					{ orderable: false, targets: [0, -1] }
				]
			});
			{/if}
				
			$('#tableUser').show('fast');
		});
	</script>
{/block}