{extends file='../layout_loggedin.tpl'}
{block name='content'}
	
	<div class="row">
		<div class="col-md-12">
			<h1 class="page-header">Hasil Tes 5 Agustus 2017 (Try Out Batch 2)</h1>
			<h2>Skor : <strong>{$test_session->skor_akhir + 0}</strong></h2>
			
			<p>
				<a href="{site_url('test/list-test')}" class="btn btn-xs btn-default">Kembali ke daftar tes</a>
				<a href="{site_url('test/bahas-soal/')}{$test_session->id_test_session}" class="btn btn-xs btn-success">Pembahasan Soal</a>
			</p>
			
			<div class="table-responsive">
					<table class="table table-bordered">
						<tbody>
							<tr>
								<td>Jumlah Soal</td><td class="text-center">{$test_session->jumlah_soal}</td>
							</tr>
							<tr>
								<td>Dijawab</td><td class="text-center">{$test_session->jumlah_dijawab}</td>
							</tr>
							<tr>
								<td>Kosong</td><td class="text-center">{$test_session->jumlah_kosong}</td>
							</tr>
							<tr>
								<td>Ragu</td><td class="text-center">{$test_session->jumlah_ragu}</td>
							</tr>
						</tbody>
					</table>
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Kelompok Soal</th>
								<th class="text-center">Benar</th>
								<th class="text-center">Salah</th>
							</tr>
						</thead>
						<tbody>
							{$jumlah_benar = 0}{$jumlah_salah = 0}
							{foreach $kelompok_soal_set as $ks}
								{$jumlah_benar = $jumlah_benar + $ks->jumlah_benar}
								{$jumlah_salah = $jumlah_salah + $ks->jumlah_salah}
								<tr>
									<td>{$ks->nama_kelompok}</td>
									<td class="text-center">{$ks->jumlah_benar + 0}</td>
									<td class="text-center">{$ks->jumlah_salah + 0}</td>
								</tr>
							{/foreach}
						</tbody>
						<tfoot>
							<tr>
								<td class="text-right">JUMLAH</td>
								<td class="text-center"><strong>{$jumlah_benar}</strong></td>
								<td class="text-center"><strong>{$jumlah_salah}</strong></td>
							</tr>
						</tfoot>
					</table>
					
			</div>
		</div>
	</div>
	
{/block}