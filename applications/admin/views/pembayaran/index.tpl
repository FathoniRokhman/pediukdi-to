{extends file='../layout.tpl'}
{block name='head'}
	<link href="{site_url('../assets/DataTables/datatables.min.css')}" rel="stylesheet" />
{/block}
{block name='content'}
	<h2 class="page-header">Daftar Pembayaran</h2>
	<p>Untuk menambah pembayaran, masuk ke menu <code>Daftar User &gt; Tambah Pembayaran Tes</code></p>
	
	<table id="tablePembayaran" class="table table-bordered table-condensed">
		<thead>
			<tr>
				<th></th>
				<th>Nama User</th>
				<th>Jadwal Tes</th>
				<th>Lembar Soal</th>
				<th>Tanggal Bayar</th>
				<th>Besar Bayar</th>
			</tr>
		</thead>
	</table>
	
	<p><button class="btn btn-danger" id="btnDelete" data-toggle="modal" data-target="#deleteModal" style="display:none">Hapus Pembayaran Terpilih</button></p>
	
	<!-- Modal Konfirmasi -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<h4>Apakah pembayaran terpilih akan dihapus ?</h4>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default" data-dismiss="modal">Batal</button>
					<button class="btn btn-danger" data-dismiss="modal" id="btnConfirmDelete">Hapus</button>
				</div>
			</div>
		</div>
	</div>
{/block}
{block name='footer-script'}
	<script src="{site_url('../assets/DataTables/datatables.min.js')}"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			
			var table = $('#tablePembayaran').DataTable({
				ajax: "{site_url('pembayaran/index-data')}",
				columns: [
					{ className: 'select-checkbox', defaultContent: '', orderable: false },
					{ data: "nama" },
					{ data: null, render: { sort: "tanggal_test", filter: "tanggal_test_display", display: "tanggal_test_display" } },
					{ data: "nama_form" },
					{ data: null, render: { sort: "tanggal_bayar", filter: "tanggal_bayar_display", display: "tanggal_bayar_display" } },
					{ data: "biaya" }
				],
				select : { style: 'multi' }
			});
			
			table.on('select', function(e, dt, type, indexes) {
				if (type === 'row') {
					if (dt.rows({ selected: true }).count() > 0)
						$('#btnDelete').show();
				}
			});
			
			table.on('deselect', function(e, dt, type, indexes) {
				if (type === 'row') {
					if (dt.rows({ selected: true }).count() === 0)
						$('#btnDelete').hide();
				}
			});
				
			var selectedIds = []; /* Kumpulan PK yang mau di hapus */
			
			$('#btnDelete').on('click', function() {
				selectedIds = []; /* clear array */
				$.each(table.rows({ selected: true }).data(), function(key, value) {
					selectedIds.push(value.id_pembayaran);
				});
				
				
			});
			
			$('#btnConfirmDelete').on('click', function() {
				$.post('{site_url('pembayaran/delete-multi')}', { id_pembayaran_set: selectedIds }, function(data, textStatus, jqXHR) {
					if (data === '1') {
						alert('Data berhasil dihapus');
						table.rows({ selected: true }).remove().draw();
						$('#btnDelete').hide();
					}
					else
						alert('data gagal dihapus');
				});
			});
		});
	</script>
{/block}