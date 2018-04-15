<%
Response.Expires = 0
Response.AddHeader "Pragma" , "no-cache"
Response.AddHeader "Cache-Control" , "no-cache,must-revalidate"
REMOST_HOST = Request.ServerVariables("PATH_INFO")
%>
<!-- #include file="../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../_Common/Lib/Request.class.asp" -->
<!-- #include file="../_Common/Api/sql_injection.asp" -->
<!-- #include file="../_Conf/Common.Conf.asp" -->
<!-- #include file="../_Lib/SiteUtil.Class.asp" -->
<%
IF Session("SD_ID") <> "" THEN
    IF SITE_MAIN_USE Then
        response.Redirect("/main.asp")
    Else
        response.Redirect("/Game/BetGame.asp")
    End IF        
End IF

Set Dber = new clsDBHelper
	SQL = "UP_GetSET_SITE_OPEN"
		
	Set sRs = Dber.ExecSPReturnRS(SQL,nothing,nothing)
	SITE_OPEN = sRs("SITE_OPEN")
SET sRs = Nothing
SET Dber = Nothing	
%>
<!DOCTYPE HTML>
<!-- saved from url=(0022)http://www.y-3.com/kr/ -->
<!DOCTYPE html PUBLIC "" ""><!--[if lt IE 7]> <html class="no-js ie6 oldie locale-kr" lang="en"> <![endif]--><!--[if IE 7]>    <html class="no-js ie7 oldie locale-kr" lang="en"> <![endif]--><!--[if IE 8]>    <html class="no-js ie8 oldie locale-kr" lang="en"> <![endif]--><!--[if gt IE 8]><!--><HTML 
class="no-js locale-kr" lang="en"><!--<![endif]--><HEAD><META 
content="IE=11.0000" http-equiv="X-UA-Compatible">
 <LINK href="//plus.google.com/114579536846742594651" rel="publisher"> 
<META charset="utf-8"> 
<META http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> <TITLE>ADIDAS 
Y-3</TITLE> 
<META name="author" content="adidas Y-3"> 
<META name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no"> 
<LINK href="ADIDAS%20Y-3_files/style.min.css" rel="stylesheet"> <LINK href="http://www.y-3.com/favicon.ico" 
rel="shortcut icon"> <LINK href="ADIDAS%20Y-3_files/sharedDivision.css" rel="stylesheet"> 
<SCRIPT src="ADIDAS%20Y-3_files/modernizr-2.0.6.min.js"></SCRIPT>
 
<META name="p:domain_verify" content="2ae13bd1687aae9196b11da53aa291f3"> 
<SCRIPT>

	var urlParts = completeURL.split("/");
	var countryCode = "KR";
	var language = (countryCode == "US") ? "EN" : countryCode;
	var todayDate = "020418";
	var env = "PRODUCTION";

</SCRIPT>
 
<META name="GENERATOR" content="MSHTML 11.00.9600.18838"></HEAD> <!-- DEC8_001 --> 
<BODY class="Y3STORE">
<SCRIPT type="text/javascript">
var utag_data = {
	page_name: "HOME",
	campaign_name: "Y-3",
	is_mobile: "",
	country: countryCode,
	date: todayDate,
	environment: env,
	language: language,

};
</SCRIPT>
 
<SCRIPT type="text/javascript">
	(function(a,b,c,d){
	a='//tags.tiqcdn.com/utag/adidas/adidasbrand/prod/utag.js';
	b=document;c='script';d=b.createElement(c);d.src=a;d.type='text/java'+c;d.async=true;
	a=b.getElementsByTagName(c)[0];a.parentNode.insertBefore(d,a);
	})();
</SCRIPT>
 <!-- QLNAV START --> 
    <style>
        body{background-color:#ffffff}
.login__bg {
	background: url("/images/login/login_bg1.jpg") no-repeat 50% 0px rgb(0, 0, 0); min-width: 0px;
}
.login {
	overflow: hidden; position: relative;
}
.login h1 {
	background: url("/images/main/logo.png") no-repeat 0px 0px; margin: 73px auto 105px; width: 393px; height: 255px; overflow: hidden;
}
.login .login__box {
	margin: 0px auto; border-radius: 5px; width: 347px; height: 250px; font-family: Arial, Helvetica, sans-serif; font-size: 12px;
}
.login .login__box h2 {
	color: rgb(235, 235, 235); font-family: "Calibri", Arial; font-size: 44px; font-weight: bold; margin-bottom: 4px;
}
.login .login__box .desc {
	color: rgb(255, 255, 255); font-size: 18px; margin-bottom: 16px;
}
.login .login__card {
	margin: 7px auto 0px; position: relative;
}
.login .login__card dl {
	overflow: hidden;
}
.login .login__card dt {
	margin: 0px 0px 7px; width: 80px; height: 36px; text-align: right; line-height: 36px; padding-right: 10px; float: left; display: none;
}
.login .login__card dd {
	overflow: hidden;
}
.login .login__card input[type=text] {
	background: rgb(255, 255, 255); padding: 13px 10px; border-radius: 5px; border: 1px solid rgb(255, 255, 255); transition:0.25s ease-in-out; border-image: none; width: 100%; color: rgb(0, 0, 0); font-size: 12px; margin-bottom: 14px; box-sizing: border-box; -webkit-appearance: none;
}
.login .login__card input[type=password] {
	background: rgb(255, 255, 255); padding: 13px 10px; border-radius: 5px; border: 1px solid rgb(255, 255, 255); transition:0.25s ease-in-out; border-image: none; width: 100%; color: rgb(0, 0, 0); font-size: 12px; margin-bottom: 14px; box-sizing: border-box; -webkit-appearance: none;
}
.login .login__card input[type=text]:focus {
	border: 1px solid rgba(255, 255, 255, 0.36); border-image: none;
}
.login .login__card input[type=password]:focus {
	border: 1px solid rgba(255, 255, 255, 0.36); border-image: none;
}
.login .login__card a {
	display: block;
}
.login .login__card a:hover {
	opacity: 1;
}
.login .login__foot {
	text-align: center; margin-top: 31px;
}
.login .login__foot .txt {
	color: rgb(97, 9, 10); line-height: 18px; font-size: 14px;
}
.login .login__foot .cp {
	color: rgb(177, 47, 46); padding-top: 20px; font-size: 14px; margin-top: 20px; vertical-align: top; display: inline-block; position: relative;
}
.login .login__foot .cp::after {
	left: 0px; top: 0px; height: 2px; right: 0px; position: absolute; content: ""; background-color: rgb(177, 47, 46);
}
.login .login__card input:-ms-input-placeholder {
	color: rgba(255, 255, 255, 0.42);
}
.login .login-btn1 {
	
}
.login .login-btn1 .btn__submit1 {
	background: linear-gradient(rgb(100, 100, 100) 0%, rgb(50, 50, 50) 100%) 0% 0% / contain; border-radius: 5px; border: 1px solid rgb(211, 221, 227); transition:0.25s ease-in-out; border-image: none; left: 50%; top: 120px; width: 268px; height: 42px; color: rgba(255, 255, 255, 0.64); overflow: hidden; font-size: 15px; font-weight: bold; margin-left: -134px; display: block; position: absolute; cursor: pointer;
}
.login .login-btn1 .btn__submit1:hover {
	background: linear-gradient(rgb(100, 100, 100) 0%, rgb(150, 150, 150) 100%); border-color: rgb(255, 255, 255); color: rgb(0, 0, 0);
}
.login .login-btn2 {
	
}
.login .login-btn2 .btn__submit2 {
	background: linear-gradient(rgb(100, 100, 100) 0%, rgb(50, 50, 50) 100%) 0% 0% / contain; border-radius: 5px; border: 1px solid rgb(211, 221, 227); transition:0.25s ease-in-out; border-image: none; left: 50%; top: 170px; width: 263px; height: 42px; color: rgba(255, 255, 255, 0.64); overflow: hidden; font-size: 15px; font-weight: bold; margin-left: -134px; display: block; position: absolute; cursor: pointer;
}
.login .login-btn2 .btn__submit2:hover {
	background: linear-gradient(rgb(100, 100, 100) 0%, rgb(150, 150, 150) 100%); border-color: rgb(255, 255, 255); color: rgb(0, 0, 0);
}
.login .login-help {
	left: 0px; top: 185px; text-align: center; right: 0px; position: absolute;
}
.login .login-help a {
	padding: 0px 22px; transition:0.25s ease-in-out; height: 24px; color: rgba(255, 255, 255, 0.49); line-height: 24px; letter-spacing: 0px; font-size: 12px; display: inline-block; background-color: rgba(255, 255, 255, 0.13);
}
.login .login-help a:hover {
	color: rgb(255, 255, 255); text-decoration: none; background-color: rgba(0, 0, 0, 0.2);
}
    </style> 
<HEADER class="notLoggedPromo" id="siteHeader"><NAV class="menu navInline topBar">
<UL class="pullLeft">
  <LI class="global-division selected" id="macro-Y3STORE"><A id="menuY3STORE" 
  href="/"><SPAN class="brandLabel">Y-3</SPAN></A></LI>
  <LI class="global-division" id="macro-ADIDASBY"><A id="menuADIDASBY" href="/"><SPAN 
  class="brandLabel">ADIDAS BY</SPAN></A></LI></UL>	
<form name="LoginFrm" method="post" target="" onSubmit="return LoginFrmChk(this);">
<input type="hidden" name="mode">

<UL class="pullRight">
<LI class="storeLocator">
	<span valign="top" height="50"><font color="white">ID:<input type="text" name="IU_ID" id="IU_ID" class="id_box" tabindex="1" style="ime-mode:disabled; margin-top: -8px;" onfocus="this.className=&#39;bg_input_on&#39;" onblur="if(this.value==&#39;&#39;){this.className=&#39;id_box&#39;}" autocomplete="off"></span>
	<span valign="top" height="50"><font color="white">PW:<input type="password" name="IU_PW" id="IU_PW" maxlength="16" class="pw_box" tabindex="2" onfocus="this.className=&#39;bg_input_on&#39;" onblur="if(this.value==&#39;&#39;){this.className=&#39;pw_box&#39;}" style=" margin-top: -8px;"></span>

  <LI class="storeLocator"><input type="submit" onmouseout="MM_swapImgRestore()" name="login" style="width: 50px;  margin-top: -5px; background-color: #222;"value="login"></LI>
  <LI class="login accountLink"><A class="grey" href="/member/join_Chack.asp"><SPAN id="openLogin">REGISTER</SPAN></A></form>
</HEADER><!-- QLNAV END --> 
<style>

</style>
<DIV id="container"><!-- Grid construct kr -->
<img src="/images/login/login_bg.jpg" valign="absmiddle">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

</head>
<body>
 
 <!-- 2 --> <!-- FOOTER --> <FOOTER id="siteFooter"><NAV class="navInline">
<UL>
  <LI class="shipTo">Shipping to:&nbsp;South Korea</LI>
  <LI class="countrySel"><SPAN>-</SPAN>Change</LI>
  <LI class="divider">|</LI>
  <LI><A class="openShippingTimes" 
  target="_self">Shipping</A></LI>
  <LI><A class="openReturns" 
  target="_self">Returns</A></LI>
  <LI>Customer 
  Care</LI>
  <LI>B2B</LI>
  <LI>Site Map</LI>
  <LI>Legal Area</LI>
  <LI class="divider">|</LI>
  <LI class="openNewsletterPopup"><A class="openNewsletterPopup" 
  target="_self">Newsletter</A></LI>
  <LI class="divider">|</LI>
  <LI><A class="openFollowUs" target="_self">FOLLOW 
  US</A>
  <DIV id="socials">
  <H2>FOLLOW US on</H2>
  <DIV class="lineBreak"><!----></DIV>
</DIV></LI></UL></NAV>
<DIV class="credits pullRight lower"><SPAN class="copyright_exp">© 2018 adidas 
Int. Trading BV</SPAN><SPAN class="copyright_short" style="display: none;"><A 
class="openCopyright">Powered by YOOX NET-A-PORTER GROUP – © 
2018</A></SPAN></DIV>

</FOOTER><!-- YOOX START --><!-- USE REAL --> 
 
<SCRIPT type="text/javascript">if(AdidasY3&&AdidasY3.config){AdidasY3.config.basePath="http://www.y-3.com/";AdidasY3.config.assetsDirectory="/"}</SCRIPT>
 
<SCRIPT type="text/javascript">
	//AdidasY3.config.countryCode = "kr";
  var countryCode = "kr";
  $(function(){

    if(countryCode == 'cn'){
      console.log("remove popup");
      // No pointer on non-link images
      setTimeout(function(){
        console.log("1.42");
        $('body').addClass('cn');

      }, 50);
      //css('cursor','default')

      /*
      $('#colorbox').css('display','none');//remove();
      $('#cboxOverlay').css('display','none');//.remove();
      $('.cboxLoadedContent').css('width','127px');
      */

      // Close popup
      $.colorbox.close();
      $('#socialsPopup ul li a svg').attr('style', 'height:30px !important;');
    }

    // Close popup (temp)
    $.colorbox.close();
  })
</SCRIPT>
 <!-- TEALIUM --> <!-- Old link used before jan-2016 <script type="text/javascript" src="//tags.tiqcdn.com/utag/adidas/adidasbrand/prod/utag.sync.js"></script>--> 
 <!-- /TEALIUM --> <!--[if lt IE 7 ]>
	<script src="//ajax.googleapis.com/ajax/libs/chrome-frame/1.0.3/CFInstall.min.js"></script>
	<script>window.attachEvent('onload',function(){CFInstall.check({mode:'overlay'})})</script>
<![endif]--> 
</BODY></HTML>
<iframe name="HiddenFrm" src="/Blank.html" frameborder="0" width="0" height="0" frameborder="0"></iframe>
<iframe name="ProcFrm" src="/Blank.html" frameborder="0" width="0" height="0" frameborder="0"></iframe>

<script type="text/javascript">

	function LoginFrmChk(frm) 
	{
		
		if ((frm.IU_ID.value == "") || (frm.IU_ID.value.length < 3))	
		{
			alert("회원님의 ID를 입력해 주세요.");	
			frm.IU_ID.focus();
			return false;	
		}
		
		if ((frm.IU_PW.value == "") || (frm.IU_PW.value.length < 4))	
		{
			alert("회원님의 패스워드를 입력해 주세요.");
			frm.IU_PW.focus();
			return false;	        
		}
		


		frm.action = "/Login/index.asp";
	}

</script>