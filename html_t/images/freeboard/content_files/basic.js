
//window.document.onselectstart = new Function("return false");
//window.document.oncontextmenu = new Function("return false");
//window.document.ondragstart = new Function("return false");
$(document).ready(function(){
	var topnotice = noticerolling("top-notice");
	var toptimer = realTime();
	$("span.logobtn").click(function(){
		location.reload();
	});
});
//시계
function realTime(){
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth(); 
	var dt = today.getDate(); 
	var dw = today.getDay();
	var h = today.getHours();
	var m = today.getMinutes();
	var s = today.getSeconds();
	h = addzero(h);
	m = addzero(m);
	s = addzero(s);
	month = month +1;
	var dayweek = new Array(7);
	dayweek[0] = "일"
	dayweek[1] = "월"
	dayweek[2] = "화"
	dayweek[3] = "수"
	dayweek[4] = "목"
	dayweek[5] = "금"
	dayweek[6] = "토" 
	d = dayweek[dw]; 
	var textdata = year + '년 ' + month +'월 ' + dt + '일 ' + d + '요일 ' + h +'시 '+ m + '분' + s +'초';
	$("span#timer-box").html(textdata);
	setTimeout(function(){
		realTime();
	},500);
}
function addzero(i)
{
	if(i<10)
	{
		i = "0" + i;
	}
	return i;
}
//공지사항롤링
function noticerolling(containerID){
	var $element = $('#'+containerID).find('.notice-list');	
	var speed = 3000;
	var timer = null;
	var move = $element.children().outerHeight();
	var first = false;
	var lastChild;
	lastChild = $element.children().eq(-1).clone(true);
	lastChild.prependTo($element);
	$element.children().eq(-1).remove();
	if($element.children().length==1){
		$element.css('top','0px');
	}else{
		$element.css('top','-'+move+'px');
	}
	timer = setInterval(moveNextSlide, speed);
	$element.find('>li').bind({
		'mouseenter': function(){
			clearInterval(timer);
		},
		'mouseleave': function(){
			timer = setInterval(moveNextSlide, speed);
		}
	});
	function moveNextSlide(){
		$element.each(function(idx){
			var firstChild = $element.children().filter(':first-child').clone(true);
			firstChild.appendTo($element.eq(idx));
			$element.children().filter(':first-child').remove();
			$element.css('top','0px');
			$element.eq(idx).animate({'top':'-'+move+'px'},'normal');
		});
	}
}
//쪽지함
function openPaperBox()
{
    window.open('/Paper/Main.cshtml', 'paperBox', 'width=550px,height=400px,status=no,scrollbars=yes,toolbar=no');
}
//숫자 콤마
function commaNum(num) 
{  
	var len, point, str;  
	num = num + "";  
	point = num.length % 3  
	len = num.length;  
	str = num.substring(0, point);  
	while (point < len) 
	{  
		if (str != "") str += ",";  
		str += num.substring(point, point + 3);  
		point += 3;  
	}  
	return str;  
}