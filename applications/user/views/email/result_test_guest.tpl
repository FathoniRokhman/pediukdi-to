<!DOCTYPE html>
<html>
	<head>
		<title>Hasil tes</title>
		<style type="text/css">
			body {
				background-color: #fff;
				margin: 40px;
				color: #4F5155;
				font-family: Verdana;
				font-size: 12px;
			}
			h2 {
				color: #444;
				background-color: transparent;
				border-bottom: 1px solid #D0D0D0;
				font-size: 26px;
				font-weight: normal;
				margin: 0 0 14px 0;
				padding: 14px 15px 10px 15px;
			}
			a {
				color: #003399;
				background-color: transparent;
				font-weight: normal;
			}
			#container {
				margin: 10px 10px 10px 3px;
				border: 1px solid #D0D0D0;
				box-shadow: 0 0 8px #D0D0D0;
			}
			#footer {
				font-size: 11px;
			}
			p, table {
				margin: 12px 15px 12px 15px;
			}
			ul {
				margin: 6px 15px 12px;
			}
			ul>li>code { font-size: 13px; }
			
			table { border-collapse: collapse; border-spacing: 0; }
			table thead tr th, table tbody tr td { border: 1px solid #333; padding: 6px 8px; }
		</style>
	</head>
	<body>
		<div id="container">
			<h2>Selamat {$test_session_set[0]->nama}, Anda telah menyelesaikan Coba Soal</h2>
			<p>Berikut hasil pekerjaan anda untuk soal {$test_session_set[0]->form_soal->nama_form} :</p>
			{foreach $test_session_set as $test_session}
			<table>
				<thead>
					<tr>
						<th>Keterangan</th>
						<th>Jumlah</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Jumlah Soal</td>
						<td>{$test_session->form_soal->jumlah_soal}</td>
					</tr>
					<tr>
						<td>Dijawab</td>
						<td>{$test_session->form_soal->jumlah_dijawab}</td>
					</tr>
					<tr>
						<td>Dikosongi</td>
						<td>{$test_session->form_soal->jumlah_soal - $test_session->form_soal->jumlah_dijawab}</td>
					</tr>
					<tr>
						<td>Ragu</td>
						<td>{$test_session->form_soal->jumlah_ragu}</td>
					</tr>
				</tbody>
			</table>
			{/foreach}
			<p>Anda bisa melihat detail di link berikut : <a target="_blank" href="http://www.pediukdi.com/user/test-guest/test-result/{$test_session->id_guest_session}">http://www.pediukdi.com/user/test-guest/test-result/{$test_session->id_guest_session}</a></p>
		</div>
		<div id="footer">
			<p>&copy; PEDIUKDI.com - {date('Y')} </p>
		</div>
	</body>
</html>