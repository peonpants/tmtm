<%
	IF Session("SD_ID") = "" OR isNull(Session("SD_ID")) THEN

		With Response
			.Write "<script language=javascript>" & vbCrLf
			.Write "alert('로그인하신 후에 이용하세요.');" & vbCrLf
			.Write "window.close();" & vbCrLf
			.Write "</script>" & vbCrLf
			.END
		END With

	END IF	

	Set Dber = new clsDBHelper
	SQL = "SELECT Top 1 ll_regdate FROM LOG_LOGIN WHERE ll_id = ? AND ll_site = ? ORDER BY ll_regdate desc"

	reDim param(1)
	param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

	If Not sRs.eof then
		ll_regdate = sRs("ll_regdate")
	End If 

	If cdate(ll_regdate) = cdate(Session("ll_regdate"))  Then
	
	Else
		
%>
        <script>
            alert("중복 로그인 방지 기능이 적용되었습니다.");
            location.href = "/login/Logout_Proc.asp" ;
        </script>
<%
	End If 

	sRs.close
	Set sRs = Nothing
	Dber.Dispose
	Set Dber = Nothing 

%>