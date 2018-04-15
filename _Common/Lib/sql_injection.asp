<% 
injection_i=0

For each item in Request.QueryString 
	for injection_i = 1 to Request.QueryString(item).Count 

	strInjection	=	 strInjection & Request.QueryString(item)(injection_i)
	tmpstring		=	 replace(Request.QueryString(item)(injection_i)," ","") 
    if  instr(UCASE(tmpstring),"'OR")	> 0 or instr(UCASE(tmpstring),"'AND")	> 0 then
		%>
		<script>
			alert("SQL Injection hacking[page back]");
			history.back();
		</script>
		<%
		response.end
	end if

	strInjection	=	 strInjection & item
	next 
next 

injection_i=0

For each item in Request.Form 
	for injection_i = 1 to Request.Form(item).Count
	strInjection	=	strInjection & Request.form(item)(injection_i)

	tmpstring		=	 replace(Request.form(item)(injection_i)," ","") 
    if  instr(UCASE(tmpstring),"'OR")	> 0 or instr(UCASE(tmpstring),"'AND")	> 0 then
		%>
		<script>
			alert("SQL Injection hacking[page back]");
			history.back();
		</script>
		<%
		response.end
	end if
    strInjection	=	strInjection & item
	next 
next 



if instr(UCASE(strInjection),"CREATE")	> 0 or instr(UCASE(strInjection),"DROP")>0 or instr(UCASE(strInjection),"UPDATE")>0 or instr(UCASE(strInjection),"SELECT")>0 or instr(UCASE(strInjection),"UNION")>0 OR  instr(UCASE(strInjection),"'OR")>0 OR  instr(UCASE(strInjection),"'AND")>0  OR  instr(UCASE(strInjection),"EXEC")>0  OR instr(UCASE(strInjection),"INSERT")>0 OR instr(UCASE(strInjection),"DECLARE")>0 OR instr(UCASE(strInjection),"DELETE")>0 then
%>
<script>
	alert("허용되지 않는 글자가 포함되어 있습니다.");
	history.back();
</script>
<%

response.end
end if

if     instr(UCASE(strInjection),"<SCRIPT")>0 	or instr(UCASE(strInjection),"</SCRIPT")>0  	or instr(UCASE(strInjection),"<HTML")>0 	or instr(UCASE(strInjection),"</HTML")>0 	or instr(UCASE(strInjection),"<META")>0 	or instr(UCASE(strInjection),"<LINK")>0 	or instr(UCASE(strInjection),"<HEAD")>0 	or instr(UCASE(strInjection),"</HEAD")>0 	or instr(UCASE(strInjection),"<BODY")>0 	or instr(UCASE(strInjection),"</BODY")>0 	or instr(UCASE(strInjection),"<FORM")>0 	or instr(UCASE(strInjection),"</FORM")>0 	or instr(UCASE(strInjection),"<STYLE")>0 	or instr(UCASE(strInjection),"</STYLE")>0 	or instr(UCASE(strInjection),"COOKIE")>0	or instr(UCASE(strInjection),"<DOCUMENT.")>0  	or instr(UCASE(strInjection),"SCRIPT:")>0 	Then
%>
<script>
	alert("스크립트나 HTML태그는 사용하실 수 없습니다.");
	history.back();
</script>
<%

response.end
end if

%>
<%
	'특수문자 변경하기
	Function Checkot(CheckValue)
		CheckValue = replace(CheckValue, "&lt;", "<")
		CheckValue = replace(CheckValue, "&gt;", ">")	
		CheckValue = replace(CheckValue, "&amp;", "&" )
		Checkot = CheckValue
	End Function

	Function Checkit(CheckValue)
		CheckValue = replace(CheckValue, "&" , "&amp;")
		CheckValue = replace(CheckValue, "<", "&lt;")
		CheckValue = replace(CheckValue, ">", "&gt;")
		CheckValue = replace(CheckValue, "'", "''")
		Checkit = CheckValue
	End Function

	Function numdel(var)
		If InStr(var,".") Then
			a = Split(var,".")(0)
			If Len(Left(Split(var,".")(1),2)) > 1 Then
				b = Left(Split(var,".")(1),2)
			ElseIf Len(Left(Split(var,".")(1),2)) > 0 Then 
				b = Left(Split(var,".")(1),2) & "0"
			Else 
				b = "00"
			End If 
			var = a & "." & b
		Else
			var = var & ".00"
		End If 

		numdel = var
	End Function 
%>