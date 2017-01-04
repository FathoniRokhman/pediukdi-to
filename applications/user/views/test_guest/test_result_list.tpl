{extends file='../layout_wordpress.tpl'}
{block name='content'}
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1 class="page-header">Hasil Coba Soal</h1>
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th>#</th>
							<th>Waktu Mengerjakan</th>
							<th>Nama</th>
							<th class="text-center">Jumlah Soal</th>
							<th class="text-center">Jumlah Benar</th>
							<th class="text-center">Jumlah Salah</th>
							<th>Detail</th>
						</tr>
					</thead>
					<tbody>
						{foreach $guest_session_set as $guest_session}
							<tr>
								<td>{$guest_session@index + 1}</td>
								<td>{$guest_session->start_time_elapsed}</td>
								<td>{$guest_session->nama}</td>
								<td class="text-center">{$guest_session->jumlah_soal}</td>
								<td class="text-center">{$guest_session->jumlah_benar}</td>
								<td class="text-center">{$guest_session->jumlah_salah}</td>
								<td><a href="{site_url('test-guest/test-result')}/{$guest_session->id_guest_session}">Detail jawaban</a></td>
							</tr>
						{/foreach}
						<tr>
							<td colspan="7" class="text-center">
								List hasil coba soal terbatas untuk umum.<br/>
								Silahkan Registrasi untuk melihat hasil sendiri yang bisa dilihat kapan saja.
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
{/block}