{extends file='layout.tpl'}
{block name='title'} - Tentang Online Tryout{/block}
{block name='head'}
	<style type="text/css">
		body { padding-top: 0; }
		.bs-docs-header, .bs-docs-masthead {
			position: relative;
			padding: 30px 0;
			color: rgb(200, 230, 230);
			text-align: center;
			text-shadow: 0 1px 0 rgba(0,0,0,.1);
			background-color: rgb(0, 140, 186);
			background-image: -webkit-gradient(linear,left top,left bottom,from(#563d7c),to(#6f5499));
			background-image: -webkit-linear-gradient(top,#563d7c 0,#6f5499 100%);
			background-image: -o-linear-gradient(top,#563d7c 0,#6f5499 100%);
			background-image: linear-gradient(to bottom,rgb(0, 80, 90) 0,rgb(0, 140, 186) 100%);
			filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#563d7c', endColorstr='#6F5499', GradientType=0);
			background-repeat: repeat-x;
		}
		.bs-docs-header {
			padding-top: 110px;
			padding-bottom: 60px;
			font-size: 24px;
			text-align: left;
		}
		.bs-docs-header h1 {
			margin-top: 0;
			color: rgb(255, 255, 255);
		}
	</style>
{/block}
{block name='content'}
	<div class="bs-docs-header" id="content" tabindex="-1"> 
		<div class="container">
			<h1>Tentang Kami</h1>
		</div> 
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1 class="page-header">PEDI UKDI</h1>
				<p class="lead">PEDI UKDI adalah bimbingan UKDI/UKMPPD yang hadir untuk membantu para teman sejawat mereview materi dan berlatih ribuan versi soal yang diprediksi sering keluar pada UKMPPD, sehingga mengerjakan UKMPPD yang sebenarnya sudah jauh lebih terbiasa.</p>
				
			</div>
		</div>

		<div class="row">
			<div class="col-md-6">
				<h2>Tryout Online</h2>
				<p>Hanya dengan Rp 99.000, sejawat dapat merasakan serunya sensasi mengerjakan soal-soal standar UKMPPD secara online plus memiliki kesempatan untuk mendapatkan kesempatan belajar di LBB PEDI-UKDI Dengan HARGA KHUSUS bagi peserta yang beruntung. Kami tunggu partisipasinya ya, semoga sukses!</p>
				<h2>Kenapa harus PEDI-UKDI ?</h2>
				<ol>
					<li>Modul &amp; Materi Lengkap sesuai standar UKMPPD</li>
					<li>Metode belajar terbaik dengan pendekatan keywords, tips-trik, dan pemahaman soal</li>
					<li>Belajar OSCE sesuai standar OSCE nasional</li>
				</ol>
			</div>
			<div class="col-md-6">
				<h2>PROGRAM BELAJAR PEDI-UKDI</h2>
				<p>Privat : minimal 5 orang dalam 1 kelompok, maksimal 10 orang, 10x pertemuan, (waktu dan tempat  fleksibel dikomunikasikan dengan tutor)</p>
				<p>OSCE : Teori, simulasi, kasus, 4 hari @ 3 jam, total 8 pos</p>
				<table class="table table-condensed table-bordered">
					<tbody>
						<tr>
							<td>Privat Saja</td>
							<td>Rp. 1.800.000</td>
						</tr>
						<tr>
							<td>OSCE saja </td>
							<td>Rp. 1.000.000</td>
						</tr>
						<tr>
							<td>TO Online Bersama</td>
							<td>Rp. 99.000</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		{include file="../footer.tpl"}

	</div>
{/block}