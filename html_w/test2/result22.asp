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



	  set Com = server.createobject("TesterAPICall.TesterAPI")
	  result= Com.deposit_Click(acc,money,tong,id,pin)


%>