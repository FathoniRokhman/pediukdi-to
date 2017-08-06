<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

		<title>PEDI-UKDI User</title>

		<!-- Bootstrap core CSS -->
		<link href="{$ci->config->item('app_site_url')}assets/css/bootstrap-yeti.min.css" rel="stylesheet">

		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<link href="{$ci->config->item('app_site_url')}assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

		<!-- Custom styles for this template -->
		<style type="text/css">
			body { padding-top: 50px; }
			.mulai-tes { }
		</style>

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
		
		{block name='head'}{/block}
	</head>

	<body>

		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">PEDI-UKDI User</a>
				</div>
				<div id="navbar" class="navbar-collapse collapse">
					
					<ul class="nav navbar-nav">
						<li><a href="{site_url('home')}">Home</a></li>
						<li><a href="{site_url('home/elearning')}">E-Learning</a></li>
						<li><a href="{site_url('test/list-test')}">Tes</a></li>
						<li><a href="{site_url('test/test-result')}">Hasil Tes</a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="{site_url('auth/change_password')}">Ganti Password</a></li>
						<li><a href="{site_url('auth/logout')}">Logout</a></li>
					</ul>
				</div><!--/.nav-collapse -->
			</div>
		</nav>
		
		<div class="container" role="main">
			{block name='content'}{/block}
		</div>

		<!-- Bootstrap core JavaScript
		================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		<!-- <script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script> -->
		<script>window.jQuery || document.write('<script src="{base_url('../assets/js/jquery-1.12.4.min.js')}"><\/script>')</script>
		<script src="{base_url('../assets/js/bootstrap.min.js')}"></script>
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="{base_url('../assets/js/ie10-viewport-bug-workaround.js')}"></script>
		{block name='footer-script'}{/block}
	</body>
	
</html>