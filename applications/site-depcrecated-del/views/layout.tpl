<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<link rel="icon" href="favicon.ico">

		<title>PEDI-UKDI{block name='title'} - Halaman depan{/block}</title>

		<!-- Bootstrap core CSS -->
		<link href="{base_url('assets/css/bootstrap-yeti.min.css')}" rel="stylesheet">

		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<link href="{base_url('assets/css/ie10-viewport-bug-workaround.css')}" rel="stylesheet">

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

		<style type="text/css">
			body {
				padding-top: 50px;
			}

			/* CUSTOMIZE THE NAVBAR
			-------------------------------------------------- */

			/* Special class on .container surrounding .navbar, used for positioning it into place. */
			.navbar-wrapper {
				position: absolute;
				top: 0;
				right: 0;
				left: 0;
				z-index: 20;
			}

			/* Flip around the padding for proper display in narrow viewports */
			.navbar-wrapper > .container {
				padding-right: 0;
				padding-left: 0;
			}
			.navbar-wrapper .navbar {
				padding-right: 15px;
				padding-left: 15px;
			}
			.navbar-wrapper .navbar .container {
				width: auto;
			}

			/* RESPONSIVE CSS
			-------------------------------------------------- */
			@media (min-width: 768px) {
				/* Navbar positioning foo */
				.navbar-wrapper {
					margin-top: 20px;
				}
				.navbar-wrapper .container {
					padding-right: 15px;
					padding-left: 15px;
				}
				.navbar-wrapper .navbar {
					padding-right: 0;
					padding-left: 0;
				}

				/* The navbar becomes detached from the top, so we round the corners */
				.navbar-wrapper .navbar {
					border-radius: 4px;
				}

				/* Bump up size of carousel content */
				.carousel-caption p {
					margin-bottom: 20px;
					font-size: 21px;
					line-height: 1.4;
				}

				.featurette-heading {
					font-size: 50px;
				}
			}

			@media (min-width: 992px) {
				.featurette-heading {
					margin-top: 120px;
				}
			}
		</style>

	{block name='head'}{/block}
</head>
<body>
	<!-- NAVBAR
	================================================== -->
	<div class="navbar-wrapper">
		<div class="container">

			<nav class="navbar navbar-inverse navbar-static-top">
				<div class="container">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="#">PEDI-UKDI</a>
					</div>
					<div id="navbar" class="navbar-collapse collapse">
						<ul class="nav navbar-nav">
							<li><a href="{site_url()}">Home</a></li>
							<li {if $ci->uri->segment(2) == 'about'}class='active'{/if}><a href="{site_url('site/about')}">Tentang Kami</a></li>
							<li><a href="{site_url('user/test-guest/pre-start')}">Coba Soal !</a></li>
							<li><a href="{site_url('user/test-guest/test-result-list')}">Hasil coba soal</a></li>
							<li {if $ci->uri->segment(2) == 'jadwal'}class='active'{/if}><a href="{site_url('site/jadwal')}">Jadwal</a></li>
							<li><a href="{site_url('user/auth/registration')}">Registrasi</a></li>
							<li {if $ci->uri->segment(2) == 'contact_us'}class='active'{/if}><a href="{site_url('site/contact_us')}">Kontak</a></li>
						</ul>

						<ul class="nav navbar-nav navbar-right">
							<li {if $ci->uri->segment(2) == 'login'}class='active'{/if}><a href="{site_url('user/auth/login')}">Login</a></li>
						</ul>
					</div>
				</div>
			</nav>

		</div>
	</div>

{block name='carousel'}{/block}

{block name='content'}{/block}

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<!-- <script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script> -->
<script>window.jQuery || document.write('<script src="{base_url('assets/js/jquery-1.12.4.min.js')}"><\/script>')</script>
<script src="{base_url('assets/js/bootstrap.min.js')}"></script>
<!-- Just to make our placeholder images work. Don't actually copy the next line! -->
<script src="{base_url('assets/js/holder.min.js')}"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="{base_url('assets/js/ie10-viewport-bug-workaround.js')}"></script>
</body>
</html>
