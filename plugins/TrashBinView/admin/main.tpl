<div class="Panel" >
	<table id="dataTable" class="dataTable" width="100%" >
		<thead>
			<tr>
				<td>Заголовок</td>
				<td>Дата удаления</td>
				<td>Опции</td>
			</tr>
		</thead>
		<tbody>
			[foreach block=TrashBin]
			<tr>
				<td width="60%" >{TrashBin.name}</td>
				<td>{S_langdata="{TrashBin.date}","d M Y",true}</td>
				<td width="150px" >
					<a class="Button EDIT d-block m-top-botom-5" href="./?pages=TrashBinView&mod=reestablish&id={TrashBin.id}" >Востановить</a>
					<a class="Button DEL d-block m-top-botom-5" href="./?pages=TrashBinView&mod=delete&id={TrashBin.id}" onclick="remove(this,event);"  >Удалить</a>					
				</td>
			</tr>
			[/foreach]
		</tbody>
	</table>
</div>
<script type="text/javascript">
jQuery(document).ready(function($){	
$("#dataTable").dataTable({
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