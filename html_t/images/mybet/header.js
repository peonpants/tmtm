function view_cover(id, formid, nurl, divtype, cover) {
	if(!id) id = "divModifyForm";
	if(!divtype) divtype = true;
	if(!cover) cover = true;

	if(cover == true) {
		if(!top.document.getElementById('div_cover')) {
			create_cover();
		} else {
			top.document.getElementById('div_cover').style.width = '100%';
			if(top.document.body.clientHeight > top.document.body.scrollHeight) top.document.getElementById('div_cover').style.height = '100%';
			else top.document.getElementById('div_cover').style.height = top.document.body.scrollHeight;
			top.document.getElementById('div_cover').style.display = 'block';
		}
	}

	var w = parseInt(top.document.getElementById(id).style.width);
	var h = parseInt(top.document.getElementById(id).style.height);
	var window_left = (top.document.body.clientWidth-w)/2;
	var window_top = (top.document.body.clientHeight-h)/2;
	this.Lw = h/2;

	if(id) {
		this.Lid = id;
		top.document.getElementById(id).style.display = '';
		top.document.getElementById(id).style.top = window_top;
		top.document.getElementById(id).style.left = window_left;
		document.modifyForm.modify_pw.focus();
		if(divtype == true) CheckUIElements();
	}
}

function CheckUIElements() {
	var yMenuFrom, yMenuTo, yButtonFrom, yButtonTo, yOffset, timeoutNextCheck;

	yMenuFrom = parseInt (top.document.getElementById(this.Lid).style.top, 10);
	if ( window.document.layers ) yMenuTo = top.pageYOffset + 0;
	else if ( window.document.getElementById ) yMenuTo = top.document.body.scrollTop + parseInt('80');

	timeoutNextCheck = 500;

	if ( Math.abs (yButtonFrom - (yMenuTo + 152)) < 6 && yButtonTo < yButtonFrom ) {
		setTimeout ("CheckUIElements()", timeoutNextCheck);
		return;
	}

	if ( yMenuFrom != yMenuTo ) {
		yOffset = Math.ceil( Math.abs( yMenuTo - yMenuFrom ) / 10 );
		if ( yMenuTo < yMenuFrom ) yOffset = -yOffset;
		top.document.getElementById(this.Lid).style.top = (parseInt(top.document.getElementById(this.Lid).style.top) + yOffset) + 5;
		timeoutNextCheck = 10;
	}
	setTimeout("CheckUIElements()", timeoutNextCheck);
}

function cover_off(id){
	if(top.document.getElementById('div_cover')) top.document.getElementById('div_cover').style.display = 'none';
	if(id) top.document.getElementById(id).style.display = 'none';
}

function create_cover(){
	var color = '#000000';
	var opacity = '70';

	var cover_div = top.document.createElement('div');
	cover_div.style.position = 'absolute';
	cover_div.style.top = '0px';
	cover_div.style.left = '0px';
	cover_div.style.width = '100%';
	cover_div.style.zIndex = 1;
	if(top.document.body.offsetHeight > top.document.body.scrollHeight) cover_div.style.height = '100%';
	else cover_div.style.height = top.document.body.scrollHeight;
	cover_div.style.backgroundColor = color;
	cover_div.style.filter = 'alpha(opacity='+opacity+')';
	cover_div.id = 'div_cover';
	top.document.body.appendChild(cover_div);
}

function move(url) {
	top.location.href = url;
}
// 영어,숫자만 가능
function ch(obj){
	var str = obj.src;               
	if(str.indexOf('_on.gif') < 0){         
	ss = str.substr(0, str.indexOf('.gif'))      
	obj.src = ss + "_on.gif";                         
	}else{                                      
	ss = str.substr(0, str.indexOf('_on.gif'))
	obj.src = ss + ".gif";
	}
}



//메인 경기 스크롤
 var $id = function (id) {
     return "string" == typeof id ? document.getElementById(id) : id;
 };
 
var Class = {
   create: function() {
     return function() {
       this.initialize.apply(this, arguments);
     }
   }
 }
 
Object.extend = function(destination, source) {
     for (var property in source) {
         destination[property] = source[property];
     }
     return destination;
 }
 
function addEventHandler(oTarget, sEventType, fnHandler) {
     if (oTarget.addEventListener) {
         oTarget.addEventListener(sEventType, fnHandler, false);
     } else if (oTarget.attachEvent) {
         oTarget.attachEvent("on" + sEventType, fnHandler);
     } else {
         oTarget["on" + sEventType] = fnHandler;
     }
 };
 

var Scroller = Class.create();
 Scroller.prototype = {
   initialize: function(idScroller, idScrollMid, options) {
     var oScroll = this, oScroller = $id(idScroller), oScrollMid = $id(idScrollMid);
     
     this.heightScroller = oScroller.offsetHeight;
     this.heightList = oScrollMid.offsetHeight;
     
     if(this.heightList <= this.heightScroller) return;
     
     oScroller.style.overflow = "hidden";
     oScrollMid.appendChild(oScrollMid.cloneNode(true));
     
     this.oScroller = oScroller;    
     this.timer = null;
     
     this.SetOptions(options);
     
     this.side = 1;//1是上 -1是下
     switch (this.options.Side) {
         case "down" :
             this.side = -1;
             break;
         case "up" :
         default :
             this.side = 1;
     }
     
     addEventHandler(oScrollMid , "mouseover", function() { oScroll.Stop(); });
     addEventHandler(oScrollMid , "mouseout", function() { oScroll.Start(); });
     
     if(this.options.PauseStep <= 0 || this.options.PauseHeight <= 0) this.options.PauseStep = this.options.PauseHeight = 0;
     this.Pause = 0;
     
     this.Start();
   },
   //设置默认属性
   SetOptions: function(options) {
     this.options = {//默认值
       Step:            1,//每次变化的px量
       Time:            20,//速度(越大越慢)
       Side:            "up",//滚动方向:"up"是上，"down"是下
       PauseHeight:    0,//隔多高停一次
       PauseStep:    2000//停顿时间(PauseHeight大于0该参数才有效)
     };
     Object.extend(this.options, options || {});
   },
   //滚动
   Scroll: function() {
     var iScroll = this.oScroller.scrollTop, iHeight = this.heightList, time = this.options.Time, oScroll = this, iStep = this.options.Step * this.side;
     
     if(this.side > 0){
         if(iScroll >= (iHeight * 2 - this.heightScroller)){ iScroll -= iHeight; }
     } else {
         if(iScroll <= 0){ iScroll += iHeight; }
     }
     
     if(this.options.PauseHeight > 0){
         if(this.Pause >= this.options.PauseHeight){
             time = this.options.PauseStep;
             this.Pause = 0;
         } else {
             this.Pause += Math.abs(iStep);
             this.oScroller.scrollTop = iScroll + iStep;
         }
     } else { this.oScroller.scrollTop = iScroll + iStep; }
     
     this.timer = window.setTimeout(function(){ oScroll.Scroll(); }, time);
   },
   //开始
   Start: function() {
     this.Scroll();
   },
   //停止
   Stop: function() {
     clearTimeout(this.timer);
   }
 };
 
 
 

function checkAll(f,lists){
	var change_id = Array('chk','m_idx','ckGameSeq');
	if( f.checked == false ){
		$("input[id='"+lists+"']").attr("checked",false);  
		if($.inArray(change_id,lists)){
			$("input[id='"+lists+"']").each(function(){ 
				if($(this).val().indexOf("|")<0){
					$("#con_"+$("#bgc_"+$(this).val()).val()).css({"background-color":""});
				}else{
					ids = $(this).val().split("|");
					$("#con_"+$("#bgc_"+ids[0]).val()).css({"background-color":""});
				}
			});
		}
	}else{
		$("input[id='"+lists+"']").attr("checked",true);
		if($.inArray(change_id,lists)){
			$("input[id='"+lists+"']").each(function(){ 
				if($(this).val().indexOf("|")<0){
					$("#con_"+$("#bgc_"+$(this).val()).val()).css({"background-color":"#FFC69D"});
				}else{
					ids = $(this).val().split("|");
					$("#con_"+$("#bgc_"+ids[0]).val()).css({"background-color":"#FFC69D"});
				}
			});
		}
	}
}

