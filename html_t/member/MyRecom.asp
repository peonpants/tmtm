<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<img src="/images/mypage/recommend2.png" align="absmiddle" width="100%">
<div style="text-align: right; margin: 15px 15px">
  <a href="/member/info.asp"><img src="/images/mypage/info_011.jpg" border="0"></a>
    <a href="MyRecom.asp"><img src="/images/mypage/info_031_on.jpg" border="0"></a>
    <a href="mybet.asp"><img src="/images/mypage/info_041.jpg" border="0"></a>
</div>
<table id="ctl00_ContentPlaceHolder1_lv_usepoint_Table1" width="100%" align="center" cellspacing="0" cellpadding="0" class="noticestyle">
  <tbody>
    <tr>
        <th width="10%" height="40px">번호</th>
        <th width="35%">아이디</th>
        <th width="35%">닉네임</th>
        <th width="20%">가입일</th>
    </tr>
<%
  Set Dber = new clsDBHelper

  '######## 최근 추천한 회원
  SQL = "UP_RetrieveINFO_USERByRecomID1"
  
  reDim param(0)
  param(0) = Dber.MakeParam("@iu_id",adVarWChar,adParamInput,20,Session("SD_ID"))
  Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
  INPC = sRs.RecordCount

  If Not sRs.EOF THEN
    IF NOT sRs.Eof Then
      For RE = 1 TO INPC
         
        IF sRs.EOF THEN
          EXIT FOR
        END IF
        IU_ID= sRs(2)
        LR_Name = sRs(4)
        regDT = sRs(11)
        IU_POINT = sRs(22)
%>
    <tr align="center">
      <td height="30px" width="10%">1</td>
      <td width="35%"><%=IU_ID%></td>
      <td width="35%"><%=LR_Name%></td>
      <td width="20%"><%=dfSiteUtil.GetBetDate(regDT)%></td>
    </tr>
<%    
            sRs.MoveNext
      NEXT            
    END IF  
  ELSE  
%> 
    <tr>
      <td align="center" colspan="10"><font color="ffffff">추천한 회원내역이 존재하지않습니다.</font></td>
    </tr>
<%    
  End IF
  sRs.close
  Set sRs = Nothing
%>  
  </tbody>
</table>

<!-- #include file="../_Inc/footer.asp" -->