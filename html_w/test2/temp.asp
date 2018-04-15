
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<%
	 iu_id = Session("SD_ID")
	 casinoid   = Request("casino_id")

		Set Dber = new clsDBHelper	
		SQL = "UP_UpdateINFO_USERCASINOID"
		reDim param(1)
		param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@IU_CASINOID",adVarWChar,adParamInput,20,casinoid)
		Dber.ExecSP SQL,param,Nothing
		Dber.Dispose
		Set Dber = Nothing

		response.redirect "/game/BetGame.asp?game_type=casino_help"

		'htmlView = casinoid
		'Response.Write htmlView
%>