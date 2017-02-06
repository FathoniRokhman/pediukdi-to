<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

		<title>Administrator PEDI-UKDI</title>

		{if $smarty.const.ENVIRONMENT == 'production'}
		<!-- Bootstrap core CSS -->
		<link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.7/yeti/bootstrap.min.css" rel="stylesheet" integrity="sha384-HzUaiJdCTIY/RL2vDPRGdEQHHahjzwoJJzGUkYjHVzTwXFQ2QN/nVgX7tzoMW3Ov" crossorigin="anonymous">
		{/if}
        
        {if $smarty.const.ENVIRONMENT == 'development'}
		<!-- Bootstrap core CSS -->
		<link href="{$ci->config->item('app_site_url')}assets/css/bootstrap-yeti.min.css" rel="stylesheet">
		{/if}
        
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<link href="{$ci->config->item('app_site_url')}assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
		<!-- Custom styles for this template -->
		<link href="{$ci->config->item('app_site_url')}assets/css/admin.css" rel="stylesheet">

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
		
		{block name='head'}{/block}
	</head>

	<body>

		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="{site_url()}">PEDI-UKDI Administrator</a>
				</div>
				<div id="navbar" class="navbar-collapse collapse">
					
					<ul class="nav navbar-nav">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Manajemen Soal <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="{site_url('form-soal')}">Master Lembar Soal</a></li>
								<li><a href="{site_url('soal')}">Editor Soal</a></li>
								<li><a href="{site_url('kelompok-soal')}">Master Kelompok Soal</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Manajemen User <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="{site_url('user')}">Daftar User</a></li>
								<li><a href="{site_url('pembayaran')}">Pembayaran</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Manajemen Tes <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="{site_url('jadwal')}">Jadwal Tes</a></li>
								<li><a href="{site_url('hasil')}">Hasil Tes</a></li>
							</ul>
						</li>
						<li>
							<li><a href="{site_url('elearning')}">Manajemen E-learning</a></li>
						</li>
					</ul>
					
					<ul class="nav navbar-nav navbar-right">
						<li><a href="{site_url('home/setting')}">Setting</a></li>
						<li><a href="{site_url('home/logout')}">Logout</a></li>
					</ul>
				</div>
			</div>
		</nav>


		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-2 col-md-2 hidden-sm hidden-xs">
					<!-- It can be fixed with bootstrap affix http://getbootstrap.com/javascript/#affix-->
					<div id="sidebar" class="sidebar-nav">
						<h5><i class="glyphicon glyphicon glyphicon-book"></i>
							<small><b>MANAJEMEN SOAL</b></small>
						</h5>
						<ul class="nav nav-pills nav-stacked">
							<li><a href="{site_url('form-soal')}">Master Lembar Soal</a></li>
							<li><a href="{site_url('soal')}">Editor Soal</a></li>
							<li><a href="{site_url('kelompok-soal')}">Master Kelompok Soal</a></li>
						</ul>
						<h5><i class="glyphicon glyphicon-user"></i>
							<small><b>MANAJEMEN USER</b></small>
						</h5>
						<ul class="nav nav-pills nav-stacked">
							<li><a href="{site_url('user')}">Daftar User</a></li>
							<li><a href="{site_url('pembayaran')}">Pembayaran</a></li>
						</ul>
						<h5><i class="glyphicon glyphicon-user"></i>
							<small><b>MANAJEMEN TES</b></small>
						</h5>
						<ul class="nav nav-pills nav-stacked">
							<li><a href="{site_url('jadwal')}">Jadwal Tes</a></li>
							<li><a href="{site_url('hasil')}">Hasil Tes</a></li>
						</ul>
						<h5><i class="glyphicon glyphicon-user"></i>
							<small><b>MANAJEMEN E-Learning</b></small>
						</h5>
						<ul class="nav nav-pills nav-stacked">
							<li><a href="{site_url('elearning')}">Video</a></li>
						</ul>
					</div>
				</div>
				<div class="col-lg-10 col-md-10 col-sm-12 col-xs-12 main">
					{block name='content'}{/block}
				</div>
			</div>
		</div>

		<!-- Bootstrap core JavaScript
		================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		{if $smarty.server.SERVER_NAME == 'www.pediukdi.com'}
		<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/js/ie10-viewport-bug-workaround.js" crossorigin="anonymous"></script>
		{else}
		<script src="{base_url('../assets/js/jquery-1.12.4.min.js')}"></script>
		<script src="{base_url('../assets/js/bootstrap.min.js')}"></script>
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="{base_url('../assets/js/ie10-viewport-bug-workaround.js')}"></script>
		{/if}
		{block name='footer-script'}{/block}
	</body>

</html>