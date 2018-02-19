<link rel="stylesheet" href="{C_default_http_host}{D_ADMINCP_DIRECTORY}/assets/widgets/news/style.css" />
<div class="BlockButton" >
	<a class="Button ADD Left" href="./?pages=news&mod=add" >Добавить</a>
	<a class="Button SETIN" onclick="NewsSetting();" >Настройки</a>
</div>
<div class="Panel" >
	<table id="dataTable" class="dataTable" width="100%" >
		<thead>
			<tr>
				<td>Заголовок</td>
				<td>Автор</td>
				<td>Дата</td>
				<td>Опции</td>
			</tr>
		</thead>
		<tbody>
			[foreach block=news]
			<tr>
				<td width="60%" >{news.title}</td>
				<td>{news.autor}</td>
				<td>{S_langdata="{news.date}","d M Y",true}</td>
				<td width="150px" >
					<a class="Button EDIT d-block m-top-botom-5" href="./?pages=news&mod=edit&id={news.id}" >Редактировать</a>
					<a class="Button DEL d-block m-top-botom-5" href="./?pages=news&mod=delete&id={news.id}" onclick="remove(this,event);" >Удалить</a>					
				</td>
			</tr>
			[/foreach]
		</tbody>
	</table>
</div>
<script src="{C_default_http_host}{D_ADMINCP_DIRECTORY}/assets/widgets/news/processing.js"></script>