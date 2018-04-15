<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->

<%
	LoginID = Trim(dfRequest.Value("IU_ID"))		'아이디
	LoginPW = Trim(dfRequest.Value("IU_PW"))		'비밀번호

    IF LoginID = "" And LoginPW = "" Then
		Response.Write "<script language='javascript'>"
		Response.Write "alert('정상적인 접근바랍니다.');"
		Response.Write "parent.LoginFrm.IU_ID.value='';"
		Response.Write "parent.LoginFrm.IU_PW.value='';"
		Response.Write "parent.LoginFrm.IU_ID.focus();"
		Response.Write "</script>"    
		response.End
    End IF

    '######## 아이디 체크 #######################
    IF NOT dfSiteUtil.Pattern("ID", LoginID) Then
%>
		    <script type="text/javascript">
			    alert("첫글자는 영자 그뒤엔 영어숫자 4이상 12자리 이하로 가입하셔야 합니다.");
				parent.location.href='/index.asp';
				parent.LoginFrm.IU_ID.value='';
				parent.LoginFrm.IU_PW.value='';
				parent.LoginFrm.IU_ID.focus();
		    </script>
<%	
        response.End        
    End IF
	Set Dber = new clsDBHelper

	
IU_IP = Trim(Request("REMOTE_ADDR"))
sql = "select top 1 blockip from BLOCK_IP with(nolock) where blockip='"& IU_IP &"' "


Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)
If sRs.eof Or sRs.bof Then 
Else
	sRs.close
	Set sRs = Nothing
	Dber.Dispose
	Set Dber = Nothing 
	Response.Write "<script language='javascript'>"
	Response.Write "alert('차단된 IP 입니다.\n관리자에게 문의하세요.');"
	Response.Write "parent.location.href='http://naver.com';"
	Response.Write "</script>"
	Response.End 
end If 
sRs.close
Set sRs = Nothing

	SQL = "UP_GetINFO_USERByLogin_NEW"
	reDim param(1)
	param(0) = Dber.MakeParam("@loginid",adVarWChar,adParamInput,20,LoginID)
	param(1) = Dber.MakeParam("@IU_GTYPE",adInteger,adParamInput,,1)

	Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

	IF NOT sRs.EOF THEN
		PWD = sRs(1)
		NickName = sRs(2)
		Status = sRs(3)
		Site = sRs(4)
		IU_Level = sRs(5)
        IUL_BETTINGMIN = sRS("IUL_BETTINGMIN")
        IUL_BETTINGMAX = sRS("IUL_BETTINGMAX")
        IUL_BENEFITMAX = sRS("IUL_BENEFITMAX")
		IF PWD <> LoginPW THEN
				Response.Write "<script language='javascript'>"
				Response.Write "alert('비밀번호를 확인하세요.');"
				Response.Write "parent.location.href='/index.asp';"
				Response.Write "parent.LoginFrm.IU_ID.value='';"
				Response.Write "parent.LoginFrm.IU_PW.value='';"
				Response.Write "parent.LoginFrm.IU_ID.focus();"
				Response.Write "</script>"
				Response.End
		end if


		IF PWD = LoginPW THEN
			IF Status = "1" THEN
				Session("SD_ID") = sRs(0)
				Session("IU_NickName") = NickName
				Session("JOBSITE") = Site
				Session("IU_Level") = IU_Level
				Session("SB_BETTINGMIN")  = IUL_BETTINGMIN
				Session("SB_BETTINGMAX")  = IUL_BETTINGMAX
				Session("SB_BENEFITMAX")  = IUL_BENEFITMAX

				JOBSITE = Session("JOBSITE")
                
				'중복로그인
				nowHour = Hour(Now)
				If Len(nowHour) < 2 Then
					nowHour = "0"&nowHour 
				End If 
				nowMinute = minute(Now)
				If Len(nowMinute) < 2 Then
					nowMinute = "0"&nowMinute 
				End If 
				nowSecond = second(Now)
				If Len(nowSecond) < 2 Then
					nowSecond = "0"&nowSecond 
				End If 

				nowTime = date&" "&nowHour&":"&nowMinute&":"&nowSecond

				Session("ll_regdate") = nowTime
				
				IU_IP = Request("REMOTE_ADDR")

				SQL = "dbo.UP_InsertLog_LogByUserNew"

				reDim param(7)
				param(0) = Dber.MakeParam("@LoginID",adVarWChar,adParamInput,20,LoginID)
				param(1) = Dber.MakeParam("@NickName",adVarWChar,adParamInput,20,NickName)
				param(2) = Dber.MakeParam("@IU_IP",adVarWChar,adParamInput,20,IU_IP)
				param(3) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
				param(4) = Dber.MakeParam("@nowTime",adVarWChar,adParamInput,100,nowTime)
				param(5) = Dber.MakeParam("@port",adVarWChar,adParamInput,100,Request.ServerVariables("SERVER_PORT"))
				param(6) = Dber.MakeParam("@domainNm",adVarWChar,adParamInput,200,Request.ServerVariables("SERVER_NAME"))
				param(7) = Dber.MakeParam("@LLGTYPE",adInteger,adParamInput,,1)
				
				Dber.ExecSP SQL,param,Nothing
				'중복로그인		

			ELSEIF Status = "0" THEN
				Response.Write "<script language='javascript'>"
				Response.Write "alert('관리자가 회원님의 정보를 확인중입니다. 10분가량의 시간이 소모되며 필요시 가입확인을 위한 확인전화를 드릴수 있습니다1.');"
				Response.Write "parent.location.href='/index.asp';"
				Response.Write "parent.LoginFrm.IU_ID.value='';"
				Response.Write "parent.LoginFrm.IU_PW.value='';"
				Response.Write "parent.LoginFrm.IU_ID.focus();"
				Response.Write "</script>"
				Response.End
			ELSEIF Status = "9" THEN
				Response.Write "<script language='javascript'>"
				Response.Write "alert('사용자정보가 정확하기 않습니다.');"
				Response.Write "parent.location.href='/index.asp';"
				Response.Write "parent.LoginFrm.IU_ID.value='';"
				Response.Write "parent.LoginFrm.IU_PW.value='';"
				Response.Write "parent.LoginFrm.IU_ID.focus();"
				Response.Write "</script>"
				Response.End
			END IF
		ELSE
			Response.Write "<script language=javascript>"
			Response.Write "alert('관리자가 회원님의 정보를 확인중입니다. 10분가량의 시간이 소모되며 필요시 가입확인을 위한 확인전화를 드릴수 있습니다');"
			Response.Write "parent.location.href='/index.asp';"
			Response.Write "parent.LoginFrm.IU_ID.value='';"
			Response.Write "parent.LoginFrm.IU_PW.value='';"
			Response.Write "parent.LoginFrm.IU_ID.focus();"
			Response.Write "</script>"
			Response.End
		END IF
	END IF

	sRs.Close
	Set sRs = Nothing
	
    '######## 로그인 이벤트 당첨자를 위한 페이지
    boologinEvent = True
    
    IF boologinEvent = True Then
	    SQL = "SELECT EL_IDX FROM EVENT_LOGIN WHERE EL_ID = ? AND  EL_USED = 0 AND EL_STARTDATE <= getdate() AND EL_ENDDATE >= getdate() "

	    reDim param(0)
	    param(0) = Dber.MakeParam("@loginid",adVarWChar,adParamInput,20,LoginID)
	    Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)


	    IF NOT sRs.EOF THEN 
	            Response.Write "<script language=javascript>"
	            Response.Write "parent.location.href = '/event/login/event.asp';"
	            Response.Write "</script>"
	            Response.End
            
            'End IF	
        End IF
	    sRs.Close
	    Set sRs = Nothing    
        Dber.Dispose
	    Set Dber = Nothing 
    End IF
    
	Response.Write "<script language=javascript>"
	Response.Write "parent.location.href = '/main.asp';"
	Response.Write "</script>"
	Response.End

%>
