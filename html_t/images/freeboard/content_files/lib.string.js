/*--------------------------------------------------------------------------------*\
*  JavaScript framework, version 2.0
*  Date : 2006. 08. 15.
*  Copyright 1998-2007 by Vricks Studio All right reserved.
*  @author Jeff Yang routine@vricks.com
*  ���� ���̴� ��Ʈ�� ���� prototype���� ����
\*--------------------------------------------------------------------------------*/
//-----------------------------------------------------------------------------
// ������ ��, �� ���� ����
// @return : String
//-----------------------------------------------------------------------------
;String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "");
}
//-----------------------------------------------------------------------------
// ������ �� ���� ����
// @return : String
;String.prototype.ltrim = function() {
	return this.replace(/(^\s*)/, "");
}
//-----------------------------------------------------------------------------
// ������ �� ���� ����
// @return : String
;String.prototype.rtrim = function() {
	return this.replace(/(\s*$)/, "");    
}
;String.prototype.Left = function(n) {
	if (n <= 0)	{
		return "";
	} else if (n > this.length) {
		return this;
	} else {
		return this.substring(0, n);
	}
}
;String.prototype.Right = function(n) {
	return this.substring((this.length-n),this.length);
}
// ajax�� ����ϸ鼭 ����� �� ���� ���� �����ϱⰡ �ʹ� ���� ����.
;String.prototype.fields = function(str, g) {
	g = (g==null ? "&" : g); // �����۰� ����
	var arr = this.split(g);
	if (str != null) {
		for (var i=0; i<arr.length; i++) {
			if (arr[i].split("=")[0].trim() == str) {
				return arr[i].substring(arr[i].indexOf("=")+1);
				break;
			}
		}
	} else {
		for (var i=0; i<arr.length; i++) {
			arr[i] = new Array(arr[i].split("=")[0], arr[i].split("=")[1]);
		}
		return arr;
	}
}
//-----------------------------------------------------------------------------
// ���ڿ��� byte ���� ��ȯ
// @return : int
;String.prototype.byte = function() {
	var cnt = 0;
	for (var i = 0; i < this.length; i++) {
		if (this.charCodeAt(i) > 127)
			cnt += 2;
		else
			cnt++;
	}
	return cnt;
}
/** 
* string String::cut(int len)
* ���ڸ� �տ������� ���ϴ� ����Ʈ��ŭ �߶� �����մϴ�.
* �ѱ��� ��� 2����Ʈ�� ����ϸ�, ���� �߰����� �߸��� �ʽ��ϴ�.
*/
;String.prototype.strCut = function(len) {
	var str = this;
	var l = 0;
	for (var i=0; i<str.length; i++) {
			l += (str.charCodeAt(i) > 128) ? 2 : 1;
			if (l > len) return str.substring(0,i) ;
	}
	return str;
}
//-----------------------------------------------------------------------------
// ���������� ��ȯ
// @return : String
;String.prototype.int = function() {
	if(!isNaN(this)) {
		return parseInt(this);
	}
	else {
		return null;    
	}
}
//-----------------------------------------------------------------------------
// ���ڸ� ���� ����
// @return : String
;String.prototype.num = function() {
	return (this.trim().replace(/[^0-9]/g, ""));
}
//-----------------------------------------------------------------------------
// ���ڿ� 3�ڸ����� , �� �� ��ȯ
// @return : String
;String.prototype.money = function() {
	var num = this.trim();
	while((/(-?[0-9]+)([0-9]{3})/).test(num)) {
		num = num.replace((/(-?[0-9]+)([0-9]{3})/), "$1,$2");
	}
	return num;
}
//-----------------------------------------------------------------------------
// ������ �ڸ���(cnt)�� �µ��� ��ȯ
// @return : String
;String.prototype.digits = function(cnt) {
	var digit = "";

	if (this.length < cnt) {
		for(var i = 0; i < cnt - this.length; i++) {
			digit += "0";
		}
	}
	return digit + this;
}
//-----------------------------------------------------------------------------
// " -> &#34; ' -> &#39;�� �ٲپ ��ȯ
// @return : String
;String.prototype.quota = function() {
	return this.replace(/"/g, "&#34;").replace(/'/g, "&#39;");
}
//-----------------------------------------------------------------------------
// ���� Ȯ���ڸ� ��������
// @return : String
;String.prototype.ext = function() {
	return (this.indexOf(".") < 0) ? "" : this.substring(this.lastIndexOf(".") + 1, this.length);    
}
//-----------------------------------------------------------------------------
// URL���� �Ķ���� ������ ������ url ���
// @return : String
;String.prototype.uri = function() {
	var arr = this.split("?");
	arr = arr[0].split("#");
	return arr[0];    
}

//-----------------------------------------------------------------------------
// ���ԽĿ� ���̴� Ư�����ڸ� ã�Ƽ� �̽������� �Ѵ�.
// @return : String
;String.prototype.meta = function() {
	var str = this;
	var result = ""
	for(var i = 0; i < str.length; i++) {
		if((/([\$\(\)\*\+\.\[\]\?\\\^\{\}\|]{1})/).test(str.charAt(i))) {
			result += str.charAt(i).replace((/([\$\(\)\*\+\.\[\]\?\\\^\{\}\|]{1})/), "\\$1");
		}
		else {
			result += str.charAt(i);
		}
	}
	return result;
}
//-----------------------------------------------------------------------------
// ���ԽĿ� ���̴� Ư�����ڸ� ã�Ƽ� �̽������� �Ѵ�.
// @return : String
;String.prototype.remove = function(pattern) {
	return (pattern == null) ? this : eval("this.replace(/[" + pattern.meta() + "]/g, \"\")");
}
//-----------------------------------------------------------------------------
// �ּ� �ִ� �������� ����
// str.isLength(min [,max])
// @return : boolean
;String.prototype.isLength = function() {
	var min = arguments[0];
	var max = arguments[1] ? arguments[1] : null;
	var success = true;
	if(this.length < min) {
		success = false;
	}
	if(max && this.length > max) success = false;
	return success;
}
//-----------------------------------------------------------------------------
// �ּ� �ִ� ����Ʈ���� ����
// str.isByteLength(min [,max])
// @return : boolean
;String.prototype.isByteLength = function() {
	var min = arguments[0];
	var max = arguments[1] ? arguments[1] : null;
	var success = true;
	if(this.byte() < min) {
		success = false;
	}

	if(max && this.byte() > max) success = false;
	return success;
}
//-----------------------------------------------------------------------------
// �����̳� ������ Ȯ��
// @return : boolean
;String.prototype.isBlank = function() {
	var str = this.trim();
	for(var i = 0; i < str.length; i++) {
		if ((str.charAt(i) != "\t") && (str.charAt(i) != "\n") && (str.charAt(i)!="\r")) {
			return false;
		}
	}
	return true;
}
//-----------------------------------------------------------------------------
// ���ڷ� �����Ǿ� �ִ��� ����
// arguments[0] : ����� ���ڼ�
// @return : boolean
;String.prototype.isNum = function() {
	return (/^[0-9]+$/).test(this.remove(arguments[0])) ? true : false;
}
//-----------------------------------------------------------------------------
// ��� ��� - arguments[0] : �߰� ����� ���ڵ�
// @return : boolean
;String.prototype.isEng = function() {
	return (/^[a-zA-Z]+$/).test(this.remove(arguments[0])) ? true : false;
}
//-----------------------------------------------------------------------------
// ���ڿ� ��� ��� - arguments[0] : �߰� ����� ���ڵ�
// @return : boolean
;String.prototype.isEngNum = function() {
	return (/^[0-9a-zA-Z]+$/).test(this.remove(arguments[0])) ? true : false;
}
//-----------------------------------------------------------------------------
// ���ڿ� ��� ��� - arguments[0] : �߰� ����� ���ڵ�
// @return : boolean
;String.prototype.isNumEng = function() {
	return this.isEngNum(arguments[0]);
}
//-----------------------------------------------------------------------------
// ���̵� üũ ����� ���ڸ� üũ ù���ڴ� ����� ���� - arguments[0] : �߰� ����� ���ڵ�
// @return : boolean
;String.prototype.isUserid = function() {
	return (/^[a-zA-z]{1}[0-9a-zA-Z]+$/).test(this.remove(arguments[0])) ? true : false;
}
//-----------------------------------------------------------------------------
// �ѱ� üũ - arguments[0] : �߰� ����� ���ڵ�
// @return : boolean
;String.prototype.isKor = function() {
	return (/^[��-�R]+$/).test(this.remove(arguments[0])) ? true : false;
}
//-----------------------------------------------------------------------------
// �ֹι�ȣ üũ - arguments[0] : �ֹι�ȣ ������
// XXXXXX-XXXXXXX
// @return : boolean
;String.prototype.isJumin = function() {
	var arg = arguments[0] ? arguments[0] : "";
	var jumin = eval("this.match(/[0-9]{2}[01]{1}[0-9]{1}[0123]{1}[0-9]{1}" + arg + "[1234]{1}[0-9]{6}$/)");
	if(jumin == null) {
		return false;
	}
	else {
		jumin = jumin.toString().num().toString();
	}

	// ������� üũ
	var birthYY = (parseInt(jumin.charAt(6)) == (1 ||2)) ? "19" : "20";
	birthYY += jumin.substr(0, 2);
	var birthMM = jumin.substr(2, 2) - 1;
	var birthDD = jumin.substr(4, 2);
	var birthDay = new Date(birthYY, birthMM, birthDD);
	if(birthDay.getYear() % 100 != jumin.substr(0,2) || birthDay.getMonth() != birthMM || birthDay.getDate() != birthDD) {
		return false;
	}        
	var sum = 0;
	var num = [2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5]
	var last = parseInt(jumin.charAt(12));
	for(var i = 0; i < 12; i++) {
		sum += parseInt(jumin.charAt(i)) * num[i];
	}
	return ((11 - sum % 11) % 10 == last) ? true : false;
}
//-----------------------------------------------------------------------------
// �ܱ��� ��Ϲ�ȣ üũ - arguments[0] : ��Ϲ�ȣ ������
// XXXXXX-XXXXXXX
// @return : boolean
;String.prototype.isForeign = function() {
	var arg = arguments[0] ? arguments[0] : "";
	var jumin = eval("this.match(/[0-9]{2}[01]{1}[0-9]{1}[0123]{1}[0-9]{1}" + arg + "[5678]{1}[0-9]{1}[02468]{1}[0-9]{2}[6789]{1}[0-9]{1}$/)");
	if(jumin == null) {
		return false;
	}
	else {
		jumin = jumin.toString().num().toString();
	}

	// ������� üũ
	var birthYY = (parseInt(jumin.charAt(6)) == (5 || 6)) ? "19" : "20";
	birthYY += jumin.substr(0, 2);
	var birthMM = jumin.substr(2, 2) - 1;
	var birthDD = jumin.substr(4, 2);
	var birthDay = new Date(birthYY, birthMM, birthDD);
	if(birthDay.getYear() % 100 != jumin.substr(0,2) || birthDay.getMonth() != birthMM || birthDay.getDate() != birthDD) {
		return false;
	}
	if((parseInt(jumin.charAt(7)) * 10 + parseInt(jumin.charAt(8))) % 2 != 0) {
		return false;
	}

	var sum = 0;
	var num = [2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5]
	var last = parseInt(jumin.charAt(12));
	for(var i = 0; i < 12; i++) {
		sum += parseInt(jumin.charAt(i)) * num[i];
	}
	return (((11 - sum % 11) % 10) + 2 == last) ? true : false;
}    
//-----------------------------------------------------------------------------
// ����ڹ�ȣ üũ - arguments[0] : ��Ϲ�ȣ ������
// XX-XXX-XXXXX
// @return : boolean
;String.prototype.isBiznum = function() {

	var arg = arguments[0] ? arguments[0] : "";
	var biznum = eval("this.match(/[0-9]{3}" + arg + "[0-9]{2}" + arg + "[0-9]{5}$/)");
	if(biznum == null || biznum == '000-00-00000') {
		return false;
	}
	else {
		biznum = biznum.toString().num().toString();
	}

	var sum = parseInt(biznum.charAt(0));
	var num = [0, 3, 7, 1, 3, 7, 1, 3];
	for(var i = 1; i < 8; i++) sum += (parseInt(biznum.charAt(i)) * num[i]) % 10;
	sum += Math.floor(parseInt(parseInt(biznum.charAt(8))) * 5 / 10);
	sum += (parseInt(biznum.charAt(8)) * 5) % 10 + parseInt(biznum.charAt(9));
	return (sum % 10 == 0) ? true : false;
}
//-----------------------------------------------------------------------------
// ���� ��Ϲ�ȣ üũ - arguments[0] : ��Ϲ�ȣ ������
// XXXXXX-XXXXXXX
// @return : boolean
;String.prototype.isCorpnum = function() {
	var arg = arguments[0] ? arguments[0] : "";
	var corpnum = eval("this.match(/[0-9]{6}" + arg + "[0-9]{7}$/)");
	if(corpnum == null) {
		return false;
	}
	else {
		corpnum = corpnum.toString().num().toString();
	}
	var sum = 0;
	var num = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2]
	var last = parseInt(corpnum.charAt(12));
	for(var i = 0; i < 12; i++) {
		sum += parseInt(corpnum.charAt(i)) * num[i];
	}
	return ((10 - sum % 10) % 10 == last) ? true : false;
}
//-----------------------------------------------------------------------------
// �̸����� ��ȿ���� üũ
// @return : boolean
;String.prototype.isEmail = function() {
	return (/\w+([-+.]\w+)*@\w+([-.]\w+)*\.[a-zA-Z]{2,4}$/).test(this.trim());
}
//-----------------------------------------------------------------------------
// ��ȭ��ȣ üũ - arguments[0] : ��ȭ��ȣ ������
// @return : boolean
;String.prototype.isPhone = function() {
	var arg = arguments[0] ? arguments[0] : "";
	return eval("(/(02|0[3-9]{1}[0-9]{1})" + arg + "[1-9]{1}[0-9]{2,3}" + arg + "[0-9]{4}$/).test(this)");
}
//-----------------------------------------------------------------------------
// �ڵ�����ȣ üũ - arguments[0] : �ڵ��� ������
// @return : boolean
;String.prototype.isMobile = function() {
	var arg = arguments[0] ? arguments[0] : "";
	return eval("(/01[016789]" + arg + "[1-9]{1}[0-9]{2,3}" + arg + "[0-9]{4}$/).test(this)");
}