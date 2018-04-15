<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/DBConn.class.asp" -->
<!-- #include file="../../_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/lta_object.asp" -->
<!-- #include file="../../_Common/Api/lta_function.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->

<%	
    '########   리퀘스트    ##############
	PAGE	= REQUEST("PAGE")
	EMODE	= REQUEST("EMODE")
	Search	= REQUEST("Search")
	Find	= REQUEST("Find")
	Set Dber = new clsDBHelper

	IF EMODE = "QNAADD" THEN
        '########   고개센터 등록     ##############
		Bc_Writer	= XSS_T(REQUEST("Bc_Writer"))
		Bc_Title	= XSS_T(Checkit(Trim(REQUEST("Bc_Title"))))
		BC_Type     = Trim(request("BC_Type"))
		content_body = XSS_T(Checkit(Trim(REQUEST("BC_CONTENTS"))))

		SQL = "UP_INFO_Board_Customer_INS_NEW"
		reDim param(7)
		param(0) = Dber.MakeParam("@BC_WRITER", adVarWChar, adParamInput, 20, BC_WRITER)
		param(1) = Dber.MakeParam("@IU_ID", adVarWChar, adParamInput, 20, Session("SD_ID"))
		param(2) = Dber.MakeParam("@BC_TITLE", adVarWChar, adParamInput, 100, BC_TITLE)
		param(3) = Dber.MakeParam("@content_body", adVarWChar, adParamInput, 4000, content_body)
		param(4) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)	
		param(5) = Dber.MakeParam("@BC_Type", adInteger, adParamInput, , BC_Type)	
		param(6) = Dber.MakeParam("@BC_DOMAIN",adVarWChar,adParamInput,200,Request.ServerVariables("SERVER_NAME"))	
		param(7) = Dber.MakeParam("@BC_IPADDR",adVarWChar,adParamInput,50,Request.ServerVariables("REMOTE_ADDR"))	
		Dber.ExecSP SQL,param,Nothing
		Dber.Dispose
		Set Dber = Nothing
		WITH RESPONSE
			.WRITE "<script language='javascript'>" & VbCrLf
			.WRITE "alert('작성하신 문의글이 등록되었습니다.');" & VbCrLf
			.WRITE "location.href='/support/Answer_List.asp'" & VbCrLf
			.WRITE "</script>" & VbCrLf
			.END
		END WITH

	ELSEIF EMODE = "answer_alldel" THEN
		SQL = "UP_INFO_Board_Customer_DEL"
		reDim param(0)
		param(0) = Dber.MakeParam("@IU_ID", adVarWChar, adParamInput, 20, Session("SD_ID"))
		
		Dber.ExecSP SQL,param,Nothing
		Dber.Dispose
		Set Dber = Nothing
		WITH RESPONSE
			.WRITE "<script language='javascript'>" & VbCrLf
			.WRITE "alert('전체 문의가 지워졌습니다.');" & VbCrLf
			.WRITE "parent.location.reload()" & VbCrLf
			.WRITE "</script>" & VbCrLf
			.END
		END WITH
	ELSEIF EMODE = "selctedDEL" THEN

        BC_IDX	= REQUEST("BC_IDX")

		SQL = "UP_INFO_Board_Customer_DEL_1"
		reDim param(0)
		param(0) = Dber.MakeParam("@BC_IDX",adInteger, adParamInput, ,BC_IDX)
		
		Dber.ExecSP SQL,param,Nothing
		Dber.Dispose
		Set Dber = Nothing
		%>
<script>parent.location.reload()</script>
		<%
		
	End If 
%>