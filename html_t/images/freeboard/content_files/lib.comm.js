var CommClass = function() {}
var Response = function() {}
var Request = function() {}

Request.prototype.QueryString = function (name) {
	var rtnval = '';
	var nowAddress = unescape(location.href);
	var parameters = (nowAddress.slice(nowAddress.indexOf('?')+1,nowAddress.length)).split('&');
	for(var i = 0 ; i < parameters.length ; i++)
	{
		var varName = parameters[i].split('=')[0];
		if(varName.toUpperCase() == name.toUpperCase())
		{
			rtnval = parameters[i].split('=')[1];
			break;
		}
	}
	return rtnval;
}

CommClass.prototype.IE = function() { return (document.all) ? true : false; }
CommClass.prototype.ie_ver = function () {
	//4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; InfoPath.2; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)
	var app = String(navigator.appVersion);
	var arrApp;
	if (this.IE()) {
		arrApp = app.substring(app.indexOf("(") + 1,  app.indexOf(")") ).split(";");
		return arrApp[1].replace(/(^\s*)|(\s*$)/g, "");
	} else {
		return 0; // IE �� �ƴ϶�� 0�� ����
	}
}
CommClass.prototype.HTTP_HOST = function() { return location.host; }
CommClass.prototype.$attachEvent = function (obj, EventHandler, Func) {// �̺�Ʈ �ڵ鷯 ���̾������� ���� ���� ���ؼ�...
	if (this.IE())
		obj.attachEvent(EventHandler, Func);
	else
		obj.addEventListener(EventHandler.replace(/\on/gi, ""), Func, false);
}
CommClass.prototype.getBounds = function (obj, mode) {
	var getValue = 0;
	if (obj.getBoundingClientRect) {
		var rect = obj.getBoundingClientRect(); 
		switch (mode) {
			case "left" : getValue = rect.left + $(document).scrollLeft(); break;
			case "top" : getValue = rect.top + $(document).scrollTop(); break;
			case "width" : getValue = rect.right - rect.left; break;
			case "height" : getValue = rect.bottom - rect.top; break;
		}
	} else {
		var box = document.getBoxObjectFor(obj); 
		switch (mode) {
			case "left" : getValue = box.x; break;
			case "top" : getValue = box.y; break;
			case "width" : getValue = box.width; break;
			case "height" : getValue = box.height; break;
		}
	}
	return parseInt(getValue, 10);
}
// �迭 ��������
Array.prototype.shuffle = function() {
	return this.concat().sort(
		function(){return Math.random() - Math.random();}
	);
}
// ��ü�� ũ�� �� ��ġ�� ��ȯ�Ѵ�.
function getBounds(obj, mode) {
	var getValue = 0;
	if (obj.getBoundingClientRect) {
		var rect = obj.getBoundingClientRect(); 
		switch (mode) {
			case "left" :	getValue = rect.left + (document.documentElement.scrollLeft || document.body.scrollLeft); break;
			case "top" :	getValue = rect.top + (document.documentElement.scrollTop || document.body.scrollTop); break;
			case "width" :	getValue = rect.right - rect.left; break;
			case "height" : getValue = rect.bottom - rect.top; break;
		}
	} else {
		var box = document.getBoxObjectFor(obj); 
		
		switch (mode) {
			case "left" :	getValue = box.x; break;
			case "top" :	getValue = box.y; break;
			case "width" :	getValue = box.width; break;
			case "height" : getValue = box.height; break;
		}
	}
	return parseInt(getValue, 10);
}
// FireFox���� innerText�� �ν��� �ȵɶ�...
function setInnerTextProperty() {
	if(typeof HTMLElement != "undefined" && typeof HTMLElement.prototype.__defineGetter__ != "undefined") {
		HTMLElement.prototype.__defineGetter__("innerText",function() {
			if(this.textContent) {
				return(this.textContent)
			} 
			else {
				var r = this.ownerDocument.createRange();
				r.selectNodeContents(this);
				return r.toString();
			}
		});
		
		HTMLElement.prototype.__defineSetter__("innerText",function(sText) {
			this.innerHTML = sText
		});
	}
}
	
// ���ϴ� ũ��� ��â�� ����.
// �Ķ��Ÿ ( �ּ�, ���α���, ���α���, â �̸� )
function OpenWindow ( url, mheight, mwidth, mname ) {
	var toppos = (screen.height-mheight)/2 - 100;
	var leftpos = (screen.width-mwidth)/2;
	open(url, mname, "menubar=no,toolbar=no,location=no,directories=no,status=no,scrollbars=no,resizable=no,width="+mwidth+",height="+mheight+",left="+leftpos+",top="+toppos);
}
// string Ŭ������ ���ÿ� ���Ǿ�� �ȴ�.
function __open(url, name, args) {
	var toppos  = (screen.height - parseInt(args.fields("height", ","), 10))/2 - 100;
	var leftpos = (screen.width - parseInt(args.fields("width", ","), 10))/2;
	open(url, name, args + ",left="+leftpos+",top="+toppos);
}
Response.prototype.redirect = function (str) { location.replace(str); }
// ���� �������� �����´�.
function HTTP_HOST() {
	return location.host;
}
// ���� ���������� ��ȯ�Ѵ�.
function JS_SELF(reqPath) {
	var strPath = (typeof reqPath=='undefined'?document.location:reqPath);
	var _self = String(strPath);
	if (_self.indexOf('?') == -1) {
		if (_self.indexOf('#') == -1)
			return _self.substring(_self.lastIndexOf('/')+1, _self.length);
		else
			return _self.substring(_self.lastIndexOf('/')+1, _self.lastIndexOf('#'));
	}
	else {
		return _self.substring(_self.lastIndexOf('/')+1, _self.lastIndexOf('?'));
	}
}

// Text Box Checking
function check_input(sname, str) {
	if (sname.type == "text" || sname.type== "textarea" || sname.type == "hidden" || sname.type == "select-one" || sname.type == "password" || sname.type=="file") {
		if (sname.value.match(/\S/)==null || sname.value == '' ) {
			alert(str);
			if (sname.type != "hidden") sname.focus();
			return false;
		}
		else
			return true;
	}
	else {
		var count = sname.length;
		for (i=0; i < sname.length; i++ ) {
			if (sname[i].checked == false) {
				count -= 1;
				if (count == 0) {
					alert(str);
					sname[0].focus();
					return false;
				}
			}
			else
				return true;
		}
	}
}

// checkbox or radio ���� ���õ� ���� �迭�� ����.
function checked_input(obj) {
	var count = obj.length;
	var arr = new Array();
	var j = 0;
	for (i=0; i < obj.length; i++ ) {
		if (obj[i].checked) {
			arr[j] = obj[i].value;
			j++;
		}
	}
	return arr;
}

function MouseOnBoard(obj, bool, bc, fc){ // ������ ���콺 ������ tr ���󺯰�
	var bgcolor = (typeof bc=='undefined')?'F7F7F7':bc;
	var fontcolor = (typeof fc=='undefined')?'4A494A':fc;
	var rtnColor = (obj.bgColor=='')?'#FFFFFF':obj.bgColor;		
	if (bool){
		obj.style.backgroundColor = bgcolor;
		obj.style.color = 'FFFFFF';
		obj.style.cursor = "default";
	}else{
		obj.style.backgroundColor = rtnColor;
		obj.style.color = "4A494A";
	}
}
function getCookie(name) {
	var Found = false;
	var start, end, name_length = name.length;
	var i = 0;
	// cookie ���ڿ� ��ü�� �˻�
	var cookies = document.cookie;
	var cookies_length = cookies.length;
	while(i <= cookies_length) {
		start = i;
		end = start + name_length;
		// name�� ������ ���ڰ� �ִٸ�
		if(cookies.substring(start, end) === name) {
			Found = true;
			break;
		}
		i++;
	}
	// name ���ڿ��� cookie���� ã�Ҵٸ�
	if(Found) {
		start = end + 1;
		end = cookies.indexOf(";", start);
		// ������ �κ��̶�� ���� �ǹ�(���������� ";"�� ����) 
		if(end < start)
			end = cookies_length; 
			// name�� �ش��ϴ� value���� �����Ͽ� �����Ѵ�. 
			return cookies.substring(start, end);
	} 
	//ã�� ���ߴٸ�
}

//������ ��¥��ŭ ��Ű�� �����ǰ�. expiredays�� 1 �̸� �Ϸ絿�� ����
function setCookie(name, value, expiredays) {
	var expire_date = new Date();
	expire_date.setDate(expire_date.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; expires=" + expire_date.toGMTString() + "; path=/";
} 
//��Ű �Ҹ� �Լ�
function clearCookie(name) {
	var expire_date = new Date();
	//���� ��¥�� ��Ű �Ҹ� ��¥�� �����Ѵ�.
	expire_date.setDate(expire_date.getDate() - 1)
	document.cookie = name + "= " + "; expires=" + expire_date.toGMTString() + "; path=/"
}

// ���̵� �� ��й�ȣ üũ
function check( oValue ) {
	var regExp1 = /[^-a-zA-Z0-9]/;
	// ���� �� ���ڸ� �����ϴ��� üũ�Ѵ�. ( �ѱ� �� Ư�����ڸ� �������� �ʴ´�. )
	if (!regExp1.test(oValue)) {
		// ���� �� ���ڸ� �����Ѵٸ� ������ ���ڰ� ���յǾ����� Ȯ���Ѵ�.
		var sCount = oValue.length;
		var nCount = oValue.length;

		// �Ѿ�� ���ڼ���ŭ �� ���� sCount, nCount �� �Ҵ��ϰ� ������ ����.
		// ������ ���鼭 �� �ڸ����� �������� �������� ��ȯ�ؼ� �ش纯���� ���� 1�� ���ش�.
		// ���� ���� �����̰ų� ���� �����̸� ���� �Ѱ��� ���������� 0 �� �Ҵ�ȴ�. �׷� ������ ���� �ʾҴٴ� ���� �˼��� �ִ�.
		for(i=0;i < oValue.length;i++) {
			if (isNaN(oValue.charAt(i))) { // �����϶�
				sCount -= 1;
			}
			else {	// �����϶�
				nCount -= 1;
			}
		}
		if (sCount == 0 || nCount == 0) {
			alert('�����ڿ� ���ڰ� ���յ��� �ʾҽ��ϴ�.');
			return false;
		}
		else {
			return true;
		}
	}
	else {
		alert('������ ���ڸ� �Է��ϼ���');
		return false;
	}
}
function moveFocus(num, fromform, toform) { // Ŀ�� �ڵ� �̵�
	var str = fromform.value.length;
	if(str == num) toform.focus();
}
// �˾�â �ڵ�����
function resizeToWindow( win ) {
	while(win.document.readyState != 'complete') {
	}

	var winBody = win.document.body;
	var marginHeight = parseInt(winBody.topMargin) + parseInt(winBody.bottomMargin);
	var marginWidth = parseInt(winBody.leftMargin) + parseInt(winBody.rightMargin);
	var wid = winBody.scrollWidth + (winBody.offsetWidth - winBody.clientWidth);
	var hei = winBody.scrollHeight + (winBody.offsetHeight - winBody.clientHeight);
	win.resizeTo(wid, hei);
}
function resizeIFrame(iframeId) { // ���������� ��������
	try { 
		var innerBody = iframeId.contentWindow.document.body; 
		var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight); 
	
		if(iframeId.style.height != innerHeight) { 
			iframeId.style.height = innerHeight + "px"; 
		} 
		if(document.all) { 
			innerBody.attachEvent('onclick',parent.do_resize); 
			innerBody.attachEvent('onkeyup',parent.do_resize); 
		} 
		else { 
			innerBody.addEventListener("click", parent.do_resize, false); 
			innerBody.addEventListener("keyup", parent.do_resize, false); 
		} 
	} 
	catch (e) { 
	} 
} 

// �˾�â �ڵ�����
function autoResizePopup() {
	var winW, winH, sizeToW, sizeToH;
	//var doc = document.documentElement;
	var doc = document.body;
	if ( parseInt(navigator.appVersion) > 3 ) {
		if ( navigator.appName=="Netscape" ) {
			winW = window.innerWidth;
			winH = window.innerHeight;
		}
  		if ( navigator.appName.indexOf("Microsoft") != -1 ) {
			winW = doc.scrollWidth;
			winH = doc.scrollHeight;
		}
	}
	sizeToW = 0;
	sizeToH = 0;
	if ( winW > 1024 ) { // 1024�� �����ϰ��� �ϴ� ����ũ��
		sizeToW = 1024 - doc.clientWidth;
	} else if ( Math.abs(doc.clientWidth - winW ) > 3 ) {
		sizeToW = winW - doc.clientWidth;
	}
	if ( winH > 768 ) {  //768�� �����ϰ��� �ϴ� ����ũ��
		sizeToH = 768 - doc.clientHeight;
	} else if ( Math.abs(doc.clientHeight - winH) > 4 ) {
		sizeToH = winH - doc.clientHeight;
	}
	if ( sizeToW != 0 || sizeToH != 0 ) {
		window.resizeBy(sizeToW, sizeToH);
	}
}

// �Է��� �ڵ� ������� �迭�� �����մϴ�.
// string Ŭ������ trim�� ����մϴ�.
function XML_CODE_SEARCH(ArrayValue, ArrayKey) {
	var objXML, objRootElement;
	objXML = new ActiveXObject("Microsoft.XMLDOM");
	objXML.async = false;
	objXML.load("/js/code.xml");
	objRootElement = objXML.documentElement;
	if(objRootElement.hasChildNodes){
		if (ArrayValue==""||ArrayValue==","){
			ArrayName = "-"
		}else{
			var r = ArrayValue.split(ArrayKey);
			var ArrayName = new Array();

			for (var i=0; i<r.length; i++)
			{
				ArrayName[i] = objRootElement.selectNodes("//code[@code_no='"+r[i].trim()+"']").item(0).childNodes.item(1).text;
			}
		}
		return ArrayName;
	}
}
//document.write(XML_CODE_SEARCH("83,86", ","));
function XML_CODE_RETURN(ArrayValue, ArrayKey, RtnKey) {
	
	RtnArrayText = ""
	var objXML, objRootElement;
	objXML = new ActiveXObject("Microsoft.XMLDOM");
	objXML.async = false;
	objXML.load("/js/code.xml");

	objRootElement = objXML.documentElement;
	if(objRootElement.hasChildNodes){
		if (ArrayValue==""||ArrayValue==","){
			RtnArrayText = "-"
		}else{
			var r = ArrayValue.split(ArrayKey);
			var ArrayName = new Array();
			var ArrayText = "";

			for (var i=0; i<r.length; i++) {
				ArrayName[i] = objRootElement.selectNodes("//code[@code_no='"+r[i].trim()+"']").item(0).childNodes.item(1).text;
				ArrayText = ArrayText + RtnKey +ArrayName[i]
			}
			RtnArrayText = ArrayText.substring(RtnKey.length,ArrayText.length);
		}
		return RtnArrayText;
	}
}

// ASP JOIN �Լ��� ���� ��Ȱ�� �Ѵ�.
function join(strArr, Key) {
	var rtnStr = '';
	for(var i=0; i<strArr.length; i++) {
		if (!rtnStr) {
			rtnStr = strArr[i];
		}
		else {
			rtnStr += Key + strArr[i];
		}
	}
	return rtnStr;
}
// PHP EXPLODE �Լ��� ���� ��Ȱ�� �Ѵ�.
function explode(Key, strArr) {
	var rtnStr = '';
	for(var i=0; i<strArr.length; i++) {
		if (!rtnStr) {
			rtnStr = strArr[i];
		}
		else {
			rtnStr += Key + strArr[i];
		}
	}
	return rtnStr;
}

// void : �̹��� ��������
function imageResize(objImg, intMaxW, intMaxH) {
	var intWid = objImg.offsetWidth;
	var intHei = objImg.offsetHeight;

	// ���ΰ� ũ�ٸ�...
	if (intWid >= intHei) {
		if (intWid > intMaxW) {			// ���λ������ �ִ밡�λ����� ������ ũ�ٸ�
			objImg.width = intMaxW;		// �ִ밡�λ���� ����.
		}
		if (intHei > intMaxH) {			// ���λ������ �ִ뼼�λ����� ������ ũ�ٸ�
			objImg.height = intMaxH;	// �ִ뼼�λ���� ����.
		}
	}
	else if (intWid < intHei) {
		if (intHei > intMaxH) {			// ���λ������ �ִ뼼�λ����� ������ ũ�ٸ�
			objImg.height = intMaxH;	// �ִ뼼�λ���� ����.
		}
	}
}

// ������ ������ �̹����� ���δ�.
function fixed_ratio(objImg, maxWid, maxHei) {
	
	// ���� �̹��� ����� �����´�.
	var img = new Image();
	var imgWid, imgHei;
	img.src = objImg.src;
	imgWid = img.width;
	imgHei = img.height;

	var new_wid = (imgWid>maxWid?maxWid:imgWid);
	var new_hei = (imgHei>maxHei?maxHei:imgHei);

	if (imgWid > imgHei) {
		// ������� �ٿ��� ���ΰ� ������ ũ�⸦ �Ѿ�ٸ�...
		new_hei = parseInt((imgHei * new_wid)/imgWid, 10);
		if (new_hei > maxHei) new_hei = maxHei
	}
	else {
		new_wid = parseInt((imgWid * new_hei)/imgHei, 10);
		if (new_wid > maxWid) new_wid = maxWid
	}
	if (!isNaN(new_wid) && !isNaN(new_hei)) {
		objImg.width  = new_wid;
		objImg.height = new_hei;
	}
	img = null;
}
/*
* ���α׷� ��� : ���� ���Ե� ��ü���� �������ڷ� �����.
* �Է°� : objForm ( Form ��ü���� �ѱ��. ex) document.theForm; ) 
*/
function GetQueryString(objForm){
	var queryString = "";
	var frm = (typeof objForm=="undefined"?document.forms[0]:objForm);
	var numberElements = frm.elements.length;
	var s_name = ""; // �ݺ��Ǵ� ��ü�� ���庯��
	
	for(var i = 0; i < numberElements; i++){
		if (frm.elements[i].name) {
			if(i == 0) {
				queryString = frm.elements[i].name + "=" + frm.elements[i].value;
			}
			else {
				arr_obj = document.getElementsByName(frm.elements[i].name);
				if (arr_obj.length > 1) {
					if (s_name != frm.elements[i].name) { // �̷��� �б��ϴ� ������ ������ üũ�ڽ� ���� ��쿡 �����̸��� ������ �ݺ��Ǳ� ����...
						for (var j=0; j<arr_obj.length; j++) {
							if (arr_obj[j].checked) queryString += "&" + frm.elements[i].name + "=" + arr_obj[j].value;
						}
						s_name = frm.elements[i].name
					}
				}
				else {
					queryString += "&" + frm.elements[i].name + "=" + frm.elements[i].value;
				}
			}
		}
	}
	return "?" + queryString;
}

function GetQueryStringClear(query) {
	var strArrayQuery, strArray, intLoop, strQuery = "";
	if (query.indexOf("?") != -1)
		query = query.substr(1)

	strArrayQuery = query.split("&")
	for (intLoop=0; intLoop<strArrayQuery.length; intLoop++) {
		strArray = strArrayQuery[intLoop].split("=");

		if (strArray[1] != "") {
			if (strQuery == "") {
				strQuery = strArrayQuery[intLoop];
			}
			else {
				strQuery += ("&" + strArrayQuery[intLoop]);
			}
		}
	}
	return "?" + strQuery;
}