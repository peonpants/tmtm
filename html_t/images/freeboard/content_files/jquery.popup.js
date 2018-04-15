var popupClass = function() {
	
	this.title = "";
	this.modal = false;			// 모달 형태로 
	this.autosize = false;		// 가로 세로 사이즈를 자동으로 맞출껀지. 옵션
	this.position = "";			// 팝업창 위치 옵션
	this.padding = "0 0 0 0";	// 팝업창 패팅값
	this.background_color = ""; // 팝업창 배경색
	this.PageRendering = "iframe"
	this.PageMode = 0; // 페이지 팝업형식으로 볼껀지 레이어 형식으로 볼껀지 구분 0:팝업, 1:레이어
	this.objDiv;
}
popupClass.prototype.IE = function() { // IE 인지 FF 인지 구분
	return (document.all) ? true : false;
}
popupClass.prototype.getClientSize = function(mode) {
	var oDoc = document[document.compatMode == 'CSS1Compat' ? 'documentElement' : 'body'];
	if (/Opera/.test(navigator.userAgent)) oDoc = document.body;

	if (mode == "width") {
		return parseInt(oDoc.clientWidth, 10);
	} else if (mode == "height") {
		return parseInt(oDoc.clientHeight, 10);
	} else {
		return [
			parseInt(oDoc.clientWidth, 10),
			parseInt(oDoc.clientHeight, 10)
		];
	}
}

popupClass.prototype.getScrollSize = function (mode) {

	var oDoc = document[document.compatMode == 'CSS1Compat' ? 'documentElement' : 'body'];
	if (/Opera|Safari/.test(navigator.userAgent)) oDoc = document.body;

	// IE6 미만이면
	if (/MSIE\s([0-9]+(\.[0-9]+)*)/.test(navigator.userAgent) && parseFloat(RegExp.$1) < 6) {

		var aOld = [ oDoc.scrollLeft, oDoc.scrollTop ];
		var aClient = getClientSize();

		oDoc.scrollLeft = 999999;
		oDoc.scrollTop = 999999;

		var aRet = [
			oDoc.scrollLeft + aClient[0],
			oDoc.scrollTop + aClient[1]
		];
		oDoc.scrollLeft = aOld[0];
		oDoc.scrollTop = aOld[1];
		return aRet;
	}

	if (mode == "width") {
		return parseInt(oDoc.scrollWidth, 10);
	} else if (mode == "height") {
		return parseInt(oDoc.scrollHeight, 10);
	} else if (mode == "top") {
		return parseInt(oDoc.scrollTop, 10);
	} else {
		return [
			oDoc.scrollWidth,
			oDoc.scrollHeight,
			oDoc.scrollTop
		];
	}
}
popupClass.prototype.getScreenSize = function(mode) {
	var s;
	switch (mode) {
		case "width"  : s = screen.width; break;
		case "height" : s = screen.height; break;
	}
	return s;
}

popupClass.prototype.setContentOnLoad = function(name) {
	var __title = this.title;
	var __doc = document;
	if (__title == "") {
		__title = (this.IE() ? __doc.getElementById("content_"+name).document.title : __doc.getElementById("content_"+name).contentDocument.title);
		if (__title == "") __title = "no title";
	}
	var objTitle = __doc.getElementById("title_"+name);
	if (objTitle != null) {
		$(objTitle).html("<b>"+__title+"</b>").css({fontFamily:"Gulim", fontSize:"10pt", color:"#FFFFFF", letterSpacing:"0px"});
	}

	// 아이프레임 사이즈 자동 조절
	if (this.autosize) this.resizeToAuto(name);
}

// 객체 삭제
popupClass.prototype.purge = function(d) {   
	var a = d.attributes, i, l, n;   
	if (a) {   
		l = a.length;   
		for (i = 0; i < l; i += 1) {   
			n = a[i].name;   
			if (typeof d[n] === 'function') d[n] = null;   
		}   
	}   
	a = d.childNodes;   
	if (a) {   
		l = a.length;   
		for (i = 0; i < l; i += 1) {   
			purge(d.childNodes[i]);   
		}   
	}   
}
popupClass.prototype.setClose = function(strName) { // 닫기
	if (this.modal) $("#modal_background"+strName).remove();
	if (this.PageRendering == "iframe") $("#content_" + strName).remove(); // 아이프레임 삭제
	$("#"+strName).remove();
}
String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "");
}

popupClass.prototype.layer_mouseOver = function (obj, bool) {
	obj.src = (bool ? "/framework/js/image/close_on.gif" : "/framework/js/image/close_off.gif");
}

popupClass.prototype.setFocus = function (name) { // 클릭했을때 가장 상위로 오게한다.
	$("div.divFrame").each(function() {
		if (this.id == name) $(this).css("zIndex", 1000);
		else $(this).css("zIndex", 500);
	});
}
popupClass.prototype.resizeToAuto = function(name) {
	
	// 아이프레임 사이즈 조절
	var doc = document;
	var oFrame = doc.getElementById("content_"+name);
	if (oFrame != null) {
		var parentFrame;
		var _width;
		var _height;

		if (this.IE()) { // IE 라면...
			parentFrame = doc.frames["content_" + name].document.body;
			_width = parentFrame.scrollWidth + (parentFrame.offsetWidth - parentFrame.clientWidth);
			_height = parentFrame.scrollHeight + (parentFrame.offsetHeight - parentFrame.clientHeight);
		} else {
			parentFrame = oFrame.contentDocument.body;
			_width = $(parentFrame).outerWidth();
			_height = $(parentFrame).outerHeight();
		}
		
		var objDiv = doc.getElementById(name);
		$(objDiv).css({"width":_width+"px", "height":_height+"px"});
		$(oFrame).css({"width":_width+"px", "height":_height+"px"});
	}
}

popupClass.prototype.resizeTo = function(name, _top, _left, _width, _height) {
	var doc = document;
	var objDiv = doc.getElementById(name);
	var objIFrame = doc.getElementById("content_"+name);

	if (_top != null) $(objDiv).css("top", _top);
	if (_left != null) $(objDiv).css("left", _left);

	$(objDiv).css({width:_width, height:_height});
	$(objIFrame).css({width:_width, height:_height});
}

popupClass.prototype.$open = function(url, name, strArgs) {
	
	var self = this;
	var doc = document;
	var $doc = $(doc);
	if (this.modal) {
		$("<div id=\"modal_background" + name + "\" style=\"top:0px;left:0px;width:100%;height:" + $doc.height() + "px;position:absolute;z-Index:499;background:url(/framework/js/image/40x40.png);opacity:0.50;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=50)\"></div>").appendTo("body");
		//$("<div id=\"modal_background" + name + "\" style=\"top:0px;left:0px;width:100%;height:" + $doc.height() + "px;position:absolute;z-Index:499;background-color:#000000;opacity:0.50;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=50)\"></div>").appendTo("body");
	}
	var top	= 0, left = 0;
	var width = 1024, height = 768;
	var args = "", scrollbars;

	var strArr = strArgs.split(','); // 각 속성을 분리한다.
	for (var i=0, strArr_length = strArr.length; i<strArr_length; i++) {
		if (strArr[i].indexOf("=") !== -1) {
			var m = strArr[i].split('=');
			var field = m[0].trim();
			var value = m[1].trim();
			switch (field) {
				case 'left'		: left	 = value ; break;
				case 'top'		: top	 = value ; break;
				case 'width'	: width	 = parseInt(value, 10) ; break;
				case 'height'	: height = parseInt(value, 10); break;
				case 'scrollbars' :
					switch (value) {
						case "N" : scrollbars = "no"; break;
						case "Y" : scrollbars = "yes"; break;
						case "A" : scrollbars = "auto"; break;
						default : scrollbars = value; break;
					}
				break;
			}
		} else {
			args += (args=="" ? strArr[i] : "," + strArr[i]);
			doc.body.channelmode = true;
		}
	}
	if (this.position == "center") {
		var $win = $(window);
		top  = ($win.height()-height)/2 - 5 + $doc.scrollTop();
		left = ($win.width()-width)/2;
	}
	// 컨테이너 레이어
	this.objDiv = doc.createElement('div');
	this.objDiv.id = name;
	$(this.objDiv).addClass("divFrame").css({ "top":top+"px", "left":left+"px", "width":width+"px", "height":height+"px", 
			"position":"absolute", "padding":self.padding, "zIndex":500, "background-color":self.background_color
		}).mousedown(function() {
			self.setFocus(name)
		}).appendTo("body");
	
	if (this.PageMode == 0) { // 팝업모드라면...
		var p = '';
		p += '<table cellpadding="0" cellspacing="0" border="0">';
		p += '	<tr>';
		p += '		<td width="6" height="32"><img src="/framework/js/image/p1.gif" width="6" height="32" style="display:block"></td>';
		p += '		<td height="32" background="/framework/js/image/p2.gif">';
		p += '			<div id="title_bar_'+name+'" style="position:relative"><table cellpadding="0" cellspacing="0" width="100%">';
		p += '				<tr>';
		p += '					<td width="10"></td>';
		p += '					<td style="cursor:default"><div id="title_'+name+'"></div></td>';
		p += '					<td width="21" align="right"><img id="close_'+name+'" src="/framework/js/image/close_off.gif" width="21" height="21"></td>';
		p += '				</tr>';
		p += '			</table></div>';
		p += '		</td>';
		p += '		<td width="6" height="32"><img src="/framework/js/image/p3.gif" width="6" height="32" style="display:block"></td>';
		p += '	</tr>';
		p += '	<tr>';
		p += '		<td background="/framework/js/image/p4.gif" height='+height+'></td>';
		p += '		<td><iframe id="content_'+name+'" name="content_'+name+'" width="'+width+'" height="'+height+'" scrolling="'+scrollbars+'" frameborder="0" src="'+url+'" style="border:0px" allowTransparency="true"></iframe></td>';
		p += '		<td background="/framework/js/image/p6.gif"></td>';
		p += '	</tr>';
		p += '	<tr>';
		p += '		<td height="6"><img src="/framework/js/image/p7.gif" width="6" height="6" style="display:block"></td>';
		p += '		<td background="/framework/js/image/p8.gif"></td>';
		p += '		<td><img src="/framework/js/image/p9.gif" width="6" height="6" style="display:block"></td>';
		p += '	</tr>';
		p += '</table>';

		$(this.objDiv).html(p);
		$("#" + name).mousedown(function() { self.setFocus(name) }).draggable();
		$("#close_" + name).click(function() { self.setClose(name) }).mouseover(function() { self.layer_mouseOver(this, true) }).mouseout(function() { self.layer_mouseOver(this, false) });
		$("#content_" + name).load(function() { self.setContentOnLoad(name) }).mousedown(function() { self.setFocus(name) });
	}
	else if (this.PageMode == 1) { // 레이어 모드라면...
		if (this.PageRendering == "ajax") { // jQuery
			$("#"+name).load(url);
		} 
		else if (this.PageRendering == "iframe") {
			var oFrame = $("<iframe id=\"content_"+name+"\" name=\"content_"+name+"\" src=\""+url+"\" width=\"100%\" height=\""+height+"\" scrolling=\""+scrollbars+"\" frameborder=\"0\"></iframe>");
			oFrame.css({"border":"0px"}).appendTo(this.objDiv);
			if (this.autosize) {
				oFrame.load(function() { self.setContentOnLoad(name) }).mousedown(function() { self.setFocus(name) });
			}
		}
	}
}