<link rel="stylesheet" href="{C_default_http_host}{D_ADMINCP_DIRECTORY}/assets/widgets/news/style.css" />
<form method="POST" enctype="multipart/form-data" >
<div class="Panel" >
	<div class="Row">
		[if {langInit}==true]
		<div class="BlockLang" >
			[foreach block=LANG_NEWS]
			<a href="" [if {LANG_NEWS.select}==true] class="active" [/if {LANG_NEWS.select}==true] href="./?pages=BlockPage&lang={LANG_NEWS.Lang}&mod={mod}[if {mod}==edit]&id={id}[/if {mod}==edit]&Section={Section}" >{LANG_NEWS.lang}</a>
			[/foreach]
		</div>
		[/if {langInit}==true]
		<button type="submit" class="Button SAVE" style="float: right" >Сохранить</button>
	</div>
</div>
<div class="Panel" >
	<label class="upload-img" for="upload-img" >
		<img src="{C_default_http_host}{images}" alt="" />
		<input type="file" name="images" onchange="uploadIMG(this);" id="upload-img" style="display: none;" />
	</label>
</div>
<div class="Panel" >
	<div class="form-group" >
		<div class="col-4" ><p class="label-control" >Заголовок</p></div>
		<div class="col-8" >
			<input type="text" value="{title}" class="form-control" name="title" />
		</div>
	</div>
	[if {categoriesInit}==true]
	<div class="form-group" >
		<div class="col-4" ><p class="label-control" >Категория</p></div>
		<div class="col-8" >
			<select class="form-control" name="categories" >
				<option value="" >нет</option>
				[foreach block=categories]
				<option  [if {cat}=={categories.id}] selected [/if {cat}=={categories.id}] value="{categories.id}">{categories.title}</option>
				[/foreach]
			</select>
		</div>
	</div>
	[/if {categoriesInit}==true]
	[if {setDateInit}==true]
	<div class="form-group" >
		<div class="col-4" ><p class="label-control" >Дата отоброжения</p></div>
		<div class="col-8" >
			<input type="hidden" name="date" id="news-datepicker-value" value="{date}" />
			<div id="news-datepicker" data-timepicker="true"></div>
		</div>
	</div>
	[/if {setDateInit}==true]
</div>
<div class="Panel" >
	<textarea class="tinymce-editor" name="desc" >{desc}</textarea>
</div>
</form>
<script>
SETTING = '{SETTING}';
SETTING = JSON.parse(SETTING);
$(document).ready(function(){
	news_datepicker = $('#news-datepicker').datepicker({
		altField : "#news-datepicker-value"
	}).data('datepicker');
	if(SETTING.setDateInit == "true" && SETTING.mod == "edit"){
		Sdate = new Date({date} * 1000);
		news_datepicker.selectDate(Sdate);
	}
});
</script>
<script>	
$(document).ready(function(){	
	tinymce.init({
		selector: '.tinymce-editor',
		height: 500,
		language : "ru",
		plugins: [
		"advlist autolink lists link image charmap print preview anchor",
		"searchreplace visualblocks code fullscreen",
		"insertdatetime media table contextmenu paste imagetools responsivefilemanager textcolor template"
		],
		toolbar: "insertfile undo redo |  bold italic | alignleft aligncenter alignright alignjustify | forecolor backcolor | bullist numlist outdent indent | link image responsivefilemanager ",
		content_css: [],
		valid_elements : "*[*]",
		forced_root_block : '',
		image_advtab: true, 
		external_filemanager_path:"assets/modules//tinymce/filemanager/", 
		filemanager_title:"Responsive Filemanager", 
		external_plugins: { "filemanager" : "filemanager/plugin.min.js"},
		cleanup: false,
		verify_html: false,
		cleanup_on_startup: false,
		validate_children: false,
		remove_redundant_brs: false,
		remove_linebreaks: false,
		force_p_newlines: false,
		force_br_newlines: false,
		valid_children: "+li[p|img|br|strong],+ol[p|img|br|strong],+ul[p|img|br|strong]",
		validate: false,
		fix_table_elements: false,
		fix_list_elements: false,
	});
});
</script>