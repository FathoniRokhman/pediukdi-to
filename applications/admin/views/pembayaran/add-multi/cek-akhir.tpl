{extends file='../../layout.tpl'}
{block name='content'}
	<h2 class="page-header">Tambah Pembayaran Multi</h2>
	<h3>Cek Akhir</h3>
	<h4>Penambahan Pembayaran untuk jadwal test : {$jadwal_test->tanggal_test|date_format:"%d %B %Y"} - {$jadwal_test->form_soal->nama_form}</h4>
	<form action="{site_url('pembayaran/add-multi/proses')}" method="post">
		<input type="hidden" name="ijt" value="{$jadwal_test->id_jadwal_test}" />
		<table id="tableUser" class="table table-bordered table-condensed">
			<thead>
				<tr>
					<th>Nama</th>
					<th>Asal</th>
					<th>Email</th>
				</tr>
			</thead>
			<tbody>
				{foreach $data_set as $data}
					<tr>
						<td>{$data->nama} <input type="hidden" name="iu[]" {* iu = id_user *} value="{$data->id_user}" /></td>
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
						<a href="{site_url('pembayaran/add-multi/')}" class="btn btn-sm btn-default">Batal</a>
						<input type="submit" class="btn btn-sm btn-primary" value="Proses" />
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
{/block}