{extends file='../layout.tpl'}
{block name='head'}
	<link href="{site_url('../assets/DataTables/datatables.min.css')}" rel="stylesheet" />
	<style>
		#table thead tr th:nth-child(3), #table tbody tr td:nth-child(3),
		#table thead tr th:nth-child(6), #table tbody tr td:nth-child(6) { text-align: center; }
	</style>
{/block}
{block name='content'}
	<h2 class="page-header">Daftar User</h2>
	<table id="table" class="table table-bordered table-condensed">
		<thead>
			<tr>
				<th>Nama</th>
				<th>Asal</th>
				<th>Rotasi Klinik</th>
				<th>Telp</th>
				<th>Email</th>
				<th>Verifikasi</th>
				<th></th>
			</tr>
		</thead>
	</table>
{/block}
{block name='footer-script'}
	<script src="{site_url('../assets/DataTables/datatables.min.js')}"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#table').DataTable({
				ajax: '{site_url('user/index-data')}',
				columns: [
					{ data: 'nama' },
					{ data: 'institusi' },
					{ data: 'last_rotasi_klinik' },
					{ data: 'no_hp' },
					{ data: 'email' },
					{ data: function(row, type, set, meta) {
							if (row.is_verified === '1') {
								return '<span class="glyphicon glyphicon-ok-circle" aria-hidden="true" title="Verified"></span>';
							}
							else
								return '';
						} 
					},
					{ data: function(row, type, set, meta) {
							return '';
							// return '<a href="{site_url('user/add_pembayaran/')}'+row.id_user+'" class="btn btn-xs btn-success">Tambah Pembayaran Tes</a>';
						} 
					}
				],
				order: []
			});
		});
	</script>
{/block}