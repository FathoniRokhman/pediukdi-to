{extends file='../layout_loggedin.tpl'}
{block name='content'}
	<h3 class="page-header">Ganti Password</h3>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<fieldset>

			<!-- Password input-->
			<div class="form-group">
				<label class="col-md-2 control-label" for="password">Password</label>
				<div class="col-md-3">
					<input id="password" name="password" class="form-control" type="text" autocomplete="off"/>
					{if form_error('password')}{form_error('password')}{/if}
				</div>
			</div>
			
			<!-- Password input-->
			<div class="form-group">
				<label class="col-md-2 control-label" for="password2">Password (Ulangi)</label>
				<div class="col-md-3">
					<input id="password2" name="password2" class="form-control" type="text" autocomplete="off"/>
					{if form_error('password2')}{form_error('password2')}{/if}
				</div>
			</div>

			<!-- Button -->
			<div class="form-group">
				<div class="col-md-offset-2 col-md-2">
					<button class="btn btn-primary">Simpan</button>
				</div>
			</div>

		</fieldset>
	</form>
						
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">Informasi</h4>
				</div>
				<div class="modal-body">
					{if $ci->session->flashdata('updated')}
						Perubahan berhasil di simpan
					{/if}
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
{/block}
{block name='footer-script'}
	{if $ci->session->flashdata('updated')}
		<script type="text/javascript">$('#myModal').modal();</script>
	{/if}
{/block}