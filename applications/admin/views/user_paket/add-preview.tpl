{extends file='../layout.tpl'}
{block name='head'}
	<style>
		legend { margin-bottom: 10px; }
		form { margin-bottom: 20px; }
	</style>
{/block}
{block name='content'}
	<h2 class="page-header">Pendaftaran Tes</h2>
	<h4>Preview : Periode {$periode->nama_periode} - {$periode_paket->nama_paket}</h4>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<fieldset>
			
			<legend><h4>User</h4></legend>

			<table id="tableUser" class="table-bordered table-condensed table-hover" style="width: 100%">
				<thead>
					<tr>
						<th></th>
						<th>Nama</th>
						<th>Asal</th>
						<th>Rotasi Klinik</th>
						<th>Telp</th>
						<th>Email</th>
					</tr>
				</thead>
				<tbody>
					{foreach $user_set as $user}
						<tr>
							<td></td>
							<td>{$user->nama}</td>
							<td>{$user->institusi}</td>
							<td>{$user->last_rotasi_klinik}</td>
							<td>{$user->no_hp}</td>
							<td>{$user->email}</td>
						</tr>
					{/foreach}
				</tbody>
			</table>
		</fieldset>
		
		<fieldset>
			<legend><h4>Pilih Soal : {$periode_paket->jumlah} soal</h4></legend>
			
			<table id="tableSoal" class="table-bordered table-condensed table-hover" style="width: 100%">
				<thead>
					<tr>
						<th></th>
						<th>Tanggal Mulai</th>
						<th>Form Soal</th>
						<th>Waktu Pengerjaan</th>
					</tr>
				</thead>
				<tbody>
					{foreach $periode_soal_set as $periode_soal}
						<tr>
							<td></td>
							<td>{$periode_soal->tgl_mulai_display}</td>
							<td>{$periode_soal->nama_form}</td>
							<td>{$periode_soal->waktu_pengerjaan}</td>
						</tr>
					{/foreach}
				</tbody>
			</table>
		</fieldset>
				
		<fieldset>
			<input type="hidden" name="mode" value="submit" />
			<input type="hidden" name="id_periode" value="{$ci->input->post('id_periode')}" />
			<input type="hidden" name="id_periode_paket" value="{$ci->input->post('id_periode_paket')}" />
			<input type="hidden" name="jumlah_soal" value="{$periode_paket->jumlah}" />
			{$id_user_set = $ci->input->post('id_user_set')}
			{$id_periode_soal_set = $ci->input->post('id_periode_soal_set')}
			{foreach $id_user_set as $id_user}
				<input type="hidden" name="id_user_set[]" value="{$id_user}" />
			{/foreach}
			{foreach $id_periode_soal_set as $id_periode_soal}
				<input type="hidden" name="id_periode_soal_set[]" value="{$id_periode_soal}" />
			{/foreach}
			<button name="submit" class="btn btn-primary">Simpan</button>
			<a href="{site_url('user-paket/index')}" class="btn btn-default">Batal</a>
		</fieldset>
		
	</form>
{/block}
{block name='footer-script'}
	
{/block}