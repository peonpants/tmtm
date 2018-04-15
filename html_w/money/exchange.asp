
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<!-- #include file="../_Inc/clock.asp" -->
<%
mainPage = True
%>
<script type="text/javascript">
    String.prototype.setComma = function()  { 
      var temp_str = String(this); 
      for(var i = 0 , retValue = String() , stop = temp_str.length; i < stop ; i++) retValue = ((i%3) == 0) && i != 0 ? temp_str.charAt((stop - i) -1) + "," + retValue : temp_str.charAt((stop - i) -1) + retValue; 
      return retValue;  }
  
  function inputAmount()  { 
    var exchangeMoney = document.frm1.IE_Amount.value.replace(/,/gi,''); // 불러온 값중에서 컴마를 제거 
      var s = exchangeMoney;
    
    if (s == 0) {  // 첫자리의 숫자가 0인경우 입력값을 취소 시킴  
          document.frm1.IE_Amount.value = ''; 
          return;   }
     
        else { 
            document.frm1.IE_Amount.value = s.setComma(); }}

  var isSubmit = false;

    function FrmChk1() {
  if (!isSubmit)  {
    var frm = document.frm1;
    var curCash = frm.IU_Cash.value;
    
    if (frm.IE_Amount.value == "") {
      alert("환전 신청금액을 입력해 주세요.");
      frm.IE_Amount.value="";
      frm.IE_Amount.focus();
      return; }
    
    if ( parseInt(curCash) == 0 ) {
      alert("환전 가능머니가 없습니다. 확인후 다시 시도해 주세요.");
      frm.IE_Amount.value="";
      return; }
        
    if ( parseFloat(curCash) < parseFloat(frm.IE_Amount.value.replace(/,/gi,'')) )  {
      alert("환전 가능머니보다 환전신청액이 많습니다. 확인후 다시 신청해 주세요.");
      frm.IE_Amount.value="";
      return; }

    if ( parseInt(frm.IE_Amount.value.replace(/,/gi,'')) < 10000 ) {
      alert("환전 신청금액은 10,000원 이상 입력해 주세요.");
      frm.IE_Amount.value="";
      frm.IE_Amount.focus();
      return; }
    
    if ((parseFloat(frm.IE_Amount.value.replace(/,/gi,'')) % 10000) != 0 )  {
      alert("환전 신청은 10,000원 단위로 할 수 있습니다. 확인후 다시 신청해 주세요.");
      frm.IE_Amount.value="";
      frm.IE_Amount.focus();
      return; }

    isSubmit = true;
    frm.action = "Money_Proc.asp";
    frm.submit(); }
  else  {
    alert("처리중입니다. 잠시 기다리세요."); return; }
  }
  
    function goDel(IE_IDX)
    {
        if (!confirm("환전내역을 지우시겠습니까?")) return;
        ProcFrm.location.href = "Money_Proc.asp?EMODE=exc_del&IE_IDX=" + IE_IDX;
    } 
    
    function InputCheck_new( vl)
    {
        var frm = document.frm1;
        
        if(frm.IE_Amount.value == "" || parseInt(vl,10) == 0) frm.IE_Amount.value = 0        
        frm.IE_Amount.value = parseInt(frm.IE_Amount.value,10) +parseInt(vl,10);    
    }

</SCRIPT>
<%  
          '######## 보유 금액을 표시한다  ##############
        Set Dber = new clsDBHelper
        SQL = "SELECT * FROM INFO_USER WHERE IU_ID = ? AND IU_SITE = ?"

        reDim param(1)
        param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
        param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

        Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

        IU_CASH = sRs("IU_CASH")
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
<input type="hidden" name="IU_MOONEY_PW" value="<%=IU_MOONEY_PW%>"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td width="800px" align="left">
          <img src="/images/money/exchange.png" align="absmiddle">
      </td>
      <td width="210px" rowspan="9" valign="top" align="right">
          <div style="position:relative">
          <img src="/images/money/banklist.png" align="absmiddle" style="position:absolute;right:0;top:0px">
          </div>
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
                      주의사항
                  </th>
              </tr>
              <tr>
                  <td align="left" style="text-align: left; padding: 15px 20px">
                      ▶ 24시간 자유롭게 출금이 가능하며 최장 3~5분 소요됩니다.(단, 은행별 점검시간은 은행점검으로 이체가 되지않을수 있습니다.)<br>
                      <br>
                      ▶ 환전은 신청즉시 아이디에서 차감됩니다.<br>
                      <br>
                      ▶ 10분이상 입금이 지연될시 회원님 계좌정보를 잘못 기입한 경우가 많습니다. 그럴경우 고객센터로 계좌정보를 정확히 보내주세요.<br>
                      <br>
                      ▶ 충전금액 100%이상 사용하지 않을시(추가머니차감)환전이 불가합니다.<br>
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
  <tr>
    <td align="center">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" class="noticestyle">
          <tbody>
            <tr>
            <td height="35px" style="text-align: left; padding: 0 20px">
                요청하기
            </td>
            </tr>
            <tr>
              <td align="left" style="text-align: left; padding: 20px">

                ▶ 환전금액 :
                <input name="IE_Amount" type="text" value="0" maxlength="8" id="IE_Amount" onkeyup="inputAmount();" style="color:White;background-color:Black;border-color:#4C4C4C;border-width:1px;border-style:Solid;width:100px;ime-mode: disabled; text-align: right">&nbsp;원
                <img src="/images/money/1.png" id="Img6" alt="1만원" onclick="javascript:InputCheck_new('10000');" align="absmiddle" border="0" style="cursor: pointer">
                <img src="/images/money/3.png" id="Img7" alt="3만원" onclick="javascript:InputCheck_new('30000');" align="absmiddle" border="0" style="cursor: pointer">
                <img src="/images/money/5.png" id="Img8" alt="5만원" onclick="javascript:InputCheck_new('50000');" align="absmiddle" border="0" style="cursor: pointer">
                <img src="/images/money/10.png" id="Img9" alt="10만원" onclick="javascript:InputCheck_new('100000');" align="absmiddle" border="0" style="cursor: pointer">
                <img src="/images/money/50.png" id="Img10" alt="50만원" onclick="javascript:InputCheck_new('500000');" align="absmiddle" border="0" style="cursor: pointer">
                <img src="/images/money/100.png" id="Img12" alt="100만원" onclick="javascript:InputCheck_new('1000000');" align="absmiddle" border="0" style="cursor: pointer">
                &nbsp;
                <img src="/images/money/btn_delete.png" id="Img11" alt="정정" onclick="javascript:InputCheck_new(0);" align="absmiddle" border="0" style="cursor: pointer">
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
          <input type="image" title="환전요청" src="/images/money/exchange1.jpg" onclick="javascript:FrmChk1()" style="border-width:0px;">
      </td>
  </tr>
</tbody>
</table>
</form>
<br>

<table width="100%" style="text-align: center; width: 800px; float: left" class="noticestyle">
  <tbody>
      <tr>
          <th width="5%" height="30">번호</th>
          <th width="25%">환전금액</th>
          <th width="25%">환전일시</th>
          <th width="25%">상태</th>
          <th width="20%">삭제</th>
      </tr>
<% 
    '######## 하루 전 환전 내역을 보여준다  #######
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
      IE_IDX      = sRs(0)
      IE_AMOUNT   = sRs(1)
      IE_REGDATE    = sRs(2)
      IE_STATUS   = CDbl(sRs(3))
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
    <tr>
      <td height="30px">
          <b><font color="#9c9c9c"><b>
              <%=IE_IDX%></b></font>
      </b></td>
      <td>
          <b><font color="#ffe406"><%=IE_AMOUNT%> 원</font></b>
      </td>
      <td>
          <b><font color="#9c9c9c">
              <span id="ctl00_ContentPlaceHolder1_Repeater2_ctl00_lbl_time"><%=REPLACE(Left(IE_REGDATE,10),"-","/")%></span></font></b>
      </td>
      <td>
          <b><font color="#ffffff">
              <input type="hidden" name="ctl00$ContentPlaceHolder1$Repeater2$ctl00$hid_state" id="ctl00_ContentPlaceHolder1_Repeater2_ctl00_hid_state" value="4">
              
              
              <font color="Red"><%=Status%></font>
          </font></b>
      </td>
      <td>
          <b><font color="#ffe406">
		  <% If Status = "환전완료" Or Status = "환전취소" Then %>
              <input type="image"  id="ctl00_ContentPlaceHolder1_Repeater2_ctl00_ibtn_chardel" src="/images/money/cart_x.png" align="absmiddle" onclick="goDel(<%=IE_IDX%>)" style="border-width:0px;">
		  <% End If %>
          </font></b>
      </td>
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
       <td colspan="6" style="height:40px; text-align:center; background:#141618;">출금 내역이 없습니다.</td>
    </tr>
<%  
  END IF
  sRs.Close
  Set sRs = Nothing 
  Dber.Dispose
  Set Dber = Nothing  
%>  
    </tbody></table>
  
<!-- #include file="../_Inc/footer_right.asp" -->