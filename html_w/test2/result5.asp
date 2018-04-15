<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<%
   casinoid   = Request("casinoid")
   casinopw = Request("casinopw")
   firstname = Request("firstname")
   lastname = Request("lastname")
   currid = Request("currid")
   mobflag = Request("mobflag")
   mobnumber= Request("mobnumber")
   flag = Request("flag")
   profile = Request("profile")
   id  = Request("id")
   pin  = Request("pin")



'H ±¸¹ö¹ø testerAPI.DLL »ç¿ë¾ÈÇÔ
'  set Com = server.createobject("TesterAPICall.TesterAPI")
'  result= Com.addAccount_Click(casinoid, casinopw, firstname, lastname, currid, false, mobnumber, true, profile, id, pin)


'H »õ·Î¸¸µç com+ TotalEGameAPI.DLL==================================================================
	Dim HCom2
	Set HCom2 = Server.CreateObject("TotalEGameAPI.TotalEGameAPICall")
'	result1 = HCom2.GetAccountBalance(acc, id, pin)
  result= HCom2.addAccount_Click(casinoid, casinopw, firstname, lastname, currid, false, mobnumber, true, profile, id, pin)
'	result = HCom.btn_withdrawal_Click(acc, money, id, pin)
'H »õ·Î¸¸µç com+ ==================================================================


   htmlView = result
   Response.Write htmlView
%>