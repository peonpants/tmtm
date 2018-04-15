<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<%
	On Error Resume Next
	If Session("SD_ID")<>"" Then
		Set Dber = new clsDBHelper
		SQL = "select IU_ID,IU_LEVEL,IU_STATUS,IU_CASH,(select isnull(sum(IC_AMOUNT),0) from INFO_CHARGE where IC_ID=?) as IU_CHARGE from [INFO_USER] where IU_ID=?"
		reDim param(1)
		param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
		If Err Then Response.write Err.description:Response.End
		IF NOT sRs.EOF Then
			Response.write("{:"&sRs("IU_ID")&":"&sRs("IU_LEVEL")&":"&sRs("IU_STATUS")&":"&sRs("IU_CASH")&":"&sRs("IU_CHARGE")&":}")
		End If
		sRs.Close
		Set sRs = Nothing
	End If
%>