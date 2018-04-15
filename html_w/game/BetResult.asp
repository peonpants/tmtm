 <!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->

 <%
	SETSIZE = 10
	PGSIZE = 30

    PAGE            = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("PAGE")), 1, 1, 999999) 
    sType            = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("sType")), 0, 1, 6)     
    sType1            = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("sType1")), 1, 1, 11)     
    
	IF PAGE = "" THEN
		PAGE = 1
		STARTPAGE = 1
	ELSE
		PAGE = CINT(PAGE) 
		STARTPAGE = INT(PAGE/SETSIZE)

		IF STARTPAGE = (PAGE/SETSIZE) THEN
			STARTPAGE = PAGE-SETSIZE + 1
		ELSE
			STARTPAGE = INT(PAGE/SETSIZE) * SETSIZE + 1
		END IF
	END IF
	
	Set Dber = new clsDBHelper
		
	SQLR = " Info_Game Where (IG_Status = 'F' OR IG_Status = 'C') "


    IF sType <> 0 Then
        SELECT CASE sType
        CASE 1         
            SQLR = SQLR & " AND RL_SPORTS = '축구' "
        CASE 2
            SQLR = SQLR & " AND RL_SPORTS = '야구' "
        CASE 3
            SQLR = SQLR & " AND RL_SPORTS = '농구' "
        CASE 4
            SQLR = SQLR & " AND RL_SPORTS = '배구' "
        CASE 5
            SQLR = SQLR & " AND RL_SPORTS = '스타크래프트' "
        CASE 6
            SQLR = SQLR & " AND RL_SPORTS IN ('아이스하키', '피겨스케이팅','격투기')"                                                
        END SELECT
    End IF
    
    IF sType1 <> 0 Then
        SELECT CASE sType1
        CASE 1         
            SQLR = SQLR & " AND IG_TYPE IN (0, 1,2) AND IG_SP = 'N' AND IG_EVENT = 'N' AND RL_SPORTS <> '실시간'"
        CASE 2
            SQLR = SQLR & " AND IG_TYPE IN (0) AND IG_SP = 'N' AND IG_EVENT = 'N' AND RL_SPORTS <> '실시간'"
        CASE 3
            SQLR = SQLR & " AND IG_TYPE IN (1, 2) AND IG_SP = 'N' AND IG_EVENT = 'N' AND RL_SPORTS <> '실시간'"
        CASE 4
            SQLR = SQLR & " AND IG_SP = 'Y' AND IG_EVENT = 'N' AND RL_SPORTS <> '실시간'"
        CASE 5
            SQLR = SQLR & " AND IG_EVENT = 'O' AND RL_SPORTS <> '실시간'"
        CASE 6
            SQLR = SQLR & " AND RL_SPORTS = '실시간'"
		END SELECT    
    End IF
    
	SQL = "SELECT COUNT(*) AS TN FROM "& SQLR &""


	Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)
	
	TOMEM = CDbl(sRs(0))
	sRs.close
	Set sRs = Nothing


	SQL = "SELECT COUNT(*) AS TN From "& SQLR &""

	Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)
	TN = CDbl(sRs("TN"))
	sRs.close
	Set sRs = Nothing


	PGCOUNT = INT(TN/PGSIZE)
	IF PGCOUNT * PGSIZE <> TN THEN 
		PGCOUNT = PGCOUNT+1
	END If

    '########   경기 마감 리스트 출력   ##############
    SQL =  "SELECT TOP " & PGSIZE & " IG_Idx, RL_League, RL_Image, CONVERT(VARCHAR, IG_StartTime, 111) + ' ' + CONVERT(VARCHAR(8), IG_StartTime, 114) AS IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Score1, IG_Score2, IG_Result, IG_Type, RL_Sports, IG_Status, IG_Memo, IG_SP, IG_Draw FROM "& SQLR &" AND IG_Idx NOT IN (SELECT TOP " & ((PAGE - 1) * PGSIZE)   & " IG_Idx  FROM "& SQLR &" ORDER BY IG_STARTTIME DESC, rl_league DESC, IG_TEAM1 DESC)  ORDER BY IG_STARTTIME DESC, rl_league DESC, IG_TEAM1 DESC"

    'response.Write SQL
	Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)

	IF NOT sRs.EOF THEN
		NEXTPAGE = CINT(PAGE) + 1
		PREVPAGE = CINT(PAGE) - 1
		NN = TN - (PAGE-1) * PGSIZE
	ELSE
		TN = 0
		PGCOUNT = 0
	END IF
	

%>   
<TABLE width="1010" border="0" cellspacing="0" cellpadding="0">
  <TBODY>
  <TR>
    <TD align="center">
      <TABLE width="1010" border="0" cellspacing="0" cellpadding="0">
        <TBODY>
        <TR>
          <TD width="100%" valign="top"><!--  Mypage Menu -->                  
                               
            <TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
              <TBODY>
              <TR>
                <TD align="left"><IMG align="absmiddle" src="/images/game/result.png"> 
                              </TD></TR>
              <TR>
                <TD height="10"></TD></TR>
              <TR>
                <TD align="center">
                  <TABLE width="400" border="0" cellspacing="0" 
                    cellpadding="0"><TBODY>
                    <TR>
                      <TD><a href="betresult.asp?sType1=1"><img src="/images/game/re_1.jpg"></a></TD>
                      <TD><a href="betresult.asp?sType1=2"><img src="/images/game/re_2.jpg"></a></TD>
                      <TD><a href="betresult.asp?sType1=3"><img src="/images/game/re_3.jpg"></a></TD>
                      <TD><a href="betresult.asp?sType1=4"><img src="/images/game/re_4.jpg"></a></TD>
                      <TD><a href="betresult.asp?sType1=5"><img src="/images/game/re_5.jpg"></a></TD>
                      <TD><a href="betresult.asp?sType1=6"><img src="/images/game/re_10.jpg"></a></TD></TR></TBODY></TABLE><INPUT name="ctl00$ContentPlaceHolder1$hid_select" id="ctl00_ContentPlaceHolder1_hid_select" type="hidden" value="0"> 
                              </TD></TR></TBODY></TABLE><BR>
            <TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
              <TBODY>
              <TR class="game_head">
                <TH width="10%" height="30" align="center">경기일시                
                       </TH>
                <TH width="4%" align="center">                        종목       
                                </TH>
                <TH width="10%" align="center">                        리그      
                                 </TH>
                <TH width="28%" align="center">                        승(HOME) 
                                      </TH>
                <TH width="5%" align="center">무                     </TH>
                <TH width="28%" align="center">                        패(AWAY) 
                                      </TH>
                <TH width="7%" align="center">점수                     </TH>
                <TH width="8%" align="center">                        결과       
                                </TH></TR></TBODY></TABLE>
            <TABLE width="100%" style="text-align: center; border-spacing: 2px 2px;" 
            border="0" cellspacing="0" cellpadding="0">
              <TBODY>
<%	
			    RL_League1 =  0 

                IF TN > 0 THEN
                
                ON ERROR RESUME NEXT
				FOR i = 1 TO PGSIZE
				    
				    IF sRs.EOF THEN
					    EXIT FOR
				    END IF

					IG_Idx			=		sRs(0)
					RL_League		=		sRs(1)
					RL_Image		=		sRs(2)
					if left(RL_Image, 4) = "http" then
					RL_Image		=		"<img align='absmiddle' src='" & dfSiteUtil.GetLeagueImage(RL_Image) & "' width='20' />"
					else
					RL_Image		=		"<img align='absmiddle' src='http://league." & SITE_URL & "/" & srs(2) & "' width='20'/>"
					end if
					IG_StartTime	=		sRs(3)
					IG_Team1		=		sRs(4)
					IG_Team2		=		sRs(5)
					IG_Handicap		=		sRs(6)
					IG_Team1Benefit =		sRs(7)
					IG_DrawBenefit	=		sRs(8)
					IG_Team2Benefit =		sRs(9)
					IG_Score1		=		sRs(10)
					IG_Score2		=		sRs(11)
					IG_Result		=		sRs("IG_Result")
					IG_Type			=		sRs(13)
					RL_Sports		=		sRs(14)
					IG_Status		=		sRs(15)
					IG_Memo			=		sRs(16)
					IG_SP           =       sRs(17)
					IG_Draw         =       sRs("IG_Draw")
					I7_IDX		    = Trim(sRs("I7_IDX"))
					
					IF IG_Type = "0" THEN txtIG_Type = "[승무패]"
					IF IG_Type = "1" THEN txtIG_Type = "[핸디캡]"
					IF IG_Type = "2" THEN txtIG_Type = "[오/언]"
				    
				    'IF IG_SP ="Y" Then txtIG_Type = txtIG_Type & "<br><span style='color:blue'>스페셜</span>"

					IF IG_Result = 1 THEN
					    Winner = "승"
				    ELSEIF IG_Result = 0 THEN
					    Winner = "무"
				    ELSEIF IG_Result = 2 THEN
					    Winner = "패"
                    ELSE			
                        Winner = "-"			
				    END IF		                    
                    IF IG_TYPE = 1 Then
				        IF IG_Result = 1 THEN
					        Winner = "홈"
				        ELSEIF IG_Result = 2 THEN
					        Winner = "원정"                    
                        End IF					        
                    ElseIF IG_TYPE = 2 Then
				        IF IG_Result = 1 THEN
					        Winner = "오버"
				        ELSEIF IG_Result = 2 THEN
					        Winner = "언더"                    
                        End IF                    
                    End IF

					IF IG_Status = "F" THEN 
				        strGameResult = Winner 
				    ElseIF IG_Status = "C" THEN 
				        IF IG_Draw = "1" Then
				            strGameResult = "<font color='F35000'>적특</font>"
				            IG_Result = 9
				        Else
				            strGameResult = "<font color='F35000'>취소</font>"
				            IG_Result = 9
				        End IF
				    End If
 
%>	
              <TR>
                <TD width="10%" height="30" align="center" class="gradiCell"><%=dfSiteUtil.GetBetDate(IG_StartTime)%></TD>
                <TD width="4%" align="center" class="GroupCell"><%=RL_Image%></TD>
                <TD width="10%" align="left" class="gradiCell">
                                      <SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_league"><%=RL_League%></SPAN> 
                                  </TD>
                <TD width="28%" align="left" class="<% If IG_RESULT = 1 Then %>CssSelect2<% Else %>CssTeam<% End If %>" style="background: rgb(30, 30, 30); border: 1px solid rgb(0, 0, 0); border-image: none;" endcell=""><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_home" 
                  style="width: 99%; display: inline-block;"><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_Label1" 
                  style="width: 85%; display: inline-block;"><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_hometeam" 
                  style="width: 85%; text-align: left; display: inline-block;"><%=IG_Team1%></SPAN><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_over" 
                  style="width: 14%; text-align: right; display: inline-block;"></SPAN></SPAN><SPAN 
                  id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_homeodds" 
                  style="width: 14%; text-align: right; display: inline-block;"><%=FORMATNUMBER(IG_Team1Benefit,2)%></SPAN></SPAN> 
                                  </TD>
                <TD width="5%" align="center" class="<% If IG_RESULT = 0 Then %>CssSelect2<% Else %>CssTeam<% End If %>" style="background: rgb(30, 30, 30); border: 1px solid rgb(0, 0, 0); border-image: none;" 
                endcell=""><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_drawodds" 
                  style="width: 99%; text-align: center; display: inline-block;"><%= dfSiteUtil.getDrawValue(IG_TYPE, IG_DrawBenefit ,IG_Handicap) %></SPAN> 
                                  </TD>

                <TD width="28%" align="left" class="<% If IG_RESULT = 2 Then %>CssSelect2<% Else %>CssTeam<% End If %>" style="background: rgb(30, 30, 30); border: 1px solid rgb(0, 0, 0); border-image: none;" 
                endcell=""><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl4_lbl_away" 
                  style="width: 100%; display: inline-block;"><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl4_lbl_awayodds" 
                  style="width: 14%; text-align: left; display: inline-block;"><%=FORMATNUMBER(IG_Team2Benefit,2)%></SPAN><SPAN 
                  id="ctl00_ContentPlaceHolder1_lst_game_ctrl4_lbl_totalaway" 
                  style="width: 85%; text-align: right; display: inline-block;"><SPAN 
                  id="ctl00_ContentPlaceHolder1_lst_game_ctrl4_lbl_under" style="width: 14%; text-align: left; display: inline-block;"></SPAN><SPAN 
                  id="ctl00_ContentPlaceHolder1_lst_game_ctrl4_lbl_awayteam" 
                  style="width: 85%; text-align: right; display: inline-block;"><%=IG_Team2%></SPAN></SPAN></SPAN></TD>              </TD>





                <TD width="7%" align="center" class="gradiCell"><FONT color="white"><SPAN 
                  id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_homescore"><%=IG_Score1%>:<%=IG_Score2%></SPAN> 
                                      </FONT>                 </TD>
                <TD width="8%" align="center" class="gradiCell"><B><FONT 
                  color="#ffcd28"><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_result" 
                  style="width: 99%; text-align: center; display: inline-block;"><%= strGameResult %></SPAN> 
                                          </FONT></B>                 </TD></TR>
 
<%  
			RL_League1 = RL_League
			NN = NN - 1 
			sRs.MoveNext
			
		Next

	ELSE		
%>				
<%
	END IF
%>	
 </TBODY></TABLE><BR>
            <P align="center"><DIV id="paging">
<DIV class="paging">

<img src='/images/mybet/page_begin.gif' align='absmiddle' style='cursor:hand' onclick="javascript:window.self.location.href='/game/BetResult.asp?PAGE=1&sType1=<%= sType1 %>'">&nbsp;
<%	
	IF STARTPAGE = 1 THEN
		Response.Write "<img src='/images/mybet/page_prev.gif'  align='absmiddle'> &nbsp;"
	ELSEIF STARTPAGE > SETSIZE THEN
		Response.Write "<img src='/images/mybet/page_prev.gif' align='absmiddle' style='cursor:hand' onclick=javascript:window.self.location.href='/game/BetResult.asp?PAGE="&STARTPAGE-SETSIZE&"&sType1="&sType1&"'>&nbsp;"
	END IF 
%>
&nbsp;	
<%	FOR i = STARTPAGE TO SETSIZE + STARTPAGE - 1

	IF i > PGCOUNT THEN
		EXIT FOR
	END IF

	IF PAGE = i THEN
		'Response.Write " <a class='now' href=MyBet.asp?PAGE="&i&" >"& i & "</a>&nbsp;"
		Response.Write " <a class='now' href='/game/BetResult.asp?PAGE="&i&"&sType1="&sType1&"' onFocus='this.blur();'>"& i & "</a>&nbsp;"
	ELSE
		'Response.Write " <a class='rest' href=MyBet.asp?PAGE="&i&" >"& i & "</a>&nbsp;"
		Response.Write " <a class='rest' href='/game/BetResult.asp?PAGE="&i&"&sType1="&sType1&"' onFocus='this.blur();'>"& i & "</a>&nbsp;"
	END IF

NEXT 
%>
&nbsp;	
<%	
	IF PGCOUNT < SETSIZE  THEN '현재 페이지가 페이지 셋크기보다 적거나 페이지리스트가 전체페이지보다 적으면
		Response.write "<img src='/images/mybet/page_next.gif'  align='absmiddle'>"
	ELSEIF i > PGCOUNT THEN
		 Response.write "<img src='/images/mybet/page_next.gif'  align='absmiddle'>"
	ELSE
		Response.Write "<img src='/images/mybet/page_end.gif'  align='absmiddle' style='cursor:hand' onclick=javascript:window.self.location.href='/game/BetResult.asp?PAGE="&STARTPAGE+SETSIZE&"&sType1="&sType1&"'>"
	END IF
%>
		 
</DIV></DIV><!-- 페이징 -->             
  </P><BR><BR></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>

<!-- #include file="../_Inc/footer_right.asp" -->