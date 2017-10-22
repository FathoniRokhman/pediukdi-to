{extends file='../layout_loggedin.tpl'}
{block name='head'}
	<style>
		form { margin-bottom: 15px; }
	</style>
{/block}
{block name='content'}
	<div class="row">
		<div class="col-md-12">
			
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Persiapan sebelum memulai tes</h3>
				</div>
				<div class="panel-body">
					<h4>Harap diperhatikan</h4>
					<p><strong>Anda akan memulai tes secara online. Begitu tes dimulai maka Anda harus menyelesaikannya sampai 
						selesai sesuai batas waktu yang sudah ditentukan. Apabila Anda tidak menyelesaikan sampai batas 
						waktu yang telah ditentukan, maka anda tidak bisa melanjutkan lagi. Pastikan juga mempunyai koneksi 
						yang stabil ketika mengerjakan agar tidak terputus di tengah jalan.</strong></p>
					<p>Informasi hasil tes bisa diketahui sesaat setelah test sudah selesai anda kerjakan.</p>
					{foreach $user_paket_soal_set as $user_paket_soal}
						{if strtotime($user_paket_soal->tgl_mulai) < time()}
						<form action="{site_url('test/start-session')}" method="post">
							<input type="hidden" name="id_user_paket_soal" value="{$user_paket_soal->id_user_paket_soal}" />
							<button class="btn btn-primary">{$user_paket_soal->nama_form} (Start {$user_paket_soal->tgl_mulai|date_format:"%d %B %Y"})
								<span class="glyphicon glyphicon-send" aria-hidden="true"></span>
							</button>
						</form>
						{else}
						<form>
							<button class="btn btn-primary" disabled="disabled">{$user_paket_soal->nama_form} (Start {$user_paket_soal->tgl_mulai|date_format:"%d %B %Y"})
								<span class="glyphicon glyphicon-send" aria-hidden="true"></span>
							</button>
						</form>
						{/if}
					{/foreach}
					<a href="{site_url('home')}" class="btn btn-default">Kembali</a>
				</div>
			</div>
			
		</div>
	</div>
{/block}