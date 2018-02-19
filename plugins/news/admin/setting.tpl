<form name="SettingNews" enctype="multipart/form-data">
	<div class="form-group" >
		<div class="col-6" ><p>Поддержка языков</p></div>
		<div class="col-6" ><input type="checkbox" [if {lang}==true] checked [/if {lang}==true] class="form-control" name="lang" /></div>
	</div>
	<div class="form-group" >
		<div class="col-6" ><p>Поддержка категорий</p></div>
		<div class="col-6" ><input type="checkbox" [if {categories}==true] checked [/if {categories}==true] class="form-control" name="categories" /></div>
	</div>
	<div class="form-group" >
		<div class="col-6" ><p>Планирование</p></div>
		<div class="col-6" ><input type="checkbox" [if {setDate}==true] checked [/if {setDate}==true] class="form-control" name="setDate" /></div>
	</div>
	<div class="form-group" >
		<div class="col-6" ><p>Обрезка изображения</p></div>
		<div class="col-6" ><input type="checkbox" [if {resize_init}==true] checked [/if {resize_init}==true] id="news-images" onchange="newsImages();" class="form-control" name="resize.init" /></div>
		<div class="col-12" >
			<div class="form-group" id="news-images-setting" 
			[if {resize_init}==true]
			style="display: block;" >
			[/if {resize_init}==true]
			[if {resize_init}==false]
			style="display: none;" >
			[/if {resize_init}==false]
				<div class="col-5" ><input type="text" class="form-control" name="resize.width" placeholder="width" /></div>
				<div class="col-2" style="text-align: center;" >X</div>
				<div class="col-5" ><input type="text" class="form-control" name="resize.height" placeholder="height" /></div>
			</div>
		</div>
	</div>
</form>
<button class="Button SAVE" onclick="newsImagesSave();" >Сохранить</button>