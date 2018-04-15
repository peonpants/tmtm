<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<%
'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
'H
'H	¼öÁ¤		: 2017-12-21
'H
'H	¼öÁ¤»çÇ×	: ¿¬¼ÓÅ¬¸¯½Ã. 2¹ø ÁøÇà µÇ´Â Çö»ó ¼öÁ¤?
'H
'H	Line 70~	: »õ·Î¿î ÄÚµå·Î ´ëÃ¼ ( µðºñ¿¡¼­ ÃÖ±Ù ÀüÈ¯·Î±×¸¦ ÀÐ¾î¿Í¼­ 1ºÐÀÌ³»ÀÎÁö °Ë»çÈÄ ½ÇÇàÇÑ´Ù. 
'H			   2°³¿¬¼ÓÀ¸·Î ´­·¶À» °æ¿ì Ã¹¹øÂ°¸¸ ½ÇÇàµÇ°í 2¹øÂ°´Â 1ºÐÈÄ¿¡ ÇÏ¶ó´Â ¸Þ½ÃÁö°¡ ³ª¿Â´Ù.
'H
'H
'H
'H
'H
'H	ÀÛ¾÷³»¿ë :	Line 70~ 121 ·Î ¾Ë°í¸®Áò ´ëÃ¼
'H			SupportChat.inc.asp Line 155~162 ÇÁ·Î±×·¥ ¶óÀÎ»ðÀÔ
'H
'H
'H
'H
'H
'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH



   acc   = Request("acc")
   money   = Request("money")
   id  = Request("id")
   pin  = Request("pin")


'H »õ·Î¸¸µç com+ ==================================================================
	Dim HCom2
	Set HCom2 = Server.CreateObject("TotalEGameAPI.TotalEGameAPICall")
	result1 = HCom2.GetAccountBalance(acc, id, pin)
'	result = HCom.btn_withdrawal_Click(acc, money, id, pin)
'H »õ·Î¸¸µç com+ ==================================================================


'  set Com = server.createobject("TesterAPICall.TesterAPI")
'  result1 = Com.GetAccountBalance(acc, id, pin)

	Set Dber = new clsDBHelper
	SQL = "SELECT * FROM INFO_USER WHERE IU_ID = ? "

	reDim param(0)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

	IU_CASH	= sRs("IU_CASH")
	IU_CASINOID = sRs("IU_CASINOID")

	sRs.Close
	Set sRs = Nothing	

	If CDbl(result1) < CDbl(money) Then
		Dber.Dispose
		Set Dber = Nothing		
		With Response
			.write "1"  & vbcrlf
			.End
		End With
	End If
	If IU_CASINOID = "" Or isNull(IU_CASINOID) Then
		Dber.Dispose
		Set Dber = Nothing		
		With Response
			.write "2" & vbcrlf
			.End
		End With
	Else
		'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
		'H ÃÖ±Ù Ä«Áö³ë ¸Ó´Ï ÀüÈ¯ ³»¿ªÀ» ÀÐ¾î¿Â´Ù.
		LogDateNow = now 'ÇöÀç½Ã°£ ±¸ÇÏ±â
		Set Dber = new clsDBHelper

		'H Log_CashInOut ¿¡ ¸Ó´Ï ±â·Ï Á¶È¸ ¹× ºñ±³
		SQL = "SELECT top 1 * FROM Log_CashInOut WHERE LC_Cash > 0 AND LC_ID = ? Order by Lc_Regdate DESC"
		LogFlagOneMin = 1	'1ºÐÁö³µ´ÂÁö È®ÀÎ¿ë ÇÃ·¹±×°ª 0: ¾øÀ½ 1:ÀÖÀ½
		reDim param(0)
		param(0) = Dber.MakeParam("@LC_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
		if Not sRs.eof THEN
			LogDate	= sRs("LC_Regdate")
			LogDateNow1Min = dateadd("n",-1,LogDateNow)		'ÇöÀç ½Ã°£¿¡¼­ 1ºÐÀ» »©ÁØ´Ù.
			if logDate < LogDateNow1Min then				'ºñ±³ÇÑ´Ù
				LogFlagOneMin = true
			else
				LogFlagOneMin = false
			end if
 
		else 
			LogFlagOneMin = true
		end if
			sRs.Close
			Set sRs = Nothing	
		if LogFlagOneMin = true then

						SQL = "UP_INFO_CASH_LOG_INS_CASINO"
						IU_CASH = IU_CASH + money
						reDim param(3)		
						param(0) = Dber.MakeParam("@LC_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
						param(1) = Dber.MakeParam("@LC_Cash",adInteger,adParamInput,,Int(money))
						param(2) = Dber.MakeParam("@LC_GCASH",adInteger,adParamInput,,Int(IU_Cash))
						param(3) = Dber.MakeParam("@LC_SITE",adVarWChar,adParamInput,20,"MICRO")
						Dber.ExecSP SQL,param,Nothing	
						
						'########### È¸¿øÄ³½¬ Áõ°¨
						SQL = "UP_INFO_CASH_UPD_CASINO"
						reDim param(1)
						param(0) = Dber.MakeParam("@IU_Cash",adInteger,adParamInput,,Int(-money))
						param(1) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
						
						Dber.ExecSP SQL,param,Nothing

					'  set Com2 = server.createobject("TesterAPICall.TesterAPI")
					'  result= Com2.btn_withdrawal_Click(acc, money, id, pin)
'H »õ·Î¸¸µç com+ ==================================================================
	Dim HCom
	Set HCom = Server.CreateObject("TotalEGameAPI.TotalEGameAPICall")
'	result = HCom.deposit_Click(acc,money,gcc, id, pin)
	result = HCom.btn_withdrawal_Click(acc, money, id, pin)
'H »õ·Î¸¸µç com+ ==================================================================



	  	else
				'H 1ºÐÈÄ¿¡ ´Ù½ÃÇÏ¶ó´Â °æ°íÃ¢À» ¶ç¿öÁØ´Ù.  ( supportChat.in.asp ¿¡ °æ°íÃ¢ Ãß°¡)
				With Response
				.write "3"  & vbcrlf
				.End
				End With
		end if
		'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
	End if
%>

























