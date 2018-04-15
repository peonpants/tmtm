<!-- #include file="../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../_Common/Lib/Request.class.asp" -->
<!-- #include file="../_Common/Api/sql_injection.asp" -->
<!-- #include file="../_Conf/Common.Conf.asp" -->
<!-- #include file="../_Lib/SiteUtil.Class.asp" -->
<%
Response.CodePage = 65001
Response.CharSet = "UTF-8"

    IF NOT SITE_MAIN_USE Then
        response.Redirect("/Game/BetGame.asp")
    End IF        


    Dim mainPage : mainPage = True
%>

