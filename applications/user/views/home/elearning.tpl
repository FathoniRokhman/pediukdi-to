{extends file='../layout_loggedin.tpl'}
{block name='content'}

<div class="container">

    {if $isAllowVideo eq 1}
	
    <div class="row">
        <h1 class="page-header">Daftar Video E-Learning</h1>
        {foreach $list_video as $data}
        <div class="col-lg-4">
            <div class="thumbnail">
                <div class="embed-responsive embed-responsive-16by9">
					<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/KQiiLe9SZNM"></iframe>
				</div>
                <div class="caption">
                    <h3>{$data.judulVideo}</h3>
                    <p>{$data.deskripsiVideo}</p>
                </div>
            </div>
        </div>
        {/foreach}
    </div>
    <div class="row">
        <div class="col-md-2 col-md-offset-5">{$linkPaging}</div>
    </div>
    {else}
 
    <div class="panel panel-warning">
        <div class="panel-heading">
            <h3 class="panel-title">Informasi</h3>
        </div>
        <div class="panel-body">
            <p>Anda belum terdaftar sebagai pengguna premium, silakan mengaktivasi layanan premium untuk melihat video E-learning mengikuti. Untuk melakukan pendaftaran silahkan hubungi Admin.</p>
        </div>
    </div>
    {/if}
</div>



{/block}