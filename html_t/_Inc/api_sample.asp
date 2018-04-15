
<!--#include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Lib/base64_jscript.asp" -->
<!-- #include file="../../_Lib/xmlparser.asp" -->
<!-- #include file="../../_Lib/xmlrpc.asp" -->
<!-- #include file="../../_Lib/md5.asp" -->
<!-- #include file="gabiaAPI.asp"  -->

<%
    Dim oSms
    set oSms = new smsApi
    oSms.setUserID = "rlackdgh3"
    oSms.setApiKey = "dac7c5db075741552e54dfcd3a9e388e" 'api key

    phone_no = REQUEST("phone_no")
    codeRandom = REQUEST("codeRandom")
    

    ' if oSms.sms_send("01098173870", phone_no, "코드: ", "dkffkdrkahffk13", "0") = oSms.RESULT_OK then
    '   Response.Write(codeRandom& ", " &phone_no) 'for debugging'
    ' else
    '   Response.Write(oSms.RESULT_CODE & "<br>")
    '   Response.Write(oSms.RESULT_MESG & "<br>")
    '   Response.Write(RESULT)
    ' end if
    call oSms.sms_send("01098173870", phone_no, "코드: "& codeRandom, "dkffkdrk113", "0")
    ' Response.Write(oSms.RESULT_CODE & "<br>")
    ' Response.Write(oSms.RESULT_MESG & "<br>")
    
'     oSms.getStatus("dkffkdrk113") 'unique key'
'     Response.Write(&oSms.RESULT)
%>
