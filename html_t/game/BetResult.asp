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
<div id="wrap">
	<div id="subwrap">
		<div class="subbody" style="">
			<div id="sub-content">
<div class="game_view dark_radius game_title white">
  경기결과 <span>GAME RESULT</span>
</div>
<table class="bettingtable01">
  <caption class="hidden">스페셜</caption>
  <colgroup>
    <col width="11%"><col width="13%"><col width="28%"><col width="6%"><col width="28%"><col width="7%"><col width="6%">
  </colgroup>
    <tr>
      <th scope="col" style="font-size: 11px;">경기일시</th>
      <th scope="col" style="font-size: 11px;">리그</th>
      <th scope="col" style="font-size: 11px;">[승]홈팀</th>
      <th scope="col" style="font-size: 11px;">무/기</th>
      <th scope="col" style="font-size: 11px;">[패]원정팀</th>
      <th scope="col" style="font-size: 11px;">결과</th>
      <th scope="col" style="font-size: 11px;">정보</th>
    </tr>
</table>

<div class="btn_bx">
  <div class="stitle_btn btna_02"><A style="cursor: hand;" href="/game/BetResult.asp?sType1=6"><font color="white">실시간</a></div>
  <div class="stitle_btn btna_02"><A style="cursor: hand;" href="/game/BetResult.asp?sType1=4"><font color="white">스페셜</a></div>
  <div class="stitle_btn btna_02"><A style="cursor: hand;" href="/game/BetResult.asp?sType1=3"><font color="white">핸디캡</a></div>
  <div class="stitle_btn btna_02"><A style="cursor: hand;" href="/game/BetResult.asp?sType1=2"><font color="white">승무패</a></div>
</div>	

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
<table class="bettingtable01"> <!-- loop -->
  <colgroup>
    <col width="11%"><col width="13%"><col width="29%"><col width="6%"><col width="29%"><col width="7%"><col width="6%">
  </colgroup>
  <tr>
    <td colspan="7" style="padding: 4px 0;"></td></tr><tr class="betting-active">
      <td class="bt_stime"><%=dfSiteUtil.GetBetDate(IG_StartTime)%></td>
    <td class="league"><%=RL_Image%> <strong><%=RL_League%></strong></td>
    <td><a class="tleft-btn <% If IG_Result = 1 Then %>tleft-btn03<% Else %><% End If %>" bgcolor="#707018"><span class="team-l"><%=Replace(IG_Team1, "회차", "")%></span><span class="point-r"><%=FORMATNUMBER(IG_Team1Benefit,2)%></span></a></td>
    <td style="text-align: center;"><a class="tcenter-btn" bgcolor=""><%= dfSiteUtil.getDrawValue(IG_TYPE, IG_DrawBenefit ,IG_Handicap) %></a></td>
    <td><a class="tright-btn <% If IG_Result = 2 Then %>tright-btn03<% Else %><% End If %>" bgcolor=""><span class="point-l"><%=FORMATNUMBER(IG_Team2Benefit,2)%></span><span class="team-r"><%=Replace(IG_Team2, "회차", "")%></span></a></td>
    <td nowrap=""><span style="display:block;text-align:center;color:#000;font-weight:bold;font-size:12px;letter-spacing:-1px"><% IF IG_Status = "F" OR IG_Draw = "1" THEN %>
																								<%=IG_Score1%>:<%=IG_Score2%>
																							<% Else %>					
																								X 
																							<% End IF %></span></td>
    <td style="text-align:center;font-size:12px;letter-spacing:-1px"><% IF IG_Result = 1 Then %>
																							홈
																							<% ELSEIF IG_Result = 0 Then %>
																							무
																							<% ELSEIF IG_Result = 2 Then %>
																							원정
																							<% ELSEIF IG_Result = 9 Then %>
				        <% IF IG_Draw = "1" Then %>
				        <font color='F35000'>적특</font>
				        <% Else %>
				        <font color='F35000'>취소</font>
				        <% End If %>
																							<% end if %></td>
  </tr>
  <tr>
    <td colspan="7" style="padding: 4px 0;"></td>
  </tr>
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

<!-- #include file="../_Inc/footer.asp" -->