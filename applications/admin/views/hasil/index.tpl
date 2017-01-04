{extends file='../layout.tpl'}
{block name='head'}
	<style type="text/css">
		.table > tbody > tr > td { vertical-align: middle; }
	</style>
{/block}
{block name='content'}
	<h2 class="page-header">Daftar Hasil Tes</h2>
	<table class="table table-bordered table-extra-condensed">
		<colgroup>
			<col /><col />
			<col style="width: 70px" />
			<col style="width: 80px" />
			<col style="width: 70px" />
			<col style="width: 70px" />
			<col style="width: 55px" />
			<col style="width: 10px" />
		</colgroup>
		<thead>
			<tr>
				<th>Tanggal Tes</th>
				<th>Lembar Soal</th>
				<th>Peserta</th>
				<th>Rata-Rata</th>
				<th>Tertinggi</th>
				<th>Terendah</th>
				<th>Deviasi</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			{foreach $data_set as $data}
				<tr>
					<td>{$data->tanggal_test|date_format:"%d %B %Y"}</td>
					<td>{$data->nama_form}</td>
					<td class="text-center">{$data->peserta}</td>
					<td class="text-center info">{round($data->rata, 2)}</td>
					<td class="text-center success">{round($data->tertinggi, 2)}</td>
					<td class="text-center danger">{round($data->terendah, 0)}</td>
					<td class="text-center warning">{round($data->deviasi, 2)}</td>
					<td><a href="{site_url('hasil/detail')}/{$data->id_jadwal_test}" class="btn btn-default btn-xs">Detail</a></td>
				</tr>
			{/foreach}
		</tbody>
	</table>
{/block}