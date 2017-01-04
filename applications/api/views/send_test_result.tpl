<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>Hasil test</title>
		<style type="text/css">

			::selection { background-color: #E13300; color: white; }
			::-moz-selection { background-color: #E13300; color: white; }

			body {
				background-color: #fff;
				margin: 40px;
				font: 13px/20px normal Helvetica, Arial, sans-serif;
				color: #4F5155;
			}

			a {
				color: #003399;
				background-color: transparent;
				font-weight: normal;
			}

			h1 {
				color: #444;
				background-color: transparent;
				border-bottom: 1px solid #D0D0D0;
				font-size: 19px;
				font-weight: normal;
				margin: 0 0 14px 0;
				padding: 14px 15px 10px 15px;
			}

			code {
				font-family: Consolas, Monaco, Courier New, Courier, monospace;
				font-size: 12px;
				background-color: #f9f9f9;
				border: 1px solid #D0D0D0;
				color: #002166;
				display: block;
				margin: 14px 0 14px 0;
				padding: 12px 10px 12px 10px;
			}

			#container {
				margin: 10px;
				border: 1px solid #D0D0D0;
				box-shadow: 0 0 8px #D0D0D0;
			}

			p {
				margin: 12px 15px 12px 15px;
			}

			table { margin: 15px; border-collapse: collapse; border-spacing: 0; }
			table thead tr th, table tbody tr td { border: 1px solid #333; padding: 6px 8px; }
			table tbody tr:nth-child(even) { background-color: #f9f9f9; }
			table tbody tr.selected-user td { font-weight: bold; padding: 4px; font-size: 16px; }
			.text-center { text-align: center; }
		</style>
	</head>
	<body>
		<div id="container">
			<h1>Hasil test {$jadwal_test->tanggal_test|date_format:"%d %B %Y"}</h1>

			<table>
				<thead>
					<tr>
						<th>Rank</th>
						<th>Nama</th>
						<th>Waktu Tes</th>
						<th>Dijawab</th>
						<th>Kosong</th>
						<th>Ragu</th>
						<th>Benar</th>
						<th>Salah</th>
						<th>Skor</th>
					</tr>
				</thead>
				<tbody>
					{foreach $data_set as $data}
						<tr {if $data->id_user == $user->id_user}class="selected-user"{/if}>
							<td class="text-center">{$data@index + 1}</td>
							<td>{if $data->id_user == $user->id_user}{$data->nama}{else}{str_repeat("x", strlen($data->nama))}{/if}</td>
							<td class="text-center">{$data->start_time|date_format:"%H:%M:%S"}</td>
							<td class="text-center">{$data->dijawab}</td>
							<td class="text-center">{$data->jumlah_soal - $data->dijawab}</td>
							<td class="text-center">{$data->ragu}</td>
							<td class="text-center">{$data->benar}</td>
							<td class="text-center">{$data->jumlah_soal - $data->benar}</td>
							<td class="text-center">{($data->benar/$data->jumlah_soal)*100}</td>
						</tr>
					{/foreach}
				</tbody>
			</table>

			<p style="font-size: small">Email ini dikirim karena anda telah mengikuti test Try Out PEDIUKDI.</p>
		</div>
	</body>
</html>