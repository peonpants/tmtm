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
mainPage = True
%>
<%
    '---------------------------------------------------------
    '   @Title : 게임 머니 충전 페이지
    '   @desc  : 
    '---------------------------------------------------------
    Set Dber = new clsDBHelper    
    reqType = request("type")

        SQL = "select IU_BANKOWNER from dbo.INFO_USER with (nolock) where IU_ID = ?"
		reDim param(0)
		param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
       
        Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
        IU_BANKOWNER = sRs(0)
        
		sRs.close
		Set sRs = Nothing    
%>

<script type="text/javascript">
    String.prototype.setComma = function() {
        var temp_str = String(this);
        for (var i = 0, retValue = String(), stop = temp_str.length; i < stop; i++) retValue = ((i % 3) == 0) && i != 0 ? temp_str.charAt((stop - i) - 1) + "," + retValue : temp_str.charAt((stop - i) - 1) + retValue;
        return retValue;
    }

    function inputAmount() {
        var chargeMoney = document.frm1.IC_Amount.value.replace(/,/gi, ''); // 불러온 값중에서 컴마를 제거 
        var s = chargeMoney;

        if (s == 0) {  // 첫자리의 숫자가 0인경<PRE></PRE>우 입력값을 취소 시킴  
            chargeMoney.value = '';
            return;
        }

        else {
            document.frm1.IC_Amount.value = s.setComma();
        } 
    }

    function AmountChk() {
        var frm = document.frm1;

        if (frm.IC_Amount.value == "") {
            alert("입금금액을 입력해주세요.");
            frm.IC_Amount.focus();
            return;
        }

        if (parseInt(frm.IC_Amount.value.replace(/,/gi, '')) < 10000) {
            alert("입금액은 10,000원 이상 입력해주세요.");
            frm.IC_Amount.value = "";
            frm.IC_Amount.focus();
            return;
        }

        //if ((parseFloat(frm.IC_Amount.value.replace(/,/gi,'')) % 5000) != 0 )	{
        //	alert("입금액은 5000원 단위로 할 수 있습니다. 확인후 다시 신청해주세요.");
        //	frm.IC_Amount.value="";
        //	frm.IC_Amount.focus();
        //	return;	}

        if ((frm.IC_Name.value == "") || (frm.IC_Name.value.length < 2)) {
            alert("입금하시는분 이름을 정확하게 입력해주세요.");
            frm.IC_Name.focus();
            return;
        }
        if (!confirm("꼭 선입금후 입금신청을 하시기 바랍니다. 신청하시겠습니까?")) return;

        frm.action = "Money_Proc.asp";
        frm.submit();
    }

    function bankacountR() {
        var bfrm = document.BARfrm;
        bfrm.action = "bankacount_Proc.asp";
        bfrm.submit();
    }
    function selAmount(vl) {
        var frm = document.frm1;
        frm.IC_Amount.value = vl;
    }
    
    function InputCheck_new(obj, vl)
    {
        var frm = document.frm1;
        
        if(frm.IC_Amount.value == "" || parseInt(vl,10) == 0) frm.IC_Amount.value = 0        
        frm.IC_Amount.value = parseInt(frm.IC_Amount.value,10) +parseInt(vl,10);    
    }

    function goChargeCancel(idx) {
        if (!confirm("입금신청을 취소하시겠습니까?")) return;
        ProcFrm.location.href = "Money_Proc.asp?EMODE=MONEY02&IC_Idx=" + idx;
    }

    
    function goDel(IC_IDX)
    {
        if (!confirm("충전내역을 지우시겠습니까?")) return;
        ProcFrm.location.href = "Money_Proc.asp?EMODE=charge_del&IC_Idx=" + IC_IDX;
    }

function bt(id,after)
{
document.getElementById(id).filters.blendTrans.stop();
document.getElementById(id).filters.blendTrans.Apply();
document.getElementById(id).src=after;
document.getElementById(id).filters.blendTrans.Play();
}
 
function show_layer(div_name){
 
	document.all.div_01.style.display="none";
	document.all.div_02.style.display="none";
 
	switch(div_name)
	{
		case '1':
		document.all.div_01.style.display="";
		break;
		case '2':
		document.all.div_02.style.display="";
		break;
	}
}
function goDel1()
    {
        if (!confirm("전체 충전내역을 지우시겠습니까?")) return;
        ProcFrm.location.href = "Money_Proc.asp?EMODE=charge_del1";
    }
</script>

<div id="wrap">
	<div id="subwrap">
		<div class="subbody" style="">
			<div id="sub-content">

<DIV class="subbody">
<div class="game_view dark_radius game_title white" style="width:995px;">
  충전신청 <span>CHARGE</span></DIV></DIV>
<DIV id="sub-content" style="width: 100%;">
                <div style="position:relative">
                <img src="/images/money/banklist.png" align="absmiddle" style="position:absolute;right:0;top:0px">
                </div>
				<div class="charge_box" style="width:997px;">
					<table width="996" cellpadding="0" cellspacing="0" border="0" style="font-size:14px;font-weight:bold;cursor:pointer">
						<tbody><tr><td colspan="5" height="1" bgcolor="9d9d8e"></td></tr>
						<tr>
							<td height="40" width="1" bgcolor="9d9d8e"></td>
							<td width="466" onclick="location.href=&#39;charge.asp&#39;" align="center" style="background-color:#636351;color:#fff000;">충전하기</td>
							<td width="1" bgcolor="9d9d8e"></td>
							<td width="466" onclick="location.href=&#39;chargelist.asp&#39;" align="center" style="background-color:#2a2a22;color:#89d2bb;">충전신청내역</td>
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
					<div class="mentbox" style="border:1px solid #dfdfdf;width:933px;">
						<em style="padding:10px;">결재방법안내</em>
						<ol style="padding:10px;">
							<li>충전 신청을 하기 전에 은행에 입금을 먼저 하셔야 합니다.</li>
							<li>충전신청하신 예금주명과 입금하신 예금주명이 동일해야 충전신청이 가능합니다.</li>
							<li>본사의 입금계좌는 안전한 사이트 이용을 위해 수시로 변경이 될 수 있습니다.</li>
							<li>입금액은 10,000원 이상부터 아래 금액버튼을 클릭하시거나 직접 입력하실 수 있습니다.</li>
							<li>실제 입금한 금액과 충전 신청한 금액이 맞지 않으면 충전이 되지 않습니다.</li>
						</ol>
						<ul style="padding:10px;">
							<li>선입금후 충전신청해 주시면 빠르게 이용하실 수 있습니다.</li>
							<li>선입금을 충전신청30분 이전에 하신분들은 고객센터에 문의하시면 더욱더 빠르게 이용하실 수 있습니다.</li>
						</ul>
					</div>
					<div class="chargebox">
						<div class="subtitlebox" style="margin-bottom:3px; height: 20px;">입금신청서작성</div>
						<div class="chargecon">
							<table class="chargetable chargetable1">
								<tbody><tr>
									<th width="20%">입금계좌</th>
									<td>
										<b>입금계좌정보는 고객센터로 문의하시기 바랍니다.</b> &nbsp;&nbsp; <div class="btns_01" id="newAccount" style="cursor: pointer;">고객센터 문의하기</div>
									</td>
								</tr>
								<form name="frm1" method="post" target="ProcFrm">
								<input type="hidden" name="EMODE" value="MONEY01">
								<tr>
									<th>충전금액</th>
									<td>
										<div class="charge_inputtd"><input id="Text1" name="IC_Amount" value="0" type="text"  onKeyup="inputAmount();" class="money" style="text-align: right; padding-right: 5px;"></div>
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
								<tr>
									<th>예금주</th>
									<td><input type="text" name="IC_Name" id="name" value="<%= IU_BANKOWNER %>" class="form-control" style="width:110px;background:transparent;" readonly></td>
								</tr>

							</tbody></table>
							<div class="charge_submit"><a href="javascript:AmountChk();" onfocus="this.blur();" class="btns_03" style="width: 120px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;충전신청하기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div style="clear:both">
</div>
</div> <!-- wrap -->

</TABLE>
</TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
</TD></TR>
        <TR>
          <TD height="20"></TD></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD>
	  <iframe name="HiddenFrm" src="/Blank.html" frameborder="0" width="0" height="0" frameborder="0"></iframe>
<iframe name="ProcFrm" src="/Blank.html" frameborder="0" width="0" height="0" frameborder="0"></iframe>

<!-- #include file="../_Inc/footer.asp" -->