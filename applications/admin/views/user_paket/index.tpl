{extends file='../layout.tpl'}
{block name='head'}
	<link href="{site_url('../assets/DataTables/datatables.min.css')}" rel="stylesheet" />
	<style>
		
	</style>
{/block}
{block name='content'}
	<h2 class="page-header">Pendaftaran Tes</h2>
	<p><a href="{site_url('user-paket/add')}" class="btn btn-xs btn-primary">Tambah</a></p>
	<table id="table" class="table table-bordered table-condensed">
		<thead>
			<tr>
				<th>Nama</th>
				<th>No HP</th>
				<th>Asal</th>
				<th>Periode</th>
				<th>Paket</th>
				<th></th>
			</tr>
		</thead>
	</table>
	
	<!-- Modal Konfirmasi -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<h4>Apakah data pendaftaran ini akan dihapus ?</h4>
					<p>Data paket soal yang dipilih akan ikut terhapus</p>
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
				ajax: '{site_url('user-paket/index-data')}',
				columns: [
					{ data: 'nama' },
					{ data: 'no_hp' },
					{ data: 'institusi' },
					{ data: null, render: { sort: 'waktu_mulai', display: 'nama_periode' } },
					{ data: 'nama_paket' },
					{ data: function(row, type, set, meta) {
							return '<a href="#" class="btn btn-xs btn-danger" data-toggle="modal" data-target="#deleteModal" data-id="'+row.id_user_paket+'"><span class="glyphicon glyphicon-remove"></span> Hapus</a>';
						} 
					}
				],
				order: []
			});
			
			$('#deleteModal').on('show.bs.modal', function(event) {
				var button = $(event.relatedTarget);
				$(this).find('#formDelete').attr('action', "{site_url('user-paket/delete/')}" + button.data('id'));
			});
		});
	</script>
{/block}