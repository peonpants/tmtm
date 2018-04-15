
<script type="text/javascript">
    String.prototype.setComma = function() {
        var temp_str = String(this);
        for (var i = 0, retValue = String(), stop = temp_str.length; i < stop; i++) retValue = ((i % 3) == 0) && i != 0 ? temp_str.charAt((stop - i) - 1) + "," + retValue : temp_str.charAt((stop - i) - 1) + retValue;
        return retValue;
    }

    function inputAmount() {
        var chargeMoney = document.frm1.IC_Amount.value.replace(/,/gi, ''); // 불러온 값중에서 컴마를 제거 
        var s = chargeMoney;

        if (s == 0) {  // 첫자리의 숫자가 0인경우 입력값을 취소 시킴  
            chargeMoney.value = '';
            return;
        }

        else {
            document.frm1.IC_Amount.value = s.setComma();
        } 
    }

    function AmountChk() {
        var frm = document.frm1;

        if (frm.IC_Amount.value == "") {
            alert("입금금액을 입력해주세요.");
            frm.IC_Amount.focus();
            return;
        }

        if (parseInt(frm.IC_Amount.value.replace(/,/gi, '')) < 1000) {
            alert("입금액은 1,000원 이상 입력해주세요.");
            frm.IC_Amount.value = "";
            frm.IC_Amount.focus();
            return;
        }

        if ((frm.IC_Name.value == "") || (frm.IC_Name.value.length < 2)) {
            alert("입금하시는분 이름을 정확하게 입력해주세요.");
            frm.IC_Name.focus();
            return;
        }
        if (!confirm("꼭 선입금후 입금신청을 하시기 바랍니다. 신청하시겠습니까?")) return;

        frm.action = "Money_Proc.asp";
        frm.submit();
    }

    function bankacountR() {
        var bfrm = document.BARfrm;
        bfrm.action = "bankacount_Proc.asp";
        bfrm.submit();
    }
    function selAmount(vl) {
        var frm = document.frm1;
        frm.IC_Amount.value = vl;
    }
    
    function InputCheck_( vl)
    {
        var frm = document.frm1;
        
        if(frm.IC_Amount.value == "" || parseInt(vl,10) == 0) frm.IC_Amount.value = 0        
        frm.IC_Amount.value = parseInt(frm.IC_Amount.value,10) +parseInt(vl,10);    
    }


</script>

<!-- #include file="../_Inc/supportchat.inc.asp" -->

<DIV id="container">

<CENTER> 
	
	<TABLE width="1000" border="0" cellspacing="0" cellpadding="0" align="center">
  <TBODY>
  <TR>
    <TD valign="top">
      <TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
        <TBODY>

        <TR>

          <TD valign="top" colspan="2"><!--content-->				                      
                   <!--게시판목록-->				                             
            <TABLE width="1000" border="0" cellspacing="1" 
            cellpadding="2">
              <TBODY>

			 </TBODY></TABLE></TD>

			<table width="1000" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td height="2" colspan="3" ></td>
				</tr>
				<tr> 
					<td width="874" height="400" valign="top">
						<!--	Main	Start	-->
						<table width="874" border="0" cellspacing="0" cellpadding="0" background="/images/menu/title_manual3.png">
							<tr>
								<td width="300" align="left"><script type="text/javascript">Flash("title", 290, 74, "/images/sub/subtitle_05.swf");</script>
									<td>
										<table border="0" cellspacing="2" cellpadding="0" align="right">
											<tr> 
												<td>
													<table border="0" cellspacing="0" cellpadding="2">
														<tr> 
															<td>
																<table border="0" cellspacing="0" cellpadding="0">
																	<tr height="25">
																		<td>&nbsp;</td>
																	</tr>
																	<tr> 
																		<td class="tab1"><% If IU_CASINOID = "" Or IsNull(IU_CASINOID) Then %><a href="/game/BetGame.asp?game_type=casino_help"><% Else %><a href="/game/BetGame.asp?game_type=casino"><% End If 
																							%><img src="/images/btn/btn_casino_play.png"></a>
																			&nbsp;| &nbsp;<a href="/game/BetGame.asp?game_type=casino_help"><img src="/images/btn/btn_casino_guide.png"></a>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
													</table>
												</td>
												<td width="5">&nbsp;</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>

							<table width="874" border="0" cellspacing="0" cellpadding="0">
								<tr> 
									<td>
										<br>
										<table width="850" border="0" cellspacing="0" cellpadding="0">
											<tr> 
												<td width="140" align="right" valign="top" class="board_title3"><font color="ffffff">STEP 
												  0<font color="#80AFFF">1</font>.&nbsp;&nbsp;</td>
												<td class="board_default2">&nbsp;<font color="ffffff">덤프에서는 MICROMING GAMING을 카지노 게임을 서비스 하고있습니다.</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr> 
									<td height="4"></td>
								</tr>
								<tr> 
									<td height="1" background="/images/common/slip_line.gif"></td>
								</tr>
								<tr> 
									<td height="4"></td>
								</tr>
								<tr> 
									<td>
										<br>
										<table width="850" border="0" cellspacing="0" cellpadding="0">
											<tr> 
												<td width="140" align="right" valign="top" class="board_title3"><font color="ffffff">STEP 
												  0<font color="#80AFFF">2</font>.&nbsp;&nbsp;</td>
												<td class="board_default2"><font color="ffffff">&nbsp;처음 카지노는 이용하시는 회원님들께서는 <FONT COLOR="red">아래의 카지노아이디생성 버튼을 누르시면 아이디가 생성</font>되며 카지노 아이디는 덤프에서 관리하므로 따로 보관하실 필요는 없습니다</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr> 
									<td height="4"></td>
								</tr>
								<tr> 
									<td height="1" background="/images/common/slip_line.gif"></td>
								</tr>
								<tr> 
									<td height="4"></td>
								</tr>
								<tr> 
									<td>
										<br>
										<table width="850" border="0" cellspacing="0" cellpadding="0">
											<tr> 
												<td width="140" align="right" valign="top" class="board_title3"><font color="ffffff">STEP 
												  0<font color="#80AFFF">3</font>.&nbsp;&nbsp;</td>
												<td class="board_default2"><font color="ffffff">&nbsp;카지노 아이디를 생성하시면 덤프의 머니를 카지노 머니로 전환하는 메뉴가 생기며 메뉴에서 덤프머니를 카지노머니로 자유롭게 이동신청할수있습니다</td>
											</tr>
											<tr> 
												<td align="right" valign="top" class="board_content">&nbsp;</td>
												<td class="default_2"><font color="ffffff">&nbsp;(카지노머니를 바로 환전신청하실수 없으며 카지노머니를 덤프머니로 전환신청후 환전메뉴에서 환급이 가능합니다)</td>
											</tr>

										</table>
									</td>
								</tr>
								<tr> 
									<td height="4"></td>
								</tr>
								<tr> 
									<td height="1" background="/images/common/slip_line.gif"></td>
								</tr>
								<tr> 
									<td height="4"></td>
								</tr>
								<tr> 
									<td>
										<br>
										<table width="850" border="0" cellspacing="0" cellpadding="0">
											<tr> 
												<td width="140" align="right" valign="top" class="board_title3"><font color="ffffff">STEP 
												  0<font color="#80AFFF">4</font>.&nbsp;&nbsp;</td>
												<td class="board_default2">&nbsp;<font color="ffffff">카지노 관련 이용은 <font color="red">공지사항을 반드시 확인</font>하시기 바라며 이용관련 문의사항은 반드시 고객센터로 문의 주시기 바랍니다</td>
											</tr>
											<tr> 
												<td align="right" valign="top" class="board_content">&nbsp;</td>
												<td class="default_2"><font color="ffffff">&nbsp;(카지노 이용관련 공지사항 내용을 숙지하지 않으시고 게임시에 발생하는 모든 문제에 대해선 이용자의 과실임을 알려드립니다)</td>
											</tr>

										</table>
									</td>
								</tr>
								<tr> 
									<td height="4"></td>
								</tr>
								<tr> 
									<td height="1" background="/images/common/slip_line.gif"></td>
								</tr>
								<tr> 
									<td height="4"></td>
								</tr>
							</table>
<%

If IU_CASINOID = "" Or IsNull(IU_CASINOID) Then
%>

						<table width="874" border="0" cellpadding="0" cellspacing="3" align="center">
							<tr>
								<td align="center"><a href="#a" onclick="addAccount();"><img src="/images/btn/btn_casino_acc.png"></a></td>
							</tr>
						</table>
<% Else %>

									<form name="frm1" method="post" target="ProcFrm">
<input type="hidden" name="Iu_ID" value="<%=Session("SD_ID")%>">
<input type="hidden" name="iu_cash" value="<%=iu_cash%>">
									<table width="874" border="0" cellpadding="4" cellspacing="0">
										<tr > 
											<td width="120" align="center" background="<%=IMAGE_BTN%>bg_patton.jpg" class="board_title">
												<table width="100" border="0" cellspacing="0" cellpadding="0">
													<tr> 
														<td align="right" class="board_name">전환금액</td>
													</tr>
												</table>
											</td>
											<td class="board3">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr> 
														<td width="132">
														<input type="text" style="width:170px" class="input_01" name="IC_Amount" id="money" onKeyup="inputAmount();" onkeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
														<td>                            
														<img src="/images/money/1.png" id="Img6" alt="1만원" onclick="javascript:InputCheck_('10000');" align="absmiddle" border="0" style="cursor: pointer">
                            <img src="/images/money/3.png" id="Img7" alt="3만원" onclick="javascript:InputCheck_('30000');" align="absmiddle" border="0" style="cursor: pointer">
                            <img src="/images/money/5.png" id="Img8" alt="5만원" onclick="javascript:InputCheck_('50000');" align="absmiddle" border="0" style="cursor: pointer">
                            <img src="/images/money/10.png" id="Img9" alt="10만원" onclick="javascript:InputCheck_('100000');" align="absmiddle" border="0" style="cursor: pointer">
                            <img src="/images/money/50.png" id="Img10" alt="50만원" onclick="javascript:InputCheck_('500000');" align="absmiddle" border="0" style="cursor: pointer">
                            <img src="/images/money/100.png" id="Img12" alt="100만원" onclick="javascript:InputCheck_('1000000');" align="absmiddle" border="0" style="cursor: pointer">
                            &nbsp;
                            <img src="/images/money/btn_delete.png" id="Img11" alt="정정" onclick="javascript:InputCheck_(0);" align="absmiddle" border="0" style="cursor: pointer">
							</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr> 
											<td height="1" colspan="2" background="/images/common/slip_line.gif"></td>
										</tr>
									</table>
									<table width="874" border="0" cellpadding="0" cellspacing="3" align="center">
<tr>
											<td align="center"><a href="#a" onclick="setAccount();"><img src="/images/btn/btn_money_change.png"></a></td><td align="center"><a href="#a" onclick="getAccount();"><img src="/images/btn/btn_money_exchange.png"></a></td>
										</tr>
										<!---->
									</table>
									</form>
<% End if%>
<!-- #include file="../_Inc/footer_right.asp" -->
</body>
</html>
 
