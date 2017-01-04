<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<link rel="icon" href="favicon.ico">

		<title>{block name='title'}Pengerjaan Soal{/block}</title>

		<!-- Bootstrap -->
		<link href="{$ci->config->item('app_site_url')}assets/css/bootstrap-yeti.min.css" rel="stylesheet">

		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<link href="{$ci->config->item('app_site_url')}assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
		
		{block name='head'}{/block}
	</head>
	<body>

		<!-- NAVBAR
		================================================== -->
		<div class="navbar-wrapper">
			<div class="container">

				<nav class="navbar navbar-static-top">
					<div class="container">
						<div class="navbar-header">
							<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
								<span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</button>
							<a class="navbar-brand" href="{site_url('home')}">PEDI-UKDI</a>
						</div>
						<div id="navbar" class="navbar-collapse collapse">
							<ul class="nav navbar-nav">
								<li>
									<a>Pengerjaan Soal</a>
								</li>
							</ul>
						</div>
					</div>
				</nav>
			</div>
		</div>

		{block name="content"}
			<div class="container"><div class="row"><div class="col-md-12">Content not Implement !</div></div></div>
		{/block}

		<!-- Bootstrap core JavaScript
		================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
		<script>window.jQuery || document.write('<script src="{$ci->config->item('app_site_url')}assets/js/jquery-1.12.4.min.js"><\/script>');</script>
		<script src="{$ci->config->item('app_site_url')}assets/js/bootstrap.min.js"></script>
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="{$ci->config->item('app_site_url')}assets/js/ie10-viewport-bug-workaround.js"></script>
	
		{block name="footer-script"}{/block}
	</body>
</html>