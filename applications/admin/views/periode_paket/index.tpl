{extends file='../layout.tpl'}
{block name='content'}
	<h2 class="page-header">Daftar Biaya Paket <small>{$periode->nama_periode}</small></h2>
	<p>
		<a href="{site_url('periode')}" class="btn btn-xs btn-default"><span class="glyphicon glyphicon-circle-arrow-left"></span> Kembali</a>
		<a href="{site_url('periode-paket/add')}/{$periode->id_periode}" class="btn btn-xs btn-primary">Tambah</a>
	</p>
	<table class="table table-bordered" id="table">
		<thead>
			<tr>
				<th>Nama Paket</th>
				<th>Jumlah Soal</th>
				<th>Biaya Paket</th>
				<th>Aksi</th>
			</tr>
		</thead>
		<tbody>
			{foreach $data_set as $data}
				<tr>
					<td>{$data->nama_paket}</td>
					<td>{$data->jumlah}</td>
					<td>{$data->biaya}</td>
					<td>
						<a href="{site_url('periode-paket/edit')}/{$data->id_periode_paket}" class="btn btn-xs btn-info">
							<span class="glyphicon glyphicon-pencil"></span> Edit
						</a>
						<a href="#" class="btn btn-xs btn-danger" data-toggle="modal" data-target="#deleteModal" data-id="{$data->id_periode_paket}">
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
					<h4>Apakah biaya paket akan dihapus ?</h4>
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
	<script type="text/javascript">
		$(document).ready(function() {
			$('#deleteModal').on('show.bs.modal', function(event) {
				var button = $(event.relatedTarget);
				$(this).find('#formDelete').attr('action', "{site_url('periode-paket/delete/')}" + button.data('id'));
			});
		});
	</script>
{/block}