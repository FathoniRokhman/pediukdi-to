{extends file='../layout_loggedin.tpl'}
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
					<form action="{current_url()}" method="post">
						<a href="{site_url('home')}" class="btn btn-default">Kembali</a>
						<input type="submit" class="btn btn-primary" value="Mulai" />
					</form>
				</div>
			</div>
			
		</div>
	</div>
{/block}