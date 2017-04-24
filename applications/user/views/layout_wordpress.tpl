<!DOCTYPE html>
<html lang="en-US">
	<head>
		<title>PEDI-UKDI{block name='title'}{/block}</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		{if $smarty.const.ENVIRONMENT == 'development'}
			<link rel='stylesheet' id='bootstrap-css'  href='{base_url('assets/wp-content/flat-bootstrap/css/bootstrap.min.css')}' type='text/css' media='all' />
			<link rel='stylesheet' id='theme-base-css'  href='{base_url('assets/wp-content/flat-bootstrap/css/theme-base.css')}' type='text/css' media='all' />
			<link rel='stylesheet' id='theme-flat-css'  href='{base_url('assets/wp-content/flat-bootstrap/css/theme-flat.css')}' type='text/css' media='all' />
			<link rel='stylesheet' id='flat-bootstrap-css'  href='{base_url('assets/wp-content/flat-bootstrap/style.css')}' type='text/css' media='all' />
			<link rel='stylesheet' id='child-css'  href='{base_url('assets/wp-content/flat-bootstrap-child/style.css')}' type='text/css' media='all' />
			<link rel='stylesheet' id='google_fonts-css'  href='//fonts.googleapis.com/css?family=Open+Sans:300,400,700' type='text/css' media='all' />
		{/if}
		{if $smarty.const.ENVIRONMENT == 'production'}
			<link rel='stylesheet' id='bootstrap-css'  href='http://www.pediukdi.com/wp-content/themes/flat-bootstrap/bootstrap/css/bootstrap.min.css?ver=3.3.6' type='text/css' media='all' />
			<link rel='stylesheet' id='theme-base-css'  href='http://www.pediukdi.com/wp-content/themes/flat-bootstrap/css/theme-base.css?ver=20160323' type='text/css' media='all' />
			<link rel='stylesheet' id='theme-flat-css'  href='http://www.pediukdi.com/wp-content/themes/flat-bootstrap/css/theme-flat.css?ver=20160323' type='text/css' media='all' />
			<link rel='stylesheet' id='flat-bootstrap-css'  href='http://www.pediukdi.com/wp-content/themes/flat-bootstrap/style.css?ver=4.7' type='text/css' media='all' />
			<link rel='stylesheet' id='child-css'  href='http://www.pediukdi.com/wp-content/themes/flat-bootstrap-child/style.css?ver=4.7' type='text/css' media='all' />
			<link rel='stylesheet' id='google_fonts-css'  href='//fonts.googleapis.com/css?family=Open+Sans:300,400,700' type='text/css' media='all' />
		{/if}
		<style type="text/css">
			/*.site-title,
			.site-description { */
			.site-branding {
				position: absolute;
				clip: rect(1px, 1px, 1px, 1px);
			}
			.navbar-brand {
				position: relative;
				clip: auto;
			}
		</style>
		{block name="head"}{/block}
	</head>
	<body class="home page-template page-template-page-fullpostsnoheader page-template-page-fullpostsnoheader-php page page-id-2 logged-in admin-bar no-customize-support">
		<header id="masthead" class="site-header" role="banner">

			<div id="site-branding" class="site-branding">
				<div class="container">
					<div class="site-branding-text">
						<h1 class="site-title"><a href="http://www.pediukdi.com/" rel="home">PEDI-UKDI</a></h1>
						<h2 class="site-description">Informasi kesehatan terpadu dari PEDI-UKDI</h2>
					</div>
				</div>
			</div><!-- .site-branding -->

			<nav id="site-navigation" class="main-navigation" role="navigation">
				<h2 class="menu-toggle screen-reader-text sr-only ">Primary Menu</h2>
				<div class="skip-link"><a class="screen-reader-text sr-only" href="#content">Skip to content</a></div>
				<div class="navbar navbar-default navbar-static-top">
					<div class="container">
						<div class="navbar-header"><button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button><a class="navbar-brand" href="http://www.pediukdi.com/" rel="home">PEDI-UKDI</a></div><!-- navbar-header -->
						<div class="navbar-collapse collapse">
							<div class="menu-main-menu-container">
								<ul id="menu-main-menu" class="nav navbar-nav">
									<li id="menu-item-11" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-home current-menu-item page_item page-item-2 current_page_item menu-item-11"><a title="Beranda" href="http://www.pediukdi.com/">Beranda</a></li>
									<li id="menu-item-12" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-12"><a title="Tentang Kami" href="http://www.pediukdi.com/?page_id=7">Tentang Kami</a></li>
									<li id="menu-item-13" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children menu-item-13 dropdown"><a title="Tryout Online" href="#" data-target="#" data-toggle="dropdown" class="dropdown-toggle">Tryout Online <span class="caret"></span></a>
										<ul role="menu" class=" dropdown-menu">
											<li id="menu-item-14" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-14 {if $ci->uri->segment(2) == 'pre-start'}active{/if}"><a title="Coba Soal !" href="{site_url('test-guest/pre-start')}">Coba Soal !</a></li>
											<li id="menu-item-55" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-55 {if $ci->uri->segment(2) == 'test-result-list'}active{/if}"><a title="Hasil Coba Soal" href="{site_url('test-guest/test-result-list')}">Hasil Coba Soal</a></li>
										</ul>
									</li>
									<li id="menu-item-59" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-59"><a title="Jadwal" href="http://www.pediukdi.com/?page_id=56">Jadwal</a></li>
									<li id="menu-item-60" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-60 {if $ci->uri->segment(2) == 'registration'}active{/if}"><a title="REGISTRASI" href="{site_url('auth/registration')}">REGISTRASI</a></li>
									<li id="menu-item-63" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-63"><a title="Kontak Kami" href="http://www.pediukdi.com/?page_id=61">Kontak Kami</a></li>
								</ul>
							</div>		<!-- Login Link -->
							<ul class="nav navbar-nav navbar-right"><li class="menu-item {if $ci->uri->segment(2) == 'login'}active{/if}"><a href="{site_url('auth/login')}">Login</a></li></ul>
						</div><!-- .container -->
					</div><!-- .navbar -->
				</div>
			</nav><!-- #site-navigation -->
			
		</header>

		{block name='content'}{/block}
		
		{if $smarty.const.ENVIRONMENT == 'development'}
		<script type='text/javascript' src='{base_url()}assets/js/jquery-1.12.4.min.js'></script>
		<script type='text/javascript' src='{base_url()}assets/js/jquery-migrate.min.js'></script>
		<script type='text/javascript' src='{base_url()}assets/js/bootstrap.min.js'></script>
        {/if}
        {if $smarty.const.ENVIRONMENT == 'production'}
		<script type='text/javascript' src='http://www.pediukdi.com/wp-includes/js/jquery/jquery.js?ver=1.12.4'></script>
		<script type='text/javascript' src='http://www.pediukdi.com/wp-includes/js/jquery/jquery-migrate.min.js?ver=1.4.1'></script>
		<script type='text/javascript' src='http://www.pediukdi.com/wp-content/themes/flat-bootstrap/bootstrap/js/bootstrap.min.js?ver=3.3.6'></script>
        {/if}
		{block name='footer-script'}{/block}
	</body>
</html>