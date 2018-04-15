<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->

<%
    IB_IDX            = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("IB_IDX")), 0, 1, 9999999) 
	PAGE	= REQUEST("PAGE")
	Search	= REQUEST("Search")
	Find	= REQUEST("Find")
	b1 = REQUEST("b1")
	
	Set Dber = new clsDBHelper
	
    IF NOT BETTING_CANCEL Then
%>
    <script type="text/javascript">
        alert("사용하지 않는 기능입니다.");
        location.href = "<%= URL %>";
    </script>
<%
        response.end    
    End IF

    URL = "/member/MyBet.asp"

	urlt = Request.ServerVariables("HTTP_REFERER")
	
	if urlt = "" Then
	 urlt="testtestte"
	End If

    IF IB_IDX = 0 Then
%>
    <script type="text/javascript">
        alert("정상적인 접근 바랍니다.");
        location.href = "<%= URL %>";
    </script>
<%
        response.end    
    End IF

    ' 취소 내역 조회 
    SQL = "UP_CANCEL_BET"
    reDim param(3)
	param(0) = Dber.MakeParam("@IB_Idx",adInteger,adParamInput,,IB_IDX) '시간값
	param(1) = Dber.MakeParam("@DATE_TERM",adInteger,adParamInput,,BETTING_CANCEL_TERM) '시간값
    param(2) = Dber.MakeParam("@IB_ID",adVarWChar,adParamInput,20,SESSION("SD_ID"))
    param(3) = Dber.MakeParam("@BETTING_CANCEL_COUNT",adInteger,adParamInput,,BETTING_CANCEL_COUNT) '시간값
   
	Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
			
	ismsg = sRs(0)
	enumber = sRs(1)
	igidx	= sRs(2)
	ibnum	= sRs(3)

	sRs.close
	Set sRs = Nothing		
	
	If enumber <> "1000" Then			
		With Response
		.Write "<script>" & vbcrlf
		.Write "alert('"&ismsg&"');" & vbcrlf				
		.WRITE "location.href='"&URL&"'" & VbCrLf
		.Write "</script>"
		.end
		End With	
		response.end	
	End if	
 ' 취소 내역 조회 
	SQL = "UP_CANCEL_CHECK"
	reDim param(0)
	param(0) = Dber.MakeParam("@IB_Idx",adInteger,adParamInput,,IB_IDX) '시간값
	
	Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
			
	ismsg = sRs(0)
	enumber = sRs(1)

	sRs.close
	Set sRs = Nothing		

	arrIG_Idx = SPLIT(igidx, ",")
	arrIB_NUM = SPLIT(ibnum, ",")
	TotalCnt	= ubound(arrIG_Idx)

	IF Session("IU_Level") <> 9 Then
	FOR fi=0 to TotalCnt
		
		'response.Write arrIG_Idx(fi) & "<br>"
		'response.Write arrIB_NUM(fi) & "<br>"
		'response.Write IB_IDX & "<br>"
		SQL = "UP_CANCEL_GAME"
		
		reDim param(2)
		param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,arrIG_Idx(fi))
		param(1) = Dber.MakeParam("@IB_NUM",adInteger,adParamInput,,arrIB_NUM(fi))
		param(2) = Dber.MakeParam("@IB_IDX",adInteger,adParamInput,,IB_IDX)
		
		Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
		
		ismsg = sRs(0)
		enumber = sRs(1)
		
		sRs.close
		Set sRs = Nothing		
		
	NEXT
	End If

	'response.end
	WITH RESPONSE
		.WRITE "<script language='javascript'>" & VbCrLf
		.WRITE "alert('해당 배팅 내역이 취소되었습니다.\n1일 " & BETTING_CANCEL_COUNT & "회만 적용가능합니다.');" & VbCrLf
		.WRITE "location.href='"&URL&"'" & VbCrLf
		.WRITE "</script>" & VbCrLf
		.END
	END WITH

        response.end 	

%>