
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../_Inc/top.asp" -->

<% 
   Set Dber = new clsDBHelper
   SQL = "select IU_NICKNAME, IU_MOBILE, IU_EMAIL, IU_BANKNAME, IU_BANKNUM, IU_BANKOWNER from info_user where iu_id = '"&Session("SD_ID")&"' and iu_site = '"& JOBSITE &"'"
    
    nowURL = Request.ServerVariables("url")
    reDim param(1)
    param(0) = Dber.MakeParam("@iu_id",adVarWChar,adParamInput,20,Session("SD_ID"))
    param(1) = Dber.MakeParam("@jobstite",adVarWChar,adParamInput,20,JOBSITE)

    Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

    IU_NICKNAME = sRs("IU_NICKNAME")
    IU_MOBILE = sRs("IU_MOBILE")
    IU_EMAIL = sRs("IU_EMAIL")
    IU_BANKNAME = sRs("IU_BANKNAME")
    IU_BANKNUM = sRs("IU_BANKNUM")
    IU_BANKOWNER = sRs("IU_BANKOWNER")

  sRs.close
  Set sRs = Nothing
%>

<div id="contents_wrap">
<div style="height:60px; border-bottom:2px solid #1c2126">
  <table width="1200px;" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#c8100a">
     <tbody><tr>
     <td width="10%" height="60" align="center" bgcolor="#000000"><a href="info.asp"><span class="font_style04">충전내역</span></a></td>
         <td width="10%" align="center" ><a href="exchangelist.asp"><span class="font_style01">환전내역</span></a></td>
         <td width="10%" align="center" bgcolor="#000000"><a href="mybet.asp"><span class="font_style04">배팅내역</span></a></td>
         <td width="10%" align="center" bgcolor="#000000"><a href="CashLog.php"><span class="font_style04">캐쉬내역</span></a></td>
         <td width="10%" align="center" bgcolor="#000000"><a href="myPointLog.php"><span class="font_style04">포인트내역</span></a></td>
         <td width="10%" align="center" bgcolor="#000000"><a href="myrecom.asp"><span class="font_style04">추천인</span></a></td>
  </tr>
   </tbody></table>
</div>
<div style="padding-top:30px;">
<table width="1200" border="0" cellpadding="0" cellspacing="0" align="center">
    <tbody><tr>
      <td height="40"><span class="page_title">마이페이지</span></td>
      <td class="menuH" align="right" style="padding-right:10px;">
    <span class="sports_r_title">Home</span> 
    <span class="sports_r_title" style="color:#9e1814;font-weight:bold;">&gt;</span>
        
        <span class="sports_r_title">마이페이지</span> 
    <span class="sports_r_title" style="color:#9e1814;font-weight:bold;">&gt;</span>
            <span style="color:#9e1814;">환전내역</span>
    </td>
    </tr>
 </tbody></table>
 </div>
  <div class="contents_box">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tbody><tr>
  <td class="rtitle">환전내역</td>
</tr>
</tbody></table>
<div style="padding-top:20px;"></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tbody><tr>
    <td>
      <table width="1200" border="0" cellpadding="0" cellspacing="0" style="background:url(/images/info_bgbg.gif); height:236px;">
        <tbody><tr>
          <td>
            <table border="0" cellpadding="0" cellspacing="0" width="400" align="center">
              <tbody><tr>
                <td style="padding:0 0 30px 0; color:#dedede; font-size:14px; font-family:dotum; text-align:center; background:url(/images/tit_line.gif) center bottom no-repeat;">현재 보유캐쉬</td>
              </tr>
              <tr>
                <td style="padding-top:30px; text-align:center;color:#737373; font-size:14px;"><span class="txt_yellow38b"><%=formatnumber(IU_Cash,0)%></span></td>
              </tr>
            </tbody></table>
          </td>
          <td>
            <table border="0" cellpadding="0" cellspacing="0" width="400" align="center">
              <tbody><tr>
                <td style="padding:0 0 30px 0; color:#dedede; font-size:14px; font-family:dotum; text-align:center; background:url(/images/tit_line.gif) center bottom no-repeat;">현재 보유포인트</td>
              </tr>
              <tr>
                <td style="padding-top:30px; text-align:center;color:#737373; font-size:14px;"><span class="txt_skyblue38b"><%=formatnumber(IU_Point,0)%></span></td>
              </tr>
            </tbody></table>
          </td>
          <td>
            <table border="0" cellpadding="0" cellspacing="0" width="400" align="center">
              <tbody><tr>
                <td style="padding:0 0 30px 0; color:#dedede; font-size:14px; font-family:dotum; text-align:center; background:url(/images/tit_line.gif) center bottom no-repeat;">추천인 현황</td>
              </tr>
              <tr>
                <td style="padding-top:30px; text-align:center; color:#737373; font-size:14px;"><span class="txt_orange38b">0</span></td>
              </tr>
            </tbody></table>
          </td>
        </tr>
      </tbody></table>
    </td>
  </tr>
</tbody></table>
<div style="height:20px;"></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tbody><tr>
      <td height="3" colspan="5" bgcolor="#c8100a"></td>
    </tr>
    <tr>
      <td width="10%" height="40" align="center" bgcolor="#1d2023" style="color:#c8100a; font-weight:bold;">번호</td>
        <td width="10%" height="40" align="center" bgcolor="#1d2023" style="color:#c8100a; font-weight:bold;">금액</td>
        <td width="10%" height="40" align="center" bgcolor="#1d2023" style="color:#c8100a; font-weight:bold;">날짜</td>
        <td width="10%" height="40" align="center" bgcolor="#1d2023" style="color:#c8100a; font-weight:bold;">이름</td>
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
      <td height="1" colspan="5" bgcolor="#292e32"></td>
    </tr>
         <tr>
         <td height="40" bgcolor="#151719" align="center" class="font_style04"><%=IE_IDX%></td>
         <td align="center" bgcolor="#151719"><%=IE_AMOUNT%></td>
         <td align="center" bgcolor="#151719"><%=REPLACE(Left(IE_REGDATE,10),"-","/")%></td>
         <td align="center" bgcolor="#151719" class="font_style04"><%=IU_BANKOWNER%></td>
   </tr>
   <tr>
         <td height="1" colspan="5" bgcolor="#292e32"></td>
   </tr>
<%    
    sRS.Movenext
    Next
  ELSE  
%>
      <tr>
        <td colspan="6" style="height:45px; text-align:center; background:#141618;">환전전내역이 없습니다.</td>
     </tr>
<%  END IF
  sRs.Close
  Set sRs = Nothing 
  Dber.Dispose
  Set Dber = Nothing  
%>  

                  </tbody></table>
<div style="text-align:center; padding-top:20px;"><table width="100%" cellpadding="0" cellspacing="0" border="0">
<tbody><tr>
<td><a href="exchangelist.asp?table=&amp;page=1&amp;c_game_type=0"><span class="page">이전</span></a>
<span class="page_on"> 1 </span>&nbsp;<a href="exchangelist.asp?table=&amp;page=1&amp;c_game_type=0"><span class="page">다음</span></a>
</td>
</tr>
</tbody></table></div>
<div style="height:100px;"></div>
</div>
</div>