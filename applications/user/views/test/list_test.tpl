{extends file='../layout_loggedin.tpl'}
{block name='head'}
	<style>
		.table>thead>tr>th:nth-child(4), 
		.table>thead>tr>th:nth-child(5),
		.table>thead>tr>th:nth-child(6),
		.table>thead>tr>th:nth-child(7),
		.table>thead>tr>th:nth-child(8),
		.table>thead>tr>th:nth-child(9) { text-align: center }
		
		.table>tbody>tr>td:nth-child(4), 
		.table>tbody>tr>td:nth-child(5),
		.table>tbody>tr>td:nth-child(6),
		.table>tbody>tr>td:nth-child(7),
		.table>tbody>tr>td:nth-child(8),
		.table>tbody>tr>td:nth-child(9) { text-align: center }
	</style>
{/block}
{block name='content'}
	
	<div class="row">
		<div class="col-md-12">
			<h1 class="page-header">Data Tes</h1>
			
			<table class="table table-striped">
				<thead>
					<tr>
						<th>Tanggal Tes</th>
						<th>Soal</th>
						<th>Status</th>
						<th>Nilai Batas</th>
						<th>Jumlah Soal</th>
						<th>Dijawab</th>
						<th>Kosong</th>
						<th>Ragu</th>
						<th>Skor</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					{foreach $data_set as $data}
						<tr>
							<td>{$data->tanggal_test|date_format:"%d %B %Y"}</td>
							<td>{$data->nama_form}</td>
							<td>
								{if $data->is_finished == '1'}
									<span class="label label-success">Sudah Selesai</span>
								{elseif $data->is_finished == '0'}
									<span class="label label-warning">Sedang Dikerjakan</span>
								{else}
									<span class="label label-default">Belum</span>
								{/if}
							</td>
							<td>{$data->nilai_kkm}</td>
							<td>{$data->jumlah_soal}</td>
							<td>{if $data->is_finished == '1'}{$data->jumlah_dijawab}{/if}</td>
							<td>{if $data->is_finished == '1'}{$data->jumlah_kosong}{/if}</td>
							<td>{if $data->is_finished == '1'}{$data->jumlah_ragu}{/if}</td>
							<td>{if $data->is_finished == '1'}{$data->skor_akhir + 0}{/if}</td>
							<td>
								{if $data->is_finished == '1'}
									<a href="{site_url('test/detail-result/')}{$data->id_pembayaran}">Detail</a>
								{else if $data->is_finished == ''}
									{* Jika memenuhi tanggal baru bisa dikerjakan *}
									{if time() > strtotime($data->tanggal_test)}
										<a href="{site_url('test/pre-start/')}{$data->id_pembayaran}">Mulai Kerjakan</a>
									{/if}
								{/if}
							</td>
						</tr>
					{/foreach}
				</tbody>
			</table>
			
		</div>
	</div>
{/block}