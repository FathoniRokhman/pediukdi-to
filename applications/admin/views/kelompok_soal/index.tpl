{extends file='../layout.tpl'}
{block name='content'}
	<h2 class="page-header">Master Kelompok Soal</h2>
	<p><a href="{site_url('kelompok-soal/add')}" class="btn btn-xs btn-primary">Tambah</a></p>
	<table class="table table-bordered">
		<thead>
			<tr>
				<th width="20px">#</th>
				<th>Nama Kelompok Soal</th>
				<th width="180px">Aksi</th>
			</tr>
		</thead>
		<tbody>
			{foreach $data_set as $data}
				<tr>
					<td>{$data@index + 1}</td>
					<td>{$data->nama_kelompok}</td>
					<td>
						<a href="{site_url('kelompok-soal/edit/')}{$data->id_kelompok_soal}" class="btn btn-xs btn-success">Edit</a>
						<a href="" class="text-danger" data-toggle="modal" data-target="#deleteModal" data-id="{$data->id_kelompok_soal}"><strong>Hapus</strong></a>
					</td>
				</tr>
			{foreachelse}
				<tr>
					<td colspan="3"><i>Tidak ada data</i></td>
				</tr>
			{/foreach}
		</tbody>
	</table>
			
	<!-- Modal Konfirmasi -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<h4>Apakah Kelompok Soal akan dihapus ?</h4>
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
	<script type="text/javascript">
		$('#deleteModal').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget);
			$(this).find('#formDelete').attr('action', "{site_url('kelompok-soal/delete/')}" + button.data('id'));
		});
	</script>
{/block}