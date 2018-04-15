// ��ü id ���� ���� �˻�
// obj=��üid
function fnObjidCheck(obj) {
	if($(obj).length == 0) {
		alert(obj + " Object is Nothing");
		return false;
	}
	else
		return true;
}

// ��� ���� ����
// strVal=value
function strTrimAll(strVal) {
	var rtnVal = strVal.replace(/[^\d]/g,'');
	return rtnVal;
}

// id ��ü�� �� üũ
// obj=��üid, msg=�޼���, isFocus?1=��Ŀ���̵�
function fnIdValCheck(obj, msg, isFocus) {
	var strVal ; 

	if($(obj).length > 0) {

		// �յ� ���� ����
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

// ���ϴ� ���ڸ� üũ
// obj=��üid, msg=�޼���, strAllow=��빮�ڿ�
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

// Ư�����ڵ� �Էµ��� �ʰ� üũ..
// obj=��üid, msg=�޼���, strAllow=üũ���ڿ�
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

// ��й�ȣ Ȯ��ó�� ���� �ؽ�Ʈ ���� �˻�
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


// �ؽ�Ʈ ���� �ּұ��� ü��
function fnObjMinLength(obj, minLength, msg) {
	var len = $(obj).val().length;
	if(len < minLength) {
		alert(msg);
		return false;
	}
	else
		return true;
}

// �ּ� �Է°� üũ
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

// 3�ڸ� �޸��߰�
function fn_add_comma(n) {
	var reg = /(^[+-]?\d+)(\d{3})/;
	n += '';
	while(reg.test(n)) {
		n = n.replace(reg, '$1' + ',' + '$2'); 
	}

	return n;
}

// �޸� ������ ��ȯ
function fn_remove_comma(n) {
	n = n.replace(/,/gi,'');

	return n;
}


//
function fn_addBatting() {

}


// īƮ�� ��� ���Ӽ� ����
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
 
