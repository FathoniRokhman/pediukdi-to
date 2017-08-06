{extends file='../soal_layout.tpl'}
{block name='head'}
	<style type="text/css">
		.soal > .no-soal { float: left; margin-right: 4px; }
		.poin-jawaban, .jawaban-ragu { cursor: pointer; }
		.jawaban, .jawaban>.table { margin-bottom: 5px; }
		.tombol-soal { margin-bottom: 5px; }
		.tombol-soal-prev, .tombol-soal-next { display: inline; }
		div.soal-number { font-size: 110%; margin-top: 25px; }
		div.soal-number > .table { width: auto; }
		div.soal-number > .table>tbody>tr>td { padding: 4px; vertical-align: middle; text-align: center; }
		.btn-container > .btn-nomer-box { float: left; margin: 3px; padding: 0; display: block; }
		button.btn-nomer-soal { padding: 0; width: 35px; height: 35px; }
		.btn-nomer-soal.aktif { border: 4px solid gold; }
	</style>
{/block}
{block name="judul_menu"}Pembahasan Soal{/block}
{block name='content'}
	<div class="container">
		<div class="row">

			<div class="col-lg-2 col-md-2 col-sm-3 hidden-xs">
				{* <a href="" class="thumbnail profile-picture"><img src="{$ci->config->item('app_site_url')}assets/images/portrait3.jpg" alt="Profil Picture"></a> *}
				<p class="text-center">{$test_session->user->nama}</p>
				<table class="table">
					<thead>
						<tr><th colspan="2">Status Pengerjaan</th></tr>
					</thead>
					<tbody>
						<tr>
							<td>Soal</td>
							<td><strong>{$jumlah_soal}</strong></td>
						</tr>
						<tr>
							<td>Dijawab</td>
							<td><strong><span class="jumlah-dijawab">{$test_session->jumlah_dijawab}</span></strong></td>
						</tr>
						<tr>
							<td>Sisa Waktu</td>
							<td><strong><span class="sisa-waktu">0</span></strong></td>
						</tr>
						<tr>
							<td colspan="2" class="text-center">
								<a href="{site_url('test/list-test')}" class="btn btn-default btn-selesai">Kembali</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="col-lg-10 col-md-10 col-sm-9 col-xs-12">
				<!-- Region Soal -->
				<div class="soal">
					<div class="no-soal"><strong>{$soal->no_soal}. </strong></div>
					<div class="isi-soal">{$soal->isi_soal}</div>
				</div>
				<div class="jawaban">
					<table class="table table-condensed">
						<col width="20px"/>
						<col />
						<tbody>
							{foreach $soal->jawaban as $jawaban}
								
								{* Cek kunci, jika benar = hijau, jika salah = merah *}
								{$warna_tr = ''}
								{if !empty($jawaban_user)}
									{if $jawaban_user->id_jawaban_soal == $jawaban->id_jawaban_soal}
										{if $jawaban->is_kunci}
											{$warna_tr = 'success'}
										{else}
											{$warna_tr = 'danger'}
										{/if}
									{else}
										{if $jawaban->is_kunci}
											{$warna_tr = 'info'}
										{/if}
									{/if}
								{else}
									{if $jawaban->is_kunci}
										{$warna_tr = 'info'}
									{/if}
								{/if}
								
								<tr class="{$warna_tr}">
									<td><input type="radio" data-huruf="{$jawaban->huruf}" name="jawaban" value="{$jawaban->id_jawaban_soal}" 
										{if !empty($jawaban_user)}{if $jawaban_user->id_jawaban_soal == $jawaban->id_jawaban_soal}checked=""{/if}{/if} disabled="disabled"/></td>
									<td class="poin-jawaban" data-huruf="{$jawaban->huruf}">{$jawaban->huruf|capitalize}. {$jawaban->jawaban}
										{if $warna_tr == 'success'}
											<span class="glyphicon glyphicon-ok text-success" aria-hidden="true"></span>
										{else if $warna_tr == 'danger'}
											<span class="glyphicon glyphicon-remove text-danger" aria-hidden="true"></span>
										{else}
											{* Munculkan tanda pas kunci *}
											{if $jawaban->is_kunci}
												<span class="glyphicon glyphicon-ok text-info" aria-hidden="true"></span>
											{/if}
										{/if}
									</td>
								</tr>
							{/foreach}
							<tr>
								<td>
									<input type="checkbox" name="is_ragu" 
										{if empty($jawaban_user)}disabled{/if}{* Jika belum jawab, tidak bisa pilih ragu *}
										{if !empty($jawaban_user)}{if $jawaban_user->is_ragu}checked{/if}{/if} disabled="disabled"/>
								</td>
								<td>
									<i class="jawaban-ragu">Masih Ragu</i>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- Region Pembahasan Soal -->
				<div class="soal">
					<p>Pembahasan :</p>
					<div class="pembahasan-soal">{$soal->pembahasan_soal}</div>
				</div>
				
				<div class="tombol-soal">
					<form action="{$soal_url}/{$no_soal_prev}" method="get" class="tombol-soal-prev">
						<button class="btn btn-primary {if $no_soal_prev <= 0}disabled{/if}">
							<span class="glyphicon glyphicon-triangle-left" aria-hidden="true"></span>
						</button>
					</form>
					<form action="{$soal_url}/{$no_soal_next}" method="get" class="tombol-soal-next">
						<button class="btn btn-primary {if $no_soal == $jumlah_soal}disabled{/if}">
							<span class="glyphicon glyphicon-triangle-right" aria-hidden="true"></span>
						</button>
					</form>
				</div>
					
				<div class="btn-container">
					{for $number = 1 to $jumlah_soal}
						
						{* Mencocokan soal yg sudah terjawab *}
						{$warna_btn = 'btn-default'}
						{foreach $test_session->jawaban_user_set as $ju}
							{if $number == $ju->no_soal}
								{if $ju->is_ragu == 0}
									{$warna_btn = 'btn-success'}
								{else}
									{$warna_btn = 'btn-warning'}
								{/if}
								{break}
							{/if}
						{/foreach}
						
						{* Mempertebal border soal yg sedang dikerjakan *}
						{$border_aktif = ''}
						{if $number == $soal->no_soal}
							{$border_aktif = 'aktif'}
						{/if}
						
						<div class="btn-nomer-box">
							<form action="{$soal_url}/{$number}" method="post">
								<button class="btn btn-nomer-soal {$warna_btn} {$border_aktif}" data-nomer="{$number}">{$number}</button>
							</form>
						</div>
					{/for}
				</div>
				
				
				<!-- End Soal -->
			</div>


			<div class="hidden-lg hidden-md hidden-sm col-xs-12">
				{* <a href="" class="thumbnail profile-picture"><img src="{$ci->config->item('app_site_url')}assets/images/portrait3.jpg" alt="Profil Picture"></a> *}
				<p class="text-center">{$test_session->nama}</p>
				<table class="table">
					<thead>
						<tr><th colspan="2">Status Pengerjaan</th></tr>
					</thead>
					<tbody>
						<tr>
							<td>Soal</td>
							<td><strong>{$jumlah_soal}</strong></td>
						</tr>
						<tr>
							<td>Dijawab</td>
							<td><strong><span class="jumlah-dijawab">{$test_session->jumlah_dijawab}</span></strong></td>
						</tr>
						<tr>
							<td>Sisa Waktu</td>
							<td><span class="sisa-waktu">{$test_session->sisa}</span></td>
						</tr>
						<tr>
							<td colspan="2" class="text-center">
								<form action="{$end_session_url}" method="post">
									<button class="btn btn-default btn-selesai">Selesai</button>
								</form>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

		</div>
	</div>
	
{/block}