<% Response.ChaRset="euc-kr" %>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

<div style="border:1px solid #445599; font-size:12px; padding:10px;">
HBER DLL 테스트 버전입니다.
<br/>
<%
acc = "OC0026901311"
'OC0026901311
money = "20000"
id = "TOMORROW216617"
pin = "4f9b29"
gcc = "10"
'	set Com = server.createobject("TesterAPICall.TesterAPI")
'	result = Com.deposit_Click(acc,money,gcc, id, pin)
'	Response.Write Com.deposit_Click(acc,money,gcc, id, pin)

'	result = Com.btn_withdrawal_Click(acc, money, id, pin)
'	Response.Write Com.btn_withdrawal_Click(acc, money, id, pin)

'	Set Com = Nothing
'H 테스트용으로 만든것임
Dim HCom
Set HCom = Server.CreateObject("TotalEGameAPI.TotalEGameAPICall")

'H 새로만든 com+
'	result = HCom.deposit_Click(acc,money,gcc, id, pin)
	result = HCom.btn_withdrawal_Click(acc, money, id, pin)

'Response.Write HCom.ReturnText
Set HCom = Nothing


%>


*아래에 완료 라고 나와야 페이지 에러가 아닙니다.<br/>
* 소프접속경우 true 라고 문장끝에 나와야 성공<br/>
acc : <%=acc%><br/>
<br/>완료1<br/>
<div style="border:1px solid #449955; font-size:12px; padding:10px;">


<% 



'디파짓
'	Response.Write Com.deposit_Click(acc,money,gcc, id, pin)


'Function FnGET_INFO_URL(strURL,strURL2,typeP)
If a = "주석처리했음" then
	 Dim RStr, xmlHttp
	 Set xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")
	 xmlHttp.open "POST", strURL, False
	 xmlHttp.setRequestHeader "Content-Type", "text/xml"
'	 xmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	 xmlHttp.setRequestHeader "Accept-Language", "ko"
     xmlHttp.setRequestHeader "SOAPAction", strURL2
	 SOAPRequest = "<?xml version=""1.0"" encoding=""utf-8""?>"
     SOAPRequest = SOAPRequest &  "<soap:Envelope xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"" xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"">"
		If typeP = "isAuth" then
			 SOAPRequest = SOAPRequest &  "<soap:Body>"
			 SOAPRequest = SOAPRequest &  "		<IsAuthenticate xmlns=""https://entservices.totalegame.net"">"
			 SOAPRequest = SOAPRequest &  "			<loginName>"& id &"</loginName>"
			 SOAPRequest = SOAPRequest &  "			<pinCode>"& pin &"</pinCode>"
			 SOAPRequest = SOAPRequest &  "		</IsAuthenticate>"
		End if
     SOAPRequest = SOAPRequest &  "</soap:Body>"
     SOAPRequest = SOAPRequest &  "</soap:Envelope>"

'	 xmlHttp.send
	 xmlHttp.send SOAPRequest
	 If xmlHttp.status = 200 Then
		RStr = xmlHttp.ResponseText
	 Else
		RStr = "["&strURL&"] 불러오기 실패입니다. - " & xmlHttp.status
	 End If
	 Set xmlHttp = Nothing
	 FnGET_INFO_URL = RStr
End if
'End Function


'strTEMP = FnGET_INFO_URL("https://entv3.totalegame.net", "https://entservices.totalegame.net/IsAuthenticate","isAuth")	'로그인 인증
'strTEMP = FnGET_INFO_URL("https://entv3.totalegame.net", "https://entservices.totalegame.net/IsAuthenticate")

'12345678 0123 5678 0123 5678901234567				총 27자
'08b17ca2-58aa-4202-b0a1-00fd723f960a0


'Response.write "<br/>ALL :" & strTEMP &"<br/> "


'strTEMPAll = CStr(strTEMP)
'str = strTEMPAll
'	str = TextUtil.replace(str, "\"", "&quot;");
 '  str = TextUtil.replace(str, "&", "&amp;");
'   str = TextUtil.replace(str, "\'", "&apos;");
'   str = TextUtil.replace(str, "<", "&lt;");
 ' str = TextUtil.replace(str, ">", "&gt;");

'HHHHHHH 


'SessionGuidText = Replace(strTEMPAll,"?","")
'SessionGuidText = Replace(SessionGuidText,"<","&lt;")
'SessionGuidText = Replace(SessionGuidText,">","&gt;")
'SessionGuidText = Replace(SessionGuidText," ","")
'SessionGuidText = Replace(SessionGuidText,"&lt;xmlversion=""1.0""encoding=""utf-8""&gt;","")
'SessionGuidTextFind = Replace(SessionGuidText,"&lt;SessionGUID&gt;" & Find &"</SessionGUID&gt;",Find)
'Response.write "<br/>sessionguid : <b>" & SessionGuidText & "</b><br/>======== "
'Response.write "<br/>sessionguidFind : <b>" & SessionGuidTextFind & "</b><br/>======== "








'xml 읽어온거 분류하기
'sessionguid
'Response.write strTEMP.getElementsByTagName("sessionguid").childNodes.text

'Set objRoot = strTEMP.documentElement

'strTEXT1 = strTEMP.getElementsByTagName("sessionguid").childNodes.text

'Response.write strTEMP
 %>
</div>
<br/>
완료2
</div>
 