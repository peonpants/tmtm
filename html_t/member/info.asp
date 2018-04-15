
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<% 
   Set Dber = new clsDBHelper
		SQL = "UP_INFO_USER_CHK"
		nowURL = Request.ServerVariables("url")
		reDim param(1)
		param(0) = Dber.MakeParam("@iu_id",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@jobstite",adVarWChar,adParamInput,20,JOBSITE)

		Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

		IU_NICKNAME = sRs("IU_NICKNAME")
		IU_MOBILE = sRs("IU_MOBILE")
		IU_EMAIL = sRs("IU_EMAIL")
		IU_BANKNAME = sRs("IU_BANKNAME")
		IU_BANKNUM = sRs("IU_BANKNUM")
		IU_BANKOWNER = sRs("IU_BANKOWNER")

	sRs.close
	Set sRs = Nothing
%>
<STYLE type="text/css">
	table#info_table td {
		line-height: 25px;
		border-bottom: 1px solid #333;
		border-right: 1px solid #444;
		padding: 4px 0 4px 12px;
	}
	table#info_table td.titletext {
		background: #111;
	}
	.chargetable2 tr td {text-align:left;padding-left:30px;}
</STYLE>
 
<DIV id="sub-area">
<DIV class="subbody">
<DIV id="sub-content">
<DIV class="game_view dark_radius game_title white">마이페이지 <SPAN>MYPAGE</SPAN>
			 </DIV>
<DIV class="chargecon">
<DIV style="font-size: 14px; font-weight: bold; margin-bottom: 20px;"><font color="red">회원정보 변경 및 
문의는 고객센터를 이용하시기 바랍니다.</DIV>
<TABLE class="chargetable chargetable2">
  <TBODY>
  <TR>
    <TH width="20%">아이디</TH>
    <TD 
    style="text-align: left; padding-left: 30px;"><STRONG><%=Session("SD_ID")%></STRONG></TD></TR>

  <TR>
    <TH width="20%">이름						 
    <TD align="left"><FONT color="#000" size="2"><B><%=IU_BANKOWNER%></B></FONT>
      <SPAN style="color: rgb(101, 101, 101);"></SPAN></TD></TR>
  <TR>
    <TH width="20%">거래은행						 
    <TD align="left"><FONT color="#000" size="2"><B><%=IU_BANKNAME%></B></FONT></TD></TR>
  <TR>
    <TH width="20%">계좌번호						 
    <TD><FONT color="#000" size="3"><B>****(계좌번호는 고객센터에서만 보관하고있습니다)</B></FONT><SPAN style="color: rgb(101, 101, 101);"></SPAN>						 </TD></TR>
  <TR>
    <TH width="20%">닉네임</TH>
    <TD align="left"><FONT color="#000" size="2"><B><%=Session("IU_NickName")%></B></FONT>
							 <INPUT name="mb_nick" class="bg_input" id="mb_nick" type="hidden" size="25">
      							 <SPAN id="msg_mb_nick"></SPAN> 						</TD></TR>
  <TR>
    <TH width="20%">연락처</TH>
    <TD align="left"><FONT color="#000" size="2"><B>* 연락처 변경은 1:1고객문의에 문의하시기 바랍니다.</B></FONT>
      <SPAN style="color: rgb(101, 101, 101);"></SPAN>
    						 </TD></TR></TBODY></TABLE></DIV>

      				 </TD></TR></TBODY></TABLE></DIV>
<DIV></DIV></DIV>

<!-- #include file="../_Inc/footer.asp" -->