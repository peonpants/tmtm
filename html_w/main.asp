<!-- #include file="../_Code/main.Code.asp" -->
<!-- #include file="_Inc/popup.inc.asp" -->
<!-- #include file="_Inc/top.asp" -->	

<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tbody>
		<tr>
			<td align="center">
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tbody><tr>
						<td width="100%" valign="top">
							<!--  Mypage Menu -->
					<table width="100%" cellpadding="0" cellspacing="0" border="0">

						<tbody>
							<tr>
							<td width="100%" height="300" colspan="2" align="center">
								<img id="ctl00_ContentPlaceHolder1_imageSlide" src="" style="border-width:0px;">
							</td>
						</tr>
						<tr>
							<td width="100%">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
									<tbody><tr>
										<td height="270px" valign="top" class="style4">
											<table border="0" cellpadding="0" cellspacing="0" style="font-size:12px; font-family:dotum; background-image: url('images/todaysmatch1.jpg'); background-repeat: no-repeat; width: 535px; height: 270px; color: white">
												<tbody><tr>
													<td height="40px"></td>
												</tr>
<%
							Set Dber = new clsDBHelper

							'########   진행 중인 게임 리스트 출력    ##############
							
							SQL = "SELECT  Top 8 RL_League, RL_Sports,  RL_Image ,  IG_StartTime, IG_Team1, IG_Team2, IG_HANDICAP, IG_TEAM1BENEFIT, IG_TEAM2BENEFIT, IG_DRAWBENEFIT, IG_TEAM1BETTING, IG_TEAM2BETTING, IG_TYPE, ( IG_TEAM1BETTING + IG_DRAWBETTING + IG_TEAM2BETTING ) AS ALL_BETTING  FROM Info_Game WHERE IG_Status = 'S' and RL_SPORTS <> '실시간' and IG_EVENT = 'N' ORDER BY ALL_BETTING DESC"
							
							Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)
							
							INPC = sRs.RecordCount

							If Not sRs.EOF THEN

								For RE = 1 TO INPC
								   
									IF sRs.EOF THEN
										EXIT FOR
									END IF

									RL_League		= sRs("RL_League")
									IG_StartTime	= sRs("IG_StartTime")
									IG_Team1		= sRs("IG_Team1")
									IG_Team2		= sRs("IG_Team2")
									IG_TEAM1BENEFIT		= sRs("IG_TEAM1BENEFIT")
									IG_HANDICAP         = sRs("IG_HANDICAP")  
									IG_TEAM2BENEFIT		= sRs("IG_TEAM2BENEFIT")
									IG_DRAWBENEFIT		= sRs("IG_DRAWBENEFIT")
									RL_Sports		= sRs("RL_Sports")
									RL_Image		= sRs("RL_Image")
									RL_Image		= "<img align='absmiddle' src='" & dfSiteUtil.GetLeagueImage(RL_Image) & "' width='18' />"
									IG_TYPE         = sRs("IG_TYPE")      
									ALL_BETTING     = sRs("ALL_BETTING") 
									IG_TEAM1BETTING	= sRs("IG_TEAM1BETTING") 
									IG_TEAM2BETTING	= sRs("IG_TEAM2BETTING") 

								If IG_TEAM1BETTING > IG_TEAM2BETTING Then
								ne=1
								Else
								ne=2
								End if

								i=i+1
%>		
											<tr>
												<td width="2px"></td>
												<td width="93px" height="29px" align="center"><%=dfSiteUtil.GetBetDate(IG_StartTime)%></td>
												<td width="42px" align="center"><%=RL_Image%></td>
												<td width="214px" align="center"><%IF IG_TYPE=2 Then %><font color=red>▲</font><% elseIf ig_type=1 Then %><font color="red">[H]</font><% End If %>&nbsp;&nbsp;<%= Left(IG_Team1,12) %></td>
												<td width="37px" align="center">VS</td>
												<td width="214px" align="center"><%= Left(IG_Team2,12) %>&nbsp;&nbsp;<% If ig_type=2 Then %><font color=blue>▼</font><% elseIf ig_type=1 Then %><font color="0072ff">[H]</font><% End If %></td>
												<td width="2px"></td>
											</tr>

<%
								sRs.MoveNext
								NEXT
								End IF	
							sRs.close
							Set sRs = Nothing                        
%>    

												<tr>
													<td></td>
												</tr>

											</tbody></table>
										</td>
										<td class="style5">
										</td>
										<td width="420px" height="270px" valign="top">
											<table border="0" cellpadding="0" cellspacing="0" style="font-size:12px; font-family:dotum; background-image: url('images/notice1.jpg'); background-repeat: no-repeat; height: 270px; width: 420px; margin-left: 0px;">
												<tbody><tr>
													<td height="41px"></td>
												</tr>
<%	
            '### 공지사항을 불러온다
			Set DberNotice = new clsDBHelper
			sql = "SELECT Top 8 BF_IDX, BF_TITLE, BF_REGDATE, BF_HITS, BF_LEVEL FROM BOARD_FREE WHERE BF_STATUS=1 AND BF_LEVEL > 0 AND (BF_SITE = ? OR BF_SITE = 'DUMP')  order by BF_REGDATE desc"

			reDim param(0)
			param(0) = DberNotice.MakeParam("@jobstite",adVarWChar,adParamInput,20,JOBSITE)
			Set sRsNotice = DberNotice.ExecSQLReturnRS(SQL,param,nothing)

			NOTC = sRsNotice.RecordCount

			IF NOTC > 0 THEN
			
				FOR NC = 1 To NOTC
					   

				    BF_IDX = sRsNotice(0)
				    BF_TITLE = sRsNotice(1)
				    BF_REGDATE = sRsNotice(2)
				    BF_HITS = sRsNotice(3)
				    BF_LEVEL = CDbl(sRsNotice(4))
				        
                    IF BF_LEVEL	= 1 Then
                        BF_IMAGES = "/img/sub/notice.gif"
                    ElseIF BF_LEVEL = 2 Then
                        BF_IMAGES = "/img/sub/event.gif"
                    End IF			

					BF_REGDATE		= mid(sRsNotice("BF_REGDATE"),3,8)

%>				
												<tr>
													<td width="2px" height="28px"></td>
													<td width="10px"></td>
													<td width="332px" align="left">
														<a href="/freeboard/board_Read.asp?BF_IDX=<%= BF_IDX %>&page=1"><font color="yellow"><%=BF_TITLE%></font></a>
													</td>
													<td width="2px"></td>
												</tr>
<%
                    sRsNotice.Movenext
                Next
        End IF
        
        sRsNotice.close
		Set sRsNotice = Nothing
		DberNotice.Dispose
		Set DberNotice = Nothing                          
%>    



																<tr>
																	<td></td>
																</tr>

															</tbody></table>
														</td>
													</tr>
												</tbody></table>
											</td>
										</tr>
									</tbody></table>
									<input type="hidden" name="ctl00$ContentPlaceHolder1$hid_show" id="ctl00_ContentPlaceHolder1_hid_show" value="0">
									<input type="hidden" name="ctl00$ContentPlaceHolder1$hid_show2" id="ctl00_ContentPlaceHolder1_hid_show2" value="0">
									<input type="hidden" name="ctl00$ContentPlaceHolder1$hid_show3" id="ctl00_ContentPlaceHolder1_hid_show3" value="0">
									<input type="hidden" name="ctl00$ContentPlaceHolder1$hid_show4" id="ctl00_ContentPlaceHolder1_hid_show4" value="0">
									<div id="ctl00_ContentPlaceHolder1_layer_pop" style="position: absolute; z-index: 3; display: none; width: 400px; height: 550px; top: 230px; left: 150px;" class="ui-draggable">
										<table id="ctl00_ContentPlaceHolder1_popup1" cellspacing="0" cellpadding="0" border="0" style="border-collapse:collapse;border:none">
											<tbody><tr>
												<td style="height:550px;width:400px;border:1px solid #4f5750;">
													<img src="/ckfinder/userfiles/images/betmoney.png" usemap="#Map0904"><map id="Map0904" name="Map0904"><area alt="개경주" coords="30,261,170,299" href="B365Greyhounds.aspx" shape="rect"> <area alt="가상축구" coords="229,259,370,300" href="B365Soccer.aspx" shape="rect"> <area alt="홀짝" coords="32,451,172,490" href="MGModd.aspx" shape="rect"> <area alt="바카라" coords="233,450,373,490" href="MGMbaca.aspx" shape="rect"></map>
												</td>
											</tr><tr style="height:25px;">
												<td align="left" style="border:1px solid #4f5750;background-color:#242720;">&nbsp;<input type="checkbox" name="today_no" id="today_no" value="1">&nbsp;하루동안 보이지 않기&nbsp;&nbsp; <input type="button" value="닫기" onclick="javascript:pop_close();" style="background-color:#9fa7a0; border:1px solid #0f1710; color:Black;"></td>
											</tr>
										</tbody></table>
									</div>

									<div id="ctl00_ContentPlaceHolder1_layer_pop2" style="position: absolute; z-index: 3; display: none; width: 400px; height: 300px; top: 230px; left: 555px;" class="ui-draggable">
										<table id="ctl00_ContentPlaceHolder1_popup2" cellspacing="0" cellpadding="0" border="0" style="border-collapse:collapse;border:none">
											<tbody><tr>
												<td style="height:300px;width:400px;border:1px solid #4f5750;">
													<img alt="" src="/ckfinder/userfiles/images/bn_180201.jpg" style="width: 400px; height: 550px;">
												</td>
											</tr><tr style="height:25px;">
												<td align="left" style="border:1px solid #4f5750;background-color:#242720;">&nbsp;<input type="checkbox" name="today_no" id="today_no" value="1">&nbsp;하루동안 보이지 않기&nbsp;&nbsp; <input type="button" value="닫기" onclick="javascript:pop_close2();" style="background-color:#9fa7a0; border:1px solid #0f1710; color:Black;"></td>
											</tr>
										</tbody></table>
									</div>

									<div id="ctl00_ContentPlaceHolder1_layer_pop3" style="position: absolute; z-index: 3; display: none; width: 400px; height: 400px; top: 230px; left: 960px;" class="ui-draggable">
										<table id="ctl00_ContentPlaceHolder1_popup3" cellspacing="0" cellpadding="0" border="0" style="border-collapse:collapse;border:none">
											<tbody><tr>
												<td style="height:400px;width:400px;border:1px solid #4f5750;">
													<img alt="" src="/ckfinder/userfiles/images/%EC%A7%80%EC%9D%B8%EC%B6%94%EC%B2%9C%EC%9D%B4%EB%B2%A4%ED%8A%B8.jpg" style="width: 400px; height: 500px;">
												</td>
											</tr><tr style="height:25px;">
												<td align="left" style="border:1px solid #4f5750;background-color:#242720;">&nbsp;<input type="checkbox" name="today_no" id="today_no" value="1">&nbsp;하루동안 보이지 않기&nbsp;&nbsp; <input type="button" value="닫기" onclick="javascript:pop_close3();" style="background-color:#9fa7a0; border:1px solid #0f1710; color:Black;"></td>
											</tr>
										</tbody></table>
									</div>

								</td>
							</tr>
						</tbody></table>
				</td>
			</tr>
		</tbody>
	</table>
	<!-- #include file="_Inc/footer_right.asp" -->