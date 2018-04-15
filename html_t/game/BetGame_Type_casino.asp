<%	

	Set Dber = new clsDBHelper

	SQL = "UP_INFO_Cart_DEL"
	reDim param(1)
	param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

	Dber.ExecSP SQL,param,Nothing
	
	Dber.Dispose
	Set Dber = Nothing 

	IF LCase(Game_Type)  = "smp" Then
		GameList_Title = "승무패"
		Game_Home = "홈/승"
		Game_Draw = "무"
		Game_Away = "원정/패"
	ElseIF LCase(Game_Type)  = "handicap" Then
		GameList_Title = "핸디오버"
		Game_Home = "홈/오버"
		Game_Draw = "핸디/기준값"
		Game_Away = "원정/언더"
	ElseIF LCase(Game_Type)  = "special" Then
		GameList_Title = "스페셜"
		Game_Home = "홈/오버"
		Game_Draw = "핸디/기준값"
		Game_Away = "원정/언더"
	End If
	
%>
<!-- #include file="../_Inc/supportchat.inc.asp" -->
 


<DIV id="container">

<CENTER> 
	
	<TABLE width="780" border="0" cellspacing="0" cellpadding="0">
  <TBODY>
  <TR>
    <TD valign="top">
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
      <TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
        <TBODY>

        <TR>



<% If IU_CASINOID = "" Or IsNull(IU_CASINOID) Then %>
          <TD valign="top" colspan="2"><!--content-->				                      
                   <!--게시판목록-->				                             
            <TABLE width="800" bgcolor="#141414" border="0" cellspacing="1" 
            cellpadding="2">
              <TBODY>
				<tr>
					<td id="betting_result" align="center" bgcolor="000000">카지노를 플레이 하기 위해선 카지노 아이디를 생성하셔야 플레이가 가능합니다.</br>게임가이드 또는 머니전환을 누르시면 계정생성 버튼이 생성됩니다</td>

				</tr>
			 </TBODY></TABLE></TD>
<% Else %>
<!-- 게임 시작-->
          <TD valign="top" colspan="2"><!--content-->				                      
                   <!--게시판목록-->				                             
            <TABLE width="800" bgcolor="#141414" border="0" cellspacing="1" 
            cellpadding="2">
              <TBODY>
				<tr>
					<td id="betting_result" align="center" bgcolor="000000"></td>
					<iframe src="https://livegames.gameassists.co.uk/ETILandingPage/?CasinoID=2635&LoginName=<%=iu_casinoid%>&Password=1234qwer&ClientID=4&UL=ko-kr&VideoQuality=auto6&BetProfileID=DesignStyleA&CustomLDParam=MultiTableMode^^1|LobbyMode^^C&StartingTab=Default&ClientType=1&ModuleID=70004&UserType=0&ProductID=2&ActiveCurrency=Credits" width="874" height="667" frameborder="0" scrolling="no"> </iframe>
				</tr>
			 </TBODY></TABLE></TD>
<% End If %>

 <!-- 게임리스트 끝 -->	

											</TBODY>
										</TABLE>
										<B><B><FONT color="#ff1493"></FONT></B></B>
									</TD>
									<TD width="180" align="left" valign="top" style="backgroundColor: transparent;">

									</TD>
								</TR>
								</TBODY>
							</TABLE>
						</TD>
					</TR>
					</TBODY>
				</TABLE>


<!-- #include file="../_Inc/footer.asp" -->