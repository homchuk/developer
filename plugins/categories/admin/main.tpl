<div class="BlockButton" >
[if {page_add}!=false]
	<a class="Button ADD Left" href="./?pages=categories&page={page_add}&mod=add" >Добавить</a>
[/if {page_add}!=false]
	<a class="Button SETIN" onclick="CategoriesSetting();" >Настройки</a>
</div>
<div class="Panel" >
	<table id="dataTable" class="dataTable" width="100%" >
		<thead>
			<tr>
				<td>Транслит</td>
				<td>Найменование</td>
				<td>Модуль</td>
				<td>Опции</td>
			</tr>
		</thead>
		<tbody>
			[foreach block=categories]
			<tr>
				<td width="30%" >{categories.translit}</td>
				<td width="30%" >{categories.title}</td>
				<td width="20%" >{categories.page}</td>
				<td width="150px" >
					<a class="Button EDIT d-block m-top-botom-5" href="./?pages=categories&page={categories.page}&mod=edit&id={categories.id}" >Редактировать</a>
					<a class="Button DEL d-block m-top-botom-5" href="./?pages=categories&page={categories.page}&mod=delete&id={categories.id}" onclick="remove(this,event);" >Удалить</a>					
				</td>
			</tr>
			[/foreach]
		</tbody>
	</table>
</div>
<script>

function CategoriesSettingSave(){
	datas = formObject("CategoriesNews");
	$.ajax({
		type: "POST",
		url: default_admin_link +"?pages=categories&mod=setting&action=save",
		data: {datas}
	}).done(function(){
		salert({title: "Настройки", desc : "сохранено"});
	});
}
function CategoriesSetting(){
	$.ajax({
		type: "POST",
		url: default_admin_link +"?pages=categories&mod=setting"
	}).done(function(d){
		LiteBox(d,{title : "Настройки",id : 'LB-Setiing',w : 300,h : 150});
	});
}
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