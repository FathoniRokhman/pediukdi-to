{extends file='../layout.tpl'}
{block name='head'}
	<link href="{site_url('../assets/css/dataTables.bootstrap.min.css')}" rel="stylesheet" />
{/block}
{block name='content'}
	<h2 class="page-header">Detail Hasil Tes : {$jadwal_test->tanggal_test|date_format:"%d %B %Y"}</h2>
	<a href="{site_url('hasil')}">Kembali ke hasil</a>
	<table class="table table-bordered table-striped table-extra-condensed" id="dataTable" >
		<colgroup>
			<col style="width: 30px"/>
			<col />
			<col />
			<col />
			<col />
			<col />
			<col />
			<col />
			<col />
		</colgroup>
		<thead>
			<tr>
				<th>Rank</th>
				<th>Nama</th>
				<th>Waktu Tes</th>
				<th>Dijawab</th>
				<th>Kosong</th>
				<th>Ragu</th>
				<th>Benar</th>
				<th>Salah</th>
				<th>Skor</th>
			</tr>
		</thead>
		<tbody>
			{foreach $data_set as $data}
				<tr>
					<td class="text-center">{$data@index + 1}</td>
					<td>{$data->nama}</td>
					<td>{$data->start_time|date_format:"%H:%M:%S"}</td>
					<td class="text-center">{$data->dijawab}</td>
					<td class="text-center">{$data->jumlah_soal - $data->dijawab}</td>
					<td class="text-center">{$data->ragu}</td>
					<td class="text-center">{$data->benar}</td>
					<td class="text-center">{$data->jumlah_soal - $data->benar}</td>
					<td class="text-center">{($data->benar/$data->jumlah_soal)*100}</td>
				</tr>
			{/foreach}
		</tbody>
	</table>
{/block}
{block name='footer-script'}
	<script src="{site_url('../assets/js/jquery.dataTables.min.js')}"></script>
	<script src="{site_url('../assets/js/dataTables.bootstrap.min.js')}"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			{if count($data_set) > 0}
			$('#dataTable').DataTable({
				"paging": false,
				"bFilter": false,
				"bInfo": false
			});
			{/if}
		});
	</script>
{/block}