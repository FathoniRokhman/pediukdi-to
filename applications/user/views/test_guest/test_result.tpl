{extends file='../layout.tpl'}
{block name='content'}
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h2 class="page-header">Hasil Coba Soal - {$test_session_set[0]->nama}</h2>
				{foreach $test_session_set as $test_session}
					<p><a href="{site_url('test-guest/test-result-list')}">Kembali ke daftar hasil coba soal</a></p>
				<div class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title">Hasil Tes</h3>
					</div>
					<div class="panel-body">

						<h4>Waktu Pengerjaan : {strftime('%d %B %Y %H:%M:%S', strtotime($test_session->start_time))} </h4>
						<h5>{$test_session->form_soal->nama_form}</h5>
						<table class="table table-condensed">
							<thead>
								<tr>
									<th>Keterangan</th>
									<th>Jumlah</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Jumlah Soal</td>
									<td>{$test_session->form_soal->jumlah_soal}</td>
								</tr>
								<tr>
									<td>Dijawab</td>
									<td>{$test_session->form_soal->jumlah_dijawab}</td>
								</tr>
								<tr>
									<td>Dikosongi</td>
									<td>{$test_session->form_soal->jumlah_soal - $test_session->form_soal->jumlah_dijawab}</td>
								</tr>
								<tr>
									<td>Ragu</td>
									<td>{$test_session->form_soal->jumlah_ragu}</td>
								</tr>
							</tbody>
						</table>

						<table class="table table-condensed">
							<caption>Detail Jawaban</caption>
							<thead>
								<tr>
									<th>Nama kelompok</th>
									<th>Benar</th>
									<th>Salah</th>
								</tr>
							</thead>
							<tbody>
								{$jumlah_benar = 0}
								{$jumlah_salah = 0}
								{foreach $test_session->kelompok_soal_set as $kelompok_soal}
									{$jumlah_benar = $jumlah_benar + $kelompok_soal->jumlah_benar}
									{$jumlah_salah = $jumlah_salah + $kelompok_soal->jumlah_salah}
									<tr>
										<td>{$kelompok_soal->nama_kelompok}</td>
										<td>{$kelompok_soal->jumlah_benar}</td>
										<td>{$kelompok_soal->jumlah_salah}</td>
									</tr>
								{/foreach}
								<tr>
									<td><strong>Jumlah</strong></td>
									<td>{$jumlah_benar}</td>
									<td>{$jumlah_salah}</td>
								</tr>
							</tbody>
						</table>

					</div>
				</div>
				<br/>
				{/foreach}
			</div>
		</div>
	</div>
{/block}