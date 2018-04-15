<%	
Response.CodePage = 65001
Response.CharSet = "UTF-8"
Set Dber = new clsDBHelper

SQL = "UP_INFO_Cart_DEL"
reDim param(1)
param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
Dber.ExecSP SQL,param,Nothing
Dber.Dispose
Set Dber = Nothing 
minAmount=10000
if LCase(Game_Type)="cross" or LCase(Game_Type)="smp" or LCase(Game_Type)="special" or LCase(Game_Type)="special2" or LCase(Game_Type)="handicap" then minAmount = 2000

IF LCase(Game_Type)  = "smp" OR LCase(Game_Type)  = "underover" Then
    GG_TYPE = 0
  ElseIF LCase(Game_Type)  = "handicap" then
    GG_TYPE = 1
  ElseIF LCase(Game_Type)  = "special" then
    GG_TYPE = 2
  ElseIF LCase(Game_Type)  = "special2" then
    GG_TYPE = 3
  ElseIF LCase(Game_Type)  = "real" then
    GG_TYPE = 4
  ElseIF LCase(Game_Type)  = "live" then
    GG_TYPE = 35
  ElseIF LCase(Game_Type)  = "dal" then
    GG_TYPE = 36
  ElseIF LCase(Game_Type)  = "power" then
    GG_TYPE = 37
  ElseIF LCase(Game_Type)  = "aladin" then
    GG_TYPE = 39
  ElseIF LCase(Game_Type)  = "high" then
    GG_TYPE = 38
  ElseIF LCase(Game_Type)  = "dari" then
    GG_TYPE = 40
  ElseIF LCase(Game_Type)  = "virtuals" then
    GG_TYPE = 41
  ElseIF LCase(Game_Type)  = "powers" then
    GG_TYPE = 42
  ElseIF LCase(Game_Type)  = "cross" then
    GG_TYPE = 5
  ElseIF LCase(Game_Type)  = "lotusoe" then
    GG_TYPE = 43
  ElseIF LCase(Game_Type)  = "lotusb" then
    GG_TYPE = 44
  Else
    GG_TYPE = 9
  End If
  Set Dber = new clsDBHelper
  SQL = "select top 1 seq,scnt,pcnt,hcnt,lcnt,acnt,dcnt,rcnt,vcnt,mcnt,regdate from info_betting_max with(nolock)  order by seq desc "
  Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
  If Not sRs.eof Then
    scnt = sRs(1)
    pcnt = sRs(2)
    hcnt = sRs(3)
    lcnt = sRs(4)
    acnt = sRs(5)
    dcnt = sRs(6)
    rcnt = sRs(7)
    vcnt = sRs(8)
    mcnt = sRs(9)
  else
    scnt = 1
    pcnt = 1
    hcnt = 1
    lcnt = 1
    acnt = 1
    dcnt = 1
    rcnt = 1
    vcnt = 1
    mcnt = 1
  End If 
  sRs.close
  Set sRs = Nothing

  IF (LCase(Game_Type) = "live" And scnt=0) Or (LCase(Game_Type) = "power" And pcnt=0) Or (LCase(Game_Type) = "high" And hcnt=0) Or (LCase(Game_Type) = "real" And lcnt=0) Or (LCase(Game_Type) = "aladin" And acnt=0) Or (LCase(Game_Type) = "dal" And dcnt=0) Or (LCase(Game_Type) = "dari" And rcnt=0) Or (LCase(Game_Type) = "virtuals" And vcnt=0) Or (LCase(Game_Type) = "mgm" And mcnt=0) Then
    WITH RESPONSE
    .WRITE "<script>" & vbcrlf
    .WRITE "alert('현재 이용이 불가합니다.');" & vbcrlf
    .WRITE "location.href='/'" & VbCrLf
    .WRITE "</script>".END
    END WITH
  End if
%>

<table width="1010" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td style="width: 800px !important"><!--left td of cart-->
<%
  IF LCase(Game_Type)  = "dal" Then%>
  <TABLE width="100%" align="center" border="0" height="500" cellspacing="0" cellpadding="0">
  <TR>
  <TD align="center">  
  <iframe src="http://named.com/games/racing/view.php"  frameborder="0" marginwidth="500" marginheight="500" width="820" height=500 Style="margin-top:0px;margin-left:-20px;overflow-y:hidden; overflow-x:hidden" scrolling="no">  </iframe></TD></TR></TABLE>
  <%  elseIF LCase(Game_Type)  = "live" Then%>
  <TABLE width="830" align="center" border="0" height="500" cellspacing="0" cellpadding="0">
  <TR>
  <TD align="center"><iframe id="siframe" frameborder=0 src="http://named.com/game/ladder/v2_index.php" style="width:830px; height: 622px;" scrolling="no">  </iframe></TD></TR></TABLE>
  <%  elseIF LCase(Game_Type)  = "power" Then%>
  <TABLE width="100%" align="center" border="0" height="526" cellspacing="0" cellpadding="0">
  <TR>
  <TD align="center"><iframe name="powerball" src="http://ntry.com/scores/powerball/live.php" width="830" height="656" Style="margin-top:0px;overflow-y:hidden; overflow-x:hidden" frameborder="0" marginwidth="0" marginheight="0" scrolling="no">  </iframe></TD></TR></TABLE>
  <%  elseIF LCase(Game_Type)  = "high" Then%>
  <TABLE width="100%" align="center" border="0" height="500" cellspacing="0" cellpadding="0">
  <TR>
  <TD align="center"><iframe src="http://www.hafline.com/gamezone/game.asp"  frameborder="0" marginwidth="830" marginheight="500" width="830" height=500 Style="margin-top:0px;margin-left:0px;overflow-y:hidden; overflow-x:hidden" scrolling="no">  </iframe></TD></TR></TABLE>
  <%  elseIF LCase(Game_Type)  = "aladin" Then%>
  <TABLE width="100%" align="center" border="0" height="500" cellspacing="0" cellpadding="0">
  <TR>
  <TD align="center"><iframe src="http://www.hafline.com/Theme/Ladder/Game.aspx"  frameborder="0" marginwidth="830" marginheight="600" width="830" height=500 Style="margin-top:0px;margin-left:-40px;overflow-y:hidden; overflow-x:hidden" scrolling="no">  </iframe></TD></TR></TABLE>
  <%  elseIF LCase(Game_Type)  = "dari" Then%>
  <TABLE width="100%" align="center" border="0" height="500" cellspacing="0" cellpadding="0">
  <TR>
  <TD align="center"><iframe src="http://named.com/games/dari/view.php"  frameborder="0" marginwidth="830" marginheight="600" width="830" height=500 Style="margin-top:0px;margin-left:-40px;overflow-y:hidden; overflow-x:hidden" scrolling="no">
  </iframe></TD></TR></TABLE>
  <%  elseIF LCase(Game_Type)  = "virtuals" Then%>
  <TABLE width="100%" align="center" border="0" height="574" cellspacing="0" cellpadding="0">
  <TR>
  <TD align="center"><iframe id="Bet365" name="Bet365" src="g.asp?width=550&height=320" frameborder="0" allowtransparency="true" scrolling="no" style="width: 872px; height: 574px;" onload="$('#overlay').hide()">  </iframe></TD></TR></TABLE>
  <%  elseIF LCase(Game_Type)  = "mgm" Then%>
  <TABLE width="100%" align="center" border="0" height="700" cellspacing="0" cellpadding="0">
  <TR>
  <TD align="center"><iframe src="http://a2.ozlive.com/bar/web_live3.html" width="694" height="667" frameborder="0" scrolling="no" >   </iframe></TD></TR></TABLE>
  <%  elseIF LCase(Game_Type)  = "bacarat" Then%>
  <TABLE width="100%" align="center" border="0" height="600" cellspacing="0" cellpadding="0">
  <TR>
  <TD align="center"><iframe src="http://a3.ozlive.com/bar/web_baccarat1-1.html" width="920" height="600" frameborder="0" scrolling="no" >   </iframe></TD></TR></TABLE>
  <%  elseIF LCase(Game_Type)  = "powers" Then%>
  <TABLE width="100%" align="center" border="0" height="650" cellspacing="0" cellpadding="0">
  <TR>
  <TD align="center"><iframe src="bet.asp" width="900" height="650" frameborder="0" scrolling="no" style="margin-left: 50px;
  ">  </iframe></TD></TR></TABLE>
  <%  elseIF LCase(Game_Type)  = "choice" Then%>
  <TABLE width="100%" align="center" border="0" height="600" cellspacing="0" cellpadding="0">
  <TR>
  <TD align="center"><iframe src="http://www.lsbet.co.kr/module/ladder90/game.php" width="800" height="600" frameborder="0" scrolling="no" Style="margin-top:0px;margin-left:-20px;overflow-y:hidden; overflow-x:hidden" >   </iframe></TD></TR></TABLE>
  <%  elseIF LCase(Game_Type)  = "nine" Then%>
  <TABLE width="100%" align="center" border="0" height="600" cellspacing="0" cellpadding="0">
  <TR>
  <TD align="center"><iframe src="http://www.lsbet.co.kr/module/card/game.php" width="800" height="600" frameborder="0" scrolling="no" >  </iframe></TD></TR></TABLE> 
  <%  elseIF LCase(Game_Type)  = "toms" Then%>
  <TABLE width="100%" align="center" border="0" height="450" cellspacing="0" cellpadding="0">
  <TR>
  <TD align="center"><iframe src="http://toms-game.com/card_mini.aspx" width="920" height="450" frameborder="0" scrolling="no" >  </iframe></TD></TR></TABLE>
  <%  elseIF LCase(Game_Type)  = "dice" Then%>
  <TABLE width="100%" align="center" border="0" height="550" cellspacing="0" cellpadding="0">
  <TR>
  <TD align="center"><iframe src="http://score888.com/game/game.php?gameType=1" width="920" height="550" frameborder="0" scrolling="no" >   </iframe></TD></TR></TABLE> 
  <%	elseIF LCase(Game_Type)  = "lotusoe" Then%>
		<TABLE width="100%" align="center" border="0" height="550" cellspacing="0" cellpadding="0">
		<TBODY>
		<TR><TD align="center"><div style="width:830px; height:550px; overflow:hidden; margin:0 auto;" id="iframediv"><iframe src="http://mg.korodd.com/lotus/oe_2.php" width="830" height="550" frameborder="0" scrolling="no" > </iframe> </div></TD></TR></TBODY></TABLE>	
  <%	elseIF LCase(Game_Type)  = "lotusb" Then%>
		<TABLE width="100%" align="center" border="0" height="550" cellspacing="0" cellpadding="0">
		<TBODY>
		<TR><TD align="center"><div style="width:830px; height:663px; overflow:hidden; margin:0 auto;" id="iframediv"><iframe src="http://mg.korodd.com/lotus/bac1_2.php" width="830" height="663" frameborder="0" scrolling="no" > </iframe> </div></TD></TR></TBODY></TABLE>	
<% End  if %>
      <table id="ctl00_ContentPlaceHolder2_Sps" class="gradienttable" cellspacing="0" cellpadding="0" border="0" style="border-width:0px;border-collapse:collapse;font-family:돋움체;font-size:small;">
        <tbody>
          <tr><img src="/images/game/<%=LCase(Game_Type)%>.png"></tr>
          <tr class="game_head" style="border-style:None;height:30px;">
            <th style="width:10%;">경기시간</th>
            <th style="width:4%;">종목</th>
            <th style="width:17%;">리그</th>
            <th style="width:29%;">승(HOME)</th>
            <th style="width:6%;">무/핸디</th>
            <th style="width:29%;">패(AWAY)</th>
            <th style="width:5%;">상태</th>
          </tr>
<%
  'bonus event folder only'
  If LCase(Game_Type)="smp" Or LCase(Game_Type)="handicap" Or LCase(Game_Type)="special" Or LCase(Game_Type)="special2" then
    StrWhere = "(IG_Status = 'S' OR IG_Status = 'E') AND (IG_SITE = ? OR IG_SITE = 'All') AND IG_SP = 'N' and ig_type=0 AND rl_sports = '이벤트'"
    
    SQL = "SELECT IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, I7_IDX, IG_CONTENT FROM Info_Game WHERE "&StrWhere&" ORDER BY ig_status desc,IG_STARTTIME ASC, rl_league asc, IG_TEAM1 ASC,ig_type asc"
    reDim param(0)
    param(0) = Dber.MakeParam("@jobsite",adVarWChar,adParamInput,20,JOBSITE)
    Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

    INPC = sRs.RecordCount
    RL_League1 =  0
    If Not sRs.EOF THEN
      For RE = 1 TO INPC
        IF sRs.EOF THEN 
          EXIT FOR
        END IF
        IG_Idx      = sRs(0)
        RL_Idx      = sRs(1)
        RL_Sports   = sRs(2)
        RL_League   = sRs(3)
        RL_Image    = sRs(4)
        RL_Image    = "<img align='absmiddle' src='" & dfSiteUtil.GetLeagueImage(RL_Image) & "' width='20'/>"
        IG_StartTime  = sRs(5)
        IG_Team1    = sRs(6)
        IG_Team2    = sRs(7)
        IG_Handicap   = sRs(8)
        IG_Team1Benefit = sRs(9)
        IG_DrawBenefit  = sRs(10)
        IG_Team2Benefit = sRs(11)
        IG_Status   = sRs(12)
        IG_Type     = sRs(13)
        IG_VSPoint    = sRs(14)
        IG_Memo     = sRs(15)
        I7_IDX        = Trim(sRs("I7_IDX"))
        IG_CONTENT      = Trim(sRs("IG_CONTENT"))
  %>
      <tr style="height:10px;">
        <td></td>
      </tr>
      <tr class="game_tr" style="height:30px;">
        <td class="gradiCell" align="center"><%=dfSiteUtil.GetBetDate(IG_StartTime)%></td>
        <td class="GroupCell" align="center" style="border-style:None;">
          <% If rl_sports="축구" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Soccer.gif">
            <% ElseIf rl_sports="야구" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Baseball.gif">
            <% ElseIf rl_sports="농구" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Basketball.gif">
            <% ElseIf rl_sports="배구" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Hand2.gif">
            <% ElseIf rl_sports="테니스" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Tennis.gif">
            <% ElseIf rl_sports="스타" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_ESports.gif">
            <% ElseIf rl_sports="핸드볼" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Handball.gif">
            <% ElseIf rl_sports="골프" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Golf.gif">
            <% ElseIf rl_sports="E-SPORTS" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_ESports.gif">
            <% ElseIf rl_sports="아이스하키" Or rl_sports="하키" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Icehockey.gif">
            <% ElseIf rl_sports="미식축구" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_NFL.gif">
            <% ElseIf rl_sports="격투기" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_UFC.gif">
            <% ElseIf rl_sports="Type_Formula1.png" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Formula1.png">
            <% ElseIf rl_sports="다트" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Dart.gif">
            <% ElseIf rl_sports="type_curling.gif" Then %>
            <IMG width="16" height="16" src="/images/sub/cur.gif">
            <% ElseIf rl_sports="당구" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_bi.gif">
          <% End If %>
        </td>
        <td class="gradiCell" align="left" style="border-style:None;">
          <%=RL_Image%> <%=RL_League%></font>
        </td>
        
        <td class="gradiCell" id="id1_<%=IG_Idx%>" class="<%=tdClass%>" onclick="addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,1,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>');" >
          <table border="0" style="width:100%;">
            <tbody><tr>
                <td align="left" style="width:85%;"><%=IG_Team1%></td>
                <td align="right" style="width:15%;"><span style="text-align:right"><% IF IG_Type = 1 And LC_YN="N" And rl_sports <> "이벤트" Then response.Write "<FONT COLOR='36ff00'>[H]</FONT>" end if%><% IF IG_Type = 2 And LCase(Game_Type) <> "live" And LCase(Game_Type) <> "dari" Then response.Write "<FONT COLOR='F86363'><b>▲</b></FONT>" end if%><%=FORMATNUMBER(IG_Team1Benefit,2)%></span></td>
              </tr></tbody>
          </table>
        </td><!-- team1 -->

        <% IF  Cdbl(IG_DrawBenefit) > 1 THEN %>
        <td id="id0_<%=IG_Idx%>" class="<%=tdClass%>" align="center" onclick="addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,0,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>');" >
        
        <% else%>
        <td id="id0_<%=IG_Idx%>" class="CssHandi" align="center">
        <% End If %>
        
          <span style="display:inline-block;width:100%;">
            <% IF (LCase(Game_Type)  = "live" Or LCase(Game_Type)  = "dari") And (ig_drawbenefit=1 Or IG_HANDICAP=3.5) Then%>VS
            <% ElseIf LCase(Game_Type)  = "dal" then %>
            임팽이<br><%= dfSiteUtil.getDrawValue(IG_TYPE, IG_DrawBenefit ,IG_Handicap) %>
            <% Else
                response.Write dfSiteUtil.getDrawValue(IG_TYPE, IG_DrawBenefit,IG_Handicap)
              End If %>
          </span>
        </td><!-- draw/vs -->

        <td class="gradiCell" id="id2_<%=IG_Idx%>" class="<%=tdClass%>" onclick="addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,2,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>');"><table border="0" style="width:100%;">
          <tbody><tr>
            <td style="width:15%;"><span style="display:inline-block;width:100%;text-align:left;"><%=FORMATNUMBER(IG_Team2Benefit,2)%>
              <% IF IG_Type = 1 And LC_YN="N" And rl_sports <> "이벤트" Then response.Write "<FONT COLOR='36ff00'>[H]</FONT>" end if%><% IF IG_Type = 2 And LCase(Game_Type) <> "live" And LCase(Game_Type) <> "dari" Then response.Write "<font color='#4AA9C8'><b>▼</b></font>" end if%></span></td>
            <td style="width:85%;">
              <span style="display:inline-block;width:100%;text-align:right"><%=IG_Team2%></span>
            </td>
          </tr>
        </tbody></table></td><!-- team2 -->
        <td class="NowBetting"><%=IG_Status%></td>
      </tr>
  <%
      RL_League1 = RL_League
      sRs.MoveNext
      NEXT
    ELSE
  %>
        <tr><td align="center" class="style1">진행 중인 보너스배당이 없습니다.</td></tr>
  <%
    END IF
  sRs.close
  Set sRs = Nothing
  End If 'bonus event end'
	
  IF LCase(Game_Type) = "special" Then
    StrWhere = "(IG_Status = 'S' OR IG_Status = 'E') AND (IG_SITE = ? OR IG_SITE = 'All') AND RL_Sports<>'라이브' "
    IF Sel_Sports <> "" AND Sel_Sports <> "ALL" THEN StrWhere = StrWhere & " AND RL_Sports='" & Sel_Sports & "' "

    IF Sel_League <> "" THEN StrWhere = StrWhere & " AND RL_League='" & Sel_League & "' "
	StrWhere = StrWhere & "AND IG_SP = 'Y' and RL_SPORTS <> '실시간' and RL_SPORTS <> '이벤트' AND IG_EVENT <> 'O'"
    '## special game list
    SQL = "SELECT IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, I7_IDX, IG_CONTENT FROM Info_Game WHERE "&StrWhere&" ORDER BY ig_status desc,IG_STARTTIME ASC, rl_league asc, IG_TEAM1 ASC,ig_type asc"
    reDim param(0)
    param(0) = Dber.MakeParam("@jobsite",adVarWChar,adParamInput,20,JOBSITE)
    Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

  Else 'non special'
    SQL = "dbo.UP_RetrieveInfo_GameByUser"
    reDim param(1)
    param(0) = Dber.MakeParam("@gg_type",adInteger,adParamInput,,GG_TYPE)
    param(1) = Dber.MakeParam("@jobsite",adVarchar,adParamInput,20,JOBSITE)
    Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
  End IF

  INPC = sRs.RecordCount
  RL_League1 =  0
  If Not sRs.EOF THEN
    For RE = 1 TO INPC
      IF sRs.EOF THEN 
        EXIT FOR
      END IF
      IG_Idx      = sRs(0)
      RL_Idx      = sRs(1)
      RL_Sports   = sRs(2)
      RL_League   = sRs(3)
      RL_Image    = sRs(4)
      RL_Image    = "<img align='absmiddle' src='" & dfSiteUtil.GetLeagueImage(RL_Image) & "' width='20'/>"
      IG_StartTime  = sRs(5)
      IG_Team1    = sRs(6)
      IG_Team2    = sRs(7)
      IG_Handicap   = sRs(8)
      IG_Team1Benefit = sRs(9)
      IG_DrawBenefit  = sRs(10)
      IG_Team2Benefit = sRs(11)
      IG_Status   = sRs(12)
      IG_Type     = sRs(13)
      IG_VSPoint    = sRs(14)
      IG_Memo     = sRs(15)
      I7_IDX        = Trim(sRs("I7_IDX"))
      IG_CONTENT      = Trim(sRs("IG_CONTENT"))
      If IG_Status="S" then 
        IG_Status="배팅"
        tdClass="CssTeam"
      else IG_Status="E"
        IG_Status="마감"
        tdClass="disable"
      End If

      IF isNull(I7_IDX) OR I7_IDX = "0" THEN  I7_IDX = ""
%>
      <tr style="height:10px;">
        <td></td>
      </tr>
      <tr class="game_tr" style="height:30px;">
        <td class="gradiCell" align="center"><%=dfSiteUtil.GetBetDate(IG_StartTime)%></td>
        <td class="GroupCell" align="center" style="border-style:None;">
          <% If rl_sports="축구" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Soccer.gif">
            <% ElseIf rl_sports="야구" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Baseball.gif">
            <% ElseIf rl_sports="농구" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Basketball.gif">
            <% ElseIf rl_sports="배구" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Hand2.gif">
            <% ElseIf rl_sports="테니스" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Tennis.gif">
            <% ElseIf rl_sports="스타" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_ESports.gif">
            <% ElseIf rl_sports="핸드볼" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Handball.gif">
            <% ElseIf rl_sports="골프" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Golf.gif">
            <% ElseIf rl_sports="E-SPORTS" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_ESports.gif">
            <% ElseIf rl_sports="아이스하키" Or rl_sports="하키" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Icehockey.gif">
            <% ElseIf rl_sports="미식축구" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_NFL.gif">
            <% ElseIf rl_sports="격투기" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_UFC.gif">
            <% ElseIf rl_sports="Type_Formula1.png" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Formula1.png">
            <% ElseIf rl_sports="다트" Then %>
            <IMG width="16" height="16" src="/images/sub/Type_Dart.gif">
			<% ElseIf rl_sports="당구" Then %>
			<IMG width="16" height="16" src="/images/sub/Type_bi.gif">
            <% ElseIf rl_sports="type_curling.gif" Then %>
            <IMG width="16" height="16" src="/images/sub/cur.gif">
          <% End If %>

        </td>
        <td class="gradiCell" align="left" style="border-style:None;">
          <%=RL_Image%> <%=RL_League%></font>
        </td>
        
        <td id="id1_<%=IG_Idx%>" class="<%=tdClass%>" <% If IG_STATUS="배팅" Then %>onclick="addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,1,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>');"<% End If %> >
          <table border="0" style="width:100%;">
            <tbody><tr>
                <td align="left" style="width:85%;"><%=IG_Team1%></td>
                <td align="right" style="width:15%;"><span style="text-align:right"><% IF IG_Type = 1 And LC_YN="N" And rl_sports <> "이벤트" Then response.Write "<FONT COLOR='36ff00'>[H]</FONT>" end if%><% IF IG_Type = 2 And LCase(Game_Type) <> "live" And LCase(Game_Type) <> "dari" Then response.Write "<FONT COLOR='F86363'><b>▲</b></FONT>" end if%><%=FORMATNUMBER(IG_Team1Benefit,2)%></span></td>
              </tr></tbody>
          </table>
        </td><!-- team1 -->

        <% IF  Cdbl(IG_DrawBenefit) > 1 THEN %>
        <td id="id0_<%=IG_Idx%>" class="<%=tdClass%>" align="center" <% If IG_STATUS="배팅" Then %>onclick="addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,0,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>');"<% End If %> >
        
        <% else%>
        <td id="id0_<%=IG_Idx%>" class="CssHandi" align="center">
        <% End If %>
        
          <span style="display:inline-block;width:100%;">
            <% IF (LCase(Game_Type)  = "live" Or LCase(Game_Type)  = "dari") And (ig_drawbenefit=1 Or IG_HANDICAP=3.5) Then%>VS
            <% ElseIf LCase(Game_Type)  = "dal" then %>
            임팽이<br><%= dfSiteUtil.getDrawValue(IG_TYPE, IG_DrawBenefit ,IG_Handicap) %>
            <% Else
                response.Write dfSiteUtil.getDrawValue(IG_TYPE, IG_DrawBenefit,IG_Handicap)
              End If %>
          </span>
        </td><!-- draw/vs -->

        <td id="id2_<%=IG_Idx%>" class="<%=tdClass%>" <% If IG_STATUS="배팅" Then %>onclick="addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,2,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>');"<% End If %>><table border="0" style="width:100%;">
          <tbody><tr>
            <td style="width:15%;"><span style="display:inline-block;width:100%;text-align:left;"><%=FORMATNUMBER(IG_Team2Benefit,2)%>
              <% IF IG_Type = 1 And LC_YN="N" And rl_sports <> "이벤트" Then response.Write "<FONT COLOR='36ff00'>[H]</FONT>" end if%><% IF IG_Type = 2 And LCase(Game_Type) <> "live" And LCase(Game_Type) <> "dari" Then response.Write "<font color='#4AA9C8'><b>▼</b></font>" end if%></span></td>
            <td style="width:85%;">
              <span style="display:inline-block;width:100%;text-align:right"><%=IG_Team2%></span>
            </td>
          </tr>
        </tbody></table></td><!-- team2 -->
        <td class="NowBetting"><%=IG_Status%></td>
      </tr>
<%
    RL_League1 = RL_League
    sRs.MoveNext
    NEXT
  ELSE
%>
        <tr><td align="center" class="style1">진행 중인 경기가 없습니다.</td></tr>
<%
  END IF
  sRs.close
  Set sRs = Nothing
  Dber.Dispose
  Set Dber = Nothing
%>
      </tbody></table>
    </td>
    <!-- #include file="../_Inc/right.inc.asp" -->
  </tr>
</table>
<!-- #include file="../_Inc/footer_right.asp" -->