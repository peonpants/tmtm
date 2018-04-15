<script src="jquery-1.4.1.min.js" type="text/javascript"></script>

	¾ÆÀÌµð : <input type="text" name = "id" id ="id" value="bus209173"/><br />
	ºñ¹Ð¹øÈ£ : <input type="text" name = "pin" id = "pin" value="7a2239"/><br />
   °èÁÂ : <input type="text" name = "acc" id ="acc" value="OC0022567369"/><br />
   µ· : <input type="text" name = "money" id = "money" value="10"/><br />
		<input type="hidden" name = "tong" id = "tong" value="10"/>
<br />================================°èÁ¤»ý¼º¾Æ±Ô¸ÕÆ®½ÃÀÛ========================================<br />
   Ä«Áö³ë»ý¼º¾ÆÀÌµð : <input type="text" name = "casinoid" id ="casinoid" value=""/><br />
   Ä«Áö³ë»ý¼ºÆÐ½º¿öµå : <input type="text" name = "casinopw" id ="casinopw" value=""/><br />
   Ä«Áö³ë»ý¼ºfirstname : <input type="text" name = "firstname" id ="firstname" value=""/><br />
   Ä«Áö³ë»ý¼ºlastname : <input type="text" name = "lastname" id ="lastname" value=""/><br />
   Ä«Áö³ë»ý¼ºÅëÈ­ : <input type="text" name = "currid" id ="currid" value="10"/><br />
   Ä«Áö³ë»ý¼º¸ð¹ÙÀÏÀ¯¹« : <input type="text" name = "mobflag" id ="mobflag" value="N"/><br />
   Ä«Áö³ë»ý¼º¸ð¹ÙÀÏ¹øÈ£ : <input type="text" name = "mobnumber" id ="mobnumber" value=""/><br />
   Ä«Áö³ë»ý¼ºflag : <input type="text" name = "flag" id ="flag" value="Y"/><br />
   Ä«Áö³ë»ý¼ºprofile : <input type="text" name = "profile" id ="profile" value="234"/><br />
<br />================================°èÁ¤»ý¼º¾Æ±Ô¸ÕÆ®³¡========================================<br />
<br />================================·Î±×ÀÎ========================================<br />
	<a href="#a" onclick="getSessionId();">session ID °¡Á®¿À±â</a>
<div id="results"></div>
<br />================================È¸¿ø°¡ÀÔ========================================<br />
	<a href="#a" onclick="addAccount();">È¸¿ø°¡ÀÔÇÏ±â</a>
<div id="results5"></div>
<br />================================ÀÔ±ÝÇÏ±â========================================<br />

   <a href="#a" onclick="setAccount();">ÀÔ±ÝÇÏ±â</a>
<div id="results2"></div>
<br />================================Ãâ±ÝÇÏ±â========================================<br />
   <a href="#a" onclick="getAccount();">Ãâ±ÝÇÏ±â</a>
<div id="results3"></div>
<br />================================ÀÜ°íº¸±â========================================<br />
   <a href="#a" onclick="getMoneyValue();">ÀÜ°íÇÏ±â</a>
<div id="results4"></div>

<script>

		/*function getSessionId()
		{

			var cid =  document.getElementById("id").value
			var cpin =  document.getElementById("pin").value
			location.href = "/test2/result.asp?id="+cid+"&pin="+cpin;			
		}*/
/*
	getSessionId()		 : APIÇÔ¼ö¸¦ »ç¿ëÇÏ±â À§ÇØ GUID¸¦ °¡Áö°í ¿À±â À§ÇÑ ÇÔ¼ö
	º¯¼ö¼³¸í			 : cid - ¸ð¾Æ³ª´ëÇ¥ID  spo201471
						   cpin - ¸ð¾Æ³ª´ëÇ¥PW a12519
	È£ÃâÇÔ¼ö¼³¸í		 : /test2/result.asp   apiÀÇ IsAuthenticate() ÇÔ¼ö ÇÏ±âÀ§ÇÑ ÆäÀÌÁö
	return			     : GUID(¼¼¼Ç¾ÆÀÌµð)   
*/
		function getSessionId(){
			
			var cid =  document.getElementById("id").value
			var cpin =  document.getElementById("pin").value

			$(document).ready(function(){
				$.ajax({
				  type: "POST",
				  url: "/test2/result.asp",
				  data: {id: cid, pin: cpin},
				  success:function( html ) {
					$( "#results" ).append( html);
				  }
				});
			});


		}
		
/*
	addAccount()		 :  Ä«Áö³ë °èÁ¤À» ¸¸µé±â À§ÇÑÇÔ¼ö
	º¯¼ö¼³¸í			 :  casinoid  - e-sports¿¡¼­ »ý¼ºÇØ¼­ ³Ñ°ÜÁÜ   (""°ø¹éÀ¸·Î ³Ñ±ä´Ù.)
						    casinopw  - Ä«Áö³ë°èÁ¤¿¡¼­ »ç¿ëÇÒ ÆÐ½º¿öµå (¼ýÀÚ)
						    firstname - ¼º
							lastname  - ÀÌ¸§
							currid    - ÅëÈ­(¿ø) : 10
							mobflag   - ¸ð¹ÙÀÏ Çª½Ã ±¤°í Àü¼ÛÀ¯¹«
							mobnumber - ÇÚµåÆù¹øÈ£
							flag	  - 	
							profile
							cid		  - cid - ¸ð¾Æ³ª´ëÇ¥ID  spo201471
							cpin	  - cpin - ¸ð¾Æ³ª´ëÇ¥PW a12519
						 
	È£ÃâÇÔ¼ö¼³¸í		 : /test2/result.asp   apiÀÇ IsAuthenticate() ÇÔ¼ö ÇÏ±âÀ§ÇÑ ÆäÀÌÁö
	return			     : Ä«Áö³ë¾ÆÀÌµð  
*/
		function addAccount(){
			var casinoid =  document.getElementById("casinoid").value
			var casinopw =  document.getElementById("casinopw").value
			var firstname =  document.getElementById("firstname").value
			var lastname =  document.getElementById("lastname").value
			var currid =  document.getElementById("currid").value
			var mobflag =  document.getElementById("mobflag").value
			var mobnumber =  document.getElementById("mobnumber").value
			var flag =  document.getElementById("flag").value
			var profile =  document.getElementById("flag").value
			var cid =  document.getElementById("id").value
			var cpin =  document.getElementById("pin").value

			$(document).ready(function(){
				$.ajax({
				  type: "POST",
				  url: "/test2/result5.asp",
				  data: {casinoid: casinoid, casinopw: casinopw, firstname: firstname, lastname: lastname, currid: currid, mobflag: mobflag, mobnumber: mobnumber, flag: flag, profile: profile, id: cid, pin: cpin},
				  success:function( html ) {
					$( "#results5" ).append( html);
					alert(html);
				  }
				});
			});


		}
/*
	setAccount()		: ÀÔ±ÝÇÔ¼ö
*/
		function setAccount()
		{
			var acc =  document.getElementById("acc").value
			var money =  document.getElementById("money").value
			var tong =  document.getElementById("tong").value
			var cid =  document.getElementById("id").value
			var cpin =  document.getElementById("pin").value
			   
			$(document).ready(function(){
			$.ajax({
				  type: "POST",
				  url: "/test2/result22.asp",
				  data: { acc: acc, money: money, tong: tong, id: cid, pin: cpin },
				  success:function( html ) {
					$( "#results2" ).append( "ÀÔ±Ý¿Ï·á.");
				  }
				});
			});
		}

		function getAccount()
		{
			var acc =  document.getElementById("acc").value
			var money =  document.getElementById("money").value
			var cid =  document.getElementById("id").value
			var cpin =  document.getElementById("pin").value
			   
			$(document).ready(function(){
			$.ajax({
				  type: "POST",
				  url: "/test2/result3.asp",
				  data: { acc: acc, money: money, id: cid, pin: cpin },
				  success:function( html ) {
					$( "#results3" ).append( "Ãâ±Ý¿Ï·á.");
				  }
				});
			});
		}

		function getMoneyValue()
		{
			var acc =  document.getElementById("acc").value
			var cid =  document.getElementById("id").value
			var cpin =  document.getElementById("pin").value
			   
			$(document).ready(function(){
			$.ajax({
				  type: "POST",
				  url: "/test2/result4.asp",
				  data: { acc: acc, id: cid, pin: cpin },
				  success:function( html ) {
					$( "#results4" ).append( html);
				  }
				});
			});
		}

</script>
