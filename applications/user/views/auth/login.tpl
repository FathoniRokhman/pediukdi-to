{extends file='../layout_wordpress.tpl'}
{block name='title'} - Login{/block}
{block name="head"}
	<style type="text/css">
		body {
			-webkit-font-smoothing: antialiased;
		}

		.form-login {
			background-color: #EDEDED;
			padding-top: 10px;
			padding-bottom: 20px;
			padding-left: 20px;
			padding-right: 20px;
			border-radius: 15px;
			border-color:#d2d2d2;
			border-width: 5px;
			box-shadow:0 1px 0 #cfcfcf;
			width: 400px;
			margin: 80px auto 0;
		}

		h4 { 
			border:0 solid #fff; 
			border-bottom-width:1px;
			padding-bottom:10px;
			text-align: center;
		}

		.form-control {
			border-radius: 10px;
		}

		.wrapper {
			text-align: center;
		}

	</style>
{/block}
{block name='content'}
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="form-login">
					{if $ci->session->flashdata('gagal_login') === TRUE}
						<div class="panel panel-danger">
							<div class="panel-body">
								Login Email / Password anda tidak dikenali dalam sistem.
							</div>
						</div>
					{/if}
					<form action="{current_url()}" method="post">
						<h4>Silahkan login</h4>
						<input type="email" name="email" class="form-control input-sm chat-input" placeholder="Email anda" />
						<br/>
						<input type="password" name="password" class="form-control input-sm chat-input" placeholder="Password" />
						<br/>
						<div class="wrapper">
							<span class="group-btn">     
								<input type="submit" class="btn btn-primary btn-md" value="Login" />
							</span>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
{/block}