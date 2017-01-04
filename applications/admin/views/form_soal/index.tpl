{extends file='../layout.tpl'}
{block name='content'}
	<h2 class="page-header">Master Lembar Soal</h2>
	<p><a href="{site_url('form-soal/add')}" class="btn btn-xs btn-primary">Tambah</a></p>
	<table class="table table-bordered">
		<thead>
			<tr>
				<th width="20px">#</th>
				<th>Nama Lembar Soal</th>
				<th>Waktu Pengerjaan (Menit)</th>
				<th width="180px">Aksi</th>
			</tr>
		</thead>
		<tbody>
			{foreach $data_set as $data}
				<tr>
					<td>{$data@index + 1}</td>
					<td>{$data->nama_form}</td>
					<td>{$data->waktu_pengerjaan}</td>
					<td>
						<a href="{site_url('soal/index/')}{$data->id_form_soal}" class="btn btn-xs btn-primary">Editor Soal</a>
						<a href="{site_url('form-soal/edit/')}{$data->id_form_soal}" class="btn btn-xs btn-success">Edit</a>
						<a href="" class="text-danger" data-toggle="modal" data-target="#deleteModal" data-id="{$data->id_form_soal}"><strong>Hapus</strong></a>
					</td>
				</tr>
			{foreachelse}
				<tr>
					<td colspan="4"><i>Tidak ada data</i></td>
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
					<h4>Apakah Lembar Soal akan dihapus ?</h4>
					<p>* Semua soal yang sudah di input akan ikut hilang.</p>
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
	{if $ci->session->flashdata('inserted') or $ci->session->flashdata('updated')}
		<script type="text/javascript">$('#myModal').modal();</script>
	{/if}
	<script type="text/javascript">
		$('#deleteModal').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget);
			$(this).find('#formDelete').attr('action', "{site_url('form-soal/delete/')}" + button.data('id'));
		});
	</script>
{/block}