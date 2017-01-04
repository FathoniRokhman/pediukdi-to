{extends file='../layout_loggedin.tpl'}
{block name='content'}
	
	<div class="row">
		<div class="col-md-12">
			<h1 class="page-header">Hasil Tes</h1>
		
	<div class="container-fluid">
	<div class="row">
		{foreach $test_session_set as $test_session}
		<div class="col-md-4 col-sm-6">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">Tes : {$test_session->start_time|date_format:"%d %B %Y %H:%M:%S"}</h3>
				</div>
				<div class="panel-body">
					<h5>Skor Akhir : <strong style="font-size: 150%">{$test_session->form_soal->skor_akhir + 0}</strong></h5>
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
					
					<table class="table table-condensed table-striped">
						<thead>
							<tr>
								<th>Kelompok soal</th>
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
		</div>
		{/foreach}
	</div>
	</div>
		
		</div>
	</div>
{/block}