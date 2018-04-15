<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<!-- #include file="../_Inc/clock.asp" -->
<%
PGSIZE=10
SETSIZE=5
PAGE = dfSiteUtil.F_initNumericParam(dfRequest.Value("PAGE")  ,1,1,9999)

IF REQUEST("PAGE") = "" THEN
    PAGE = 1
    STARTPAGE = 1
ELSE
    PAGE = CINT(REQUEST("PAGE")) 
    STARTPAGE = INT(PAGE/SETSIZE)

    IF STARTPAGE = (PAGE/SETSIZE) THEN
        STARTPAGE = PAGE-SETSIZE + 1
    ELSE
        STARTPAGE = INT(PAGE/SETSIZE) * SETSIZE + 1
    END IF
END IF
%>
<script type="text/javascript">
	String.prototype.setComma = function()	{ 
    	var temp_str = String(this); 
    	for(var i = 0 , retValue = String() , stop = temp_str.length; i < stop ; i++) retValue = ((i%3) == 0) && i != 0 ? temp_str.charAt((stop - i) -1) + "," + retValue : temp_str.charAt((stop - i) -1) + retValue; 
			return retValue;	}
	
    function inputAmount() {
        var chargeMoney = document.frm1.IC_Amount.value.replace(/,/gi, ''); // 불러온 값중에서 컴마를 제거 
        var s = chargeMoney;

        if (s == 0) {  // 첫자리의 숫자가 0인경우 입력값을 취소 시킴  
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
    
    function InputCheck_new(vl)
    {
        var frm = document.frm1;
        if(frm.IC_Amount.value == "" || parseInt(vl,10) == 0) frm.IC_Amount.value = 0
        frm.IC_Amount.value = parseInt(frm.IC_Amount.value,10) +parseInt(vl,10);    
    }
        
	function goDel(IC_IDX)
    {
        if (!confirm("충전내역을 지우시겠습니까?")) return;
        ProcFrm.location.href = "Money_Proc.asp?EMODE=charge_del&IC_Idx=" + IC_IDX;
    }
        
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
		setCurrency(bankForm.money);
	}
</SCRIPT>

<%	
    '### cash  ###
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

	IU_BANKOWNER= sRs("IU_BANKOWNER")
	IU_MOONEY_PW = sRs("IU_MOONEY_PW")

	sRs.Close
	Set sRs = Nothing	
%>

<form name="frm1" method="post" target="ProcFrm">
	<input type="hidden" name="EMODE" value="MONEY01">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tbody><tr>
            <td width="800px" align="left">
                <img src="/images/money/deposit.png" align="absmiddle">
            </td>
            <td width="210px" rowspan="9" valign="top" align="right">
                <div style="position:relative">
                <img src="/images/money/banklist.png" align="absmiddle" style="position:absolute;right:0;top:10px">
                </div>
            </td>
        </tr>
        <tr>
            <td style="height:15px"></td>
        </tr>
        <tr>
            <td align="center">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" class="noticestyle">
                    <tbody><tr>
                        <th height="40px" style="text-align: left; padding: 0 20px">
                            주의사항
                        </th>
                    </tr>
                    <tr>
                        <td align="left" style="text-align: left; padding: 15px 20px">
                            ▶ 입금하실 계좌에 인터넷뱅킹, 폰뱅킹. 무통장입금, ATM등의 방법으로 입금합니다.<br>
                            <br>
                            ▶ <font color="red">수표 입금은 처리 불가하오니 주의하시기 바랍니다.</font><br>
                            <br>
                            ▶ 입금액은 10,000원이상 1,000원 단위입니다.<br>
                            <br>
                            ▶ 입금 전 입금계좌정보를 꼭 확인해주세요.<br>
                            <br>
                            ▶ 충전하기 버튼을 클릭하시면 충전신청이 완료됩니다.<br>
                        </td>
                    </tr>
                </tbody></table>
            </td>
        </tr>
        <tr>
            <td height="15px">
            </td>
        </tr>
        <tr>
            <td align="center">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" class="noticestyle">
                    <tbody><tr>
                        <th height="35px" style="text-align: left; padding: 0 20px">
                            요청하기
                        </th>
                    </tr>
                    <tr>
                        <td align="left" style="text-align: left; padding: 20px">
                            ▶ <font color="#9f9223"><b>&nbsp;충전계좌문의는 고객센터로 문의주세요&nbsp;</b></font>
                            <br>
                            ▶ 충전금액 :
                            <input name="IC_Amount" type="text" value="0" maxlength="8" id="IC_Amount" onkeypress="javascript:NumObj(this);" style="color:White;background-color:Black;border-color:#4C4C4C;border-width:1px;border-style:Solid;width:100px;ime-mode: disabled; text-align: right">&nbsp;원 &nbsp;&nbsp;&nbsp;&nbsp;
                            <img src="/images/money/1.png" id="Img6" alt="1만원" onclick="javascript:InputCheck_new('10000');" align="absmiddle" border="0" style="cursor: pointer">
                            <img src="/images/money/3.png" id="Img7" alt="3만원" onclick="javascript:InputCheck_new('30000');" align="absmiddle" border="0" style="cursor: pointer">
                            <img src="/images/money/5.png" id="Img8" alt="5만원" onclick="javascript:InputCheck_new('50000');" align="absmiddle" border="0" style="cursor: pointer">
                            <img src="/images/money/10.png" id="Img9" alt="10만원" onclick="javascript:InputCheck_new('100000');" align="absmiddle" border="0" style="cursor: pointer">
                            <img src="/images/money/50.png" id="Img10" alt="50만원" onclick="javascript:InputCheck_new('500000');" align="absmiddle" border="0" style="cursor: pointer">
                            <img src="/images/money/100.png" id="Img12" alt="100만원" onclick="javascript:InputCheck_new('1000000');" align="absmiddle" border="0" style="cursor: pointer">
                            &nbsp;
                            <img src="/images/money/btn_delete.png" id="Img11" alt="정정" onclick="javascript:InputCheck_new(0);" align="absmiddle" border="0" style="cursor: pointer">
                            <br>
                            <br>
                            ▶ 입금자명 :
                            <input name="IC_Name" id="IC_Name" type="text" value="<%=IU_BANKOWNER%>" readonly="readonly" style="color:White;background-color:Black;border-color:#4C4C4C;border-width:1px;border-style:Solid;width:100px;text-align: right">&nbsp;님
                        </td>
                    </tr>
                </tbody></table>
            </td>
        </tr>
        <tr>
            <td height="15px">
            </td>
        </tr>
        <tr>
            <td align="center">
                <input type="image" title="충전요청" src="/images/money/charge1.jpg" onclick="javascript:AmountChk();" style="border-width:0px;">&nbsp;&nbsp;&nbsp;&nbsp;<a href="/support/answer_write2.asp"><img src="/images/money/reaccount.png"></a>
            </td>
        </tr>
        <tr>
            <td height="15px">
            </td>
        </tr>
	     
	</tbody></table>
</form>
 
<table width="100%" style="text-align: center; width: 800px; float: left" class="noticestyle">
    <tbody>
        <tr>
            <th width="5%" height="30">번호</th>
            <th width="20%">충전금액</th>
            <th width="15%">입금자명</th>
            <th width="25%">충전일시</th>
            <th width="20%">상태</th>
            <th width="15%">삭제</th>
        </tr>
<%
    SQL = "SELECT COUNT(*) AS TN FROM Info_Charge WHERE IC_ID='"&Session("SD_ID")&"' AND IC_RegDate >= dateadd(d ,-1, getdate()) AND IC_SITE ='"&JOBSITE&"' AND IC_DEL<>1"
    Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)

    TN = CDBL(sRs(0))
    sRs.CLOSE
    SET sRs = Nothing

    PGCOUNT = INT(TN/PGSIZE)
    IF PGCOUNT * PGSIZE <> TN THEN 
        PGCOUNT = PGCOUNT+1
    END IF

	SQL = "SELECT TOP " & PGSIZE & " IC_IDX, IC_NAME, IC_AMOUNT, IC_REGDATE, IC_SETDATE, IC_STATUS FROM Info_Charge WITH(NOLOCK) WHERE IC_ID='"&Session("SD_ID")&"' AND IC_RegDate >= dateadd(d ,-1, getdate()) AND IC_SITE ='"&JOBSITE&"' AND IC_DEL<>1 AND IC_IDX NOT IN (SELECT TOP " & ((PAGE - 1) * PGSIZE) & " IC_IDX  FROM Info_Charge ORDER BY  IC_RegDate DESC ) ORDER BY IC_RegDate DESC"

    Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
    INPC = sRs.RecordCount
    IF NOT sRs.EOF THEN
        NEXTPAGE = CINT(PAGE) + 1
        PREVPAGE = CINT(PAGE) - 1
    ELSE
        TN = 0
        PGCOUNT = 0
    END If

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
            <!--리스트1 시작-->
      <tr>
        <td align="center" style="height:40px;"><%=IC_IDX%></td>
        <td align="center" class="font_style03"><%=IC_AMOUNT%> 원</td>
        <td align="center"><strong><%=IC_NAME%></strong></td>        
        <td align="center"><%=REPLACE(Left(IC_REGDATE,10),"-","/")%></td>
        <td align="center" class="font_style04"><%=Status%></td>
        <td align="center"><% If IC_STATUS = 1 Then %><a href="javascript:goDel(<%=IC_IDX%>)"><img src="/images/money/cart_x.png"></a><% Else %><% End If %></td>
      </tr>
     <tr>
        <td height="1" colspan="6" bgcolor="#212121"></td>
     </tr>
<%		
    sRS.Movenext
		Next
	ELSE	
%>
       <tr>
        <td colspan="6" style="height:45px; text-align:center; background:#141618;">충전내역이 없습니다.</td>
     </tr>
<%	END IF
	sRs.Close
	Set sRs = Nothing	
	Dber.Dispose
	Set Dber = Nothing 	
%>	

 </tbody></table>
 <table>
 	<tr>
<%	
	IF STARTPAGE = 1 THEN
		Response.Write "<img src='/images/mybet/page_prev.gif' align='absmiddle'> &nbsp;"
	ELSEIF STARTPAGE > SETSIZE THEN
		Response.Write "<img src='/images/mybet/page_prev.gif' align='absmiddle' style='cursor:hand' onclick=javascript:window.self.location.href='/money/charge.asp?PAGE="&NEXTPAGE&"'>&nbsp;"
	END IF 
%>
&nbsp;	
<%	FOR i = STARTPAGE TO SETSIZE + STARTPAGE - 1

	IF i > PGCOUNT THEN
		EXIT FOR
	END IF

	IF PAGE = i THEN
		Response.Write " <a class='now' href=/money/charge.asp?PAGE="&i&" >"& i & "</a>&nbsp;"
	ELSE
		Response.Write " <a class='rest' href=/money/charge.asp?PAGE="&i&" >"& i & "</a>&nbsp;"
	END IF

NEXT 
%>
&nbsp;	
<%	
	IF PGCOUNT < SETSIZE  THEN '현재 페이지가 페이지 셋크기보다 적거나 페이지리스트가 전체페이지보다 적으면
		Response.write "<img src='/images/mybet/page_next.gif'  align='absmiddle'>"
	ELSEIF i > PGCOUNT THEN
		 Response.write "<img src='/images/mybet/page_next.gif'  align='absmiddle' onclick=javascript:window.self.location.href='/money/charge.asp?PAGE="&PREVPAGE&"'>"
	ELSE
		Response.Write "<img src='/images/mybet/page_end.gif'  align='absmiddle' style='cursor:hand' onclick=javascript:window.self.location.href='/money/charge.asp?PAGE="&STARTPAGE+SETSIZE&"'>"
	END IF
%>
 	</tr>
 </table>
<!-- #include file="../_Inc/footer_right.asp" -->