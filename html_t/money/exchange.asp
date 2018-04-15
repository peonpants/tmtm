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

<%
mainPage = True
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

        <TR>
          <TD align="center" valign="top">
<SCRIPT language="javascript">
function listDelete(idValue) {
	if ( !confirm("삭제 하시겠습니까?") )	{
		return false;
	}
	f = document.getElementById("delForm");
	f.seqValue.value = idValue;
	f.submit();
}

function msgToFocus(msg,form)	{
	alert(msg);
	if ( form )
		form.focus();
}

function setCurrency(obj)	{
	var str = obj.value;
	str = str.toString().replace(/\$|\,/g,'');
	if(isNaN(str)) Str = "0";
	cents = Math.floor((str*100+0.5)%100);
	str = Math.floor((str*100+0.5)/100).toString();
	if(cents < 10) cents = "0" + cents;
	for (var i = 0; i < Math.floor((str.length-(1+i))/3); i++)
	str = str.substring(0,str.length-(4*i+3))+','+str.substring(str.length-(4*i+3));
	if ( str == 0 )
		str = "0";
	obj.value = str;
}

var submitFlag = 0;
var myMoney = 0;
function formCheck(form)	{	
	if ( submitFlag == 1 ) {
		alert("처리 중입니다. 잠시만 기다려주세요.");
		return false;
	}
	if ( !form.money.value || form.money.value == 0 )	{
		msgToFocus("환전금액을 입력해주세요.",form.money);
		return false;
	}
	tempMoney = form.money.value.replace(/\,/gi,'');
	if ( tempMoney < 10000 )	{
		msgToFocus("환전금액은 10,000원 이상 입력해주세요.",form.money);
		return false;
	}
	if ( tempMoney > myMoney ) {
		msgToFocus("환전금액이 보유금액보다 큽니다.",form.money);
		return false;
	}
	if ( !confirm("정말 환전 요청을 하시겠습니까?") )	{
		return false;
	}
	submitFlag = 1;
	form.submit();
}
function addMoney(plusMoney) {
	var money = bankForm.money.value;
	money = money.toString().replace(/\$|\,/g,'');
	money = parseInt(money) + plusMoney;
	bankForm.money.value = money;
	//bankForm.money.value = plusMoney;
	setCurrency(bankForm.money);
}
</SCRIPT>
<div id="wrap">
	<div id="subwrap">
		<div class="subbody" style="">
			<div id="sub-content">

<DIV class="subbody">
<div class="game_view dark_radius game_title white" style="width:995px;">
  환전신청 <span>EXCHANGE</span></DIV></DIV>
<DIV id="sub-content" style="width: 100%;">
                <div style="position:relative">
                <img src="/images/money/banklist.png" align="absmiddle" style="position:absolute;right:0;top:0px">
                </div>
				<div class="charge_box" style="width:997px;">
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
             
<form name="frm1" method="post" target="ProcFrm">
<input type="hidden" name="EMODE" value="MONEY03">
<input type="hidden" name="IE_ID" value="<%=Session("SD_ID")%>">
<input type="hidden" name="IU_Cash" value="<%=IU_Cash%>">
<input type="hidden" name="IE_NickName" value="<%=Session("NickName")%>">
<input type="hidden" name="IU_MOONEY_PWDW" value="<%=IU_MOONEY_PWDW%>">
<input type="hidden" name="mode" value="exchange"/>
<input name="exchange_money" type="hidden" value="0"/>			

						  <div style="width:996px;float:left">
				<div class="charge_box">
					<table width="996" cellpadding="0" cellspacing="0" border="0" style="font-size:14px;font-weight:bold;cursor:pointer">
						<tbody><tr><td colspan="5" height="1" bgcolor="9d9d8e"></td></tr>
						<tr>
							<td height="40" width="1" bgcolor="9d9d8e"></td>
							<td width="466" onclick="location.href=&#39;exchange.asp&#39;" align="center" style="background-color:#2a2a22;color:#fff000;">환전하기</td>
							<td width="1" bgcolor="9d9d8e"></td>
							<td width="466" onclick="location.href=&#39;exchangelist.asp&#39;" align="center" style="background-color:#636351;color:#89d2bb;">환전신청내역</td>
							<td width="1" bgcolor="9d9d8e"></td>
						</tr>
						<tr>
							<td colspan="5" height="1" bgcolor="0ea8b9"></td>
						</tr>

					</tbody></table>

					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tbody><tr>
							<td height="5"></td>
						</tr>
					</tbody></table>

					<div class="mentbox" style="width:933px;border:1px solid #dfdfdf">
						<em style="padding:10px;">환전방법안내</em>
						<ol style="padding:10px;">
							<li>환전 신청을 하게되면 회원가입시 기재하신 계좌로 입금처리가 이루어집니다.</li>
							<li>단, 23:40부터 00:20까지는 은행점검시간으로 환전이 불가능 합니다.</li>
							<li>10분이상 입금이 지연될시 회원님 계좌정보를 잘못 기입한 경우가 많습니다. 그럴 경우 상단메뉴 고객센터로 계좌정보를 정확히 보내주세요.</li>
						</ol>
					</div>

					<div class="chargebox">
						<div class="subtitlebox" style="margin-bottom:3px; height: 20px;">입금계좌정보</div>
						<div class="chargecon">
							<table class="chargetable chargetable1">
								<tbody><tr>
									<th width="20%">보유금액</th>
									<td class="price"><b><%=FORMATNUMBER(IU_CASH,0)%> 원</b> &nbsp;&nbsp;<font style="color:#888">( 최저 10,000원 부터 환전이 가능합니다. )</font></td>
								</tr>
								<tr>
									<th>은행</th>
									<td>
										<p style="height:24px"><strong>거래은행</strong> : <%=IU_BANKNAME%></p>
										<p style="height:24px"><strong>계좌번호</strong> : [<%=IU_BANKNUM_cut%><% for i =5 to IU_BANKNUM_su%>＊<% NEXT %></p>
										<p style="height:24px"><strong>예금주</strong> : <%=IU_BANKOWNER%></p>
										<!--<div class="charge_pw">출금비밀번호입력 : <input id="f_bank_pw" name="bank_pw" class="inputs1" type="password" title="출금비밀번호"></div>-->
									</td>
								</tr>
								<tr>
									<th>출금계좌비번</th>
									<td>
										<div class="charge_inputtd"><input id="money" name="iu_mooney_pwdw" value="" class="inputs1" type="text" style="text-align:right">6자리 출금계좌비번을 입력해주세요</div>
									</td>
								</tr>
								<tr>
									<th>환전금액</th>
									<td>
										<div class="charge_inputtd"><input id="IE_Amount" name="IE_Amount" value="0" class="inputs1" type="text" onfocus="this.select();" style="text-align:right"></div>
										<dl class="btns_02">
											<dd onclick="javascript:InputCheck_new(this,'10000');">1만원</dd>
											<dd onclick="javascript:InputCheck_new(this,'30000');">3만원</dd>
											<dd onclick="javascript:InputCheck_new(this,'50000');">5만원</dd>
											<dd onclick="javascript:InputCheck_new(this,'100000');">10만원</dd>
											<dd onclick="javascript:InputCheck_new(this,'500000');">50만원</dd>
											<dd onclick="javascript:InputCheck_new(this,'1000000');">100만원</dd>
											<dt onclick="javascript:InputCheck_new(this,'0');">정정하기</dt>
										</dl>
									</td>
								</tr>
							</tbody></table>
							<div class="charge_submit"><a type="submit" class="btns_03" href="javascript:FrmChk1();">환전신청하기</a></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div style="clear:both"></div>
</div> <!-- wrap -->

</form>


<script type="text/javascript" src="./jquery.comm.js.다운로드"></script>
<script type="text/javascript" src="./jquery.popup.js.다운로드"></script>
<script type="text/javascript" src="./jquery.pngFix.js.다운로드"></script>
<script type="text/javascript" src="./GX_packed.js.다운로드"></script>
<script type="text/javascript" src="./GX.extras_packed.js.다운로드"></script>

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