{extends file='../layout.tpl'}
{block name='head'}
	<link href="{site_url('../assets/DataTables/datatables.min.css')}" rel="stylesheet" />
	<style>
		.table tbody tr td:last-child { text-align: right; }
	</style>
{/block}
{block name='content'}
	<h2 class="page-header">Jadwal Tes</h2>
	<p><a href="{site_url('jadwal/add')}" class="btn btn-xs btn-primary">Tambah</a></p>
	<table class="table table-bordered table-extra-condensed" id="table">
		<thead>
			<tr>
				<th>Tanggal Tes</th>
				<th>Lembar Soal dipakai</th>
				<th>Waktu</th>
				<th>Jumlah Pendaftar</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			{foreach $data_set as $data}
				<tr>
					<td>{$data->tanggal_test|date_format:"%d %B %Y"}</td>
					<td>{$data->nama_form}</td>
					<td>{$data->waktu_pengerjaan}</td>
					<td>{$data->jumlah_pendaftar}</td>
					<td>
						<a href="{site_url('jadwal/edit/')}{$data->id_jadwal_test}" class="btn btn-xs btn-success">Edit</a>
						{if $data->jumlah_pendaftar == 0}
						<a href="" class="text-danger" data-toggle="modal" data-target="#deleteModal" data-id="{$data->id_jadwal_test}"><strong>Hapus</strong></a>
						{/if}
					</td>
				</tr>
			{foreachelse}
				<tr>
					<td colspan="5"><i>Tidak ada data ditampilkan</i></td>
				</tr>
			{/foreach}
		</tbody>
	</table>
			
	<!-- Modal Konfirmasi -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<h4>Apakah Jadwal Tes akan dihapus ?</h4>
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
	<script src="{site_url('../assets/DataTables/datatables.min.js')}"></script>
	<script type="text/javascript">
		$('#deleteModal').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget);
			$(this).find('#formDelete').attr('action', "{site_url('jadwal/delete/')}" + button.data('id'));
		});
		$('#table').DataTable();
	</script>
{/block}