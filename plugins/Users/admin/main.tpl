<link rel="stylesheet" href="{C_default_http_host}{D_ADMINCP_DIRECTORY}/assets/css/user.css" />
[if {view}==true]
<div>
	<a class="Button ADD" href="./?pages=Users&mod=Add">Добавить</a>
</div>
[foreach block=UserBlock]
<div class="UserItem" >
	<div class="Panel" >
		<div class="user-frame" >
			<div class="user-img">
				[if !empty({avatar})]
				<img  width="100%" src="{C_default_http_local}{UserBlock.avatar}" />
				[else !empty({avatar})]
				<img src="https://im0-tub-ua.yandex.net/i?id=2ba2546cc2778eff041111a535f97393&n=13" width="100%" />
				[/if !empty({avatar})]
			</div>
			<div class="user-content" >
				<table>
					<tr>
						<td>Логин</td>
						<td>{UserBlock.username}</td>
					</tr>
					<tr>
						<td>Уровень</td>
						<td>{L_{UserBlock.level}}</td>
					</tr>
				</table>
				<div class="user-button" >
					<a class="Button EDIT" href="./?pages=Users&mod=Edit&id={UserBlock.id}">Редактировать</a>
					<a class="Button min-del" href="./?pages=Users&mod=Delete&id={UserBlock.id}" onclick="remove(this,event);" ></a>
				</div>
			</div>
		</div>
	</div>
</div>
[/foreach]
[/if {view}==true]
[if {view}==false]
<form method="post" enctype="multipart/form-data" >
<div class="UserEdit" >
	<div class="Panel Row">
		<div class="UserEdit-img" >
			<label for="avatar" style="cursor: pointer;" >
				[if !empty({avatar})]
				<img  width="100%" src="{C_default_http_local}{avatar}" alt="" />
				[else !empty({avatar})]
				<img src="https://im0-tub-ua.yandex.net/i?id=2ba2546cc2778eff041111a535f97393&n=13" width="100%" alt="" />
				[/if !empty({avatar})]
			</label>
    		<input style="display: none;"  type="file" name="avatar" id="avatar">	
		</div>
		<div class="UserEdit-content" >
			<table>
				<tr>
					<td>Логин</td>
					<td><input name="username" class="StyleIn" type="text" placeholder="" value="{username}" ></td>
				</tr>
				<tr>
					<td>Пароль</td>
					<td><input name="pass" class="StyleIn" type="text" placeholder="" value="{light}" ></td>
				</tr>
				<tr>
					<td>Почта</td>
					<td><input name="email" class="StyleIn" type="text" placeholder="" value="{email}" ></td>
				</tr>
				<tr>
					<td>Уровень</td>
					<td>
						<select name="level" >
							<option value="1" [if {level}==1] selected [/if {level}==1] >{L_LEVEL_USER}</option>
							<option value="2" [if {level}==2] selected [/if {level}==2] >{L_LEVEL_MODER}</option>
							<option value="3" [if {level}==3] selected [/if {level}==3] >{L_LEVEL_ADMIN}</option>
							<option value="4" [if {level}==4] selected [/if {level}==4] >{L_LEVEL_CUSTOMER}</option>
							<option value="5" [if {level}==5] selected [/if {level}==5] >{L_LEVEL_CREATOR}</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>Активность</td>
					<td><input name="activ" class="StyleIn" type="checkbox" [if {activ}==on] checked="on" [/if {activ}==on] ></td>
				</tr>
				<tr>
					<td>Дата регистрации</td>
					<td>{S_langdata="{date}","d M Y",true}</td>
				</tr>
			</table>
		</div>
		<button type="submit" class="Button SAVE" >Сохранить</button>
	</div>
</div>
</form>
[/if {view}==false]