
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/md5.asp" -->
<%
	LoginID = Trim(dfRequest.Value("IU_ID"))
	LoginPW = Trim(dfRequest.Value("IU_PW"))

LoginPW = UCase(md5(LoginPW))
LoginPW = UCase(md5(LoginPW))

	Response.Write "<script language=javascript>"
	Response.Write "location.href = 'index2.asp?IU_ID="&LoginID&"&IU_PW="&LoginPW&"';"
	Response.Write "</script>"
%>
