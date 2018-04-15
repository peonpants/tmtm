<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<%
	acc   = Request("acc")
	money   = Request("money")
	tong  = Request("tong")
	id  = Request("id")
	pin  = Request("pin")
	iu_id = Session("SD_ID")

	Set Dber = new clsDBHelper
	SQL = "SELECT * FROM INFO_USER WHERE IU_ID = ? "

	reDim param(0)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

	IU_CASH	= sRs("IU_CASH")
	IU_CASINOID = sRs("IU_CASINOID")
	sRs.Close
	Set sRs = Nothing	
	
	If CDbl(IU_CASH) < 10000 Then
		Dber.Dispose
		Set Dber = Nothing		
		With Response
			.write "1" & vbcrlf
			.End
		End With
	END If

	If CDbl(money) > CDbl(IU_CASH) Then
		Dber.Dispose
		Set Dber = Nothing		
		With Response
			.write "2" & vbcrlf
			.End
		End With
	END If
	
	If IU_CASINOID = "" Or isNull(IU_CASINOID) Then
			Dber.Dispose
			Set Dber = Nothing		
			With Response
				.write "3" & vbcrlf
				.End
			End With
	Else

		'Log_CashInOut ¿¡ ¸Ó´ÏÀÌµ¿ ±â·Ï
		SQL = "UP_INFO_CASH_LOG_INS_CASINO"

		IU_CASH = IU_CASH - money
		
		reDim param(3)		
		param(0) = Dber.MakeParam("@LC_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@LC_Cash",adInteger,adParamInput,,Int(-money))
		param(2) = Dber.MakeParam("@LC_GCASH",adInteger,adParamInput,,Int(IU_Cash))
		param(3) = Dber.MakeParam("@LC_SITE",adVarWChar,adParamInput,20,"MICRO")
		Dber.ExecSP SQL,param,Nothing	

		'########### È¸¿øÄ³½¬ Áõ°¨
		SQL = "UP_INFO_CASH_UPD_CASINO"
		reDim param(1)
		param(0) = Dber.MakeParam("@IU_Cash",adInteger,adParamInput,,Int(money))
		param(1) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		
		Dber.ExecSP SQL,param,Nothing


			'set Com = server.createobject("TesterAPICall.TesterAPI")
			'result = Com.deposit_Click(acc,money,tong,id,pin)

'H »õ·Î¸¸µç com+ ==================================================================
	Dim HCom
	Set HCom = Server.CreateObject("TotalEGameAPI.TotalEGameAPICall")
	result = HCom.deposit_Click(acc,money,gcc, id, pin)
'	result = HCom.btn_withdrawal_Click(acc, money, id, pin)
'H »õ·Î¸¸µç com+ ==================================================================


			'H ¸Ó´Ï Àü¼ÛÀº Á¤»óÀûÀ¸·Î Àû¿ëµÇÁö¸¸ ¸®ÅÏ¿¡¼­ ¿¡·¯°¡ ¹ß»ýÇÑ´Ù
			'H ¸Ó´Ï Àü¼ÛÀº Á¤»óÀûÀ¸·Î Àû¿ëµÇÁö¸¸ ¸®ÅÏ¿¡¼­ ¿¡·¯°¡ ¹ß»ýÇÑ´Ù
			'H ¸Ó´Ï Àü¼ÛÀº Á¤»óÀûÀ¸·Î Àû¿ëµÇÁö¸¸ ¸®ÅÏ¿¡¼­ ¿¡·¯°¡ ¹ß»ýÇÑ´Ù

 	End if
%>