<link rel="stylesheet" href="{C_default_http_host}{D_ADMINCP_DIRECTORY}/assets/css/lang.css" />
<div class="InitLang" >
	<div class="AllLanguages Panel Scroll" >
		<span>Добавить язык</span>
		[foreach block=AllLanguages]
		<div class="Item" >
			<span class="flag-{AllLanguages.flag}" >{AllLanguages.title}</span>
			<button class="Button min-add fa-check" onclick="AddLang('{AllLanguages.name}')" ></button>
		</div>
		[/foreach]
	</div>
	<div class="LangContent" >
	    [foreach block=SelectLang]
		<div class="Panel LangItem flag-{SelectLang.flag}">
			<span>{SelectLang.title}</span>
			<p><input type="radio" name="LangInit" value="{SelectLang.key}" [if {LangInit}=={SelectLang.key}] checked [/if {LangInit}=={SelectLang.key}]>Начальный</p>
			<figure>
				<a class="Button DEL DeleteLangItem" >Удалить</a>
				<a class="Button ADD" href="./?pages=Languages&Lang={SelectLang.key}" >Выбрать</a>
			</figure>
		</div>
		[/foreach]
	</div>
</div>


<div class="LangSetting" >
	<div class="Panel flag-{FlagInit}" >
		<span class="TitleBlock" >Добавить перевод</span>
		<table>
			<tr>
				<td><p>Ключ</p></td>
				<td><textarea id="NewLangItemKey" ></textarea></td>
			</tr>
			<tr>
				<td><p>Значение</p></td>
				<td><textarea id="NewLangItemValue" ></textarea></td>
			</tr>
		</table>
		<span class="TitleBlock">Опции</span>
		<figure>
			<p><input type="checkbox" id="FastEditCheckbox"/>Быстрый редактор</p>
			<button class="Button ADD" >Пересобрать переводы</button>
			<button class="Button ADD" onclick="UpdateLang('add');" >Сохранить</button>
			<button class="Button SAVE" onclick="javascript:window.location.reload()" >Обновить страницу</button>
		</figure>
	</div>
</div>

<div class="Panel" >
	<table id="dataTable" class="dataTable" width="100%" >
		<thead>
			<tr>
				<td>Ключ</td>
				<td>Текст</td>
				<td>Опции</td>
			</tr>
		</thead>
		<tbody>
			[foreach block=LangArr]
			<tr>
				<td  width="20%" id="LangArrKey{LangArr.id}" >{LangArr.Key}</td>
				<td>
					<div class="LangValue" ><p>{LangArr.Value}</p><textarea onchange="UpdateLang('edit',{LangArr.id});" id="LangArrValue{LangArr.id}" >{LangArr.Value}</textarea></div>
				</td>
				<td width="50px" >
					<a class="Button min-del m-auto d-block" onclick="UpdateLang('del',{LangArr.id});" ></a>
					<!--<a class="Button EDIT"  onclick="EditLang('del',{LangArr.id});" >Редактировать</a>-->
				</td>
			</tr>
			[/foreach]
		</tbody>
	</table>
</div>

<script type="text/javascript">
var Lang = "{Lang}";
function AddLang(l){
	ajax({url : default_admin_link+"?pages=Languages&LangSelect="+l},function(res){
		salert({title: "Языки", desc : "добавлен новый язык"});
		$(".LangContent").append(res);
		init();
	});
}
function init(){
	$("#FastEditCheckbox").change(function(){
		if($(this).prop("checked")){
			$(".LangValue").addClass("FastEdit");
		}else{
			$(".LangValue").removeClass("FastEdit");
		}
	});
	$(".LangItem input[type='radio']").click(function(){
		l = $(this).val();
		des = "Начальн язык сайта - "+$(this).parent().parent().children("span").text();
		ajax({url : default_admin_link+"?pages=Languages&LangInit="+l},function(){
			salert({title: "Языки", desc : des});
		}); 
	});
	$(".LangItem .DeleteLangItem").click(function(){
		des = "Удаления языка - "+$(this).parent().parent().children("span").text();
		salert({
			title: "Языки", 
			desc : des, 
			button : [0,1],
			data : $(this)
		},function(d){
			l = $(d).parent().parent().find("input[type='radio']").val(); 
			Div = $(d).parent().parent().remove();
			ajax({url : default_admin_link+"?pages=Languages&Delete&LangSelect="+l},function(){
				salert({title: "Языки", desc : "язык удален"});
			});
		});
	});
}
jQuery(document).ready(function($){
	init();
});
function UpdateLang(action,id){
	if(empty(action)){
		return false;
	}
	res = "";
	if(action == "add"){
		Key = document.getElementById("NewLangItemKey").value;
		Value = document.getElementById("NewLangItemValue").value;
		res = "Перевод добавлен";
	}
	if(action == "edit"){
		Key = document.getElementById("LangArrKey"+id).innerHTML;
		Value = document.getElementById("LangArrValue"+id).value;
		res = "Перевод обновлен";
	}
	if(action == "del"){
		Key = document.getElementById("LangArrKey"+id).innerHTML;
		res = "Перевод будет удален! продолжить?"
		salert({
			title: "Языки", 
			desc : res, 
			button : [0,1]
		},function(){
			ajax({
				url : default_admin_link+"?pages=Languages&UpdateLang=del&Lang="+Lang,
				data: {KeyLang: Key, StringLang: ""}
			},function(){
				salert({title: "Языки", desc : "перевод удален"});
			});
		});
	}
	if(action != "del"){
		ajax({
			url : default_admin_link+"?pages=Languages&UpdateLang="+action+"&Lang="+Lang,
			data: {KeyLang: Key, StringLang:Value}
		},function(){
			salert({title: "Языки", desc : res});
		});
	}
}
</script>
<script type="text/javascript">
jQuery(document).ready(function($){	
$("#dataTable").dataTable({
	//searching:false,
	"order": [[ 0, "desc" ]],
	language: {
      "processing": "Подождите...",
      "search": "<p>Поиск:</p>",
      "lengthMenu": "<p>Показать  записей</p> _MENU_",
      "info": "Записи с _START_ до _END_ из _TOTAL_ записей",
      "infoEmpty": "Записи с 0 до 0 из 0 записей",
      "infoFiltered": "(отфильтровано из _MAX_ записей)",
      "infoPostFix": "",
      "loadingRecords": "Загрузка записей...",
      "zeroRecords": "Записи отсутствуют.",
      "emptyTable": "В таблице отсутствуют данные",
      "paginate": {
        "first": "Первая",
        "previous": "Предыдущая",
        "next": "Следующая",
        "last": "Последняя"
      },
      "aria": {
        "sortAscending": ": активировать для сортировки столбца по возрастанию",
        "sortDescending": ": активировать для сортировки столбца по убыванию"
      }
	 }
});
});
</script>