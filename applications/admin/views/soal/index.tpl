{extends file='../layout.tpl'}
{block name='content'}
	<h2 class="page-header">Editor Soal</h2>
	<form action="{current_url()}" method="get" id="formLembarSoal" style="margin-bottom: 20px">
		<select name="ifs" class="form-control" onchange="$('#formLembarSoal').submit();">
			<option value="">-- Pilih Lembar Soal --</option>
			{html_options options=$form_soal_set selected=$smarty.get.ifs}
		</select>
	</form>
	
	{if !empty($smarty.get.ifs)}
		
		<p><a href="{site_url('soal/add')}?ifs={$smarty.get.ifs}" class="btn btn-xs btn-primary">Tambah</a></p>

		<table class="table table-bordered table-extra-condensed">
			<thead>
				<tr>
					<th style="width: 40px">No</th>
					<th>Soal</th>
					<th>Kategori</th>
					<th style="width: 90px"></th>
				</tr>
			</thead>
			<tbody>
				{foreach $data_set as $data}
					<tr>
						<td>{$data->no_soal}</td>
						<td class="isi-soal">
							{* Isi soal di mampatkan *}
							{if strlen($data->isi_soal) > 105}
								{$data->isi_soal|truncate:100:"...":true}
							{else}
								{$data->isi_soal}
							{/if}
						</td>
						<td>{$data->nama_kelompok}</td>
						<td>
							<a href="{site_url('soal/edit/')}{$data->id_soal}" class="btn btn-xs btn-success">Edit</a>
							<a href="" class="text-danger" data-toggle="modal" data-target="#deleteModal" data-id="{$data->id_soal}" data-ifs="{$data->id_form_soal}"><strong>Hapus</strong></a>
						</td>
					</tr>
				{foreachelse}
					<tr>
						<td colspan="4"><i>Tidak ada data ditampilkan</i></td>
					</tr>
				{/foreach}
			</tbody>
		</table>
			
	{/if}
	
	<!-- Modal Konfirmasi -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<h4>Apakah Soal ini akan dihapus ?</h4>
					<p><i>Soal yang sudah dikerjakan tidak bisa di hapus.</i></p>
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
			$(this).find('#formDelete').attr('action', "{site_url('soal/delete/')}" + button.data('id') + '/' + button.data('ifs'));
		});
	</script>
{/block}