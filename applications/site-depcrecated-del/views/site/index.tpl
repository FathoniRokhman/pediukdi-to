{extends file='layout.tpl'}
{block name='head'}
	<style type="text/css">body { padding-top: 0; }</style>
	<!-- Custom styles for this template -->
	<link href="{base_url('assets/css/carousel.css')}" rel="stylesheet">
{/block}
{block name='carousel'}
	<!-- Carousel ================================================== -->
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
		<!-- Indicators -->
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
			<li data-target="#myCarousel" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner" role="listbox">
			<div class="item active">
				<img class="first-slide" src="{base_url('assets/images/slide1.jpg')}" alt="First slide">
				<div class="container">
					<div class="carousel-caption">
						<h1>Online Tryout</h1>
						<p>Online Tryout terpercaya dengan soal-soal yang dihimpun oleh para pakar yang kompeten di bidangnya. Soal-soal yang terupdate tiap minggu sekali.</p>
						<p><a class="btn btn-lg btn-primary" href="{site_url('auth/registration')}" role="button">Daftar Sekarang !</a></p>
					</div>
				</div>
			</div>
			<div class="item">
				<img class="second-slide" src="{base_url('assets/images/slide2.jpg')}" alt="Second slide">
				<div class="container">
					<div class="carousel-caption">
						<h1>Multi platform</h1>
						<p>Sistem berjalan secara online bisa digunakan di komputer, tablet maupun di smartphone</p>
						<p><a class="btn btn-lg btn-primary" href="#" role="button">Pelajari lebih lanjut</a></p>
					</div>
				</div>
			</div>
			<div class="item">
				<img class="third-slide" src="{base_url('assets/images/slide3.jpg')}" alt="Third slide">
				<div class="container">
					<div class="carousel-caption">
						<h1>Pengukuran hasil</h1>
						<p>Mendapatkan informasi kemampuan pribadi terhadap seluruh peserta test</p>
						<p><a class="btn btn-lg btn-primary" href="#" role="button">Lihat tampilan</a></p>
					</div>
				</div>
			</div>
		</div>
		<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
			<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			<span class="sr-only">Previous</span>
		</a>
		<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
	<!-- /.carousel -->
{/block}
{block name='content'}
	<!-- Marketing messaging and featurettes
		================================================== -->
	<!-- Wrap the rest of the page in another container to center all the content. -->

	<div class="container marketing">

		<!-- Three columns of text below the carousel -->
		<div class="row">
			<div class="col-lg-4">
				<img class="img-circle" src="{base_url('assets/images/portrait1.jpg')}" alt="Generic placeholder image" width="140" height="140">
				<h2>Online Tryout</h2>
				<p>Online Tryout terpercaya dengan soal-soal yang dihimpun oleh para pakar yang kompeten di bidangnya. Soal-soal yang terupdate tiap minggu sekali.</p>
				<p><a class="btn btn-default" href="#" role="button">Daftar Sekarang !</a></p>
			</div><!-- /.col-lg-4 -->
			<div class="col-lg-4">
				<img class="img-circle" src="{base_url('assets/images/portrait2.jpg')}" alt="Generic placeholder image" width="140" height="140">
				<h2>Multi platform</h2>
				<p>Sistem berjalan secara online bisa digunakan di komputer, tablet maupun di smartphone</p>
				<p><a class="btn btn-default" href="#" role="button">Pelajari lebih lanjut</a></p>
			</div><!-- /.col-lg-4 -->
			<div class="col-lg-4">
				<img class="img-circle" src="{base_url('assets/images/portrait3.jpg')}" alt="Generic placeholder image" width="140" height="140">
				<h2>Pengukuran hasil</h2>
				<p>Mendapatkan informasi kemampuan pribadi terhadap seluruh peserta test</p>
				<p><a class="btn btn-default" href="#" role="button">Lihat tampilan</a></p>
			</div><!-- /.col-lg-4 -->
		</div><!-- /.row -->


		<!-- START THE FEATURETTES -->

		{include file="../footer.tpl"}
		
	</div>
	<!-- /.container -->
{/block}