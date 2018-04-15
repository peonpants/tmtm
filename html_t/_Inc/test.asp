<div>
<%

getGameTime = ""
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
  End IF
IF LCase(Game_Type)  = "power" Then
onn1="on_"
ElseIf LCase(Game_Type)  = "powers" Then
onn2="on_"
ElseIf LCase(Game_Type)  = "virtuals" Then
onn3="on_"
ElseIf LCase(Game_Type)  = "nine" Then
onn4="on_"
ElseIf LCase(Game_Type)  = "choice" Then
onn5="on_"
ElseIf LCase(Game_Type)  = "mgm" Then
onn6="on_"
ElseIf LCase(Game_Type)  = "bacarat" Then
onn7="on_"
ElseIf LCase(Game_Type)  = "dice" Then
onn8="on_"
ElseIf LCase(Game_Type)  = "toms" Then
onn9="on_"
ElseIf LCase(Game_Type)  = "live" Then
onn10="on_"
ElseIf LCase(Game_Type)  = "dari" Then
onn11="on_"
ElseIf LCase(Game_Type)  = "dal" Then
onn12="on_"

End If

%>
<%  
IF LCase(Game_Type)  = "cross" OR LCase(Game_Type)  = "handicap" OR LCase(Game_Type)  = "real" OR LCase(Game_Type)  = "special" Then
LC_YN="N"
Else
LC_YN="Y"
End If 
%>
<style>
.betInfoClass, .betInfoClass:hover{
  width:320px !important;
        background-image:none !important;
        background-color:white !important;
        color:black !important;
    cursor:default !important;
}
</style>
<script type="text/javascript" src="/js/newjs/moment.min.js"></script>

<link rel="stylesheet" type="text/css" href="/css/newcss/betting.css">
<link rel="stylesheet" type="text/css" href="/css/newcss/game.css">
<style>
.bet_disable{position:absolute;top:-161px;;bottom:0;left:0;right:0;font-size:30px;text-align:center;color:white;background:rgba(0,0,0,0.7);display:none;height:323px;}

</style>
      <table width="854"  height="1130" border="0" cellspacing="0" cellpadding="0">
      <tbody>
        <tr>
          <td align="center">
            <table width="100%" border="0" cellspacing="0" cellpadding="0"  bgcolor="000000">
            <tbody>
              <tr>
                <td bgcolor="000000">&nbsp;</td>
                <td width="29" align="center" valign="top" background="/images/cross/bg_contents_L.jpg" ><img src="/images/cross/bg_contents_L2.jpg" width="29" height="6"></td>
                <td height="1130" valign="top" style="width: 1200px;">
<div id="sub-area" style="width:1173px;">
<div class="subbody">
<div id="sub-content">
<div id="content" class="sub_cnt">
<div class="ladder_wrap">
  
<div class="ladder_tit"><h3>사다리게임</h3></div>
  <div class="ladder_top" style="height: 470px; margin-left: 170px;">
    <div class="ladder_area">
      <iframe id="game_frame" src="http://named.com/game/ladder/v2_index.php" style="margin-left: -220px; margin-top: -190px; width:830px; height: 622px;" scrolling="no"></iframe>
    </div>
  </div>
<div class="ladder_cnt">
      <!-- 게임선택 -->
      <input type="hidden" id="game_hour" name="game_hour" value="21">
      <div class="ladder_choice">
        <div class="game_info">
          <span id="date_mm">일</span>
              <em><span id="date_hh"></span>:<span id="date_ii"></span>:<span id="date_ss"></span></em>

              <strong class="order" id="play_num_view" style="font-size:18px;line-height:30px;"></strong>

              <strong class="count" id="remaind_time">00:00</strong>
              <button type="button" class="btn_refresh" onclick="location.reload();">새로고침
            </button>

        </div>
        <div class="ladder_1st">
          <h4 class="hidden">1게임 홀/짝</h4>
          <ul>
            <li><a class="b_odd betting" id="id1_381_1" bt_league="네임드 사다리 [홀/짝]" flag="N">
              <span class="divd" id="benefit_381_1"></span>
            </a></li>
            <li style="display:none"><a class="betting" id="t_6893399" bt_league="네임드 사다리 [홀/짝]" flag="{victory.setCheckFlag.tie}">
              <span class="name">undefined</span>
              <span class="divd"></span>
            </a></li>
            <li><a class="b_even betting" id="id2_381_2" bt_league="네임드 사다리 [홀/짝]" flag="N">
              <span class="divd"  id="benefit_381_2"></span>
            </a></li>
          </ul>
        </div>
        <div class="ladder_2nd">
          <h4 class="hidden">2게임 출발줄 줄갯수</h4>
          <ul>
            <li><a class="b_4_even betting" id="id1_382_1" bt_league="네임드 사다리 [출발점 좌/우]" flag="N">
              <span class="divd" id="benefit_382_1"></span>
            </a></li>
            <li style="display:none"><a class="betting" id="t_6893400" bt_league="네임드 사다리 [출발점 좌/우]" flag="{victory.setCheckFlag.tie}">
              <span class="name">undefined</span>
              <span class="divd"></span>
            </a></li>
            <li><a class="b_3_odd betting" id="id2_382_2" bt_league="네임드 사다리 [출발점 좌/우]" flag="N">
              <span class="divd" id="benefit_382_2"></span>
            </a></li>
            
            <li><a class="b_lft betting" id="id1_383_1" bt_league="네임드 사다리 [3줄 / 4줄]" flag="N">
              <span class="divd" id="benefit_383_1"></span>
            </a></li>
            <li style="display:none"><a class="betting" id="t_6893401" bt_league="네임드 사다리 [3줄 / 4줄]" flag="{victory.setCheckFlag.tie}">
              <span class="name">undefined</span>
              <span class="divd"></span>
            </a></li>
            <li><a class="b_rgt betting" id="id2_383_2" bt_league="네임드 사다리 [3줄 / 4줄]" flag="N">
              <span class="divd" id="benefit_383_2"></span>
            </a></li>
          </ul>
        </div>
        <div class="ladder_3rd">
          <h4 class="hidden">3게임 좌우 출발 3/4줄</h4>
          <ul>
            <li><a class="b_lft_3_oven betting" id="id1_384_1" bt_league="네임드 사다리 [조합]" flag="N">
              <span class="divd" id="benefit_384_1"></span>
            </a></li>
            <li style="display:none"><a class="betting" id="t_6893402" bt_league="네임드 사다리 [조합]" flag="{victory.setCheckFlag.tie}">
              <span class="divd" id="benefit_384_1"></span>
            </a></li>
            <li><a class="b_rgt_3_odd betting" id="id2_384_2" bt_league="네임드 사다리 [조합]" flag="N">
              <span class="divd" id="benefit_384_2"></span>
            </a></li>
            
            <li><a class="b_lft_4_odd betting" id="id1_385_1" bt_league="네임드 사다리 [조합]" flag="N">
              <span class="divd" id="benefit_385_1"></span>
            </a></li>
            <li style="display:none"><a class="betting" id="t_6893403" bt_league="네임드 사다리 [조합]" flag="{victory.setCheckFlag.tie}">
              <span class="name">undefined</span>
              <span class="divd">0.00</span>
            </a></li>
            <li><a class="b_rgt_4_even betting" id="id2_385_2" bt_league="네임드 사다리 [조합]" flag="N">
              <span class="divd" id="benefit_385_2"></span>
            </a></li>       
          </ul>
        </div>


      </div>

     <%
          'bonus event

          

          Set Dber = new clsDBHelper
            StrWhere = "(IG_Status = 'S' OR IG_Status = 'E') AND (IG_SITE = ? OR IG_SITE = 'All') "

            IF Sel_Sports <> "" AND Sel_Sports <> "ALL" THEN
              StrWhere = StrWhere & " AND RL_Sports='" & Sel_Sports & "' "
            END IF

            IF Sel_League <> "" THEN
              StrWhere = StrWhere & " AND RL_League='" & Sel_League & "' "
            END IF

            StrWhere = StrWhere & "AND (RL_SPORTS = '공지사항' or rl_sports = '이벤트') "
            '########   진행 중인 스페셜 게임 리스트 출력    ##############

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
            RL_Image    = "<img align='absmiddle' src='" & dfSiteUtil.GetLeagueImage(RL_Image) & "' width='20' />"
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


            IF isNull(I7_IDX) OR I7_IDX = "0" THEN  I7_IDX = ""
            IF RL_League1 <> RL_League Then

        If rl_sports = "이벤트" And  LCase(Game_Type) = "cross" then
        %>     
          <div class="title-name01"><%=RL_Image%>&nbsp; <strong><%=RL_League%></strong></div><!-- League End -->         <!-- GameRow Start --> 
        <%
        End if
            End If 
        If rl_sports = "이벤트" And LCase(Game_Type) = "cross" then
        %>



    <%    ElseIf rl_sports = "공지사항" then

    End if

            '#########3 이전 리그 값을 변수에 담는다.
            RL_League1 = RL_League

            sRs.MoveNext

            NEXT

          END IF

          sRs.close
          Set sRs = Nothing
          Dber.Dispose
          Set Dber = Nothing
        %>
     <%
          '########   리스트 출력을 위해 Where 만들기   ##############

          IF LCase(Game_Type)  = "smp" Then
            GG_TYPE = 0
          ElseIF LCase(Game_Type)  = "handicap" Then
            GG_TYPE = 1
          ElseIF LCase(Game_Type)  = "cross" Then
            GG_TYPE = 2
          ElseIF LCase(Game_Type)  = "real" then
            GG_TYPE = 20
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
          Else
            GG_TYPE = 1
          End If

          Set Dber = new clsDBHelper

          '########   진행 중인 게임 리스트 출력    ##############
          IF LCase(Game_Type)  <> "special" Then

            SQL = "dbo.UP_RetrieveInfo_GameByUser"

            reDim param(1)
            param(0) = Dber.MakeParam("@gg_type",adInteger,adParamInput,,GG_TYPE)
            param(1) = Dber.MakeParam("@jobsite",adVarchar,adParamInput,20,JOBSITE)
            Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)


          Else
            StrWhere = "(IG_Status = 'S' OR IG_Status = 'E') AND (IG_SITE = ? OR IG_SITE = 'All') "

            IF Sel_Sports <> "" AND Sel_Sports <> "ALL" THEN
              StrWhere = StrWhere & " AND RL_Sports='" & Sel_Sports & "' "
            END IF

            IF Sel_League <> "" THEN
              StrWhere = StrWhere & " AND RL_League='" & Sel_League & "' "
            END IF

            StrWhere = StrWhere & "AND IG_SP = 'Y' and RL_SPORTS <> '실시간' and rl_sports <> '이벤트' "
            '########   진행 중인 스페셜 게임 리스트 출력    ##############

            SQL = "SELECT IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, I7_IDX, IG_CONTENT FROM Info_Game WHERE "&StrWhere&" ORDER BY ig_status desc,IG_STARTTIME ASC, rl_league asc, IG_TEAM1 ASC,ig_type asc"

            reDim param(0)
            param(0) = Dber.MakeParam("@jobsite",adVarWChar,adParamInput,20,JOBSITE)
            Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

          End IF

          INPC = sRs.RecordCount

          GCNT = 0
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
            RL_Image    = "<img align='absmiddle' src='" & dfSiteUtil.GetLeagueImage(RL_Image) & "' width='26' />"
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


            IF isNull(I7_IDX) OR I7_IDX = "0" THEN  I7_IDX = ""
            IF RL_League1 <> RL_League Then

            End If 
          IF IG_Status = "S" Then '마감된 경기 리스트
        %>   
      <% IF GCNT = 0 Then
        getGameTime = left(IG_StartTime,10) &" "& FormatDateTime(CDate(IG_StartTime),4) + ":" + Right(IG_StartTime,2)
      
      %> 
        
      <% End If%>
<script>
//사다리용
  $("#date_mm").html('<%=Replace(Left(dfSiteUtil.GetBetDate(IG_StartTime),5),"/","월 ")%>'+'일');
  <% 
  'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
  'H  회차 제대로 표시되게 고침
    Play_Num_View_Text = Replace(Mid(IG_Team1,1,5), "[", "")
    Play_Num_View_Text = Replace(Play_Num_View_Text, "회", "")
    Play_Num_View_Text = Replace(Play_Num_View_Text, "차", "")
    Play_Num_View_Text = " [ "& Play_Num_View_Text &" 회차 ] "
  'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
  %>
  $("#play_num_view").html("<%=Play_Num_View_Text%>");
//subCartAll();HFGameBetNum('id1_<%=RL_Idx%>_1');
  $("#id1_<%=RL_Idx%>_1").attr("onclick", "addCart_live('<%=Session("SD_ID")%>',<%=IG_Idx%>,1,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','id1_<%=RL_Idx%>_1'); return false;");
  $("#benefit_<%=RL_Idx%>_1").html("<%=FORMATNUMBER(IG_Team1Benefit,2)%>");
  $("#id2_<%=RL_Idx%>_2").attr("onclick", "addCart_live('<%=Session("SD_ID")%>',<%=IG_Idx%>,2,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','id2_<%=RL_Idx%>_2'); return false;");
  $("#benefit_<%=RL_Idx%>_2").html("<%=FORMATNUMBER(IG_Team2Benefit,2)%>");

</script>
    <%
        Else  '배팅가능 경기 리스트

        End IF

            '#########3 이전 리그 값을 변수에 담는다.
            RL_League1 = RL_League

            sRs.MoveNext

            NEXT
%>
<form  name="BetFrm" target="ProcFrm" method="post" action="Bet_Proc.asp">
<!-- //게임선택 -->
      <!-- 베팅카트 -->
      <div class="ladder_cart">
        <div class="cart_info">
          <ul>
            <li>
              <span>게임분류</span>
              <strong>[사다리]</strong>
            </li>
            <li id="selBet">
              <span>게임선택</span>
              <strong>
                <span class="tx" id="cartTable_game"></span>
                <div id="cartTable" style="display:none"></div>
              </strong>
            </li>
            <li id="betRate">
              <span>배당률</span>
              <div id="foreCastDividendPercent"><%=numdel(TotalBenefitRate)%></div>
            </li>
            <li style="display:none">
              <span id="min_price">5000</span>
              <span id="max_price">1000000</span>
              <span id="max_eprice">3,000,000</span>
            </li>
          </ul>
        </div>
        <!-- 금액선택 -->
        <div class="cart_pay">
          <h4 class="hidden">베팅금액선택</h4>
          <div class="bet_money">
            <label for="betExp2">베팅 금액</label>
            <input type="text" id="BetAmount" name="BetAmount" value="0">
          </div>
          <div class="bet_money i_blue">
            <label for="betExp3">적중 금액</label>
            <input type="text" id="TotalBenefit" name="TotalBenefit" value="0" readonly="">
          </div>
          <div class="bet_btn_inner">
                <input type="button" class="btnMoney" money="1000" value="1,000" readonly="readonly" style="cursor: pointer; margin-left: 0px;" onclick="javascript:InputCheck_new(this,'1000');">
                <input type="button" class="btnMoney" money="10000" value="10,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new(this,'10000');">
                <input type="button" class="btnMoney" money="50000" value="50,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new(this,'50000');">
                <input type="button" class="btnMoney" money="100000" value="100,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new(this,'100000');">
                <input type="button" class="btnMoney" money="500000" value="500,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new(this,'500000');">
                <input type="button" class="btnMoney" money="1000000" value="1,000,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new(this,'1000000');">
                <!--<input type="button" class="i_blue" value="잔돈" onclick="">-->
                <input type="button" class="i_brw" value="올인" id="btnMax" style="cursor: pointer;" onclick="maxvalue(this);">
                <input onclick="javascript:InputCheck_new(this,'0');" type="button" class="i_gray" value="초기화" id="btnMoneyClear" style="cursor: pointer;">
                <input type="button" class="betInfoClass" disabled="disabled" value="게임을 선택해주세요">
                <!--
                <div class="bet_money_free">
                  <label for="betExp4">직접입력</label>
                  <input type="text" name="betExp4" value="0" onkeyup="selectAmountDirect(this.value)">
                </div>
                -->
        <!-- //금액선택 -->
          </div>
          <input type="button" value="베팅하기" id="btnBett" class="btn_bet" style="cursor: pointer;" onclick="BetChk()">

        <div class="bet_disable" style="display: none;"><b style="margin-top: 20px;">지금은 베팅을 하실 수 없습니다.</b></div>

        </div>

      </div>

    </div>
    <div class="ladder_notice">
      <h4>알아두세요</h4>
      <ul>
        <li>· 사다리게임 회차는 오전 0시 기준으로 회차가 초기화 됩니다.</li>
        <li>· 한번 베팅한 게임은 베팅취소 및 베팅수정이 불가합니다.</li>
        <li>· 베팅은 본인의 보유 예치금 기준으로 베팅 가능하며, 추첨결과에 따라 명시된 배당률 기준으로 적립해드립니다.</li>
        <li>· 부적절한 방법(ID도용, 불법프로그램, 시스템 베팅 등)으로 베팅을 할 경우 무효처리되며, 전액몰수/강제탈퇴 등 불이익을 받을 수 있습니다.</li>
        <li>· 사다리 게임의 모든 배당률은 당사의 운영정책에 따라 언제든지 상/하향 조정될 수 있습니다.</li>
        <li>· 본 서비스는 네임드 사다리게임 결과를 기준으로 정산처리됩니다.</li>
        <li>· 본 서비스는 당사의 운영정책에 따라 조기 종료되거나 이용이 제한될 수 있습니다.</li>
      </ul>
    </div>
    </div>
    </div>
  </div> <!-- sub-content -->
<%
          ELSE
%>
      <div class="ladder_cart">
        <div style="bottom:0;left:0;right:0;font-size:30px;text-align:center;color:white;background:rgba(0,0,0,0.7);height:323px;">
<div style="top: 20px; color: white;">해당회차는 마감되었습니다</br>새로운회차가 진행되면 아래 새로고침 버튼을 누르세요</div>
<button type="button" class="btn_refresh" onclick="location.reload();"><font color="white">새로고침</font></button>
</div>
      </div>
    </div>
    <div class="ladder_notice">
      <h4>알아두세요</h4>
      <ul>
        <li>· 사다리게임 회차는 오전 0시 기준으로 회차가 초기화 됩니다.</li>
        <li>· 한번 베팅한 게임은 베팅취소 및 베팅수정이 불가합니다.</li>
        <li>· 베팅은 본인의 보유 예치금 기준으로 베팅 가능하며, 추첨결과에 따라 명시된 배당률 기준으로 적립해드립니다.</li>
        <li>· 부적절한 방법(ID도용, 불법프로그램, 시스템 베팅 등)으로 베팅을 할 경우 무효처리되며, 전액몰수/강제탈퇴 등 불이익을 받을 수 있습니다.</li>
        <li>· 사다리 게임의 모든 배당률은 당사의 운영정책에 따라 언제든지 상/하향 조정될 수 있습니다.</li>
        <li>· 본 서비스는 네임드 사다리게임 결과를 기준으로 정산처리됩니다.</li>
        <li>· 본 서비스는 당사의 운영정책에 따라 조기 종료되거나 이용이 제한될 수 있습니다.</li>
      </ul>
    </div>
    </div>
    </div>
  </div> <!-- sub-content -->
<%
          END IF

          sRs.close
          Set sRs = Nothing
          Dber.Dispose
          Set Dber = Nothing
        %>


<script type="text/javascript">

var g_now_datetime = undefined;
var g_end_time = 4;
var g_countdown_time = 0;
var g_refresh_count = 0;

function countdown()
{
  g_now_datetime.add(1, 'seconds');
  $('#date_hh').text(("0" + g_now_datetime.hour()).slice(-2));
  $('#date_ii').text(("0" + g_now_datetime.minute()).slice(-2));
  $('#date_ss').text(("0" + g_now_datetime.seconds()).slice(-2));
  
//H var minutes = ("0" + (parseInt(g_countdown_time / 60))).slice(-2);
  var minutes = ("0" + (parseInt(g_countdown_time / 60))).slice(-2);
  var seconds = ("0" + (parseInt(g_countdown_time % 60))).slice(-2);
  $("#remaind_time").text(minutes  + ":" + seconds);

  

  g_countdown_time--;
//H 디버깅코드 삽입-------------------시작
//  $('#dibugHber').prepend('<li>'+g_countdown_time+' | '+g_end_time+' | '+g_refresh_count + '</li>');
//  if (g_countdown_time < 200) {
//  }
//H 디버깅코드 삽입-------------------끝


  //HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
  //H 마감이후에 버튼 클릭 안되게 수정
  if (g_countdown_time > 239) {
  //다음회차인거로 
    $('#play_num_view').css('color','#FFFF00').css('font-weight','bold').css('text-shadow','2px 2px 2px #555');
    
  }else{
    $('#play_num_view').css('color','#ffce25').css('font-weight','bold').css('text-shadow','2px 2px 2px #555');
  }

  if (g_countdown_time < 0) {
    g_countdown_time = 0;
    if (++g_refresh_count >= 100) {
      location.reload();
    }

  } 
  setTimeout(countdown, 1000);
}

(function () {
  $(".btnMoney").attr('readonly', 'readonly');
  for (var i = 0; i < 1; i++)
  {
    var home_id = "";
    var tie_id = "";
    var away_id = "";
    var d = new Date();
    
    if (i == 0) {
      $('.bet_disable').hide();
      g_now_datetime = moment(getTimeStamp().replace("_", " "));
      var bt_stime = moment("<%=getGameTime%>");


      
      //$('#date_mm').text(g_now_datetime.month() + 1);
      //$('#date_dd').text(g_now_datetime.date());
      
      var duration = moment.duration(bt_stime.diff(g_now_datetime));
      g_countdown_time = duration.asSeconds();
      
      
      if (g_countdown_time < 0) {
        $('#remaind_time').text("00:00");
        $('.bet_disable').show();
      } else {
        var minutes = ("0" + (parseInt(g_countdown_time / 60))).slice(-2);
        var seconds = ("0" + (parseInt(g_countdown_time % 60))).slice(-2);
        $('#remaind_time').text(minutes + ":" + seconds);
      }
      setTimeout(countdown, 1000);
    }
  }
})();
function getTimeStamp() {
  var d = new Date();
  var s =
    leadingZeros(d.getFullYear(), 4) + '-' +
    leadingZeros(d.getMonth() + 1, 2) + '-' +
    leadingZeros(d.getDate(), 2) + ' ' +

    leadingZeros(d.getHours(), 2) + ':' +
    leadingZeros(d.getMinutes(), 2) + ':' +
    leadingZeros(d.getSeconds(), 2);

  return s;
}

function getTimeStamp2(da) {
var d = new Date();
d = da;
  var s =
    leadingZeros(d.getFullYear(), 4) + '-' +
    leadingZeros(d.getMonth() + 1, 2) + '-' +
    leadingZeros(d.getDate(), 2) + ' ' +

    leadingZeros(d.getHours(), 2) + ':' +
    leadingZeros(d.getMinutes(), 2) + ':' +
    leadingZeros(d.getSeconds(), 2);

  return s;
}

function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}


</script>

<!-- #include file="../_Inc/right.inc_dari.asp" -->
</form>
<script>
$(function () {

  var msie6 = $.browser == 'msie' && $.browser.version < 7;

  if (!msie6) {
  var top = $('#comment').offset().top - parseFloat($('#comment').css('margin-top').replace(/auto/, 0));
  $(window).scroll(function (event) {
    // what the y position of the scroll is
    var y = $(this).scrollTop();

    // whether that's below the form
    if (y >= top) {
    // if so, ad the fixed class
    $('#comment').addClass('fixed');
    } else {
    // otherwise remove it
    $('#comment').removeClass('fixed');
    }
  });
  }
});
</script>
<script type="text/javascript">
  function del_all() {
    $("#betting_cartbox").find(".btnBettDel").each(function() {
      $(this).trigger("click");
    });
  }
  var moving_stat = 1; // 메뉴의 스크롤을 로딩시 on/off설정 1=움직임 0은 멈춤
  function moving_control() {
    if(!moving_stat){ 
      moving_stat = 1;
    }
    else{ 
      moving_stat = 0; 
    }
  }
  var scrollTimer;
  var ag = navigator["userAgent"].toLowerCase();
  var win = (ag.indexOf("android") != -1 || ag.indexOf("iphone") != -1) ? parent.window : window;
  $(win).scroll(function(){ //윈도우에 스크롤값이 변경될때마다
    var $win = $(this);
    clearTimeout(scrollTimer);
    scrollTimer = setTimeout(function() {
      if (moving_stat) {
        var __scrollTop = $win.scrollTop();

        if (__scrollTop >= 160) {
          $("#scrollingLayer").animate({"top": (__scrollTop - 160) + "px"}, 300);
        } else {
          $("#scrollingLayer").animate({"top":"0px"}, 300);
        }
      }
    }, 40);
  });
</script>
<script>
  $("#sub-content").delegate("a.betting", "mouseenter mouseleave mousedown click", function (e) {
    var obj = this;
    switch (e.type) {
    case "mouseenter":
      if ($(this).text() !== "-" && $(this).text() !== "VS" && $(this).attr("flag") !== "N") {
        $(this).addClass("btn-mouseenter");
      }
      break;
    case "mouseleave":
      $(this).removeClass("btn-mouseenter");
      break;
    case "focus":
      this.blur();
      break;
    case "click":
      this.blur();
      if ($(obj).attr("flag") != "Y") {
        if ($(this).hasClass("btn-mouseclick") === false) {

          $(".btn-mouseclick").removeClass("btn-mouseclick");
          $(this).addClass("btn-mouseclick");
        } else { // 베팅해제
          $(this).removeClass("btn-mouseclick");
        }
      }
      break;
    } // switch-case
  });

 </script>