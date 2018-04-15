<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<!-- #include file="../_Inc/clock.asp" -->

<body id="top" marginwidth="0" marginheight="0">
<style type="text/css">
   #background {
		width:100%;
		height:120px;
		background:no-repeat center;
		 -webkit-user-select: none; -khtml-user-select: none;
		 -moz-user-select: none; -o-user-select: none; user-select: none;
    }
</style>


<%
    '---------------------------------------------------------
    '   @Title : 게임 머니 환전 페이지
    '   @desc  : 
    '---------------------------------------------------------
%>


<script type="text/javascript">
	String.prototype.setComma = function()	{ 
    	var temp_str = String(this); 
    	for(var i = 0 , retValue = String() , stop = temp_str.length; i < stop ; i++) retValue = ((i%3) == 0) && i != 0 ? temp_str.charAt((stop - i) -1) + "," + retValue : temp_str.charAt((stop - i) -1) + retValue; 
			return retValue;	}
	
	function inputAmount()	{ 
		var exchangeMoney = document.frm1.IE_Amount.value.replace(/,/gi,''); // 불러온 값중에서 컴마를 제거 
   		var s = exchangeMoney;
		
		if (s == 0) {  // 첫자리의 숫자가 0인경우 입력값을 취소 시킴  
       		document.frm1.IE_Amount.value = ''; 
       		return;		}
		 
       	else { 
           	document.frm1.IE_Amount.value = s.setComma();	}}

	var isSubmit = false;

	function FrmChk1() {
	if (!isSubmit)	{
		var frm = document.frm1;
		var curCash = frm.IU_Cash.value;
		
		if (frm.IE_Amount.value == "") {
			alert("환전 신청금액을 입력해 주세요.");
			frm.IE_Amount.value="";
			frm.IE_Amount.focus();
			return;	}
		
		if ( parseInt(curCash) == 0 ) {
			alert("환전 가능머니가 없습니다. 확인후 다시 시도해 주세요.");
			frm.IE_Amount.value="";
			return;	}
				
		if ( parseFloat(curCash) < parseFloat(frm.IE_Amount.value.replace(/,/gi,'')) )	{
			alert("환전 가능머니보다 환전신청액이 많습니다. 확인후 다시 신청해 주세요.");
			frm.IE_Amount.value="";
			return;	}

		if ( parseInt(frm.IE_Amount.value.replace(/,/gi,'')) < 10000 ) {
			alert("환전 신청금액은 10,000원 이상 입력해 주세요.");
			frm.IE_Amount.value="";
			frm.IE_Amount.focus();
			return;	}
		
		if ((parseFloat(frm.IE_Amount.value.replace(/,/gi,'')) % 10000) != 0 )	{
			alert("환전 신청은 10,000원 단위로 할 수 있습니다. 확인후 다시 신청해 주세요.");
			frm.IE_Amount.value="";
			frm.IE_Amount.focus();
			return;	}

		isSubmit = true;
		frm.action = "Money_Proc.asp";
		frm.submit();	}
	else	{
		alert("처리중입니다. 잠시 기다리세요."); return; }
	}
	
    function goDel(IE_IDX)
    {
        if (!confirm("환전내역을 지우시겠습니까?")) return;
        ProcFrm.location.href = "Money_Proc.asp?EMODE=exc_del&IE_IDX=" + IE_IDX;
    }	
    
    function InputCheck_new(obj, vl)
    {
        var frm = document.frm1;
        
        if(frm.IE_Amount.value == "" || parseInt(vl,10) == 0) frm.IE_Amount.value = 0        
        frm.IE_Amount.value = parseInt(frm.IE_Amount.value,10) +parseInt(vl,10);    
    }
        
	function goDel1()
    {
        if (!confirm("전체 환전내역을 지우시겠습니까?")) return;
        ProcFrm.location.href = "Money_Proc.asp?EMODE=exc_del1";
    }	
        
</script>
<div id="wrap">
	<div id="subwrap">
		<div class="subbody" style="">
			<div id="sub-content">

<DIV class="subbody">
<div class="game_view dark_radius game_title white" style="width:995px;">
  환전신청내역 <span>EXCHANGE</span></DIV></DIV>
<DIV id="sub-content" style="width: 100%;">
                <div style="position:relative">
                <img src="/images/money/banklist.png" align="absmiddle" style="position:absolute;right:0;top:0px">
                </div>
				<div class="charge_box" style="width:997px;">

					<table width="997" cellpadding="0" cellspacing="0" border="0" style="font-size:14px;font-weight:bold;cursor:pointer">
						<tbody><tr><td colspan="5" height="1" bgcolor="9d9d8e"></td></tr>
						<tr>
							<td height="40" width="1" bgcolor="9d9d8e"></td>
							<td width="466" onclick="location.href=&#39;exchange.asp&#39;" align="center" style="background-color:#636351;color:#89d2bb;">환전하기</td>
							<td width="1" bgcolor="9d9d8e"></td>
							<td width="466" onclick="location.href=&#39;exchangelist.asp&#39;" align="center" style="background-color:#2a2a22;color:#fff000;">환전신청내역</td>
							<td width="1" bgcolor="9d9d8e"></td>
						</tr>
						<tr>
							<td colspan="5" height="1" bgcolor="0380ad"></td>
						</tr>


					</tbody></table>

					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tbody><tr>
							<td height="5"></td>
						</tr>
					</tbody></table>

					<div class="chargebox">
						<div class="subtitlebox" style="margin-bottom:3px; height: 20px;">환전신청내역</div>
						<div class="chargecon">
							<table class="chargetable chargetable2">
								<tbody><tr>
									<th>번호</th>
									<th>환전금액</th>
									<th>환전신청일시</th>
									<th>상태</th>
									<th>삭제</th>
								</tr>
								
							
<%	
			    '######## 보유 금액을 표시한다  ##############
				Set Dber = new clsDBHelper
				SQL = "SELECT * FROM INFO_USER WHERE IU_ID = ? AND IU_SITE = ?"

				reDim param(1)
				param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
				param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

				Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

				IU_CASH	= sRs("IU_CASH")
				IU_BANKNAME = sRs("IU_BANKNAME") 
				IU_BANKNUM_su=Len(sRs("IU_BANKNUM"))
                IU_BANKNUM_cut=Left(sRs("IU_BANKNUM"),6)

				IU_BANKOWNER = sRs("IU_BANKOWNER")
				IU_MOONEY_PW = sRs("IU_MOONEY_PW")

				sRs.Close
				Set sRs = Nothing	
				
				 '######## 충전 내역을 체크한다  ##############
	
				                					
            %>

<%	
    '######## 하루 전 환전 내역을 보여준다  ##############
	SQL = "UP_RetrieveInfo_ExchangeForUser"

	reDim param(1)
	param(0) = Dber.MakeParam("@IE_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

	Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

	INPC = sRs.RecordCount

	IF NOT sRs.EOF THEN

		FOR RE = 1 TO INPC
			   
			IF sRs.EOF THEN
				EXIT FOR
			END IF
				   
			IE_IDX			= sRs(0)
			IE_AMOUNT		= sRs(1)
			IE_REGDATE		= sRs(2)
			IE_STATUS		= CDbl(sRs(3))
			
			IF IE_STATUS = 1 THEN
				Status = "환전완료"													
            ElseIF IE_STATUS = 4 THEN				
                Status = "환전반려"													
            ElseIF IE_STATUS = 3 THEN				
                Status = "환전취소"													                
			ELSE
				Status = "환전신청중"
			END IF		
%>
			<form name="frm1" method="post" target="ProcFrm">
			<input type="hidden" name="EMODE" value="MONEY03">
			<input type="hidden" name="IE_ID" value="<%=Session("SD_ID")%>">
			<input type="hidden" name="IU_Cash" value="<%=IU_Cash%>">
			<input type="hidden" name="IE_NickName" value="<%=Session("NickName")%>">
            <input type="hidden" name="IU_MOONEY_PW" value="<%=IU_MOONEY_PW%>"> 

								<tr>
									<th><%=RE%></th>
									<th><%=FORMATNUMBER(IE_AMOUNT,0)%></th>
									<th><%=IE_REGDATE%></th>
									<th><%=Status%></th>
									<th><% If ie_status=1 Then %><a onclick="javascript:goDel(<%= IE_IDX %>);">삭제</a><% Else %>대기중<% End If %></th>
								</tr>

	
<%		
    sRS.Movenext
		Next

	ELSE	
%>
							<tr> <td align="center" >
<font color="#FFFFFF">환전내역이 존재하지않습니다.</font></td></tr>
<%	END IF

	sRs.Close
	Set sRs = Nothing	
	Dber.Dispose
	Set Dber = Nothing 	
%>	
</tbody></table>
						</div>
					</div>
					<br>
					<div id="paging"></div>
				</div>
			</div>

		</div>
	</div>
	<div style="clear:both"></div>
</div> <!-- wrap -->

</form>

<script type="text/javascript" src="/js/newjs/jquery.comm.js.다운로드"></script>
<script type="text/javascript" src="/js/newjs/jquery.popup.js.다운로드"></script>
<script type="text/javascript" src="/js/newjs/jquery.pngFix.js.다운로드"></script>
<script type="text/javascript" src="/js/newjs/GX_packed.js.다운로드"></script>
<script type="text/javascript" src="/js/newjs/GX.extras_packed.js.다운로드"></script>
<script type="text/javascript">
	var msg_count = 0;
	var oWin;
	var wid;
	var hei;
	var TimerID;
	var intFlag = 0; // 음성을 한번만 나오게 하기 위한 변수
	$(document).ready(function() {
		
		oWin = $(window);
		wid = 260;
		hei = 130;
		
		getPostNotice("Y");
		setInterval(function() {
			getPostNotice("N");
		}, 7000);
	});

	function getPostNotice(pageLoad) {
		$.get("/include/post_notice.asp", {
			"pageLoad":pageLoad
		}, function(xml) { // 알림이 도착하면 실행된다.
			if (xml != "") {
				switch (xml) {
					case "0" : location.href = "/logout.asp?logonFlag=0"; break; //alert("잘못된 접근입니다.\\n\\n회원만 이용하실 수 있습니다.");
					case "1" : location.href = "/logout.asp?logonFlag=1"; break; //alert("다른곳에서 로그인 하여 현재 PC는 자동로그아웃 처리 되었습니다.");
					case "2" : location.href = "/logout.asp?logonFlag=2"; break; //alert("오랫동안 사용하지 않으셔서 자동로그아웃 처리 되었습니다.");
					default : post_notice(xml); break;
				}
			} 
		});
	}
	
	function post_notice(xml) {
		if ($("#alert_container").length == 0) {
			$("body").append(
				$("<div></div>").css({
					"top":(oWin.height() + oWin.scrollTop() - (hei+3)) + "px",
					"left":(oWin.width() - (wid + 3)) + "px",
					"width":(wid+2)+"px",
					"height":(hei+2)+"px",
					"position":"absolute",
					"overflow":"hidden",
					"color":"white"
				}).attr("id", "alert_container")
			);
		}
		
		if ($("#alert").length == 0) {
			$("#alert_container").append(
				$("<div></div>").css({
					"top":+(hei+3) +"px",
					"left":"0px",
					"width":wid+"px",
					"height":hei+"px",
					"position":"absolute",
					"z-index":"1000",
					"backgroundColor":"#000000",
					"border":"1px solid #FFFFFF",
					"overflow":"hidden"
				}).attr("id", "alert")
				.move("0px", "0px", [700, 'Bounce'])
				
				.mouseover(function() {
					clearTimeout(TimerID);
				})
			);
		}
		else { // 기존에 내용은 삭제한다.
			$("#alert").html("");
			msg_count = 0; // 메시지 카운터 초기화
		}

		var rs = xml.split("vbCrLf");
		for (var i=0; i<rs.length; i++) {
			if (rs[i] != "") {
				$("#alert").append(
					"<div id='al_"+rs[i].fields("seq")+"' style='padding:5px 5px 2px 10px'>"
					+ "<b>" + rs[i].fields("post_msg") + "</b><br>"
					+ rs[i].fields("post_date") + "&nbsp; "
					+ "<input type='button' value='확인' class='bg_input' onclick='post_notice_confirm(" + rs[i].fields("seq") + ")' style='font-size:11px;font-family:돋움;width:42px'>"
				
					+ "</div>"
				);
				
				// 가장 상위의 음성만 들려준다.
				if (intFlag == 0) {
					var obj = document.getElementById("player");
					obj.url = "/sound/" + rs[i].fields("sound_code") + ".wma";
					//obj.controls.play();

					// 음성을 한번만 나오게 하려고 자동으로 확인시킨다.
					if ($("#btnAdmin").css("display") == "none") { // 일반 사용자들만 자동 확인한다.
						$.get("/include/post_notice_confirm.asp", {
							"seq":rs[i].fields("seq")
						}, function(xml) {
							if (xml == "Y") {
								TimerID = setTimeout(function() {
									$("#alert")
										.move("0px", (hei+3) + "px", [1000, 'Bounce'])
										.fadeOut(100, function() {
											clearTimeout(TimerID);
											$("#alert_container").remove();
										})
								}, 5000);
							}
						});
					}
				}
				msg_count++;
				intFlag++;


				// 쪽지라면 상단에 쪽지아이콘 깜빡이게...
				if (rs[i].fields("sound_code") == "01" && $("#post_icon").attr("src").indexOf("post_yes") == -1) {
					$("#post_icon").attr("src", "/html/POKERFACE/images/post_yes.gif");
					setInterval("doBlink()",700); 
				}
			}
		}
		
		intFlag = 0;
	}
	
	function post_notice_confirm( intSeq ) {
		$.get("/include/post_notice_confirm.asp", {
			"seq":intSeq
		}, function(xml) {
			if (xml == "Y") {
				msg_count--;
				$("#al_"+intSeq).remove();
				if (msg_count == 0) {
					$("#alert")
					.move("0px", (hei+3) + "px", [1000, 'Bounce'])
					.fadeOut(100, function() {
						clearTimeout(TimerID);
						$("#alert_container").remove();
					})
				}
			}
		});
	}
	
	// ajax를 사용하면서 결과값 에 대해 값을 구분하기가 너무 힘들어서 만듬.
	String.prototype.fields = function(str, g) {
		g = (g==null ? "&" : g); // 아이템간 구분
		var arr = this.split(g);
		
		if (str != null) {
			for (var i=0; i<arr.length; i++) {
				if (arr[i].split("=")[0].trim() == str) {
					//return arr[i].split("=")[1];
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
</script>


<div id="go_top" onclick="go_top();" style="display: none;">TOP</div>

<object id="player" name="player" width="0" height="0" classid="clsid:6BF52A52-394A-11d3-B153-00C04F79FAA6" type="application/x-oleobject" codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701">
	<param name="ShowControls" value="0">
	<param name="AutoStart" value="1">
	<param name="FileName" value="">
	<param name="PlayCount" value="1">
	<param name="showControl" value="0">
	<param name="EnableContextMenu" value="false">
	<param name="AllowScan" value="true">
	<param name="TransparentAtStart" value="True">
	<param name="AutoSize" value="1">
    <param name="AnimationAtStart" value="false">
</object>

<script>
$("li","#top_menu").hover(function(){
	$(this).stop().animate({"opacity":"1"},300);
	$("var",this).stop().animate({"top":"0px"},100);
}, function(){
	$(this).stop().animate({"opacity":"0.6"},300);
	$("var",this).stop().animate({"top":"-3px"},100);
});

// TOP버튼 활성화
$(window).scroll(function(){
	var ys = $(this).scrollTop();
	if(ys >= 100){
		$("#go_top").show();
	}
	else {
		$("#go_top").hide();
	}
});

// TOP버튼 애니메이션
function go_top() {
	$('html,body').animate({scrollTop:0}, 400);
}
</script>
<script for="player" event="NewStream()" language="JScript">
	// 첫번째 미디어 실행하고 나서 PlayCount 가 끝나고 새루온 미디어가 실행시에 뜬다.
</script>
<script for="player" event="EndOfStream(lResult)" language="JScript">
</script>
<script for="player" event="Buffering(bStart)" language="JScript">
	str=(bStart)?'버퍼링중':'버퍼링완료';
	window.status=str;
</script>
	  <iframe name="HiddenFrm" src="/Blank.html" frameborder="0" width="0" height="0" frameborder="0"></iframe>
<iframe name="ProcFrm" src="/Blank.html" frameborder="0" width="0" height="0" frameborder="0"></iframe>
<!-- #include file="../_Inc/footer.asp" -->