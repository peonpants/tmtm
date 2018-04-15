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
					<table width="997" cellpadding="0" cellspacing="0" border="0" style="font-size:14px;font-weight:bold;cursor:pointer">
						<tbody><tr><td colspan="5" height="1" bgcolor="0f7883"></td></tr>

						<tr>
							<td height="40" width="1" bgcolor="9d9d8e"></td>
							<td width="466" onclick="location.href=&#39;charge.asp&#39;" align="center" style="background-color:#2a2a22;color:#fff000;">충전하기</td>
							<td width="1" bgcolor="9d9d8e"></td>
							<td width="466" onclick="location.href=&#39;chargelist.asp&#39;" align="center" style="background-color:#636351;color:#89d2bb;">충전신청내역</td>
							<td width="1" bgcolor="9d9d8e"></td>
						</tr>
						<tr>
							<td colspan="5" height="1" bgcolor="0ea8b9"></td>
						</tr>
					</tbody></table>
					<div class="chargebox">
						<div class="subtitlebox" style="margin-bottom:3px; height: 20px;">충전신청내역</div>
						<div class="chargecon">
							<table class="chargetable chargetable2">
								<tbody><tr>
									<th>번호</th>
									<th>충전금액</th>
									<th>입금자명</th>
									<th>충전신청일시</th>
									<th>상태</th>
									<th>삭제</th>
								</tr>


  <script language="javascript"> 
function deleteCharList(idx)
{
	if(!confirm("충전내역을 삭제하시겠습니까??")){
		return;
	}
	document.formCharge.cash_log_idx.value	=	idx;
	document.formCharge.mode.value	=	"delete";
	document.formCharge.submit();
 
}
</script>
<%	
	SQL = "UP_RetrieveInfo_ChargeForUser"

	reDim param(1)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
	
	Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

	INPC = sRs.RecordCount

	IF NOT sRs.EOF THEN

		FOR RE = 1 TO INPC
			   
			IF sRs.EOF THEN
				EXIT FOR
			END IF
				   
			IC_IDX			= sRs(0)
			IC_NAME			= sRs(1)
			IC_AMOUNT		= sRs(2)
			IC_REGDATE		= sRs(3)
			IC_SETDATE		= sRs(4)
			IC_STATUS		= CDbl(sRs(5))

			IF IC_STATUS = 1 THEN
				Status = "충전완료"													
			ELSE
				Status = "입금신청중"
			END IF		
%>

							<tr>
									<th><%=IC_IDX%></th>
									<th><%=IC_AMOUNT%></th>
									<th><%=IC_NAME%></th>
									<th><%=REPLACE(Left(IC_REGDATE,10),"-","/")%></th>
									<th><%=Status%></th>
									<th><% If ic_status = 1 then%> <a onclick="javascript:goDel(<%= IC_IDX %>);" style="cursor:pointer;"  alt="삭제">삭제</a><% End If %></th>
								</tr>



<%		
    sRS.Movenext
		Next

	ELSE	
%>
<table width="874" border="0" cellpadding="0" cellspacing="0">
							<tr> <td align="center" >
<font color="#FFFFFF">충전내역이 존재하지않습니다.</font></td></tr></table>
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







<%
    '---------------------------------------------------------
    '   @Title : 게임 머니 충전 페이지
    '   @desc  : 
    '---------------------------------------------------------
    Set Dber = new clsDBHelper    
    reqType = request("type")
    IF cSTr(reqType) = "1" Then
    SQL = "select SEQ ,SITE01,SITE02,SITE03,SITE04,SITE05 ,SITE06 from dbo.set_site with (nolock) where site01 = ?"
		reDim param(0)
		param(0) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
       


		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
       
		BC_TITLE	= "고객님의 전용계좌안내입니다."
		BC_MANAGER	= "관리자"
		BC_WRITER	= IC_ID
		BC_CONTENTS	= "&nbsp;&nbsp;<br />"
		BC_CONTENTS	= BC_CONTENTS & "<strong>&nbsp;입금은행 : "&sRs("SITE04")&"<br />"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;계좌번호 : "&sRs("SITE05")&"<br />"
		BC_CONTENTS	= BC_CONTENTS & "<br />"
		BC_CONTENTS	= BC_CONTENTS & "&nbsp;예금주 :&nbsp;"&sRs("SITE06")&"</strong><br />"
		

		sRs.close
		Set sRs = Nothing
    End IF
        SQL = "select IU_BANKOWNER from dbo.INFO_USER with (nolock) where IU_ID = ?"
		reDim param(0)
		param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
       
        Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
        IU_BANKOWNER = sRs(0)
        
		sRs.close
		Set sRs = Nothing    
%>

<%	
	SQL = "UP_RetrieveInfo_ChargeForUser"

	reDim param(1)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
	
	Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

	INPC = sRs.RecordCount

	IF NOT sRs.EOF THEN

		FOR RE = 1 TO INPC
			   
			IF sRs.EOF THEN
				EXIT FOR
			END IF
				   
			IC_IDX			= sRs(0)
			IC_NAME			= sRs(1)
			IC_AMOUNT		= sRs(2)
			IC_REGDATE		= sRs(3)
			IC_SETDATE		= sRs(4)
			IC_STATUS		= CDbl(sRs(5))

			IF IC_STATUS = 1 THEN
				Status = "충전완료"													
			ELSE
				Status = "입금신청중"
			END IF		
%>
						  <TBODY>
                          <TR>
                            <TD><% If ic_status = 1 then%><IMG style="cursor: pointer;" onclick="javascript:goDel(<%= IC_IDX %>);" 
                              src="/images/charge/del_btn.png"><% ELSE %>대기<% End If %></TD>
							<TD><%=IC_IDX%></TD>
                            <TD><STRONG><%=IC_AMOUNT%>원</STRONG></TD>
                            <TD><%=IC_NAME%></TD>
                            <TD><%=REPLACE(Left(IC_REGDATE,10),"-","/")%></TD>
                            <TD><%=Status%></TD></TR>
						</TBODY>
<%		
    sRS.Movenext
		Next

	ELSE	
%>

							<tr> <td align="center" >
<font color="#FFFFFF">충전내역이 존재하지않습니다.</font></td></tr>
<%	END IF

	sRs.Close
	Set sRs = Nothing	
	Dber.Dispose
	Set Dber = Nothing 	
%>	
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