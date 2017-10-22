{extends file='../layout.tpl'}
{block name='head'}
	<link href="{site_url('../assets/DataTables/datatables.min.css')}" rel="stylesheet" />
	<style type="text/css">
		#table thead tr th:nth-child(4), #table thead tr th:nth-child(5), #table thead tr th:nth-child(6) { text-align: center }
		#table tbody tr td:nth-child(4), #table tbody tr td:nth-child(5), #table tbody tr td:nth-child(6) { text-align: center }
	</style>
{/block}
{block name='content'}
	<h2 class="page-header">Periode Tes</h2>
	<p><a href="{site_url('periode/add')}" class="btn btn-xs btn-primary">Tambah</a></p>
	<table class="table table-bordered" id="table">
		<thead>
			<tr>
				<th>Periode</th>
				<th>Mulai</th>
				<th>Selesai</th>
				<th>Status</th>
				<th>Paket</th>
				<th>Form Soal</th>
				<th style="width: 220px">Aksi</th>
			</tr>
		</thead>
		<tbody>
			{foreach $data_set as $data}
				<tr>
					<td>{$data->nama_periode}</td>
					<td data-order="{$data->waktu_mulai}">{$data->waktu_mulai_display}</td>
					<td data-order="{$data->waktu_selesai}">{$data->waktu_selesai_display}</td>
					<td>
						{if $data->is_aktif}
							<span class="label label-success">AKTIF</span>
						{else}
							<span class="label label-default">TIDAK AKTIF</span>
						{/if}
					</td>
					<td>{$data->jumlah_paket}</td>
					<td>{$data->jumlah_soal}</td>
					<td>
						<a href="{site_url('periode/edit')}/{$data->id_periode}" class="btn btn-xs btn-info">
							<span class="glyphicon glyphicon-pencil"></span> Edit
						</a>
						<a href="{site_url('periode-paket/index')}/{$data->id_periode}" class="btn btn-xs btn-warning">
							<span class="glyphicon glyphicon-tags"></span> Paket
						</a>
						<a href="{site_url('periode-soal/index')}/{$data->id_periode}" class="btn btn-xs btn-success">
							<span class="glyphicon glyphicon-file"></span> Soal
						</a>
						<a href="#" class="btn btn-xs btn-danger" data-toggle="modal" data-target="#deleteModal" data-id="{$data->id_periode}">
							<span class="glyphicon glyphicon-remove"></span> Hapus
						</a>
					</td>
				</tr>
			{/foreach}
		</tbody>
	</table>
			
	<!-- Modal Konfirmasi -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<h4>Apakah periode akan dihapus ?</h4>
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
	
	<!-- Modal -->
	<div class="modal fade" id="notifyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
					{if $ci->session->flashdata('deleted')}
						Data berhasil di hapus
					{/if}
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
{/block}
{block name='footer-script'}
	{if $ci->session->flashdata('inserted') or $ci->session->flashdata('updated') or $ci->session->flashdata('deleted')}
		<script type="text/javascript">$('#notifyModal').modal();</script>
	{/if}
	<script src="{site_url('../assets/DataTables/datatables.min.js')}"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#table').DataTable({
				paging: false, 
				searching: false,
				order: []
			});
			
			$('#deleteModal').on('show.bs.modal', function(event) {
				var button = $(event.relatedTarget);
				$(this).find('#formDelete').attr('action', "{site_url('periode/delete/')}" + button.data('id'));
			});
		});
	</script>
{/block}