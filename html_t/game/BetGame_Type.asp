<link rel="stylesheet" href="/css/betting.css" type="text/css">

<%
Set Dber = new clsDBHelper
SQL = "UP_INFO_Cart_DEL"
reDim param(1)
param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
Dber.ExecSP SQL,param,Nothing
Dber.Dispose
Set Dber = Nothing 
minAmount=10000
isSports= false
if LCase(Game_Type)="cross" or LCase(Game_Type)="smp" or LCase(Game_Type)="special" or LCase(Game_Type)="special2" or LCase(Game_Type)="handicap" then minAmount = 2000

  IF LCase(Game_Type)  = "smp" Then
    GG_TYPE = 0
    isSports=true
  ElseIF LCase(Game_Type)  = "handicap" Then
    GG_TYPE = 1
    isSports=true
  ElseIF LCase(Game_Type)  = "cross" Then
    GG_TYPE = 2
    isSports=true
  ElseIF LCase(Game_Type)  = "real" then
    GG_TYPE = 20
    isSports=true
  ElseIF LCase(Game_Type)  = "live" then
    GG_TYPE = 10
  ElseIF LCase(Game_Type)  = "dari" then
    GG_TYPE = 11
  ElseIF LCase(Game_Type)  = "dal" then
    GG_TYPE = 12
  ElseIF LCase(Game_Type)  = "high" then
    GG_TYPE = 13
  ElseIF LCase(Game_Type)  = "aladin" then
    GG_TYPE = 14
  ElseIF LCase(Game_Type)  = "power" then
    GG_TYPE = 15
  ElseIF LCase(Game_Type)  = "mgm" then
    GG_TYPE = 16
  ElseIF LCase(Game_Type)  = "virtuals" then
    GG_TYPE = 17
  ElseIF LCase(Game_Type)  = "bacarat" then
    GG_TYPE = 18
  ElseIF LCase(Game_Type)  = "dice" then
    GG_TYPE = 19
  ElseIF LCase(Game_Type)  = "choice" then
    GG_TYPE = 21
  ElseIF LCase(Game_Type)  = "nine" then
    GG_TYPE = 22
  ElseIF LCase(Game_Type)  = "powers" then
    GG_TYPE = 23
  ElseIF LCase(Game_Type)  = "toms" then
    GG_TYPE = 24
  ElseIF LCase(Game_Type)  = "lotusoe" then
    GG_TYPE = 25
  ElseIF LCase(Game_Type)  = "lotusb" then
    GG_TYPE = 26
  Else
    GG_TYPE = 1
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

	IF (LCase(Game_Type) = "live" And scnt=0) Or (LCase(Game_Type) = "power" And pcnt=0) Or (LCase(Game_Type) = "power" And hcnt=0) Or (LCase(Game_Type) = "real" And lcnt=0) Or (LCase(Game_Type) = "aladin" And acnt=0) Or (LCase(Game_Type) = "dal" And dcnt=0) Or (LCase(Game_Type) = "dari" And rcnt=0) Or (LCase(Game_Type) = "virtuals" And vcnt=0) Or (LCase(Game_Type) = "mgm" And mcnt=0) Then
		WITH RESPONSE
		.WRITE "<script>" & vbcrlf
		.WRITE "alert('현재 이용이 불가합니다.');" & vbcrlf
		.WRITE "location.href='/'" & VbCrLf
		.WRITE "</script>"
		.END
	END WITH
	End if
%>

<div class="subbody">
  <div id="sub-content">
    <% If isSports=true then %>
    <div class="game_view dark_radius game_title white">
      <% IF LCase(Game_Type)="special" then%>
      스페셜 <span>SPECIAL BET</span>
      <% ElseIF LCase(Game_Type)="cross" then%>
      조합베팅 <span>Cross BET</span>
      <% ElseIF LCase(Game_Type)="real" then%>
      라이브 <span>Live</span>
      <% End IF %>
    </div>
    <ul class="tabs">
      <li data-tab="tab1"><a href="betgame.asp?game_type=<%=LCase(Game_Type)%>&GGG_TYPE=0"><img src="/images/sport01.png"><br>종합</a><p></p></li>
      <li data-tab="tab2"><a href="betgame.asp?game_type=<%=LCase(Game_Type)%>&GGG_TYPE=1"><img src="/images/sport02.png"><br>축구</a><p></p></li>
      <li data-tab="tab3"><a href="betgame.asp?game_type=<%=LCase(Game_Type)%>&GGG_TYPE=2"><img src="/images/sport03.png"><br>야구</a><p></p></li>
      <li data-tab="tab4"><a href="betgame.asp?game_type=<%=LCase(Game_Type)%>&GGG_TYPE=3"><img src="/images/sport04.png"><br>농구</a><p></p></li>
      <li data-tab="tab5"><a href="betgame.asp?game_type=<%=LCase(Game_Type)%>&GGG_TYPE=4"><img src="/images/sport05.png"><br>배구</a><p></p></li>
      <li data-tab="tab6"><a href="betgame.asp?game_type=<%=LCase(Game_Type)%>&GGG_TYPE=5"><img src="/images/sport06.png"><br>하키</a><p></p></li>
    </ul>
    <% End If%>
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
<style>
.b365_frame {
    margin-bottom: 5px;
    padding: 0 0 30px 0;
    overflow: hidden;
    text-align: center;
    background: #141416;
    border-radius: 6px;
}
.b365_frame iframe {
    display: inline-block;
    margin: 0 auto;
    margin-top: 0px;
    width: 520px;
    height: 300px;
    border: none;
    overflow: hidden;
}
</style>
                                <TABLE width="100%" align="center" border="0" height="500" cellspacing="0" cellpadding="0">
                                <TBODY>
                                <TR>
                                <TD align="center"><div class="b365_frame"><iframe id="bet365" src="bet365_soccer.html?ver=103&src=https://www.bet365.com" scrolling="no"></iframe></div>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<style>
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, code, form, fieldset, legend, input, button, textarea, p, blockquote, th, td {
	margin: 0;
	padding: 0;
}
.b365_btn {
	margin-bottom: 5px;
	padding: 0 0 0px 0;
	overflow: hidden;
	text-align: center;
	background: #141416;
	border-radius: 6px;
}
body {
	font-family: "Nanum Gothic", Malgun Gothic, dotum, Verdana;
	font-size: 12px;
	text-decoration: none;
	word-break: break-all;
	margin: 0px;
	padding: 0px;
	background: top center fixed;
}
.game_list {
	width: 940px;
	min-height: 900px;
	background: rgba(31,32,35, 0.9);
}
.content_wrap .content {
	padding: 0;
	width: 950px;
}
.short.content_wrap .content {
	clear: both;
	width: 940px;
}
.content_wrap {
	position: relative;
	margin: 0 auto;
	padding: 20px 0;
	width: 1200px;
	background: rgba(0,0,0,0.5);
	border-radius: 3px;
	padding-left: 10px;
	padding-right: 10px;
	min-height: 850px;
}
html {
	margin: 0px;
	padding: 0px;
}
a {
	text-decoration: none;
	color: #fff;
}
#liveBtn {
	display: inline-block;
	color: #fff;
	margin: 0 5px;
	margin-top: 10px;
	margin-bottom: 10px;
	width: 110px;
	height: 40px;
	font-size: 13px;
	font-weight: bold;
	font-family: "Noto Sans",맑은 고딕,"Malgeun Gothic","맑은 고딕",dotum !important;
	line-height: 40px;
	text-align: center;
	border: 1px solid #FFFFFF;
	-webkit-border-radius: 3px;
	border-radius: 3px;
	-webkit-box-shadow: inset 1px 1px 1px rgba(255, 255, 255, 0.3), inset -1px -1px 1px rgba(255, 255, 255, 0.3);
	background: -webkit-gradient(linear,left top,left bottom,from(#5da2dc),to(#00399f));
	background-color: #f90;
}
</style>
<div class="b365_btn"><a id="liveBtn" onclick="$('#bet365').attr('src','bet365_soccer1.html?ver=103&src=https://www.bet365.com');" href="#">프리미어 시청</a><a id="liveBtn" onclick="$('#bet365').attr('src','bet365_soccer2.html?ver=103&src=https://www.bet365.com');" href="#">슈퍼리그 시청</a><a id="liveBtn" onclick="$('#bet365').attr('src','bet365_soccer3.html?ver=103&src=https://www.bet365.com');" href="#">월드컵 시청</a></div>

								</TD></TR></TBODY></TABLE>
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
                                <TR><TD align="center"><div style="width:830px; height:550px; overflow:hidden; margin:0 auto;" id="iframediv"><iframe src="http://ltslee.numedia365.com/oddeven.html" width="830" height="550" frameborder="0" scrolling="no" > </iframe> </div></TD></TR></TBODY></TABLE>	
								<TABLE width="100%" align="center" border="0" height="50" cellspacing="0" cellpadding="0">
                                <TBODY>
                                <TR><TD align="center"><div style="width:830px; height:50px; font-size: 22px; color: rgb(255,255,255); margin-top: 20px;" id="iframediv"><a href="http://lotusgm.com/renew/oddeven_game.html" target ="_blank" style="background: rgb(255, 100, 100); padding: 13px 10px; border-radius: 5px; border: 1px solid rgb(95, 62, 62); transition:0.25s ease-in-out; border-image: none; width: 100%; color: rgb(0, 0, 0); font-size: 12px; margin-bottom: 14px; box-sizing: border-box; -webkit-appearance: none;"/>위 영상이 나오질 않을경우 이 링크를 클릭하세요</a></font></div></TD></TR></TBODY></TABLE>		
  <%	elseIF LCase(Game_Type)  = "lotusb" Then%>
                                <TABLE width="100%" align="center" border="0" height="660" cellspacing="0" cellpadding="0">
                                <TBODY>
                                <TR><TD align="center"><div style="width:830px; height:660px; overflow:hidden; margin:0 auto;" id="iframediv"><iframe src="http://ltslee.numedia365.com/baccarat.html" width="830" height="663" frameborder="0" scrolling="no" > </iframe> </div></TD></TR></TBODY></TABLE>
								<TABLE width="100%" align="center" border="0" height="50" cellspacing="0" cellpadding="0">
                                <TBODY>
                                <TR><TD align="center"><div style="width:830px; height:50px; font-size: 22px; color: rgb(255,255,255); margin-top: 20px;" id="iframediv"><a href="http://lotusgm.com/renew/baccarat_game.html" target ="_blank" style="background: rgb(255, 100, 100); padding: 13px 10px; border-radius: 5px; border: 1px solid rgb(95, 62, 62); transition:0.25s ease-in-out; border-image: none; width: 100%; color: rgb(0, 0, 0); font-size: 12px; margin-bottom: 14px; box-sizing: border-box; -webkit-appearance: none;"/>위 영상이 나오질 않을경우 이 링크를 클릭하세요</a></font></div></TD></TR></TBODY></TABLE>		
<% End  if %>
    <table class="bettingtable01">
    <colgroup>
      <col width="15%"><col width="33%"><col width="11%"><col width="33%"><col width="8%"></colgroup>
      <tbody>
<%
  'bonus event folder only'

  If LCase(Game_Type)="cross" or LCase(Game_Type)="handicap" then
    StrWhere = "(IG_Status = 'S' OR IG_Status = 'E') AND (IG_SITE = ? OR IG_SITE = 'All') AND (RL_SPORTS = '공지사항' or rl_sports = '이벤트')"
    
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
      <%IF RL_League1 <> RL_League Then 'league info----%>
        <tr><td colspan="5">
        <div class="title-name01"><%=RL_Image%> <strong><%=RL_League%></strong></div>
        </td></tr>
      <%End If 'league info end ----%>

        <tr>
          <td colspan="6" style="padding: 2px 0;"></td>
        </tr>
        <tr <%if IG_Status="E" then%>class="inactive"<%end if%>>
          <td class="bt_stime" bt_folder_cnt="0" bt_type_name="핸디" bt_item_name="야구">
            <span class="tleft-title01"><%=dfSiteUtil.GetBetDate(IG_StartTime)%></span>
          </td>
          <td>
          <a id="id1_<%=IG_Idx%>" class="tleft-btn betting " flag="Y" onclick="addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,1,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','<%=IG_Status%>')">
            <span class="name ls"><%=IG_Team1%></span>
            <span class="divd rs"><% IF IG_Type = 1 And LC_YN="N" And rl_sports <> "이벤트" Then response.Write "<FONT COLOR='36ff00'>[H]</FONT>" end if%><% IF IG_Type = 2 And LCase(Game_Type) <> "live" And LCase(Game_Type) <> "dari" Then response.Write "<FONT COLOR='F86363'><b>▲</b></FONT>" end if%><%=FORMATNUMBER(IG_Team1Benefit,2)%></span>
          </a>
          </td><!-- team1 -->
          <td align="center">
          <% IF Cdbl(IG_DrawBenefit) > 1 THEN %>
          <a id="id0_<%=IG_Idx%>" class="tcenter-btn betting" flag="Y" onclick="addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,0,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','<%=IG_Status%>')">
          <% else%>
          <a id="id0_<%=IG_Idx%>" class="tcenter-btn betting" flag="N">
          <% End If %>
            <span style="display:inline-block;width:100%;">
              <% IF (LCase(Game_Type)  = "live" Or LCase(Game_Type)  = "dari") And (ig_drawbenefit=1 Or IG_HANDICAP=3.5) Then%>VS
              <% ElseIf LCase(Game_Type)  = "dal" then %>
              임팽이<br><%= dfSiteUtil.getDrawValue(IG_TYPE, IG_DrawBenefit ,IG_Handicap) %>
              <% Else
                  response.Write dfSiteUtil.getDrawValue(IG_TYPE, IG_DrawBenefit,IG_Handicap)
                End If %>
            </span>
          </a>
          </td><!-- draw/vs -->

          <td >
            <a class="tright-btn betting" id="id2_<%=IG_Idx%>" onclick="addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,2,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','<%=IG_Status%>')">
            <span class="divd ls"><%=FORMATNUMBER(IG_Team2Benefit,2)%><% IF IG_Type = 1 And LC_YN="N" And rl_sports <> "이벤트" Then response.Write "<FONT COLOR='36ff00'>[H]</FONT>" end if%><% IF IG_Type = 2 And LCase(Game_Type) <> "live" And LCase(Game_Type) <> "dari" Then response.Write "<font color='#4AA9C8'><b>▼</b></font>" end if%></span>
            <span class="name rs"><%=IG_Team2%></span>
            </a>
          </td><!-- team2 -->
          <td class="NowBetting"><%=status_%></td>
        </tr>    
  <%
      RL_League1 = RL_League
      sRs.MoveNext
      NEXT
    ELSE
  %>
        <tr><td align="center">진행 중인 보너스배당이 없습니다.</td></tr>
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
    param(0) = Dber.MakeParam("@IG_SITE",adVarWChar,adParamInput,20,JOBSITE)
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
        status_="배팅"
        tdClass="CssTeam"
      else IG_Status="E"
        status_="마감"
        tdClass="disable"
      End If

If GGG_TYPE=1 Then
RSPORTS="축구"
ElseIf GGG_TYPE=2 Then
RSPORTS="야구"
ElseIf GGG_TYPE=3 Then
RSPORTS="농구"
ElseIf GGG_TYPE=4 Then
RSPORTS="배구"
ElseIf GGG_TYPE=5 Then
RSPORTS="아이스하키"
End If

	If RL_SPORTS=RSPORTS OR GGG_TYPE=0 THEN
      IF isNull(I7_IDX) OR I7_IDX = "0" THEN  I7_IDX = ""
%>
      <%IF RL_League1 <> RL_League Then 'league info----%>
        <tr><td colspan="5">
        <div class="title-name01"><%=RL_Image%> <strong><%=RL_League%></strong></div>
        </td></tr>
      <%End If 'league info end ----%>

        <tr>
          <td colspan="6" style="padding: 2px 0;"></td>
        </tr>
        <tr <%if IG_Status="E" then%>class="inactive"<%end if%>>
          <td class="bt_stime" bt_folder_cnt="0" bt_type_name="핸디" bt_item_name="야구">
            <span class="tleft-title01"><%=dfSiteUtil.GetBetDate(IG_StartTime)%></span>
          </td>
          <td>
          <a id="id1_<%=IG_Idx%>" class="tleft-btn betting " flag="Y" onclick="addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,1,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','<%=IG_Status%>')">
            <span class="name ls"><%=IG_Team1%></span>
            <span class="divd rs"><% IF IG_Type = 1 And LC_YN="N" And rl_sports <> "이벤트" Then response.Write "<FONT COLOR='36ff00'>[H]</FONT>" end if%><% IF IG_Type = 2 And LCase(Game_Type) <> "live" And LCase(Game_Type) <> "dari" Then response.Write "<FONT COLOR='F86363'><b>▲</b></FONT>" end if%><%=FORMATNUMBER(IG_Team1Benefit,2)%></span>
          </a>
          </td><!-- team1 -->
          <td align="center">
          <% IF Cdbl(IG_DrawBenefit) > 1 THEN %>
          <a id="id0_<%=IG_Idx%>" class="tcenter-btn betting" flag="Y" onclick="addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,0,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','<%=IG_Status%>')">
          <% else%>
          <a id="id0_<%=IG_Idx%>" class="tcenter-btn betting" flag="N">
          <% End If %>
            <span style="display:inline-block;width:100%;">
              <% IF (LCase(Game_Type)  = "live" Or LCase(Game_Type)  = "dari") And (ig_drawbenefit=1 Or IG_HANDICAP=3.5) Then%>VS
              <% ElseIf LCase(Game_Type)  = "dal" then %>
              임팽이<br><%= dfSiteUtil.getDrawValue(IG_TYPE, IG_DrawBenefit ,IG_Handicap) %>
              <% Else
                  response.Write dfSiteUtil.getDrawValue(IG_TYPE, IG_DrawBenefit,IG_Handicap)
                End If %>
            </span>
          </a>
          </td><!-- draw/vs -->

          <td >
            <a class="tright-btn betting" id="id2_<%=IG_Idx%>" onclick="addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,2,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','<%=IG_Status%>')">
            <span class="divd ls"><%=FORMATNUMBER(IG_Team2Benefit,2)%><% IF IG_Type = 1 And LC_YN="N" And rl_sports <> "이벤트" Then response.Write "<FONT COLOR='36ff00'>[H]</FONT>" end if%><% IF IG_Type = 2 And LCase(Game_Type) <> "live" And LCase(Game_Type) <> "dari" Then response.Write "<font color='#4AA9C8'><b>▼</b></font>" end if%></span>
            <span class="name rs"><%=IG_Team2%></span>
            </a>
          </td><!-- team2 -->
          <td class="NowBetting"><%=status_%></td>
        </tr>    
<%
    RL_League1 = RL_League
  End IF
    sRs.MoveNext
    NEXT
  ELSE
%>
        <tr><td align="center">진행 중인 경기가 없습니다.</td></tr>
<%
  END If
  sRs.close
  Set sRs = Nothing
  Dber.Dispose
  Set Dber = Nothing
%>
      </tbody>
    </table>
  </div>
  <div id="right-side">
  <!-- #include file="../_Inc/right.inc.asp" -->
