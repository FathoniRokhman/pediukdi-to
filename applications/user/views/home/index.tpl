{extends file='../layout_loggedin.tpl'}
{block name='content'}
	<!-- Main jumbotron for a primary marketing message or call to action -->
	<div class="jumbotron">
		<h1>Selamat datang,</h1>
		<p>{$user->nama}</p>
	</div>
	
	<div class="row">
		<div class="col-md-12">
			
			<div class="panel panel-danger">
				<div class="panel-heading">
					<h3 class="panel-title"><strong>PAKTA INTEGRITAS</strong></h3>
				</div>
				<div class="panel-body">
					<p><strong>Saya yang terdaftar dalam Try Out UKMPPD.</strong></p>
					<p><strong>Dengan ini menyatakan akan bersungguh-sungguh dalam melaksanakan try out simulasi UKMPPD 
						yang diselenggarakan oleh ensikloPEDI-UKDI. Nilai yang Saya dapat, akan Saya gunakan sebagai 
						pacuan bagi diri Saya agar belajar lebih baik, demi kelulusan Saya dalam UKMPPD tahun 2017.</strong></p>
					<p><strong>Pernyataan ini Saya buat dengan penuh Kesadaran.</strong></p>
				</div>
			</div>

		{if isset($pembayaran_aktif)}
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Informasi</h3>
				</div>
				<div class="panel-body">
					<p>Anda telah terdaftar untuk mengikuti tes online PEDI-UKDI yang akan diselenggarakan pada tanggal <strong>{$jadwal_test->tanggal_test|date_format:"%d %B %Y"}</strong>. 
						Anda diperbolehkan memulai pengerjaan soal jam berapa saja asal masih dalam tanggal tersebut. 
						Pastikan waktu untuk memulai pengerjaan tidak melebihi batas tanggal tes.</p>
					<p><a class="btn btn-default" href="{site_url('test/pre_start')}">Klik disini untuk memulai pengerjaan soal</a></p>
				</div>
			</div>
		{else}
			<div class="panel panel-warning">
				<div class="panel-heading">
					<h3 class="panel-title">Informasi</h3>
				</div>
				<div class="panel-body">
					<p>Anda belum terdaftar untuk mengikuti tes online PEDI-UKDI. Untuk melakukan pendaftaran silahkan hubungi Admin.</p>
				</div>
			</div>
		{/if}
	
		</div>
	</div>
	
{/block}
