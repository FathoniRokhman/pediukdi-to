{extends file='../layout.tpl'}
{block name='head'}
	<style>
		/* Custom Style */
		form > fieldset > legend { margin-bottom: 10px; }
		.no-soal { height:auto; padding: 5px 7px; color: black; font-weight: bold; }
		.form-horizontal .jawaban, .form-horizontal .kelompok-soal { margin-left: 0; margin-bottom: 10px; }
		.kelompok-soal .control-label { width: auto; padding: 9px 5px 0; float: left; }
		.kelompok-soal > div > select { padding: 3px 5px; height: auto; }
		.jawaban > .control-label { float: left; padding: 9px 10px 0 }
		.jawaban > div > .input-group > .form-control { height: auto; padding: 3px 5px; }
		.jawaban > div > .input-group > .input-group-addon { padding: 3px 7px }
	</style>
{/block}
{block name='content'}
	<h2 class="page-header">Editor Soal</h2>
	<form class="form-horizontal" action="{current_url()}" method="post">
		<input type="hidden" name="id_form_soal" value="{$soal->id_form_soal}" />
		<fieldset>
			<!-- Form Name -->
			<legend><h4>Edit Soal - {$form_soal->nama_form}</h4></legend>
		
		
			<!-- Textarea input -->
			<div class="form-group">
				<div class="col-md-7">
				<textarea class="form-control" rows="1" id="editorSoal" name="isi_soal">{$soal->isi_soal}</textarea>
				</div>
				<div class="col-md-1">
					<label>No Soal</label><input type="text" class="form-control input-md no-soal" name="no_soal" value="{$soal->no_soal}"/>
				</div>
			</div>
			
			<!-- Select Basic -->
			<div class="form-group kelompok-soal">
				<label class="control-label" for="id_kelompok_soal" >Kelompok Soal</label>
				<div class="col-md-5">
					<select id="id_kelompok_soal" name="id_kelompok_soal" class="form-control">
						<option value="">-- Pilih Kelompok Soal --</option>
						{html_options options=$kelompok_soal_set selected=$soal->id_kelompok_soal}
					</select>
				</div>
			</div>
			
			<!-- Text input-->
			<div class="form-group jawaban">
				<label class="control-label" for="jawaban_a"><strong>A. </strong></label>
				<div class="col-md-6">
					<div class="input-group">
						<input class="form-control" type="text" name="jawaban[a]" value="{$soal->jawaban.a->jawaban}"/>
						<span class="input-group-addon"><input type="radio" name="kunci" value="a" {if $soal->jawaban.a->is_kunci}checked{/if}/> Kunci</span>
					</div>
				</div>
			</div>
			
			<!-- Text input-->
			<div class="form-group jawaban">
				<label class="control-label"><strong>B. </strong></label>
				<div class="col-md-6">
					<div class="input-group">
						<input class="form-control" type="text" name="jawaban[b]" value="{$soal->jawaban.b->jawaban}"/>
						<span class="input-group-addon"><input type="radio" name="kunci" value="b" {if $soal->jawaban.b->is_kunci}checked{/if}/> Kunci</span>
					</div>
				</div>
			</div>
			
			<!-- Text input-->
			<div class="form-group jawaban">
				<label class="control-label"><strong>C. </strong></label>
				<div class="col-md-6">
					<div class="input-group">
						<input class="form-control" type="text" name="jawaban[c]" value="{$soal->jawaban.c->jawaban}"/>
						<span class="input-group-addon"><input type="radio" name="kunci" value="c" {if $soal->jawaban.c->is_kunci}checked{/if}/> Kunci</span>
					</div>
				</div>
			</div>
			
			<!-- Text input-->
			<div class="form-group jawaban">
				<label class="control-label"><strong>D. </strong></label>
				<div class="col-md-6">
					<div class="input-group">
						<input class="form-control" type="text" name="jawaban[d]" value="{$soal->jawaban.d->jawaban}"/>
						<span class="input-group-addon"><input type="radio" name="kunci" value="d" {if $soal->jawaban.d->is_kunci}checked{/if}/> Kunci</span>
					</div>
				</div>
			</div>
			
			<!-- Text input-->
			<div class="form-group jawaban">
				<label class="control-label"><strong>E. </strong></label>
				<div class="col-md-6">
					<div class="input-group">
						<input class="form-control" type="text" name="jawaban[e]" value="{$soal->jawaban.e->jawaban}"/>
						<span class="input-group-addon"><input type="radio" name="kunci" value="e" {if $soal->jawaban.e->is_kunci}checked{/if}/> Kunci</span>
					</div>
				</div>
			</div>
			
			<!-- Button (Double) -->
			<div class="form-group">
				<div class="col-md-8">
					<a href="{site_url('soal')}?ifs={$soal->id_form_soal}" class="btn btn-default">Batal</a>
					<input type="submit" value="Simpan" class="btn btn-primary"/>
				</div>
			</div>
			
		</fieldset>	
	</form>
{/block}
{block name='footer-script'}
	<script src="{base_url('../assets/plugins/ckeditor/ckeditor.js')}"></script>
	
	<script type="text/javascript">
		CKEDITOR.replace('editorSoal', {
			height: 150,
			width: 600,
			toolbarGroups : [
				{ name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
				{ name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
				{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
				{ name: 'forms', groups: [ 'forms' ] },
				{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
				{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
				{ name: 'links', groups: [ 'links' ] },
				{ name: 'insert', groups: [ 'insert' ] },
				{ name: 'styles', groups: [ 'styles' ] },
				{ name: 'colors', groups: [ 'colors' ] },
				{ name: 'tools', groups: [ 'tools' ] },
				{ name: 'others', groups: [ 'others' ] },
				{ name: 'about', groups: [ 'about' ] }
			],
			removeButtons: 'Anchor,Underline,Strike,Subscript,Superscript,Outdent,About,Unlink,Link,Indent',
			extraPlugins: 'uploadwidget,uploadimage',
			filebrowserUploadUrl: '{site_url('soal/upload-img')}',
			image_previewText: "."
		});
	</script>
{/block}