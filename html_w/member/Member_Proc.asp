
<!-- #include file="../../_Common/Api/md5.asp" -->
<%
    '---------------------------------------------------------
    '   @Title : 비번암호화
    '---------------------------------------------------------


            '######## 피드백  ##############	
            
            RECOM_ID        = Trim(REQUEST.Form("RECOM_ID"))
            RECOM_CODE      = Trim(REQUEST.Form("RECOM_CODE"))
			IU_ID           = Trim(REQUEST.Form("IU_ID"))
			IU_PW           = Trim(REQUEST.Form("IU_PW"))
			IU_BankName     = Trim(REQUEST.Form("IU_BankName"))
			IU_BankNum      = Trim(REQUEST.Form("IU_BankNum"))
			IU_BankOwner    = Trim(REQUEST.Form("IU_BankOwner"))			
			IU_NickName     = Trim(REQUEST.Form("IU_NickName"))
			IU_CODE         = Trim(REQUEST.Form("IU_CODE"))
			IU_Mobile1      = REQUEST.Form("IU_Mobile1")
			IU_Mobile2      = REQUEST.Form("IU_Mobile2")
			IU_Mobile3      = REQUEST.Form("IU_Mobile3")
			IU_SITE         = REQUEST.Form("IU_SITE")
			SMSYN           = REQUEST.Form("SMSYN")
			Email1        = REQUEST.Form("Email1") 
			Email3        = REQUEST.Form("Email3")
			REMOTE_ADDR           = REQUEST("REMOTE_ADDR")
			IU_MOONEY_PW   = REQUEST("IU_MOONEY_PW")
			EMODE   = 		REQUEST.Form("EMODE")

'######## MD5 이중 암호화
IU_PW = UCase(md5(IU_PW))
IU_PW = UCase(md5(IU_PW))

 Response.Redirect ("member_procf.asp?RECOM_ID="&RECOM_ID&"&RECOM_CODE="&RECOM_CODE&"&IU_ID="&IU_ID&"&IU_PW="&IU_PW&"&IU_BankName="&IU_BankName&"&IU_BankNum="&IU_BankNum&"&IU_BankOwner="&IU_BankOwner&"&IU_NickName="&IU_NickName&"&IU_CODE="&IU_CODE&"&IU_Mobile1="&IU_Mobile1&"&IU_Mobile2="&IU_Mobile2&"&IU_Mobile3="&IU_Mobile3&"&IU_SITE="&IU_SITE&"&SMSYN="&SMSYN&"&Email1="&Email1&"&Email3="&Email3&"&REMOTE_ADDR="&REMOTE_ADDR&"&IU_MOONEY_PW="&IU_MOONEY_PW&"&EMODE="&EMODE)
%>
