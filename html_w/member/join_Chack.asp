<%

Response.Expires = 0
Response.AddHeader "Pragma" , "no-cache"
Response.AddHeader "Cache-Control" , "no-cache,must-revalidate"

REMOST_HOST = Request.ServerVariables("PATH_INFO")


%>
<%
    IF Session("SD_ID") <> "" THEN
        response.Redirect("/game/betGame.asp")
    End IF
%>
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<%
Set Dber = new clsDBHelper
	SQL = "UP_GetSET_SITE_OPEN"
		
	Set sRs = Dber.ExecSPReturnRS(SQL,nothing,nothing)
	SITE_OPEN = "2"
SET sRs = Nothing
SET Dber = Nothing	

IF cStr(SITE_OPEN) = "4" Then
%>
    <script type="text/javascript">
    alert("페이지에 접근할 수 없습니다.");
    location.href = "/"
    </script>
<%
    response.end
End IF
IF cStr(SITE_OPEN) = "1" Then
    response.Redirect("join.asp")  
    response.end
End IF


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<!-- saved from url=(0033)http://cl-79.com/frmRecommend.asp -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><HTML 
xmlns="http://www.w3.org/1999/xhtml"><HEAD><META content="IE=11.0000" 
http-equiv="X-UA-Compatible">
 
<META http-equiv="Content-Type" content="text/html;"> <TITLE><%=site_name%></TITLE> 
<LINK href="/css/join.css" rel="stylesheet" type="text/css"> 
<STYLE type="text/css">
	html {
		font-size: 12px;
		padding-top: 100px;
	}
	body {
		color: #ddd;
		background: #000;
	}
	h2 {
		padding: 10px 0 10px 15px;
		color: #FC0;
		font-weight: bold;
		background-color: black;
		margin: 21px;
	}
	table {
		width: 800px;
		margin: 0 auto;
		border: 1px solid #111;
	}
	td.text01 {
		font-weight: bold;
		background-color: #282828;
		border-top: #3E3E3E solid 1px;
		border-left: #3E3E3E solid 1px;
		color: #AAA;
		width: 104px;
		font-size: 12px;
		padding-left: 12px;
	}
	td.text02 {
		padding: 5px;
		line-height: 28px;
		background-color: #333;
		border-top: #484848 solid 1px;
		border-left: #484848 solid 1px;
	}
</STYLE>

 <meta name="viewport" content="width=1000">
<META name="GENERATOR" content="MSHTML 11.00.9600.18698"></HEAD> 
<BODY id="top">
<form name="recomForm" target="ProcFrm" method="post" action="/member/MemberJoinCheck.asp" onsubmit="return checkRecomForm(this);" > 
<script type="text/javascript">
function checkRecomForm(frm)
{
	if ((frm.RECOM_ID.value.length == 0) || (frm.RECOM_ID.value.length < 3) || (frm.RECOM_ID.value.length > 12)) 
	{
		alert("추천인 아이디를 정확히 넣어주세요.\n아이디는 3~12까지만 입력이 가능합니다.");
		frm.RECOM_ID.value = "";
		frm.RECOM_ID.focus();
		return false;
	}
	else if (EnNumCheck(frm.RECOM_ID.value) == false) 
	{
		alert("아이디는 공백없이 영어와 숫자로만 입력이 가능합니다.");
		frm.RECOM_ID.value = "";
		frm.RECOM_ID.focus();
		return false;
	}
<% IF SITE_OPEN = "3" Then %>  
	else if(frm.RECOM_CODE.value.length != 6) 
	{
		alert("추천코드는 6자리입니다.");
		frm.RECOM_CODE.value = "";
		frm.RECOM_CODE.focus();
		return false;                        
	}
<% End IF %>                                  
}
</script>
<DIV id="sub-area" style="width: 100%;">
<DIV style="margin: 0px auto; width: 840px; border-top-color: rgb(65, 65, 65); border-left-color: rgb(65, 65, 65); border-top-width: 1px; border-left-width: 1px; border-top-style: solid; border-left-style: solid; background-color: rgb(32, 32, 32);">
<H2>■ 추천인 입력</H2>
<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
  <TBODY>
  <TR>
    <TD align="left" class="text01"><STRONG>추천 코드</STRONG></TD>
    <TD height="30" align="left" class="text02"><INPUT name="RECOM_ID" class="bg_input" style="background: rgb(68, 68, 68); padding: 4px; border: 1px solid rgb(85, 85, 85); border-image: none; width: 200px; color: rgb(242, 242, 242); font-size: 12px;" type="text" size="20"></TD></TR></TBODY></TABLE>
<DIV style="padding: 20px 0px; width: 100%; text-align: center;"><SPAN id="btnSubmit"><INPUT width="70" height="33" type="image" src="/images/join/vo.gif"></SPAN>
		 </DIV></DIV></DIV></FORM></BODY></HTML>
	  <iframe name="HiddenFrm" src="/Blank.html" frameborder="0" width="0" height="0" frameborder="0"></iframe>
<iframe name="ProcFrm" src="/Blank.html" frameborder="0" width="0" height="0" frameborder="0"></iframe>