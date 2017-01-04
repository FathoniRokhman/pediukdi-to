{extends file='../soal_layout.tpl'}
{block name='head'}
	<style type="text/css">
		.profile-picture {
			margin-bottom: 0;
		}
		div.soal {
			font-size: 120%;
		}
		div.jawaban {
			padding-left: 15px;
		}
		div.jawaban table {
			font-size: 100%;
		}
		div.tombol-soal {
			margin-top: 20px;
		}
		div.soal-number {
			font-size: 110%;
			margin-top: 25px;
		}
	</style>
{/block}
{block name='content'}
	<div class="container">
		<div class="row">
			
			<div class="col-lg-2 col-md-2 col-sm-3 hidden-xs">
				<a href="" class="thumbnail profile-picture"><img src="../assets/images/portrait3.jpg" alt="Profil Picture"></a>
				<p class="text-center">Mokhammad Fathoni Rokhman</p>
				<table class="table">
					<thead>
						<tr><th colspan="2">Status Pengerjaan</th></tr>
					</thead>
					<tbody>
						<tr>
							<td>Soal</td>
							<td><strong>50</strong></td>
						</tr>
						<tr>
							<td>Dijawab</td>
							<td><strong>25</strong></td>
						</tr>
						<tr>
							<td>Sisa Waktu</td>
							<td><span class="sisa-waktu">00:50:23</span></td>
						</tr>
					</tbody>
				</table>
				<form action="" method="post">
					<input type="submit" value="Selesai" />
				</form>
			</div>
			
			<div class="col-lg-10 col-md-10 col-sm-9 col-xs-12">
				<!-- Region Soal -->
				<div class="soal">
					<h4>Kelompok Soal : BIOETIK</h4>
					<p>1. Pasien laki-­‐laki mengalami kecelakaan, kemudian diantar oleh PMI dan polisi ke IGD RS tempat anda bekerja. Sebagai dokter apa yang anda lakukan terkait dengan <i>informed consent</i>?</p>
				</div>
				<div class="jawaban">
					<table class="table-condensed">
						<col width="20px"/>
						<col />
						<tbody>
							<tr>
								<td><input type="radio" name="j1" /></td>
								<td>A. Inform consent minta pada PMI</td>
							</tr>
							<tr>
								<td><input type="radio" name="j1" /></td>
								<td>B. Inform consent dilakukan setelah pasien sadar</td>
							</tr>
							<tr>
								<td><input type="radio" name="j1" /></td>
								<td>C. Inform consent diminta setelah keluarga datang</td>
							</tr>
							<tr>
								<td><input type="radio" name="j1" /></td>
								<td>D. Live saving tanpa meminta informed consent</td>
							</tr>
							<tr>
								<td><input type="radio" name="j1" /></td>
								<td>E. Life saving dengan meminta persetujuan polisi</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="tombol-soal">
					<button type="button" class="btn btn-primary">
						<span class="glyphicon glyphicon-triangle-left" aria-hidden="true"></span>
					</button>
					<button type="button" class="btn btn-primary">
						<span class="glyphicon glyphicon-triangle-right" aria-hidden="true"></span>
					</button>
				</div>
				<div class="soal-number">
					<table class="table">
						<tbody>
							{$rows = 5}{$cols = 10}
							{for $row = 1 to $rows}
								<tr>
									{for $col = 1 to $cols}
										<td class="text-center">
											{$number = (($row - 1) * $cols) + $col}
											<form action="" method="post">
												<input type="submit" value="{$number}" class="btn btn-sm btn-default" />
											</form>
										</td>
									{/for}
								</tr>
							{/for}
						</tbody>
					</table>
				</div>
				<!-- End Soal -->
			</div>
						
			
			<div class="hidden-lg hidden-md hidden-sm col-xs-12">
				<a href="" class="thumbnail profile-picture"><img src="../assets/images/portrait3.jpg" alt="Profil Picture"></a>
				<p class="text-center">Mokhammad Fathoni Rokhman</p>
				<table class="table">
					<thead>
						<tr><th colspan="2">Status Pengerjaan</th></tr>
					</thead>
					<tbody>
						<tr>
							<td>Soal</td>
							<td><strong>50</strong></td>
						</tr>
						<tr>
							<td>Dijawab</td>
							<td><strong>25</strong></td>
						</tr>
						<tr>
							<td>Sisa Waktu</td>
							<td><span class="sisa-waktu">00:50:23</span></td>
						</tr>
					</tbody>
				</table>
				<form action="{current_url()}" method="post">
					<input type="submit" value="Selesai" />
				</form>
			</div>
						
		</div>
	</div>
{/block}
{block name="footer-script"}
	<script src="{base_url('assets/js/jquery.countdown-2.2.0/jquery.countdown.min.js')}"></script>
	<script type='text/javascript'>
		var endTime = new Date().getTime() + (1000 * 60 * 5);  // end in 5 minutes
		
		$('span.sisa-waktu').countdown(endTime)
			.on('update.countdown', function(event) {
				var $this = $(this);
				$this.html(event.strftime('%H:%M:%S'));
			})
			.on('finish.countdown', function(event) {
				var $this = $(this);
				$this.html(event.strftime('%H:%M:%S'));
			})
	</script>
{/block}