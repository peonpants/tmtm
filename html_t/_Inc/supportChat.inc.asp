<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<%
IF Session("SD_ID") = "" Then 
	%>
	<script type="text/javascript">
		alert("로그인이 필요합니다.");
		top.location.href = "/"
	</script>
	<%        
	response.End
End IF

%>

<script>
	var doubleSubmitFlag = false;
	function doubleSubmitCheck(){
		if(doubleSubmitFlag){
			return doubleSubmitFlag;
		}else{
			doubleSubmitFlag = true;
			return false;
		}
	}

	function getSessionId2()
	{

		var cid =  document.getElementById("id").value
		var cpin =  document.getElementById("pin").value
		location.href = "/test/result.asp?id="+cid+"&pin="+cpin;			
	}

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

	function addAccount(){
		var casinoid =  document.getElementById("casinoid").value
		var casinopw =  document.getElementById("casinopw").value
		var firstname =  document.getElementById("firstname").value
		var lastname =  document.getElementById("lastname").value
		var currid =  document.getElementById("currid").value
		var mobflag =  document.getElementById("mobflag").value
		var mobnumber =  document.getElementById("mobnumber").value
		var flag =  document.getElementById("flag").value
		var profile =  document.getElementById("profile").value
		var cid =  document.getElementById("id").value
		var cpin =  document.getElementById("pin").value
		if(doubleSubmitCheck()) return;

		if (!confirm("카지노 계정을 생성하시겠습니까?")) {
			return;
		}
		else {
			$(document).ready(function(){
				$.ajax({
					type: "POST",
					url: "../test2/result5.asp",
					data: {casinoid: casinoid, casinopw: casinopw, firstname: firstname, lastname: lastname, currid: currid, mobflag: mobflag, mobnumber: mobnumber, flag: flag, profile: profile, id: cid, pin: cpin},
					success:function( html ) {
						$( "#results5" ).append( html);
						parent.location.href="../test2/temp.asp?casino_id="+html;
					}
				});
			});
		}
	}

	function setAccount()
	{
		var acc =  document.getElementById("acc").value
		var money =  document.getElementById("money").value
		var tong =  document.getElementById("tong").value
		var cid =  document.getElementById("id").value
		var cpin =  document.getElementById("pin").value

		if(doubleSubmitCheck()) return;
		if (money == "") {
			alert("전환을 원하는 금액을 만원단위로 눌러주세요.");
			money.focus();
			return;
		}
		if (!confirm("머니를 전환하시겠습니까?")) {
			return;
		}
		else {
			$(document).ready(function(){
				$.ajax({
					type: "POST",
					url: "../test2/result2.asp",
					data: { acc: acc, money: money, tong: tong, id: cid, pin: cpin },
					success:function( html ) {
						if(Number(html) == 1){
							alert("보유머니가 10,000  이하입니다. \n 입금후에 다시 신청하세요");
						}
						else if (Number(html) == 2){
							alert("보유머니가 전환금액보다 작은경우 처리가 불가합니다. \n전환된 금액을 확인해주세요");
						}
						else if (Number(html) == 3){
							alert("카지노 아이디 오류\n 고객센터에 문의하세요");
						}
						else{
							alert("입금되었습니다.");
						}
						parent.location.href="/";
					}
				});
			});
		}
	}

	function getAccount()
	{
		var acc =  document.getElementById("acc").value
		var money =  document.getElementById("money").value
		var cid =  document.getElementById("id").value
		var cpin =  document.getElementById("pin").value
		if(doubleSubmitCheck()) return;
		if (money == "") {
			alert("전환을 원하는 금액을 만원단위로 눌러주세요.");
			money.focus();
			return;
		}
		if (!confirm("머니를 전환하시겠습니까?")) {
			return;
		}
		else {
			$(document).ready(function(){
				$.ajax({
					type: "POST",
					url: "../test2/result3.asp",
					data: { acc: acc, money: money, id: cid, pin: cpin },
					success:function( html ) {
						if(Number(html) == 1){
							alert("카지노머니가 신청한금액보다 작은경우 처리가 불가합니다. \n전환된 금액을 확인해주세요");
						}
								//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
								else if (Number(html) == 2){
									alert("카지노 아이디 오류 입니다. \n 고객센터에 문의해주세요.");
								}
								else if (Number(html) == 3){
									alert("1분후에 다시 시도해 주세요. \n잔액을 확인해주세요");
								}
								else if (Number(html) == 4){
									alert("에러예외처리중입니다.");
								}
								//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
								else if (Number(html) == 9){
									alert("출금되었습니다..");
								}
								else{
									alert("출금되었습니다..");
								}
								parent.location.href="/";
							}
						});
			});
		}
	}

	function getMoneyValue()
	{
		var acc =  document.getElementById("acc").value
		var cid =  document.getElementById("id").value
		var cpin =  document.getElementById("pin").value
		
		$(document).ready(function(){
			$.ajax({
				type: "POST",
				url: "../test2/result4.asp",
				data: { acc: acc, id: cid, pin: cpin },
				success:function( html ) {
					$( "#results4" ).append( html);
				}
			});
		});
	}

</script>
<%
casino_id = "dump209744"
%>
<input type="hidden" name = "id" id ="id" value="<%=casino_id%>" />
<input type="hidden" name = "pin" id = "pin" value="3b5eed"/>
<input type="hidden" name = "casinoid" id ="casinoid" value=""/>
<input type="hidden" name = "casinopw" id ="casinopw" value="1234qwer"/>
<input type="hidden" name = "acc" id ="acc" value="<%=iu_casinoid%>"/>
<input type="hidden" name = "currid" id ="currid" value="10"/>
<input type="hidden" name = "mobflag" id ="mobflag" value="N"/>
<input type="hidden" name = "mobnumber" id ="mobnumber" value=""/>
<input type="hidden" name = "flag" id ="flag" value="Y"/>
<input type="hidden" name = "profile" id ="profile" value="243"/>
<input type="hidden" name = "tong" id = "tong" value="10"/>
<input type="hidden" name = "firstname" id ="firstname" value="<%=Session("SD_ID")%>"/>
<input type="hidden" name = "lastname" id ="lastname" value="<%=jobsite%>"/>