{extends file='layout.tpl'}
{block name="title"} - Jadwal{/block}
{block name="head"}{/block}
{block name="content"}
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1 class="page-header">Jadwal Kegiatan</h1>
				<h3>Jadwal rutin Try-Out</h3>
				<p>Setiap Sabtu Mulai Desember 2016 - Februari 2017</p>
				<table class="table">
					<thead>
						<tr>
							<th><h4>Desember 2016</h4></th>
							<th><h4>Januari 2017</h4></th>
							<th><h4>Februari 2017</h4></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<ul class="list-unstyled">
									<li>10 Desember 2016</li>
									<li>17 Desember 2016</li>
									<li>24 Desember 2016</li>
									<li>31 Desember 2016</li>
								</ul>
							</td>
							<td>
								<ul class="list-unstyled">
									<li>7 Januari 2017</li>
									<li>14 Januari 2017</li>
									<li>21 Januari 2017</li>
									<li>28 Januari 2017</li>
								</ul>
							</td>
							<td>
								<ul class="list-unstyled">
									<li>4 Februari 2017</li>
									<li>11 Februari 2017</li>
								</ul>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		{include file="../footer.tpl"}

	</div>
{/block}