{extends file='../soal_layout.tpl'}
{block name='head'}
	<style type="text/css">
		.soal > .no-soal { float: left; margin-right: 4px; }
		.poin-jawaban, .jawaban-ragu { cursor: pointer; }
		.jawaban { margin-bottom: 5px; }
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
{block name='content'}
	<div class="container">
		<div class="row">

			<div class="col-lg-2 col-md-2 col-sm-3 hidden-xs">
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
							<td><strong><span class="sisa-waktu">{$test_session->sisa}</span></strong></td>
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

			<div class="col-lg-10 col-md-10 col-sm-9 col-xs-12">
				<!-- Region Soal -->
				<div class="soal">
					<div class="no-soal"><strong>{$soal->no_soal}. </strong></div>
					<div class="isi-soal">{$soal->isi_soal}</div>
				</div>
				<div class="jawaban">
					<table class="table-condensed">
						<col width="20px"/>
						<col />
						<tbody>
							{foreach $soal->jawaban as $jawaban}
								<tr>
									<td><input type="radio" data-huruf="{$jawaban->huruf}" name="jawaban" value="{$jawaban->id_jawaban_soal}" 
										{if !empty($jawaban_user)}{if $jawaban_user->id_jawaban_soal == $jawaban->id_jawaban_soal}checked=""{/if}{/if}/></td>
									<td class="poin-jawaban" data-huruf="{$jawaban->huruf}">{$jawaban->huruf|capitalize}. {$jawaban->jawaban}</td>
								</tr>
							{/foreach}
							<tr>
								<td>
									<input type="checkbox" name="is_ragu" 
										{if empty($jawaban_user)}disabled{/if}{* Jika belum jawab, tidak bisa pilih ragu *}
										{if !empty($jawaban_user)}{if $jawaban_user->is_ragu}checked{/if}{/if} />
								</td>
								<td>
									<i class="jawaban-ragu">Masih Ragu</i>
								</td>
							</tr>
						</tbody>
					</table>
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
{block name='footer-script'}
	<script src="{$ci->config->item('app_site_url')}assets/js/jquery.countdown-2.2.0/jquery.countdown.min.js"></script>
	<script type='text/javascript'>
		
		var endTime = '{$test_session->end_time}';
		
		$('span.sisa-waktu').countdown(endTime)
			.on('update.countdown', function(event) {
				var $this = $(this);
				$this.html(event.strftime('%H:%M:%S'));
			})
			.on('finish.countdown', function(event) {
				var $this = $(this);
				$this.html(event.strftime('%H:%M:%S'));
				
				alert('Waktu anda sudah habis. Anda bisa melihat hasilnya di menu Hasil Test');
				
				/* Redirect */
				window.location = '{$end_session_url}';
			});
		
		/* Jawaban berubah / dipilih */
		$('input[type="radio"][data-huruf]').on('change', function() {
			
			var btnNomor = $('button.btn-nomer-soal.aktif');
			/* Clear warna, kemudian warnai hijau */
			btnNomor.removeClass('btn-success btn-warning').addClass('btn-success');
			
			var data = {
				id_soal: '{$soal->id_soal}',
				id_jawaban_soal: $(this).val()
			};
			
			// Kirim jawaban ke server
			$.ajax({
				type: "POST",
				url: '{$jawab_soal_url}',
				data: data,
				dataType: 'json',
				beforeSend: function () {
					$('.jumlah-dijawab').html('<img src="{$ci->config->item('app_site_url')}assets/images/loading.gif" />');
                },
				success: function(data) {
					$('.jumlah-dijawab').html(data.jumlah_dijawab);
					// otomatis aktifkan checkbox ragu
					$('input[name="is_ragu"]').removeAttr('disabled');
				}
			});
			
			//$.post('{$jawab_soal_url}', data, function(data) {
			//	$('.jumlah-dijawab').html(data.jumlah_dijawab);
				// otomatis aktifkan checkbox ragu
			//	$('input[name="is_ragu"]').removeAttr('disabled');
			//});
		});
	
		/* Centang ragu di klik */
		$('input[name="is_ragu"]').on('change', function() {
			
			var is_checked = $(this).is(':checked');
			
			$.post('{$set_ragu_url}', { id_soal: '{$soal->id_soal}', checked: is_checked }, function(data) {
				var btnNomor = $('button.btn-nomer-soal.aktif');
				
				if (is_checked)
					btnNomor.removeClass('btn-success').addClass('btn-warning');  // Warna orange
				else
					btnNomor.removeClass('btn-warning').addClass('btn-success');  // Warna hijau
			});
		});
	
		// Event handler label jawaban di klik
		$('.poin-jawaban').on('click', function() {
			
			var huruf = $(this).data('huruf');
			var radio = $('input[type="radio"][data-huruf="'+huruf+'"]');
			
			/* set check saat jawaban di klik */
			radio.prop('checked', true);
			radio.trigger('change');

		});
		
		// Event handler tombol selesai di klik
		$('.btn-selesai').on('click', function() {
			if (confirm('Apakah anda akan menyelesaikan pengerjaan soal ?'))
				return;
			else
				return false;
		});
		
		// Event handler label ragu di klik
		$('.jawaban-ragu').on('click', function() {
			var raguCheckbox = $('input[name="is_ragu"]');
			if (raguCheckbox.is(':disabled') == false)
			{
				if (raguCheckbox.is(':checked'))
					raguCheckbox.prop('checked', false);
				else
					raguCheckbox.prop('checked', true);
				
				raguCheckbox.trigger('change');
			}
		});
	</script>
{/block}