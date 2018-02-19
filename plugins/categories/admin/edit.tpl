<form method="POST" enctype="multipart/form-data" >
<div class="Panel" >
	<div class="Row">
		<button type="submit" class="Button SAVE" style="float: right" >Сохранить</button>
	</div>
</div>

<div class="Panel" >
	[if {langInit}==true]
		[foreach block=CAT_LANG]
		<div class="form-group" >
			<div class="col-4" ><p class="label-control" >Заголовок ({CAT_LANG.lang})</p></div>
			<div class="col-8" >
				<input type="text" value="{CAT_LANG.title}" class="form-control" name="title[{CAT_LANG.lang}]" />
			</div>
		</div>
		[/foreach]
	[/if {langInit}==true]
	[if {langInit}==false]
	<div class="form-group" >
		<div class="col-4" ><p class="label-control" >Заголовок</p></div>
		<div class="col-8" >
			<input type="text" value="{title}" class="form-control" name="title" />
		</div>
	</div>
	[/if {langInit}==false]
</div>
</form>