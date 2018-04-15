<%
IF Session("SD_ID") <> "" THEN
    Set Dberp = new clsDBHelper
	SQL = "SELECT * FROM POPOP02 where p_yn='Y' and (p_site LIKE 'DUMP%') order by p_idx desc"
	Set sRsp = Dberp.ExecSQLReturnRS(SQL,nothing,nothing)
	
	nn = 0
    strOnmousemove = ""
	Do While Not sRsp.eof 
	    nn = nn + 1
    	
	    P_SUB		= sRsp("P_SUB")
	    P_CONTENTS		= sRsp("P_CONTENTS")
	    P_WIDTH		= sRsp("P_WIDTH")
	    P_HEIGHT		= sRsp("P_HEIGHT")
	    P_TOP		= sRsp("P_TOP")
	    P_LEFT		= sRsp("P_LEFT")
	    P_SITE		= sRsp("P_SITE")
	    P_YN		= sRsp("P_YN")
	    
	    strOnmousemove = strOnmousemove & "dragBoxpop8"&NN&"();" & chr(10)
%>


<script type="text/javascript" language="javascript"> 

clicked<%= nn %> = false; 
maxZindex = 200 ;
function startDragpop8<%=nn%>(cx,cy) { 
    clicked<%= nn %> = true; 
    pleft=parseInt(document.getElementById("pop8<%=nn%>").style.left); 
ptop=parseInt(document.getElementById("pop8<%=nn%>").style.top); 
    maxZindex = maxZindex + 2 ;
    document.getElementById("pop8<%=nn%>").style.zIndex = maxZindex ;
    dragxcoor=cx;        
dragycoor=cy;        
} 
                
function stopDragpop8<%=nn%>() { 
    clicked<%= nn %> = false; 
} 
        
function dragBoxpop8<%=nn%>(evt) { 
    e = evt || window.event; 
    if (clicked<%= nn %> == true) { 
        newx = pleft+e.clientX-dragxcoor; 
        newy = ptop+e.clientY-dragycoor; 
        document.getElementById("pop8<%=nn%>").style.left=newx; 
        document.getElementById("pop8<%=nn%>").style.top=newy; 
//         return false; 
    } 
} 
//document.onmousemove = dragBoxpop8<%=nn%>; 



function setCookiepop8<%=nn%>( name, value, expiredays ) { 
var todayDate = new Date(); 
todayDate.setDate( todayDate.getDate() + expiredays ); 
document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
} 

function closeWinpop8<%=nn%>() { 
if ( document.notice_formpop8<%=nn%>.chkbox.checked ){ 
setCookiepop8<%=nn%>( "pop8<%=nn%>", "done" , 1 ); 
} 

document.getElementById("pop8<%=nn%>").style.visibility = "hidden"; 
} 

     

</script> 
<div id="pop8<%=nn%>" style="position:absolute; left:<%=P_left%>px; top:<%=P_top%>px; z-index:200;width:390;height:400; visibility:visible; display:table; " onmousedown="startDragpop8<%=nn%>(event.clientX,event.clientY)" onmouseup="stopDragpop8<%=nn%>()"> 
<% 'If Left(Session("JOBSITE"),1) = "T" then%>
<form name="notice_formpop8<%=nn%>">



<table border='0' cellpadding='0' cellspacing='0' WIDTH='390'  >
  <tr>

<% If P_SUB=1 Then%>
    <td height="400"  align="left" background="/images/pop/1.png">
<% ElseIf P_SUB=2 Then %>
    <td height="400"  align="left" background="/images/pop/d2.gif">
<% ElseIf P_SUB=3 Then %>
    <td height="400"  align="left" background="/images/pop/d3.gif">
<% ElseIf P_SUB=4 Then %>
    <td height="400"  align="left" background="/images/pop/4.gif">
<% End if %>

      <table border='0' cellpadding='0' cellspacing='0'  width="100%">        
	  <tr><td height="30"></td></tr>
        <tr>
            <td height="20" align="center"><b><b><b><font color='#000000'><%= P_SUB %></font></b></td>
        </tr>
      </table>    
    </td>
  </tr>

  <tr bgcolor="000000">
    <td align="center">
    	<table border=0 width="90%" >
		<tr>
		<td>
			&nbsp;<input type="checkbox" name="chkbox" value="checkbox" onClick="closeWinpop8<%=nn%>()"><b><font color='#ffffff'> 하루 동안 이 창을 열지 않음</font></b>
		</td>
		<td align="right" valign="bottom"  onclick="closeWinpop8<%=nn%>();">
		    <b style="curosr:pointer;cursor:hand;"> <font color='#ffffff'>[닫기]</font></b>
		</td>
		</tr>
        </table>
    </td>
  </tr>

</table>
<% 'End If %>
</form>
</div> 

<script language="Javascript"> 
cookiedata = document.cookie; 
if ( cookiedata.indexOf("pop8<%=nn%>=done") < 0 )
{ 
    document.getElementById("pop8<%=nn%>").style.visibility = "visible"; 
} 
else 
{ 
    document.getElementById("pop8<%=nn%>").style.visibility = "hidden"; 
} 
</script> 

<%
	sRsp.movenext
	loop

	sRsp.close
	Set sRsp = Nothing

	Dberp.Dispose
	Set Dberp = Nothing 
End If 

IF nn <> 0 Then
%>
<script type="text/javascript">

    document.onmousemove = function()
    {   
        <%= strOnmousemove %>                
    }   
</script>
<%
end if
%>