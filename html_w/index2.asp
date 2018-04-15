
<%
Response.Expires = 0
Response.AddHeader "Pragma" , "no-cache"
Response.AddHeader "Cache-Control" , "no-cache,must-revalidate"
REMOST_HOST = Request.ServerVariables("PATH_INFO")
%>
<!-- #include file="../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../_Common/Lib/Request.class.asp" -->
<!-- #include file="../_Common/Api/sql_injection.asp" -->
<!-- #include file="../_Conf/Common.Conf.asp" -->
<!-- #include file="../_Lib/SiteUtil.Class.asp" -->
<%
IF Session("SD_ID") <> "" THEN
    IF SITE_MAIN_USE Then
        response.Redirect("/main.asp")
    Else
        response.Redirect("/Game/BetGame.asp")
    End IF        
End IF

Set Dber = new clsDBHelper
	SQL = "UP_GetSET_SITE_OPEN"
		
	Set sRs = Dber.ExecSPReturnRS(SQL,nothing,nothing)
	SITE_OPEN = sRs("SITE_OPEN")
SET sRs = Nothing
SET Dber = Nothing	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" ""><HTML><HEAD><META 
content="IE=5.0000" http-equiv="X-UA-Compatible">
 
<META http-equiv="Content-Type" content="text/html; charset=ks_c_5601-1987"> 
<TITLE><%=site_title%></TITLE> <LINK href="Star%20King_files/style97YPOGL1.css" rel="stylesheet" 
type="text/css"> <LINK href="Star%20King_files/style_button.css" rel="stylesheet" 
type="text/css">
<SCRIPT language="javascript">
    function setPng24(obj) {
        obj.width=obj.height=1;
        obj.className=obj.className.replace(/\bpng24\b/i,'');
        obj.style.filter ="progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');";
        obj.src='';
        return '';
    }
	
	function LoginFrmChk() 
	{
		var frm = document.LoginFrm;
		if ((frm.IU_ID.value.length < 4))	
		{
			alert("회원님의 ID를 입력해 주세요");
			return false;	
		}
		
		if ((frm.IU_PW.value == "") || (frm.IU_PW.value.length < 4))	
		{
			alert("회원님의 패스워드를 입력해 주세요.");
			frm.IU_PW.focus();
			return false;	        
		}

		frm.action = "/Login/index.asp";
		frm.submit();
	}
</SCRIPT>

<SCRIPT src="Star%20King_files/common.js" type="text/javascript"></SCRIPT>

<SCRIPT src="Star%20King_files/jquery-1.4.2.min.js" type="text/javascript"></SCRIPT>

<SCRIPT>
!window.jQuery && document.write('<script type=\"text/javascript\" src=\"/js/jquery-1.4.2.min.js\"><\/script>');
</SCRIPT>

<SCRIPT type="text/javascript">var $j = jQuery.noConflict(); jQuery.ajaxSetup({cache:false});</SCRIPT>

<SCRIPT src="Star%20King_files/ajax.js" type="text/javascript"></SCRIPT>

<SCRIPT src="Star%20King_files/wz_tooltip.htm" type="text/javascript"></SCRIPT>

<SCRIPT src="Star%20King_files/showid.js" type="text/javascript"></SCRIPT>

<META name="GENERATOR" content="MSHTML 11.00.9600.18098"></HEAD> 
<BODY topmargin="0" leftmargin="0" ondragstart="return false" onselectstart="return false" 
oncontextmenu="return false" bgcolor="white" marginheight="0" marginwidth="0"><A 
name="g4_head"></A> 
<STYLE type="text/css">

    body {
        background: url("/images/login/login_bg.jpg") scroll center top #000;
        margin: 0;
    }
    .notice_all {
                        color:#f7f7f7;
                        height:60px;
                        line-height:60px;
                        width:100%;
                        clear:both;
                        position:relative;
                        overflow-y:hidden;
                    }

</STYLE>
 
<FORM name="LoginFrm">
<DIV style="width: 100%; margin-top: 300px; position: relative;">
<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
  <TBODY>
  <TR>
    <TD style="width: 100%;">
      <TABLE width="650" height="60" align="center" style='padding: 0px; border-radius: 10px; border: 2px solid rgb(17, 17, 17); border-image: none; display: none; background-image: url("/images/newskin2/ttbg.png"); background-attachment: scroll; background-repeat: repeat; -moz-border-radius: 10px 10px 10px 10px; -webkit-border-radius: 10px 10px 10px 10px;' 
      border="0" cellspacing="0" cellpadding="0" valign="bottom">
        <TBODY>
        <TR>
          <TD>       					 
<STYLE>
					
					</STYLE>
</TD></TR></TBODY></TABLE>
      <TABLE align="center" border="0" cellspacing="0" cellpadding="0">
        <TBODY>
        <TR>
          <TD align="center"><IMG src="/images/login/login_logo.gif">
          				 </TD></TR>
		<tr>
			<td height="20">&nbsp;</td>
		</tr>
</TBODY></TABLE>
      <TABLE align="center" style="background: rgb(0, 0, 0); border-radius: 15px; border: 2px solid rgb(0, 0, 0); border-image: none; opacity: 0.7; -moz-border-radius: 15px 15px 15px 15px; -webkit-border-radius: 15px 15px 15px 15px; -moz-opacity: 0.7;" 
      border="0" cellspacing="0" cellpadding="0">
        <TBODY>
        <TR>
          <TD>
            <TABLE align="center" style="padding: 20px 35px 20px 40px; border-radius: 15px; border: 1px solid rgb(34, 34, 34); border-image: none; position: relative; -moz-border-radius: 15px 15px 15px 15px; -webkit-border-radius: 15px 15px 15px 15px;" 
            border="0" cellspacing="0" cellpadding="0">
              <TBODY>
              <TR>
                <TD><IMG style="margin-right: 8px; float: right;" src="images/login/ID.png">
                  							 </TD>
                <TD><INPUT name="IU_ID" tabindex="1" id="IU_ID" style="background: rgb(255, 255, 255); padding: 4px; border: 1px solid rgb(102, 102, 102); border-image: none; width: 150px; height: 28px; color: black; font-weight: bold;" type="text"></TD>
                <TD><IMG style="margin: 0px 8px 0px 20px; float: right;" src="images/login/PW.png">
                  							 </TD>
                <TD><INPUT name="IU_PW" tabindex="2" id="IU_PW" style="background: rgb(255, 255, 255); padding: 4px; border: 1px solid rgb(102, 102, 102); border-image: none; width: 150px; height: 28px; color: black; font-weight: bold;" type="password">
                  							 </TD>
                <td width="100">
                    <input type="image" name="ibtn_login" tabindex="3" src="images/login/btn_login.jpg" onclick="LoginFrmChk()" style="border-width:0px;">
                </td>
                <td width="100">
                    <a href="/member/join_Chack.asp"><img src="images/login/btn_01.jpg" style="border-width:0px;" alt="회원가입"></a>
				</td>
			  </TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
      <TABLE align="center" border="0" cellspacing="0" cellpadding="0">
        <TBODY>
        <TR>
          <TD>
            <DIV style="margin: 25px 0px 0px; color: rgb(255, 255, 255); font-family: arial; font-size: 11pt; font-weight: bold;">Copyright ⓒ 2010 <%=SITE_TITLE%> All rights reserved.</DIV></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></DIV></FORM>
 </BODY></HTML>
