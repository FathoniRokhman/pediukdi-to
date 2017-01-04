{extends file='../layout_wordpress.tpl'}
{block name='head'}
	<style type="text/css">
		.form-control { width: auto }
	</style>
{/block}
{block name='title'}Pengerjaan Soal TRIAL{/block}
{block name='content'}
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1 class="page-header">Tryout COBA SOAL</h1>
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Persiapan</h3>
					</div>
					<div class="panel-body">
						<h4>Anda akan memulai mencoba soal</h4>
						<p>Kami memerlukan informasi data anda, masukkan nama anda dan no telp terlebih dahulu sebelum memulai test.</p>
						<form action="{current_url()}" method="post">
							<div class="form-group">
								<label for="nama">Nama</label>
								<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama" required>
							</div>
							<div class="form-group">
								<label for="email">Email</label>
								<input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
							</div>
							<input type="submit" class="btn btn-primary" value="Mulai" />
						</form>
					</div>
				</div>

			</div>
		</div>
	</div>
{/block}