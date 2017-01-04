{extends file='layout.tpl'}
{block name='title'} - Kontak Kami{/block}
{block name="head"}
	<style type="text/css">
		body {
			padding-top: 100px;
		}
	</style>
{/block}
{block name='content'}
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<div class="well well-sm">
					<form>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label for="name">Nama</label>
									<input type="text" class="form-control" id="name" placeholder="Masukkan nama anda" required="required" />
								</div>
								<div class="form-group">
									<label for="email">Email</label>
									<div class="input-group">
										<span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span>
										</span>
										<input type="email" class="form-control" id="email" placeholder="Enter email" required="required" /></div>
								</div>
								<div class="form-group">
									<label for="subject">Perihal</label>
									<select id="subject" name="subject" class="form-control" required="required">
										<option value="na" selected="">Pilih salah satu:</option>
										<option value="service">General Customer Service</option>
										<option value="suggestions">Suggestions</option>
										<option value="product">Product Support</option>
									</select>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="name">
										Pesan</label>
									<textarea name="message" id="message" class="form-control" rows="9" cols="25" required="required"
											  placeholder="Tulis pertanyaan atau pesan Anda disini"></textarea>
								</div>
							</div>
							<div class="col-md-12">
								<button type="submit" class="btn btn-primary pull-right" id="btnContactUs">
									Kirim Pesan</button>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="col-md-4">
				<form>
					<legend><span class="glyphicon glyphicon-globe"></span> Kontak Kami</legend>
					<address>
						<strong>Andra Pranata</strong><br/>
						<abbr title="Phone">HP: 0856-4875-1499</abbr><br/>
						<strong>Bagus</strong><br/>
						<abbr title="Phone">HP: 0812-5257-3664</abbr><br/>
					</address>
				</form>
			</div>
		</div>
	</div>

{/block}