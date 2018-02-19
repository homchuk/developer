var pattern = {
	bufferCSS : "",
	collection : [],
	add : function(selector, type, append, title){
		Citem = new Array;
		Citem["name"] = pattern.translit(selector+"_"+type);
		Citem["type"] = type;
		Citem["selector"] = selector;
		Citem["append"] = append;
		if(isset(title) && !empty(title)){
			Citem["title"] = title;
		}
		pattern.collection.push(Citem);
	},
	generate : function(){
		for(i=0;i<pattern.collection.length;i++){
			parent = document.querySelector(pattern.collection[i]["append"]); 
			type = pattern.collection[i]["type"];
			property = pattern.collection[i]["type"];
			name = pattern.collection[i]["name"];
			selector = pattern.collection[i]["selector"];
			type = type.split("-");
			for(j=0; j<type.length;j++){
				type[j] = type[j].charAt(0).toUpperCase() + type[j].substr(1).toLowerCase();
			}
			if(type[0]=="Border"){
				type = type[0];
			}else{
				type = type.join("");
			}			
			if(!isset(pattern.default[type])){
				continue;
			}
			if(isset(pattern.collection[i]["title"])){
				title = pattern.collection[i]["title"];
			}else{
				title = pattern.default[type];
			}
			html = pattern.template[type];
			html = pattern.tmp(html,"id",name);
			html = pattern.tmp(html,"title",title);
			if(isset(pattern.select[type])){
				keys = Object.keys(pattern.select[type]);
				select = "";
				for(j=0;j<keys.length;j++){
					select = select +"<option>"+keys[j]+"</option>";
				}
				html = pattern.tmp(html,"select",select);
			}
			$(parent).append(html);
			name = new pattern.elements[type](name,selector,property);		
		}
	},
	parse : function(container,selector,value){
		content = document.getElementById("css-admin");
		css = content.innerHTML;
		returnVal = false;
		if(!RegExp("("+container+")\\{(.*?)\\}","gs").test(css)){
			css = css+" \n "+container+"{}";
		}
		css = css.replace(RegExp("("+container+")\\{(.*?)\\}","gs"), function (match, cont, res){
			if(!RegExp("(?<!\\-)("+selector+")\\:(.*?)\\;","g").test(res)){
				res = res+" \n "+selector+":null;";
			}
			res = res.replace(RegExp("(?<!\\-)("+selector+")\\:(.*?)\\;","g"), function (m, s, c){
				returnVal = c;
				return s+":"+value+";";
			});
			return cont+"{"+res+"}";
		});
		if(value == "return"){
			return returnVal;
		}else{
			content.innerHTML = css;
		}
	},
	minification : function(){
		content = document.getElementById("css-admin");
		css = content.innerHTML;
		css = css.replace(RegExp("\\t","gs"), function (match){return "";});
		css = css.replace(RegExp("(?<=:)\\s","g"), function (match){return "";});
		css = css.replace(RegExp("(?<=,)\\s","g"), function (match){return "";});
		content.innerHTML = css;
	},
	translit : function(name){
		name = name.replace(RegExp("\\#","g"), function (match){return "";});
		name = name.replace(RegExp("\\.","g"), function (match){return "";});
		name = name.replace(RegExp("\\s","g"), function (match){return "_";});
		name = name.replace(RegExp("\\>","g"), function (match){return "_";});
		return name;
	},
	tmp : function(t,k,v){
		k = new RegExp('@'+k, 'g');
		return t.replace(k, v);
	},
	create : function(){
		var head = document.head || document.getElementsByTagName('head')[0];
		ajax({type: "GET",url:document.getElementById("css-admin").href},function(css){
			pattern.bufferCSS = css;
		});
		head.removeChild(document.getElementById("css-admin"));
		style = document.createElement("style");
    	style.id = "css-admin";
    	head.appendChild(style);
  		style.textContent = pattern.bufferCSS; 
	},
	init : function(){
		pattern.create();
		pattern.minification();
		pattern.generate();
		$('.colorPicker').colorPicker({
			renderCallback: function(){
				if(this.$trigger != null){
					this.$trigger[0].Finit();
				}
			}
		});
	}
}

pattern.default = {
		BackgroundColor : "Фон",
		Color : "Цвет",
		BoxShadow : "Тень",
		Border : "Обводка"
	};
pattern.select = {
		Border : {
			"solid" : 0,
			"dotted" : 1,
			"dashed" : 2,
			"double" : 3,
			"groove" : 4,
			"ridge"  : 5,
			"inset"  : 6,
			"outset" : 7
		}
	};
pattern.template = {
	BackgroundColor : '<div class="Item" ><span>@title</span><figure><input type="button" id="@id" class="colorPicker" value="@value"/></figure></div>',
	Color : '<div class="Item" ><span>@title</span><figure><input type="button" id="@id" class="colorPicker" value="@value"/></figure></div>',
	BoxShadow : '<div class="Item-group" ><span>@title</span><div class="Item" ><span>Цвет</span><figure><input type="button" id="@id_color" class="colorPicker" value="@value-color"/></figure></div><div class="Item" ><span>Смещение по Y</span><figure><input type="range" class="style-range" id="@id_y" min="-20" max="20" /></figure></div><div class="Item" ><span>Смещение по X</span><figure><input type="range" class="style-range" id="@id_x" min="-20" max="20" /></figure></div><div class="Item" ><span>Размытие</span><figure><input type="range" class="style-range" id="@id_blur" min="0" max="20" /></figure></div><div class="Item" ><span>Размер</span><figure><input type="range" class="style-range" id="@id_size" min="0" max="20" /></figure></div></div>',
	Border : '<div class="Item-group" ><span>@title</span><div class="Item" ><span>Цвет</span><figure><input type="button" id="@id_color" class="colorPicker" value="@value-color"/></figure></div><div class="Item" ><span>Тип</span><figure><select id="@id_type">@select</select></figure></div><div class="Item" ><span>Размер</span><figure><input type="range" class="style-range" id="@id_size" min="0" max="20" /></figure></div></div>'
};
pattern.elements = {
	Color : function (name,selector,property){
		buffVal = pattern.parse(selector, "color", "return");
		if(!buffVal || buffVal == "null"){
			buffVal = "#fff";
		}
    	document.getElementById(name).value = buffVal;
		document.getElementById(name).Finit = function (){
	        pattern.parse(selector, "color", this.value);
	    };
	},
	BackgroundColor : function (name,selector,property){
		buffVal = pattern.parse(selector, "background-color", "return");
		if(!buffVal || buffVal == "null"){
			buffVal = "#fff";
		}
		document.getElementById(name).value = buffVal;
		document.getElementById(name).Finit = function (){
	        pattern.parse(selector, "background-color", this.value);
	    };
	},
	BoxShadow : function (name,selector,property){
		buffVal = pattern.parse(selector, "box-shadow", "return");
		if(!buffVal || buffVal == "null"){
			buffVal = "0 0 0 0 #fff";
		}
    	buffVal = buffVal.split(" ");
    	document.getElementById(name+"_y").value = parseInt(buffVal[0]);
    	document.getElementById(name+"_x").value = parseInt(buffVal[1]);
    	document.getElementById(name+"_blur").value = parseInt(buffVal[2]);
    	document.getElementById(name+"_size").value = parseInt(buffVal[3]);
    	document.getElementById(name+"_color").value = buffVal[4];
		document.getElementById(name+"_color").Finit = function (){
			pattern.box.BoxShadow(name,selector);
	    };
	    document.getElementById(name+"_y").addEventListener('input', function(){
			pattern.box.BoxShadow(name,selector);
	    });
	    document.getElementById(name+"_x").addEventListener('input', function(){
			pattern.box.BoxShadow(name,selector);
	    });
	    document.getElementById(name+"_blur").addEventListener('input', function(){
			pattern.box.BoxShadow(name,selector);
	    });
	    document.getElementById(name+"_size").addEventListener('input', function(){
			pattern.box.BoxShadow(name,selector);
	    });
	},
	Border : function (name,selector,property){
		buffVal = pattern.parse(selector, property, "return");
		if(!buffVal || buffVal == "null"){
			buffVal = "1px solid #fff";
		}
    	buffVal = buffVal.split(" ");
    	document.getElementById(name+"_size").value = parseInt(buffVal[0]);
		document.getElementById(name+"_type").options.selectedIndex = pattern.select.Border[buffVal[1]];
    	document.getElementById(name+"_color").value = buffVal[2];
		document.getElementById(name+"_color").Finit = function (){
			pattern.box.Border(name,selector,property);
	    };
	    document.getElementById(name+"_type").addEventListener('change', function(){
			pattern.box.Border(name,selector,property);
	    });
	    document.getElementById(name+"_size").addEventListener('input', function(){
			pattern.box.Border(name,selector,property);
	    });
	}
};
pattern.box = {
	BoxShadow : function(name,selector){
		color = document.getElementById(name+"_color").value;
		y = document.getElementById(name+"_y").value;
		x = document.getElementById(name+"_x").value;
		blur = document.getElementById(name+"_blur").value;
		size = document.getElementById(name+"_size").value;
		css = x+"px "+y+"px "+blur+"px "+size+"px "+color;
		pattern.parse(selector, "box-shadow", css);
	},
	Border : function(name,selector,property){
		color = document.getElementById(name+"_color").value;
		type = document.getElementById(name+"_type").options.selectedIndex;
		type = document.getElementById(name+"_type").options[type].text;
		size = document.getElementById(name+"_size").value;
		css = size+"px "+type+" "+color;
		pattern.parse(selector, property, css);
	}
};