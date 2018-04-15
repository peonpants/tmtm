function getCookie(c_name){

	var i,x,y,ARRcookies=document.cookie.split(";");
	for (i=0;i<ARRcookies.length;i++)
	{

	  x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
	  y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
	  x=x.replace(/^\s+|\s+$/g,"");
	  if (x==c_name)
		{
		return unescape(y);
		}
	  }
}



function setCookie(c_name,value,exdays)
{

	var exdate=new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
	document.cookie=c_name + "=" + c_value;

}



function removeHtml(text)
{
 text = text.replace(/<br>/ig, "\n"); // <br>을 엔터로 변경
 text = text.replace(/&nbsp;/ig, " "); // 공백      
 // HTML 태그제거
 text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
 
 // shkim.add.
 text = text.replace(/<(no)?script[^>]*>.*?<\/(no)?script>/ig, "");
 text = text.replace(/<style[^>]*>.*<\/style>/ig, "");
 text = text.replace(/<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>/ig, "");
 text = text.replace(/<\\w+\\s+[^<]*\\s*>/ig, "");
 text = text.replace(/&[^;]+;/ig, "");
 text = text.replace(/\\s\\s+/ig, "");
 
 return text;
} 



// 삭제시 물어보는 스크립트
function del_really(){
    if (confirm('\n정말로 삭제하시겠습니까?\n')) return true;
    return false;
}



// 삭제시 물어보는 스크립트
function cancel_really(){
    if (confirm('\n정말로 취소하시겠습니까?\n')) return true;
    return false;
}


function is_onlynumeric( v, o ) {
  var chk = v.replace(/[^,0-9]/g,'');
  if( v != chk ) { window.alert('숫자만 입력해주세요.'); o.value = chk; return false; }
}



$(function(){
	
	$(".imgpngover").mouseover(function(e) {
         $(this).attr("src", $(this).attr("src").replace("_off.png","_on.png"));
	}).mouseout(function(e) {
         $(this).attr("src", $(this).attr("src").replace("_on.png","_off.png"));
	});

	$(".imgpngover2").mouseover(function(e) {
         $(this).attr("src", $(this).attr("src").replace("_off.gif","_on.gif"));
	}).mouseout(function(e) {
         $(this).attr("src", $(this).attr("src").replace("_on.gif","_off.gif"));
	});


    $("#named_wrap").mouseenter(function(){
      $("#named_submenu_wrap").show();
    }).mouseleave(function(){
      $("#named_submenu_wrap").hide();
    });

    $("#named_wrap2").mouseenter(function(){
      $("#named_submenu_wrap2").show();
    }).mouseleave(function(){
      $("#named_submenu_wrap2").hide();
    });


});


popNoticeShow=function(url, w, h){
     $("#pop_notice_iframe").css({'width':w + 'px','height':h + 'px' });
	 $("#pop_notice_iframe").attr("src", url);

     $("#pop_notice_wrap").show();
     $("#pop_notice_body").show();
};


popNoticeHide=function(){
     $("#pop_notice_wrap").hide();
     $("#pop_notice_body").hide();
	 $("#pop_notice_iframe").attr("src", "");
};


popNoticeShow2=function(){
     $("#pop_notice_wrap").show();
     $("#pop_memo_body").show();
};