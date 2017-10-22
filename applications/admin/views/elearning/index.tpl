{extends file='../layout.tpl'}
{block name='head'}
	<link href="{site_url('../assets/DataTables/datatables.min.css')}" rel="stylesheet" />
{/block}
{block name='content'}
	<h2 class="page-header">Daftar Video E-learning</h2>
	<p><a href="{site_url('elearning/add')}" class="btn btn-xs btn-primary">Tambah</a></p>
	<table id="tableVideo" class="table table-bordered table-condensed" style="display: none">
		<thead>
			<tr>
				<th>Judul</th>
				<th>Deskripsi</th>
				<th>Link</th>
				<th>Date Upload</th>
				<th>Status Video</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			{foreach $data_set as $data}
				<tr>
					<td>{$data.judulVideo}</td>
					<td>{$data.deskripsiVideo}</td>
					<td>{$data.linkVideo}</td>
					<td>{$data.dateVideo}</td>
					<td>{if $data.statusVideo == 1}
						Aktif
						{else}
						Non-Aktif
						{/if}
					</td>
					<td class="text-right">
							<a href="{site_url('elearning/edit/')}{$data.idElearningVideo}" class="btn btn-xs btn-success">Edit</a>
							<a href="" class="text-danger" data-toggle="modal" data-target="#deleteModal" data-id="{$data.idElearningVideo}"><strong>Hapus</strong></a>
					</td>
				</tr>
			{foreachelse}
				<tr>
					<td colspan="6">Tidak ada data ditampilkan</td>
				</tr>
			{/foreach}
		</tbody>
	</table>

	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">Informasi</h4>
				</div>
				<div class="modal-body">
					{if $ci->session->flashdata('inserted')}
						Data berhasil di tambahkan
					{/if}
					{if $ci->session->flashdata('updated')}
						Data berhasil di update
					{/if}
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
					
	<!-- Modal Konfirmasi -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<h4>Apakah Video akan dihapus ?</h4>
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
		$(document).ready(function() {

			{if count($data_set) > 0}
				$('#tableVideo').DataTable({
					columnDefs: [
						{ orderable: false, targets: [-1] }
					]
				});
			{/if}
			$('#tableVideo').show('fast');
			
		});
	</script>
	{if $ci->session->flashdata('inserted') or $ci->session->flashdata('updated')}
		<script type="text/javascript">$('#myModal').modal();</script>
	{/if}

	<script type="text/javascript">
		$('#deleteModal').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget);
			$(this).find('#formDelete').attr('action', "{site_url('elearning/delete/')}" + button.data('id'));
		});
	</script>

{/block}

