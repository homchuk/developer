<form name="CategoriesNews" enctype="multipart/form-data">
	<div class="form-group" >
		<div class="col-6" ><p>Поддержка языков</p></div>
		<div class="col-6" ><input type="checkbox" [if {lang}==true] checked [/if {lang}==true] class="form-control" name="lang" /></div>
	</div>
</form>
<button class="Button SAVE" onclick="CategoriesSettingSave();" >Сохранить</button>