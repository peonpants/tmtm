
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../_Inc/top.asp" -->

<% 
  SB_BETTINGMIN = Session("SB_BETTINGMIN")
  SB_BETTINGMAX = Session("SB_BETTINGMAX")
  SB_BENEFITMAX = Session("SB_BENEFITMAX")
  last_charged = "--"
 Set Dber = new clsDBHelper
 SQL = "Select top 1 IC_REGDATE FrOM INFO_CHARGE WHERE IC_ID='"&Session("SD_ID")&"' ORDER BY IC_REGDATE DESC"

  Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)
  If not sRs.Eof then
    lc = sRs(0)
    last_charged= (month(lc)) &"-"&(day(lc))

  End If
  sRs.close
  Set sRs = Nothing
%>
<img src="/images/mypage/mypage2.png" align="absmiddle" width="100%">
<div style="text-align: right; margin: 10px 12px">
  <a href="/member/info.asp"><img src="/images/mypage/info_011_on.jpg" border="0"></a>
    <a href="MyRecom.asp"><img src="/images/mypage/info_031.jpg" border="0"></a>
    <a href="mybet.asp"><img src="/images/mypage/info_041.jpg" border="0"></a>
</div>
<table width="100%" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse; color: white" class="board_view">
    <tbody>
        <tr>
            <th width="15%">닉네임</th>
            <td width="18%">
                <span id="ctl00_ContentPlaceHolder1_lbl_name"><%=iu_nickname%></span></td>
            <th width="15%">레벨</th>
            <td width="18%">
                <span id="ctl00_ContentPlaceHolder1_lbl_level"><%=iu_level%></span></td>
            <th width="15%">가입일</th>
            <td width="18%">
                <span id="ctl00_ContentPlaceHolder1_lbl_register"><%=dfSiteUtil.GetBetDate(IU_REGDATE)%></span></td>
        </tr>
        <tr>
            <th>캐시</th>
            <td><span id="ctl00_ContentPlaceHolder1_lbl_cash"><%=IU_CASH%> 원</span></td>
            <th>포인트</th>
            <td><span id="ctl00_ContentPlaceHolder1_lbl_point"><%=IU_Point%> 점</span></td>
            <th>마지막 충전일</th>
            <td><span id="ctl00_ContentPlaceHolder1_lbl_lastcharge"><%=last_charged%></span></td>
        </tr>
        <tr>
            <th>최소 배팅금액</th>
            <td><span id="ctl00_ContentPlaceHolder1_lbl_minbet"><%=SB_BETTINGMIN%> 원</span></td>
            <th>최대 배팅금액</th>
            <td><span id="ctl00_ContentPlaceHolder1_lbl_maxbet"><%=SB_BETTINGMAX%> 원</span></td>
            <th>1회 최대 당첨금액</th>
            <td><span id="ctl00_ContentPlaceHolder1_lbl_maxwin"><%=SB_BENEFITMAX%> 원</span></td>
        </tr>
    </tbody>
</table>

<img src="/images/mypage/pointlist.png" alt="" style="margin: 17px 0 5px 10px; float: left">
<table id="ctl00_ContentPlaceHolder1_lv_usepoint_Table1" width="100%" align="center" cellspacing="0" cellpadding="0" class="noticestyle" style="margin: 0">
  <tbody>
    <tr>
    <th width="8%" height="35px">번호</th>
    <th width="18%">포인트</th>
    <th width="36%">내역</th>
    <th width="20%">등록일시</th>
</tr>
<%  
  SQL = "UP_RetrieveLOG_POINTINOUTByBounus"
  
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
        
        LP_POINT = sRs(0)
        LP_COMMENTS = sRs(1)
        If Right(lp_comments,8) = "의배팅낙첨포인트" Then
        lp_comments = "추천지인의" & Right(lp_comments,8)
        End if
        LP_DATE = sRs(2)
        LP_GPOINT = sRs(3)
%>

  <tr align="center" style="color: white">
      <td height="30px" width="8%"><%=RE%></td>
      <td width="18%"><%=LP_POINT%></td>
      <td width="36%"><%=LP_COMMENTS%></td>
      <td width="20%"><%=dfSiteUtil.GetBetDate(LP_DATE)%></td>
  </tr>
  
<%    
        sRs.MoveNext
      NEXT            
    END IF  
  END IF
%>  
</tbody>
</table>
<!-- #include file="../_Inc/footer_right.asp" -->