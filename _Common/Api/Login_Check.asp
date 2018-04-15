<%
	IF Session("SD_ID") = "" OR isNull(Session("SD_ID")) THEN

		With Response
			.Write "<script language=javascript>" & vbCrLf
			.Write "alert('로그인하신 후에 이용하세요.');" & vbCrLf
			.Write "top.location.href='/';" & vbCrLf
			.Write "</script>" & vbCrLf
			.END
		END With

	END IF	

	Set Dber = new clsDBHelper
	SQL = "UP_GetLOG_LOGINForUser"

	reDim param(1)
	param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,SESSION("JOBSITE"))

	Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
        
    ll_regdate = "2010-01-01 00:01"        
    
	If Not sRs.eof then
		ll_regdate = sRs("ll_regdate")
		IF NOT isDate(ll_regdate) Then
		    ll_regdate = "2010-01-01 00:01"        
		End IF
	End If 

	If NOT (cdate(ll_regdate) = cdate(Session("ll_regdate")))  Then
		
%>
        <script type="text/javascript">
            alert("중복 로그인 방지 기능이 적용되었습니다.");
            top.location.href = "/login/Logout_Proc.asp" ;
        </script>
<%
    
        response.End
	End If 


	'// 사용자 Cash를 가져와 배팅가능여부 체크...
	SQL = "SELECT IU_ID FROM INFO_USER WHERE IU_ID = ? AND IU_LOGOUT = 1 "
	
	reDim param(0)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))

	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

	If Not sRs.eof Then
		Session.Abandon
%>
        <script type="text/javascript">
            alert("로그인 후 이용하시기 바랍니다.");
            top.location.href = "/login/Logout_Proc.asp" ;
        </script>
<%	    	
        response.End		
	End If 
	
	sRs.close
	Set sRs = Nothing

	BLOCKIP = Request.ServerVariables("REMOTE_ADDR")
	SQL = "UP_GetBLOCK_IPForUser"
	
	reDim param(0)
	param(0) = Dber.MakeParam("@BLOCKIP",adVarWChar,adParamInput,20,BLOCKIP)
	
	Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

	If NOT sRs.eof then		
%>
        <script type="text/javascript">
            alert("회원님의 요청으로 IP차단되었습니다.");
            top.location.href = "http://www.daum.com/" ;
        </script>
<%		
	    'sRs.close
	    'Set sRs = Nothing
	    'Dber.Dispose
	    'Set Dber = Nothin
    	
        response.End
	End If 
		
	sRs.close
	Set sRs = Nothing
	Dber.Dispose
	Set Dber = Nothing 

%>