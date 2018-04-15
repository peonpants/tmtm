<%@ CodePage=65001  Language="VBScript"%>
<!-- #include file="../_Common/Lib/DBHelper.asp" -->

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
<title><%= SITE_TITLE %></title>
<%
Set Dber = new clsDBHelper
sql = "SELECT P_CONTENTS FROM POPOP02 WHERE P_SUB='maint'"
Set Rs = Dber.ExecSQLReturnRS(sql,nothing,nothing)
Dim contents
If Not (Rs.bof Or Rs.Eof) then
	contents = Rs(0)
%>
<script></script>l
<style type="text/css">
	body{
		margin: 0px;
		font-family: Verdana, sans-serif;
		font-size: 12px;
	}
	h1{
		font-size: 22px;
		color: #D70637;
		font-weight: bold;
		text-align: center;
	}
	h1,pre{
		width: 600px;
		margin: auto;
		font-weight: bold;
	}pre{
		font-size: 15px
	}
</style>
</head>
<body>
	<br>
	<div style="padding: 5px;">
		<h1>★★★ 서버점검 안내 ★★★</h1><br><br>

<pre>
<%=contents%>
</pre>
	</div>
</body>
</html>

<%
Else
%>
 <script>
  var this_url = document.location.href;
  var split_url =this_url.split("/");
var url_detail = split_url[2].split(".");

if (url_detail.length == 2) {
var final_url = "http://m."+split_url[2];

} else {

var final_url = "http://m."+url_detail[1]+"."+url_detail[2];
}

     if (navigator.userAgent.match(/iPad/) == null && navigator.userAgent.match(/iPhone|Mobile|UP.Browser|Android|BlackBerry|Windows CE|Nokia|webOS|Opera Mini|SonyEricsson|opera mobi|Windows Phone|IEMobile|POLARIS/) != null) { 
     location.href = final_url;

     } else {
	 } 

</script>
</head>

<frameset rows="*,0" cols="1*" border=0>
<frame src="index2.asp" frameborder=0 scrolling=auto>
</frameset>

</body>
</html>
<%End If%>