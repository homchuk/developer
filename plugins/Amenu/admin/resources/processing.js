var ItemMenuEdit = false;
var ItemMenuEL = null;
var Collection = [];
var CT = {T: 0, R: 0, B: 0, L: 0};
///////////////////
var Wmouse = {Y: 0, directions:null};
window.addEventListener('mousemove',  function(e){
	if(Wmouse.Y < e.clientY && (Wmouse.directions != "down" || Wmouse.directions == null)){
		Wmouse.directions = "down";
	}
	if(Wmouse.Y > e.clientY &&  (Wmouse.directions != "up" || Wmouse.directions == null)){
		Wmouse.directions = "up";
	}
	Wmouse.Y = e.clientY;
});
//////////////////
function ShowIcon(){
	$.ajax({
		type: "POST",
		url: default_admin_link +"?pages=Amenu&mod=icons",
		data: {}
	}).done(function(d){
		LiteBox(d,{id : 'LB-Icon'});
		$(".menu-icon-content figure").click(function(){
			document.getElementsByName("icon")[0].value = $(this).attr("data-icon");
			document.getElementById("Amenu-Setting-Icon").className = $(this).attr("data-icon");
			$("#LB-Icon-close").click();
		});
		
	});
}
function FocusItemMenu(){
	$('#Amenu-content .menu-edit').click(function(){
		ResetItemMenu();
		ItemMenuEL = $(this).parent();
		ItemMenuEdit = true;
		document.getElementsByName("title")[0].value = $(ItemMenuEL).attr("menu-title");
		document.getElementsByName("link")[0].value = $(ItemMenuEL).attr("menu-link");
		document.getElementsByName("icon")[0].value = $(ItemMenuEL).attr("menu-icon");
		document.getElementById("Amenu-Setting-Icon").className = $(ItemMenuEL).attr("menu-icon");
		access = $(ItemMenuEL).attr("menu-access");
		access = JSON.parse(access);
		access_form = document.getElementsByName("access")[0];
		for(var i = 0; i < access_form.elements.length; i++){
			access_form.elements[i].checked = false;
			if(in_array(access_form.elements[i].name, access)){
				access_form.elements[i].checked = true;
			}
	    }
	});
	$('#Amenu-content .menu-del').click(function(){
		$(this).parent().remove();
	});
}
function ResetItemMenu(){
	ItemMenuEdit = false;
	document.getElementsByName("title")[0].value = "";
	document.getElementsByName("link")[0].value = "";
	document.getElementsByName("icon")[0].value = "fa-tag";
	document.getElementById("Amenu-Setting-Icon").className = "fa-tag";
	access_form = document.getElementsByName("access")[0];
	for(var i = 0; i < access_form.elements.length; i++){
		access_form.elements[i].checked = false;
    }
}
function SaveItemMenu(){
	title = document.getElementsByName("title")[0].value;
	link = document.getElementsByName("link")[0].value;
	icon = document.getElementsByName("icon")[0].value;
	access = new Array;
	access_form = document.getElementsByName("access")[0];
	for(var i = 0; i < access_form.elements.length; i++){
		if(access_form.elements[i].checked){
			access.push(access_form.elements[i].name);
		}
    }
	if(ItemMenuEdit){
		div = ItemMenuEL[0];
	}else{
		div = document.createElement('div');
		div.className = "Item";
	}
	div.setAttribute("menu-title", title);
	div.setAttribute("menu-link", link);
	div.setAttribute("menu-icon", icon);
	div.setAttribute("menu-access", JSON.stringify(access));
	tmp = document.getElementById("tmp-item-menu").innerHTML;
	tmp = TmpCreate(tmp,"icon",icon);
	tmp = TmpCreate(tmp,"title",title);
	div.innerHTML = tmp;
	if(!ItemMenuEdit){
		document.getElementById("Amenu-content").appendChild(div);
		CollectionCreate();
	}
	FocusItemMenu();
	ItemMenuEdit = false;
	ResetItemMenu();
	salert({title: "Меню", desc : "елемент сохранен"});
}
function SaveMenu(){
	i = null;
	cList = 0;
	Menu = new Array;
	$('#Amenu-content > .Item').each(function(j, element){
		elem = $(element);
		elem = elem[0];
		if(!$(element).hasClass("list-children")){
			if(i == null){
				i = 0;
			}else{
				i++;
			}
			Menu[i] = Object.create(null);
			Menu[i]["title"] = elem.getAttribute("menu-title");
			Menu[i]["link"] = elem.getAttribute("menu-link");
			Menu[i]["icon"] = elem.getAttribute("menu-icon");
			Menu[i]["access"] = elem.getAttribute("menu-access") != "undefined" ? JSON.parse(elem.getAttribute("menu-access")) : "";
			Menu[i]["parrent"] = false;
			cList = 0;
		}else{
			childrenList = Object.create(null);
			childrenList["title"] = elem.getAttribute("menu-title");
			childrenList["link"] = elem.getAttribute("menu-link");
			childrenList["icon"] = elem.getAttribute("menu-icon");
			childrenList["access"] = elem.getAttribute("menu-access") != "undefined" ? JSON.parse(elem.getAttribute("menu-access")) : "";
			if(typeof(Menu[i]["parrent"]) != "object" ){
				Menu[i]["parrent"] = new Array;
			}
			Menu[i]["parrent"][cList] = childrenList;
			cList++;
		}
	});
	$.ajax({
		type: "POST",
		url: default_admin_link +"?pages=Amenu&mod=save",
		data: {Menu}
	}).done(function(){
		salert({title: "Меню", desc : "сохранено"});
	});
}
function CreateMenuItem(obj,type){
	div = document.createElement('div');
	div.className = "Item";
	if(isset(type) && !empty(type)){
		div.classList.add(type);
	}
	div.setAttribute("menu-title", obj.title);
	div.setAttribute("menu-link", obj.link);
	div.setAttribute("menu-icon", obj.icon);
	div.setAttribute("menu-access", JSON.stringify(obj.access));
	tmp = document.getElementById("tmp-item-menu").innerHTML;
	tmp = TmpCreate(tmp,"icon",obj.icon);
	tmp = TmpCreate(tmp,"title",obj.title);
	div.innerHTML = tmp;
	document.getElementById("Amenu-content").appendChild(div);
}
function LoadMenu(){
	for(i=0;i<MENU_DB.length;i++){
		CreateMenuItem(MENU_DB[i]);
		if(typeof(MENU_DB[i].parrent) == "object" ){
			for(j=0;j<MENU_DB[i].parrent.length;j++){
				CreateMenuItem(MENU_DB[i].parrent[j],"list-children");
			}
		}
	}
	move();
	FocusItemMenu();
}

function CollectionCreate(){
	i = 0;
	$('#Amenu-content > .Item').each(function(j, element){
		if($(element).hasClass("focus")){
			return false;
		}
		elem = $(element);
		Collection[i] = Object.create(null);
		Collection[i]["Element"] = elem[0];
		Collection[i]["T"] = elem.offset().top;
		Collection[i]["B"] = elem.offset().top + elem.outerHeight();
		i++;
	});
}
function SelectFocus(el,mouse){
	if(mouse.Y > CT.T && mouse.Y < CT.B && mouse.X > CT.L && mouse.X < CT.R){
		CollectionCreate();
		for(i=0; i<Collection.length; i++){
			if(mouse.Y > Collection[i]["T"] && mouse.Y < Collection[i]["B"]){
				if(Wmouse.directions == "down"){
					if((Collection[i]["B"] - mouse.Y) < 5){
						$(Collection[i]["Element"]).insertBefore($(".cell-menu-list"));
					}					
				}
				if(Wmouse.directions == "up"){
					if((Collection[i]["T"] - mouse.Y) < 5){
						$(Collection[i]["Element"]).insertAfter($(".cell-menu-list"));
					}
				}				
			}
		}
	}
}
function move(){
	action = [];
	moveEl = null;
	$("#Amenu-content .Item .menu-move").mousedown(function(md){
		$(".substrate").addClass("active");
		CollectionCreate();
		moveEl = $(this).parent();
		moveEl = moveEl[0];
		$('<div class="cell-menu-list" ></div>').insertAfter($(moveEl));
		moveEl.classList.add("focus");
		moveEl.classList.remove("list-children");
		//////////////////////////
		CT.T = $("#Amenu-content").offset().top;
		CT.R = $("#Amenu-content").offset().left + $("#Amenu-content").outerWidth();
		CT.B = $("#Amenu-content").offset().top + $("#Amenu-content").outerHeight();
		CT.L = $("#Amenu-content").offset().left;
		//////////////////////////
		action['mousemove'] = function(mv){
			mouse = {X:mv.clientX,Y:mv.clientY};
			moveEl.style.top = (mv.clientY-md.offsetY)+"px";
			moveEl.style.left = (mv.clientX-md.offsetX)+"px";
			SelectFocus(moveEl,mouse);
			if((parseInt(moveEl.style.left) - CT.L) > 40){
				$(".cell-menu-list").addClass("list-children");
			}else{
				$(".cell-menu-list").removeClass("list-children");
			}
		};
		window.addEventListener('mousemove',  action['mousemove']); 
	}).mouseup(function(){
		window.removeEventListener('mousemove', action['mousemove']); 
		moveEl.classList.remove("focus");
		moveEl.style = "";
		$(moveEl).insertAfter($(".cell-menu-list"));
		if($(".cell-menu-list").hasClass("list-children")){
			$(moveEl).addClass("list-children");
		}
		$("#Amenu-content .cell-menu-list").remove();
		$(".substrate").removeClass("active");
	});
}