{extends file='../layout_wordpress.tpl'}
{block name="title"} - Registrasi{/block}
{block name="head"}{/block}
{block name="content"}
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1 class="page-header">Registrasi</h1>

				<form class="form-horizontal" action="{current_url()}" method="post">
					<fieldset>
						
						<!-- Text input-->
						<div class="form-group">
							<label class="col-md-2 control-label" for="email">Email</label>  
							<div class="col-md-4">
								<input id="email" name="email" type="text" placeholder="contoh@gmail.com" class="form-control input-md" required="" value="{set_value('email')}">
								{if form_error('email')}{form_error('email')}{/if}
							</div>
						</div>

						<!-- Password input-->
						<div class="form-group">
							<label class="col-md-2 control-label" for="password">Password</label>
							<div class="col-md-3">
								<input id="password" name="password" type="password" class="form-control input-md" required="" value="{set_value('password')}">
								{if form_error('password')}{form_error('password')}{/if}
							</div>
						</div>

						<!-- Password input-->
						<div class="form-group">
							<label class="col-md-2 control-label" for="password2">Ulangi Password</label>
							<div class="col-md-3">
								<input id="password2" name="password2" type="password" class="form-control input-md" required="" value="{set_value('password2')}">
								{if form_error('password2')}{form_error('password2')}{/if}
							</div>
						</div>
						
						<br/>

						<!-- Text input-->
						<div class="form-group">
							<label class="col-md-2 control-label" for="nama">Nama</label>  
							<div class="col-md-4">
								<input id="nama" name="nama" type="text" placeholder="Nama lengkap anda" class="form-control input-md" required="" value="{set_value('nama')}">
								{if form_error('nama')}{form_error('nama')}{/if}
							</div>
						</div>
						
						<!-- Text input-->
						<div class="form-group">
							<label class="col-md-2 control-label" for="institusi">Institusi / Perguruan Tinggi</label>  
							<div class="col-md-4">
								<input id="institusi" name="institusi" type="text" placeholder="Asal institusi anda" class="form-control input-md" required="" value="{set_value('institusi')}">
								{if form_error('institusi')}{form_error('institusi')}{/if}
							</div>
						</div>
						
						<!-- Text input-->
						<div class="form-group">
							<label class="col-md-2 control-label" for="no_hp">No HP</label>  
							<div class="col-md-4">
								<input id="no_hp" name="no_hp" type="text" placeholder="Ex. 08100000000" class="form-control input-md" required="" value="{set_value('no_hp')}">
								<span class="help-block">Isikan nomer hp yg bisa dihubungi</span>
								{if form_error('no_hp')}{form_error('no_hp')}{/if}
							</div>
						</div>
						
						<!-- Select Basic -->
						<div class="form-group">
							<label class="col-md-2 control-label" for="rotasi_klinik">Tahun Terakhir Rotasi Klinik</label>
							<div class="col-md-2">
								<select name="last_rotasi_klinik" class="form-control" style="width: auto">
									<option value=""></option>
									{$max = date('Y')}
									{for $n=2000 to $max}
										<option value="{$n}" {if set_value('last_rotasi_klinik') == $n}selected="selected"{/if}>{$n}</option>
									{/for}
								</select>
							</div>
						</div>

						<!-- Button -->
						<div class="form-group">
							<label class="col-md-2 control-label" for="submit"></label>
							<div class="col-md-4">
								<button id="submit" name="submit" class="btn btn-primary">Daftar</button>
							</div>
						</div>

					</fieldset>
				</form>

			</div>
		</div>
	</div>
{/block}