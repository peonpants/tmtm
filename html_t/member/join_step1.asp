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

IF Session("IMAGE_URL") = "" Then
    Session("IMAGE_URL") = SITE_IMAGE_URL
End IF

Set Dber = new clsDBHelper
	SQL = "UP_GetSET_SITE_OPEN"
		
	Set sRs = Dber.ExecSPReturnRS(SQL,nothing,nothing)
	SITE_OPEN = sRs("SITE_OPEN")
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
<head>
<TITLE><%= SITE_TITLE %></TITLE>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta name="keywords" content="<%= SITE_DESC %>">
<meta name="Description" content="<%= SITE_DESC %>">
<link rel="stylesheet" href="<%= Session("IMAGE_URL") %>/css/stylesheet.css" type="text/css">
<script language="javascript" type="text/javascript" src="/js/flash.js"></script>
<script language="javascript" type="text/javascript" src="/js/menu_link.js"></script>
<script language="javascript" type="text/javascript" src="/js/func.js"></script>
<script language="javascript" type="text/javascript" src="/js/scroll2.js"></script>
<script language="javascript" type="text/javascript" src="/js/ajax.js" ></script>
<script language="javascript" type="text/javascript" src="/js/function.js" ></script>
<script language="javascript" type="text/javascript" src="/js/Base.js"></script>
</head>
<body  topmargin="0" topmargin="0" oncontextmenu="return false" ondragstart="return false" onselectstart="return false"> 

<!-- 전체 레이아웃 -->
<iframe name="HiddenFrm" src="/Blank.html" frame width="0" height="0"></iframe>
<iframe name="ProcFrm" src="/Blank.html" frame width="0" height="0"></iframe>
<table width="100%" cellpadding=0 cellspacing=0>
<tr>
	<td align="center" valign="top">
	<!-- 실제 레이아웃 -->
	<table WIDTH=1024  cellpadding=0 cellspacing=0 align="center">
	<tr>
		<td align="center"  height="29">
		
			
					
		</td>
	</tr>
	<tr>
		<td valign="top" align="center"   height="61">
			
		</td>
	</tr>
	<tr>
	    <td height="50"></td>
	</tr>
	<tr>
		<td valign="top" align="center" height="600" width="780">
<%
    '---------------------------------------------------------
    '   @Title : 회원 가입 페이지
    '   @desc  : 회원가입을 위한 페이지(중복 체크 모듈 및 UI단 자바스크립트)
    '---------------------------------------------------------
%>
 <table width="100%" height="620"  cellspacing="3" cellpadding="10" class="baord_table_bg">
        <tr>
            <td class="trIngGame" valign="top"> 	
			<table width="100%" cellpadding="0" cellspacing="0" >
			<tr><td height="10"></td></tr>
			
			<tr>
			<td> <div id="st_13"></div>	
			</td>
			</tr>
			<tr><td height="10"></td></tr>
			
		
			<tr>
			<td style="padding:10 10 10 10;">







<!-- 바디 시작 -->
<table  cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td class="trIngGame">
            <table align="center"  cellpadding="0" cellspacing="0" width="760">
                
                <tr>
                    <td height="50" align="center">
                    <script type="text/javascript">
                    function checkRecomForm(frm)
                    {
                        if ((frm.RECOM_ID.value.length == 0) || (frm.RECOM_ID.value.length < 4) || (frm.RECOM_ID.value.length > 12)) 
                        {
                            alert("추천인 아이디를 정확히 넣어주세요.\n아이디는 4~12까지만 입력이 가능합니다.");
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
                    <% IF SITE_OPEN = "1" Then %>
                        <a href="/member/join.asp"><img src="<%= Session("IMAGE_URL") %>/sub/member_agree02.gif" /></a>
                        <img src="<%= Session("IMAGE_URL") %>/sub/member_notagree01.gif" onclick="alert('이용해주셔서 감사합니다.');location.href='/'" style="cursor:pointer;" />
                    <%
                        ElseIF SITE_OPEN = "2" Then 
                    %>
                        <form name="recomForm" target="ProcFrm" method="post" action="/member/MemberJoinCheck.asp" onsubmit="return checkRecomForm(this);" > 
                        <table  cellpadding="5" cellspacing="1" width="100%" class="baord_table_bg">                            
                            <tr>
                                <td class="trEndGame" align="center">회원 아이디</td>                    
                                <td class="trEndGame">
                                    <input type="text" name="RECOM_ID"  class="input_01" maxlength="20" />                        
                                    <input type="image" src="<%= Session("IMAGE_URL") %>/sub/btn_Board_Write.gif"  align="absmiddle">
                                    &nbsp;<a href="javascript:location.href = '/'" onfocus="this.blur();"><img src="<%= Session("IMAGE_URL") %>/sub/btn_b_cancel.gif"  align="absmiddle"></a>
                                </td>
                            </tr>
                        </table>                                                            
                        </form>
                    <%      
                        ElseIF SITE_OPEN = "3" Then 
                    %>
                        <form name="recomForm" target="ProcFrm" method="post" action="/member/MemberJoinCheck.asp" onsubmit="return checkRecomForm(this);" >                        
                        <table  cellpadding="5" cellspacing="1" width="100%" class="baord_table_bg">                            
                            <tr>
                                <td class="trEndGame" align="center">추천인</td>                    
                                <td class="trEndGame">
                                    <input type="text" name="RECOM_ID"  class="input_01" maxlength="20" />                        
                                </td>
                            </tr>
                            <tr>
                                <td class="trEndGame" align="center">추천코드</td>                    
                                <td class="trEndGame">
                                    <input type="text" name="RECOM_CODE"  class="input_01" maxlength="6" />                                                            
                                </td>
                            </tr>                            
                        </table>                   
                        <br />                                         
                        <input type="image" src="<%= Session("IMAGE_URL") %>/sub/btn_Board_Write.gif"  align="absmiddle">
                        &nbsp;<a href="javascript:location.href = '/'" onfocus="this.blur();"><img src="<%= Session("IMAGE_URL") %>/sub/btn_b_cancel.gif"  align="absmiddle"></a>
                        </form>                    
                    <%      
                        ElseIF SITE_OPEN = "5" Then 
                    %>
                        <form name="recomForm" target="ProcFrm" method="post" action="/member/MemberJoinCheck.asp" onsubmit="return checkRecomForm(this);" >                        
                        <table  cellpadding="5" cellspacing="1" width="100%" class="baord_table_bg">                            
                            <tr>
                                <td class="trEndGame" align="center">핸드폰번호</td>                    
                                <td class="trIngGame">
                                    <input type="text" name="IU_Mobile1"  class="input_01" size="5" maxlength="3" />-
                                    <input type="text" name="IU_Mobile2"  class="input_01" size="5" maxlength="4" />-                       
                                    <input type="text" name="IU_Mobile3"  class="input_01" size="5" maxlength="4" />                        
                                </td>
                            </tr>
                            <tr>
                                <td class="trEndGame" align="center">추천코드</td>                    
                                <td class="trIngGame">
                                    <input type="text" name="RECOM_CODE"  class="input_01" maxlength="6" />  
                                    <br />
                                    추천코드는 6자리이며 혹 7자리 인증번호 받으신 분도 6자리 입력시 정상적으로 가입되십니다.                                                          
                                </td>
                            </tr>                            
                        </table>     
                        <br />        
                        <table  cellpadding="5" cellspacing="1" width="100%">                            
                            <tr>
                                <td  align="center">                                               
                        <input type="image" src="<%= Session("IMAGE_URL") %>/sub/btn_Board_Write.gif"  align="absmiddle">
                        &nbsp;<a href="javascript:location.href = '/'" onfocus="this.blur();"><img src="<%= Session("IMAGE_URL") %>/sub/btn_b_cancel.gif"  align="absmiddle"></a>
                        </form>                            
                                </td>
                            </tr>
                        </table>                                                            
                    <%                        
                        End IF
                    %>                        
                    </td>
                </tr>

            </table>
        </td>
    </tr>
</table>

                    </table>
</td>
                </tr>
            </table>
</td>
                </tr>
            </table>       
	</td>
</tr>

</table>
<!-- 전체 레이아웃 -->
</body>
</html>
