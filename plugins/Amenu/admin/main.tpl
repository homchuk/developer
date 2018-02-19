<link rel="stylesheet" href="{C_default_http_host}{D_ADMINCP_DIRECTORY}/assets/widgets/Amenu/style.css" />
<div class="AmenuBlock" >
<div class="Amenu" >
	<div id="Amenu-content" class="Amenu-content" ></div>
	<div class="Amenu-Setting" >
		<div class="Panel" >
			<table>
				<tr>
					<td>Заголовок</td>
					<td><input name="title" class="StyleIn" type="text" ></td>
				</tr>
				<tr>
					<td>Ссылка</td>
					<td><input name="link" class="StyleIn" type="text" ></td>
				</tr>
				<tr>
					<td>Иконка</td>
					<td><input type="hidden" name="icon" value="fa-tag" /><i id="Amenu-Setting-Icon" onclick="ShowIcon();" class="fa-tag" ></i></td>
				</tr>
				<tr>
					<td  >Доступен</td>
					<td>
						<div class="Amenu-access" >
							<form name="access">
							[foreach block=UserBlock]
							<div class="Item" >
								<input type="checkbox" class="StyleIn" name="{UserBlock.id}" />
								<p>{UserBlock.username}</p>
							</div>
							[/foreach]
							</form>
						</div>
					</td>
				</tr>
			</table>
			<button class="Button SAVE" onclick="SaveItemMenu();" >Применить</button>
			<button class="Button DEL" onclick="ResetItemMenu();" >Отменить</button>
			<button class="Button SAVE" style="float: right;" onclick="SaveMenu();" >Сохранить меню</button>
		</div>
	</div>
</div>
</div>
<div style="display: none;" id="tmp-item-menu" >
	<i class="@icon" ></i>
	<p>@title</p>
	<figure class="menu-move" ></figure>
	<figure class="menu-edit" ></figure>
	<figure class="menu-del" ></figure>
</div>
<script src="{C_default_http_host}{D_ADMINCP_DIRECTORY}/assets/widgets/Amenu/processing.js"></script>
<script>
var MENU_DB = {MENU_DB};
LoadMenu();
</script>