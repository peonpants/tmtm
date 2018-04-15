// 개체 id 존재 여부 검사
// obj=개체id
function fnObjidCheck(obj) {
	if($(obj).length == 0) {
		alert(obj + " Object is Nothing");
		return false;
	}
	else
		return true;
}

// 모든 공백 제거
// strVal=value
function strTrimAll(strVal) {
	var rtnVal = strVal.replace(/[^\d]/g,'');
	return rtnVal;
}

// id 개체의 빈값 체크
// obj=개체id, msg=메세지, isFocus?1=포커스이동
function fnIdValCheck(obj, msg, isFocus) {
	var strVal ; 

	if($(obj).length > 0) {

		// 앞뒤 공백 제거
		strVal = $.trim($(obj).val());

		if(strVal == "") {
			alert(msg);

			if(isFocus == 1)	
				$(obj).focus();

			return false;
		}
		else {
			//alert(strVal);
			return true;
		}
	}
	else {
		alert(obj + " Object is Nothing.");
		return false;
	}
}

// 원하는 문자만 체크
// obj=개체id, msg=메세지, strAllow=허용문자열
function fnAlphaNumericCheck(obj, msg, strAllow) {
	
	if(!fnObjidCheck(obj))	return false;

	var strVal = $(obj).val();
	var rtnVal;

	for(var i=0; i<strVal.length; i++) {

		rtnVal = false;

		for(var j=0; j<strAllow.length; j++) {

			//alert(strVal.charAt(i) + " , " + strAllow.charAt(j));
			if(strVal.charAt(i) == strAllow.charAt(j)) {
				rtnVal = true;
				break;
			}
		}

		if(!rtnVal)	break;
	}

	if (strVal!='')
		if(!rtnVal)	alert(msg);

	return rtnVal;
}

// 특수문자등 입력되지 않게 체크..
// obj=개체id, msg=메세지, strAllow=체크문자열
function fnCharDenyCheck(obj, msg, strAllow) {
	
	if(!fnObjidCheck(obj))	return false;

	var strVal = $(obj).val();
	var rtnVal = false;
	var strDeny = strAllow + "'";

	for(var i=0; i<strVal.length; i++) {


		for(var j=0; j<strDeny.length; j++) {

			//alert(strVal.charAt(i) + " , " + strDeny.charAt(j));
			if(strVal.charAt(i) == strDeny.charAt(j)) {
				rtnVal = true;
				break;
			}
		}

		if(rtnVal)	break;
	}

	if(rtnVal) alert(msg);

	return rtnVal;
}

// 비밀번호 확인처럼 같은 텍스트 인지 검사
function fnTextSameCheck(obj1, obj2, msg) {

	var str1 = $(obj1).val();
	var str2 = $(obj2).val();
	if(str1!=str2) {
		alert(msg);
		return false;
	}
	else
		return true;
}


// 텍스트 문자 최소길이 체ㅡ
function fnObjMinLength(obj, minLength, msg) {
	var len = $(obj).val().length;
	if(len < minLength) {
		alert(msg);
		return false;
	}
	else
		return true;
}

// 최소 입력값 체크
function fn_minValue(n, minVal, msg) {

	if(n < minVal) {
		alert(msg);
		return false;
	}
	else
		return true;
}

function fnSet_comma(n) {

}

// 3자리 콤마추가
function fn_add_comma(n) {
	var reg = /(^[+-]?\d+)(\d{3})/;
	n += '';
	while(reg.test(n)) {
		n = n.replace(reg, '$1' + ',' + '$2'); 
	}

	return n;
}

// 콤마 제거후 반환
function fn_remove_comma(n) {
	n = n.replace(/,/gi,'');

	return n;
}


//
function fn_addBatting() {

}


// 카트에 담긴 게임수 리턴
function getCartCount() {
	var cartCount;
	if($('#cartCount').length > 0 )
		cartCount = $('#cartCount').val();
	else
		cartCount = 0;
	return cartCount;
}


function addComma(n) {
	var reg = /(^[+-]?\d+)(\d{3})/;
	n += '';
	while (reg.test(n)) {
		n = n.replace(reg, '$1' + ',' + '$2');
	}
	return n;
}
 
