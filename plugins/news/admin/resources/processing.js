function newsImages(){
	checkbox = document.getElementById("news-images").checked;
	box = document.getElementById("news-images-setting");
	if(checkbox){
		box.style.display = "table";
	}else{
		box.style.display = "none";
	}
}
function newsImagesSave(){
	datas = formObject("SettingNews");
	$.ajax({
		type: "POST",
		url: default_admin_link +"?pages=news&mod=setting&action=save",
		data: {datas}
	}).done(function(){
		salert({title: "Настройки", desc : "сохранено"});
	});
}
function NewsSetting(){
	$.ajax({
		type: "POST",
		url: default_admin_link +"?pages=news&mod=setting"
	}).done(function(d){
		LiteBox(d,{title : "Настройки",id : 'LB-Setiing',w : 300,h : 300});
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