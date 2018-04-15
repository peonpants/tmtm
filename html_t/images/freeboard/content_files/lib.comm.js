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
		return 0; // IE 가 아니라면 0을 리턴
	}
}
CommClass.prototype.HTTP_HOST = function() { return location.host; }
CommClass.prototype.$attachEvent = function (obj, EventHandler, Func) {// 이벤트 핸들러 파이어폭스와 같이 쓰기 위해서...
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
// 배열 랜덤정렬
Array.prototype.shuffle = function() {
	return this.concat().sort(
		function(){return Math.random() - Math.random();}
	);
}
// 객체의 크기 및 위치를 반환한다.
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
// FireFox에서 innerText가 인식이 안될때...
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
	
// 원하는 크기로 새창을 띄운다.
// 파라메타 ( 주소, 세로길이, 가로길이, 창 이름 )
function OpenWindow ( url, mheight, mwidth, mname ) {
	var toppos = (screen.height-mheight)/2 - 100;
	var leftpos = (screen.width-mwidth)/2;
	open(url, mname, "menubar=no,toolbar=no,location=no,directories=no,status=no,scrollbars=no,resizable=no,width="+mwidth+",height="+mheight+",left="+leftpos+",top="+toppos);
}
// string 클래스와 동시에 사용되어야 된다.
function __open(url, name, args) {
	var toppos  = (screen.height - parseInt(args.fields("height", ","), 10))/2 - 100;
	var leftpos = (screen.width - parseInt(args.fields("width", ","), 10))/2;
	open(url, name, args + ",left="+leftpos+",top="+toppos);
}
Response.prototype.redirect = function (str) { location.replace(str); }
// 현재 도메인을 가져온다.
function HTTP_HOST() {
	return location.host;
}
// 현재 페이지명을 반환한다.
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

// checkbox or radio 에서 선택된 값을 배열로 리턴.
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

function MouseOnBoard(obj, bool, bc, fc){ // 본문에 마우스 오버시 tr 색상변경
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
	// cookie 문자열 전체를 검색
	var cookies = document.cookie;
	var cookies_length = cookies.length;
	while(i <= cookies_length) {
		start = i;
		end = start + name_length;
		// name과 동일한 문자가 있다면
		if(cookies.substring(start, end) === name) {
			Found = true;
			break;
		}
		i++;
	}
	// name 문자열을 cookie에서 찾았다면
	if(Found) {
		start = end + 1;
		end = cookies.indexOf(";", start);
		// 마지막 부분이라는 것을 의미(마지막에는 ";"가 없다) 
		if(end < start)
			end = cookies_length; 
			// name에 해당하는 value값을 추출하여 리턴한다. 
			return cookies.substring(start, end);
	} 
	//찾지 못했다면
}

//설정한 날짜만큼 쿠키가 유지되게. expiredays가 1 이면 하루동안 유지
function setCookie(name, value, expiredays) {
	var expire_date = new Date();
	expire_date.setDate(expire_date.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; expires=" + expire_date.toGMTString() + "; path=/";
} 
//쿠키 소멸 함수
function clearCookie(name) {
	var expire_date = new Date();
	//어제 날짜를 쿠키 소멸 날짜로 설정한다.
	expire_date.setDate(expire_date.getDate() - 1)
	document.cookie = name + "= " + "; expires=" + expire_date.toGMTString() + "; path=/"
}

// 아이디 및 비밀번호 체크
function check( oValue ) {
	var regExp1 = /[^-a-zA-Z0-9]/;
	// 영문 및 숫자만 존재하는지 체크한다. ( 한글 및 특수문자면 실행하지 않는다. )
	if (!regExp1.test(oValue)) {
		// 영문 및 숫자만 존재한다면 영문과 숫자가 조합되었는지 확인한다.
		var sCount = oValue.length;
		var nCount = oValue.length;

		// 넘어온 문자수만큼 각 변수 sCount, nCount 에 할당하고 루프를 돈다.
		// 루프를 돌면서 각 자릿수가 문자인지 숫자인지 반환해서 해당변수의 수를 1씩 빼준다.
		// 만약 전부 문자이거나 전부 숫자이면 둘중 한개의 변수값에는 0 이 할당된다. 그럼 조합이 되지 않았다는 것을 알수가 있다.
		for(i=0;i < oValue.length;i++) {
			if (isNaN(oValue.charAt(i))) { // 문자일때
				sCount -= 1;
			}
			else {	// 숫자일때
				nCount -= 1;
			}
		}
		if (sCount == 0 || nCount == 0) {
			alert('영문자와 숫자가 조합되지 않았습니다.');
			return false;
		}
		else {
			return true;
		}
	}
	else {
		alert('영문과 숫자만 입력하세요');
		return false;
	}
}
function moveFocus(num, fromform, toform) { // 커서 자동 이동
	var str = fromform.value.length;
	if(str == num) toform.focus();
}
// 팝업창 자동조정
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
function resizeIFrame(iframeId) { // 아이프레임 리사이즈
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

// 팝업창 자동조정
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
	if ( winW > 1024 ) { // 1024는 제한하고자 하는 가로크기
		sizeToW = 1024 - doc.clientWidth;
	} else if ( Math.abs(doc.clientWidth - winW ) > 3 ) {
		sizeToW = winW - doc.clientWidth;
	}
	if ( winH > 768 ) {  //768은 제한하고자 하는 세로크기
		sizeToH = 768 - doc.clientHeight;
	} else if ( Math.abs(doc.clientHeight - winH) > 4 ) {
		sizeToH = winH - doc.clientHeight;
	}
	if ( sizeToW != 0 || sizeToH != 0 ) {
		window.resizeBy(sizeToW, sizeToH);
	}
}

// 입력한 코드 순서대로 배열로 리턴합니다.
// string 클래스의 trim을 사용합니다.
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

// ASP JOIN 함수와 같은 역활을 한다.
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
// PHP EXPLODE 함수와 같은 역활을 한다.
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

// void : 이미지 리사이즈
function imageResize(objImg, intMaxW, intMaxH) {
	var intWid = objImg.offsetWidth;
	var intHei = objImg.offsetHeight;

	// 가로가 크다면...
	if (intWid >= intHei) {
		if (intWid > intMaxW) {			// 가로사이즈값이 최대가로사이즈 값보다 크다면
			objImg.width = intMaxW;		// 최대가로사이즈를 삽입.
		}
		if (intHei > intMaxH) {			// 세로사이즈값이 최대세로사이즈 값보다 크다면
			objImg.height = intMaxH;	// 최대세로사이즈를 삽입.
		}
	}
	else if (intWid < intHei) {
		if (intHei > intMaxH) {			// 세로사이즈값이 최대세로사이즈 값보다 크다면
			objImg.height = intMaxH;	// 최대세로사이즈를 삽입.
		}
	}
}

// 고정된 비율로 이미지를 줄인다.
function fixed_ratio(objImg, maxWid, maxHei) {
	
	// 원본 이미지 사이즈를 가져온다.
	var img = new Image();
	var imgWid, imgHei;
	img.src = objImg.src;
	imgWid = img.width;
	imgHei = img.height;

	var new_wid = (imgWid>maxWid?maxWid:imgWid);
	var new_hei = (imgHei>maxHei?maxHei:imgHei);

	if (imgWid > imgHei) {
		// 비율대로 줄여도 세로가 지정한 크기를 넘어간다면...
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
* 프로그램 기능 : 폼에 포함된 객체들을 쿼리문자로 만든다.
* 입력값 : objForm ( Form 객체명을 넘긴다. ex) document.theForm; ) 
*/
function GetQueryString(objForm){
	var queryString = "";
	var frm = (typeof objForm=="undefined"?document.forms[0]:objForm);
	var numberElements = frm.elements.length;
	var s_name = ""; // 반복되는 객체명 저장변수
	
	for(var i = 0; i < numberElements; i++){
		if (frm.elements[i].name) {
			if(i == 0) {
				queryString = frm.elements[i].name + "=" + frm.elements[i].value;
			}
			else {
				arr_obj = document.getElementsByName(frm.elements[i].name);
				if (arr_obj.length > 1) {
					if (s_name != frm.elements[i].name) { // 이렇게 분기하는 이유는 라디오나 체크박스 같은 경우에 같이이름이 여러번 반복되기 때문...
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