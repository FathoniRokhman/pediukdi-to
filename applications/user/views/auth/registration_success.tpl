{extends file='../layout_wordpress.tpl'}
{block name="title"} - Registrasi{/block}
{block name="head"}{/block}
{block name="content"}
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1 class="page-header">Registrasi</h1>
				
				<div class="alert alert-success" role="alert">
					<strong>Anda berhasil mendaftar !</strong><br/>
					Pastikan anda menerima email informasi pendaftaran.<br/>
					<a href="{site_url('auth/login')}" class="alert-link">Klik disini untuk Login</a>
				</div>
			</div>
		</div>
	</div>
{/block}