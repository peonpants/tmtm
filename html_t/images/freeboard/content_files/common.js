
/** 로그인 - 조인 클릭시 레이어팝업 **/
jQuery(function($){
	function layer_open(el){
		//$('.layer').addClass('open');
		var temp = $('#' + el);
		if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
		else temp.css('top', '0px');
		if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
		else temp.css('left', '0px');
	}

	/* 회원가입 추천코드 시작*/
	$('#join_open').click(function(){
		$('.join_pop').fadeIn();
		layer_open('layer1'); /* 열고자 하는 것의 아이디를 입력 */
		return false;
	});
	$('.join_pop .bg').click(function(){
		$('.join_pop').fadeOut();
	});
	$('#layer_close').click(function(){
		$('.join_pop').fadeOut();
		return false;
	});
	$('#layer_close2').click(function(){

        $('.i_check').prop('checked', '');
		$('.betlist_selectall').remove();

		$('.join_pop').fadeOut();
		return false;
	});
	$('#layer_close3').click(function(){

		$('.join_pop').fadeOut();
		return false;
	});
	/* 회원가입 추천코드 끝*/

	/* 회원정보 시작*/
	$('#mbinfo_open').click(function(){
		$('.mbinfo_open_pop').fadeIn();
		layer_open('layer2'); /* 열고자 하는 것의 아이디를 입력 */
		return false;
	});
	$('.mbinfo_open_pop .bg').click(function(){
		$('.mbinfo_open_pop').fadeOut();
	});
	$('#layer_close').click(function(){
		$('.mbinfo_open_pop').fadeOut();
		return false;
	});

	// 팝업 쿠키
	$("#closeTime_1").bind("click", function() {
		if (this.checked) {
			var today = new Date();
			today.setTime(today.getTime() + (60 * 60 * 1000 * 24));
			document.cookie = 'closeTime_1' + '=' + escape( 'done' ) + '; path=/; expires=' + today.toGMTString() + ';';
			$('.popdiv_1').fadeOut();
			$('.popup_bgmask').fadeOut();
			return false;
		}
	});
	$('#layer_close4_1').click(function(){
		$('.popdiv_1').fadeOut();
		$('.popup_bgmask').fadeOut();
		return false;
	});

	// 팝업 쿠키
	$("#closeTime_2").bind("click", function() {
		if (this.checked) {
			var today = new Date();
			today.setTime(today.getTime() + (60 * 60 * 1000 * 24));
			document.cookie = 'closeTime_2' + '=' + escape( 'done' ) + '; path=/; expires=' + today.toGMTString() + ';';
			$('.popdiv_2').fadeOut();
			$('.popup_bgmask').fadeOut();
			return false;
		}
	});
	$('#layer_close4_2').click(function(){
		$('.popdiv_2').fadeOut();
		$('.popup_bgmask').fadeOut();
		return false;
	});

	// 팝업 쿠키
	$("#closeTime_3").bind("click", function() {
		if (this.checked) {
			var today = new Date();
			today.setTime(today.getTime() + (60 * 60 * 1000 * 24));
			document.cookie = 'closeTime_3' + '=' + escape( 'done' ) + '; path=/; expires=' + today.toGMTString() + ';';
			$('.popdiv_3').fadeOut();
			$('.popup_bgmask').fadeOut();
			return false;
		}
	});
	$('#layer_close4_3').click(function(){
		$('.popdiv_3').fadeOut();
		$('.popup_bgmask').fadeOut();
		return false;
	});

	// 팝업 쿠키
	$("#closeTime_4").bind("click", function() {
		if (this.checked) {
			var today = new Date();
			today.setTime(today.getTime() + (60 * 60 * 1000 * 24));
			document.cookie = 'closeTime_4' + '=' + escape( 'done' ) + '; path=/; expires=' + today.toGMTString() + ';';
			$('.popdiv_4').fadeOut();
			$('.popup_bgmask').fadeOut();
			return false;
		}
	});
	$('#layer_close4_4').click(function(){
		$('.popdiv_4').fadeOut();
		$('.popup_bgmask').fadeOut();
		return false;
	});

	/* 회원정보 끝*/

	/* 베팅 게시판 첨부 체크박스 시작*/
	$('.betcheckbox_select').click(function(){
		var id = $(this).val();
		if($(this).prop("checked")){
			$("#betlist_write").prepend("<div id='betlist_selectmove_"+ id +"' class='betlist_selectall'>"+ $("#betlist_select_"+id).html() +"</div>");
		}else{
			$("#betlist_selectmove_"+id).remove();
		}

	});
	/* 베팅 게시판 첨부 체크박스 끝*/


	$(document).ready(function(){
	});

	// 고객센터, 게시판 공지, 쪽지 등 테이블 슬라이딩
	$('.slide_view').click(function(){
		if ($(this).hasClass('active'))
		{
			$(this).parent().parent().next().hide();
			$(this).removeClass('active');
		} else {
			$(this).parent().parent().next().show();
			$(this).addClass('active');
		}
		return false;
	});

	$('#cart_lock').click(function(){
		if($("#cart_lock").hasClass("on")){
			$("#cart_lock").removeClass("on");
		}else{
			$("#cart_lock").addClass("on");
		}
		return false;
	});

});

jQuery(window).scroll(function(){
    var scrollTop = jQuery(document).scrollTop();
	scrollTop = scrollTop-200;
    //console.log("scrollTop : " + scrollTop);
    if (scrollTop < 0) {
        scrollTop = 0;
    }
    jQuery("#quickMenu").stop();

	if($("#cart_lock").hasClass("on")){
	    jQuery("#quickMenu").animate( { "top" : scrollTop });
	}
});

function setrawcookie(name, value, expires, path, domain, secure) {

    if (typeof expires === 'string' && (/^\d+$/)
    .test(expires)) {

        expires = parseInt(expires, 10);
    }

    if (expires instanceof Date) {

        expires = expires.toGMTString();
    }
    else if (typeof expires === 'number') {

        expires = (new Date(expires * 1e3))
        .toGMTString();
    }

    var r = [name + '=' + value],
    s = {},
    i = '';
    s = {
        expires: expires,
        path: path,
        domain: domain
    };

    for (i in s) {

        if (s.hasOwnProperty(i)) { // Exclude items on Object.prototype

            s[i] && r.push(i + '=' + s[i]);
        }
    }

    return secure && r.push('secure'), this.window.document.cookie = r.join(';'), true;
}

function setcookie(name, value, expires, path, domain, secure) {

    return setrawcookie(name, encodeURIComponent(value), expires, path, domain, secure);
}

function getcookie(cname) {

    var name = cname + "=";
    var ca = document.cookie.split(';');

    for(var i=0; i<ca.length; i++) {

        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
    }

    return "";
}

//20170210
function to_integer(num) {

    var i = 0, div = 0, minus = '';

    num = String(num);

    if (/^-?[0-9,.]+$/.test(num) == false){

        alert(num + ' 은 숫자가 아닙니다.');

        return [0, 1];
    }

    if (/[0-9]e\s*[\-+]\s*[0-9]*$/.test(num)){

        alert(num + ' 은 계산할수없는 수입니다.');

        return [0, 1];
    }

    if (num.substr(0, 1) == '-')
        minus = '-';

    num = num.replace('-', '').replace(',', '');

    i = num.indexOf(".");

    if (i >= 0) {

        num = num.replace('.', '');

        if (i > 0)
            div = num.length - i;
    }

    div = Math.pow(10, div);
    num = parseInt(minus + num, 10);

    return [num, div];
}

function new_multiply (num1, num2) {

    var _num1 = to_integer(num1) , _num2 = to_integer(num2) ;
    var _div = _num1[1] * _num2[1];

    return Number((Math.round((_num1[0] * _num2[0] * Math.pow(10, 6) / _div).toFixed(6)) / Math.pow(10, 6)).toFixed(6));
}

//기본적으로 round
function set_number_len (num, div) {

    if (div == 0)
        return Number(Math.floor(num));

    var _num = to_integer(num);

    return Number((Math.round(_num[0] * Math.pow(10, div) / _num[1]) / Math.pow(10, div)).toFixed(div));
}
//20170210

function number_format(number, decimals, dec_point, thousands_sep) {

    number = (number + '').replace(/[^0-9+\-Ee.]/g, '');

    var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function(n, prec) {

        var k = Math.pow(10, prec);
        return '' + (Math.round(n * k) / k)
        .toFixed(prec);
    };

    // Fix for IE parseFloat(0.55).toFixed(0) = 0;
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n))
    .split('.');
    if (s[0].length > 3) {

        s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
    }

    if ((s[1] || '')
    .length < prec) {

        s[1] = s[1] || '';
        s[1] += new Array(prec - s[1].length + 1)
        .join('0');
    }

    return s.join(dec);
}

function strip_tags(input, allowed) {

    allowed = (((allowed || '') + '')
    .toLowerCase()
    .match(/<[a-z][a-z0-9]*>/g) || [])
    .join(''); // making sure the allowed arg is a string containing only tags in lowercase (<a><b><c>)

    var tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/gi,
    commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/gi;

    return input.replace(commentsAndPhpTags, '')
    .replace(tags, function($0, $1) {

        return allowed.indexOf('<' + $1.toLowerCase() + '>') > -1 ? $0 : '';
    });
}

function htmlspecialchars(string, quote_style, charset, double_encode) {

    var optTemp = 0,
    i = 0,
    noquotes = false;

    if (typeof quote_style === 'undefined' || quote_style === null) {

        quote_style = 2;
    }

    string = string.toString();
    if (double_encode !== false) { // Put this first to avoid double-encoding

        string = string.replace(/&/g, '&amp;');
    }

    string = string.replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');

    var OPTS = {
    'ENT_NOQUOTES': 0,
    'ENT_HTML_QUOTE_SINGLE': 1,
    'ENT_HTML_QUOTE_DOUBLE': 2,
    'ENT_COMPAT': 2,
    'ENT_QUOTES': 3,
    'ENT_IGNORE': 4
    };

    if (quote_style === 0) {

        noquotes = true;
    }

    if (typeof quote_style !== 'number') { // Allow for a single string or an array of string flags

        quote_style = [].concat(quote_style);
        for (i = 0; i < quote_style.length; i++) {

            // Resolve string input to bitwise e.g. 'ENT_IGNORE' becomes 4
            if (OPTS[quote_style[i]] === 0) {

                noquotes = true;
            }
            else if (OPTS[quote_style[i]]) {

                optTemp = optTemp | OPTS[quote_style[i]];
            }
        }
        quote_style = optTemp;
    }
    if (quote_style & OPTS.ENT_HTML_QUOTE_SINGLE) {

        string = string.replace(/'/g, '&#039;');
    }

    if (!noquotes) {

        string = string.replace(/"/g, '&quot;');
    }

    return string;
}