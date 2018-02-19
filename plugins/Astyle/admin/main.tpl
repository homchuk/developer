<link rel="stylesheet" href="{C_default_http_host}{D_ADMINCP_DIRECTORY}/assets/widgets/Astyle/style.css" />
[if {logo}==true]
<form role="form" class="form-horizontal" method="post" enctype="multipart/form-data">
	<div class="Astyle-logo" >
		<label style="background-image: url('{C_default_http_host}{site-logo}'" for="site-logo" ></label>
		<input type="file" name="logo" id="site-logo" style="display: none;" />
		<button type="submit" class="Button SAVE m-auto d-block" >Сохранить</button>
	</div>
</form>
[/if {logo}==true]
[if {logo}==false]
<div class="BlockButton right">
	<span class="Title" style="float: left;" ><b>Настройка стилизации админ панели</b></span>
	<a class="Button ADD" onclick="SaveStyle();" >Сохранить</a>
</div>

<div class="Astyle_custom_block" >
	<div class="Astyle-item" >
		<span>:default</span>
		<div class="Astyle-setting" >
			<div id="style-Button-ADD" ></div>
		</div>
		<div class="Astyle-content" >
			<a class="Button ADD" >Добавить</a>
		</div>
		<span>:hover</span>
		<div class="Astyle-setting" >
			<div id="style-Button-ADD-hover" ></div>
		</div>
	</div>
	
	<div class="Astyle-item" >
		<span>:default</span>
		<div class="Astyle-setting" >
			<div id="style-Button-EDIT" ></div>
		</div>
		<div class="Astyle-content" >
			<a class="Button EDIT" >Редактировать</a>
		</div>
		<span>:hover</span>
		<div class="Astyle-setting" >
			<div id="style-Button-EDIT-hover" ></div>
		</div>
	</div>
	
	<div class="Astyle-item" >
		<span>:default</span>
		<div class="Astyle-setting" >
			<div id="style-Button-DEL" ></div>
		</div>
		<div class="Astyle-content" >
			<a class="Button DEL" >Удалить</a>
		</div>
		<span>:hover</span>
		<div class="Astyle-setting" >
			<div id="style-Button-DEL-hover" ></div>
		</div>
	</div>
	
	<div class="Astyle-item" >
		<span>:default</span>
		<div class="Astyle-setting" >
			<div id="style-Button-SAVE" ></div>
		</div>
		<div class="Astyle-content" >
			<a class="Button SAVE" >Сохранить</a>
		</div>
		<span>:hover</span>
		<div class="Astyle-setting" >
			<div id="style-Button-SAVE-hover" ></div>
		</div>
	</div>
</div>

<div class="Astyle_custom_block" >
	<div class="Astyle-item" >
		<span>Админ панели</span>
		<div class="Astyle-setting" >
			<div id="style-body" ></div>
		</div>
	</div>
	<div class="Astyle-item" >
		<span>Шапка админ панели</span>
		<div class="Astyle-setting" >
			<div id="style-header" ></div>
		</div>
	</div>
	<div class="Astyle-item" >
		<span>Навигация админ панели</span>
		<div class="Astyle-setting" >
			<div id="style-nav" ></div>
		</div>
	</div>
</div>
<div class="Astyle_full_block" >
	<div class="Astyle-item" >
		<span>Стилизация панели</span>
		<div class="Astyle-setting" >
			<div id="style-panel" ></div>
		</div>
		<div class="Astyle-content" >
			<div class="Panel" style="margin: 0" >Стилизация админ панели</div>
		</div>
	</div>
</div>
<script src="{C_default_http_host}{D_ADMINCP_DIRECTORY}/assets/widgets/Astyle/processing.js?{S_time}"></script>
<script>
$(document).ready(function(){
	pattern.add(".ADD","background-color","#style-Button-ADD");
	pattern.add(".ADD:hover","background-color","#style-Button-ADD-hover");
	pattern.add(".EDIT","background-color","#style-Button-EDIT");
	pattern.add(".EDIT:hover","background-color","#style-Button-EDIT-hover");
	pattern.add(".DEL","background-color","#style-Button-DEL");
	pattern.add(".DEL:hover","background-color","#style-Button-DEL-hover");
	pattern.add(".SAVE","background-color","#style-Button-SAVE");
	pattern.add(".SAVE:hover","background-color","#style-Button-SAVE-hover");
	
	pattern.add(".Panel","background-color","#style-panel");
	pattern.add(".Panel","color","#style-panel");
	pattern.add(".Panel","box-shadow","#style-panel");
	pattern.add(".Panel","border","#style-panel");
	pattern.add(".Panel","border-left","#style-panel", "Обводка (по левому краю)");
	
	pattern.add("body","background-color","#style-body");
	pattern.add("body","color","#style-body");
	
	pattern.add("header","background-color","#style-header");
	pattern.add("header","color","#style-header");
	
	pattern.add("nav","background-color","#style-nav");
	
	////////////////////////////////////////////////
	pattern.init();
	
	$(".Item-group").each(function(){
		$(this).css("height", $(this).height());
		$(this).addClass("close");
	});
	
	$(".Item-group > span").click(function(){
		$(".Item-group").addClass("close");
		$(this).parent().toggleClass("close");
	});
});

function SaveStyle(){
	css = document.getElementById("css-admin").innerHTML;
	$.ajax({
		type: "POST",
		url: default_admin_link +"?pages=Astyle&mod=save",
		data: {css : css}
	}).done(function(){
		salert({title: "Стилизация", desc : "Сохранено"});
	});
}
</script>
[/if {logo}==false]