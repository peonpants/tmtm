<link rel="stylesheet" href="/css/game.css" type="text/css">

<%
	getGameTime = ""
  Set Dber = new clsDBHelper

  SQL = "UP_INFO_Cart_DEL"
  reDim param(1)
  param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
  param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

  Dber.ExecSP SQL,param,Nothing

	IF LCase(Game_Type)  = "powers" Then
  	onn2="on_"
  	GG_TYPE = 23
    name = "파워사다리"
    bID = "70"
	ElseIf LCase(Game_Type)  = "live" Then
  	onn10="on_"
  	GG_TYPE = 10
    name = "사다리"
    bID = "38"
  ElseIf LCase(Game_Type)  = "dari" Then
    GG_TYPE = 11
    onn11="on_"
    name = "다리다리"
    bID = "60"
	End If
%>
	
<div class="ladder_wrap" id="sub-content" style="width:940px;margin: auto">
	<div class="ladder_top">
		
    <% If LCase(Game_Type)="live" then %>
    <div id="live-frame" style="width: 589px; height: 423px;">
      <iframe frameborder="0" scrolling="no" src="http://ladder.named.com/main.php" style="width: 811px; height: 608px; margin-top: -144px; margin-left: -223px;">
    <% elseIf LCase(Game_Type)="powers" then %>
    <div id="live-frame" style="width: 830px; height: 632px;">
      <iframe frameborder="0" scrolling="no" src="http://www.ntry.com/scores/power_ladder/live.php" style="width: inherit; height: inherit;">
    <% elseIf LCase(Game_Type)="dari" then %>
    <div id="live-frame" style="width: 830px; height: 560px;"><iframe frameborder="0" scrolling="no" src="http://daridari.named.com" style="width: 830px; height: 565px; margin-top: -5px;">
    <% End If %>
      </iframe></div>
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
            <li><a class="b_odd betting" id="id1_<%=bID%>1_1" bt_league="네임드 사다리 [홀/짝]" flag="N">
              <span class="divd" id="benefit_<%=bID%>1_1"></span>
            </a></li>
            <li style="display:none"><a class="betting" id="t_6893399" bt_league="네임드 사다리 [홀/짝]" flag="{victory.setCheckFlag.tie}">
              <span class="name">undefined</span>
              <span class="divd"></span>
            </a></li>
            <li><a class="b_even betting" id="id2_<%=bID%>1_2" bt_league="네임드 사다리 [홀/짝]" flag="N">
              <span class="divd"  id="benefit_<%=bID%>1_2"></span>
            </a></li>
          </ul>
        </div>
        <div class="ladder_2nd">
          <h4 class="hidden">2게임 출발줄 줄갯수</h4>
          <ul>
            <li><a class="b_4_even betting" id="id1_<%=bID%>2_1" bt_league="네임드 사다리 [출발점 좌/우]" flag="N">
              <span class="divd" id="benefit_<%=bID%>2_1"></span>
            </a></li>
            <li style="display:none"><a class="betting" id="t_6893400" bt_league="네임드 사다리 [출발점 좌/우]" flag="{victory.setCheckFlag.tie}">
              <span class="name">undefined</span>
              <span class="divd"></span>
            </a></li>
            <li><a class="b_3_odd betting" id="id2_<%=bID%>2_2" bt_league="네임드 사다리 [출발점 좌/우]" flag="N">
              <span class="divd" id="benefit_<%=bID%>2_2"></span>
            </a></li>
            
            <li><a class="b_lft betting" id="id1_<%=bID%>3_1" bt_league="네임드 사다리 [3줄 / 4줄]" flag="N">
              <span class="divd" id="benefit_<%=bID%>3_1"></span>
            </a></li>
            <li style="display:none"><a class="betting" id="t_6893401" bt_league="네임드 사다리 [3줄 / 4줄]" flag="{victory.setCheckFlag.tie}">
              <span class="name">undefined</span>
              <span class="divd"></span>
            </a></li>
            <li><a class="b_rgt betting" id="id2_<%=bID%>3_2" bt_league="네임드 사다리 [3줄 / 4줄]" flag="N">
              <span class="divd" id="benefit_<%=bID%>3_2"></span>
            </a></li>
          </ul>
        </div>
        <div class="ladder_3rd">
          <h4 class="hidden">3게임 좌우 출발 3/4줄</h4>
          <ul>
            <li><a class="b_lft_3_oven betting" id="id1_<%=bID%>4_1" bt_league="네임드 사다리 [조합]" flag="N">
              <span class="divd" id="benefit_<%=bID%>4_1"></span>
            </a></li>
            <li style="display:none"><a class="betting" id="t_6893402" bt_league="네임드 사다리 [조합]" flag="{victory.setCheckFlag.tie}">
              <span class="divd" id="benefit_<%=bID%>4_1"></span>
            </a></li>
            <li><a class="b_rgt_3_odd betting" id="id2_<%=bID%>4_2" bt_league="네임드 사다리 [조합]" flag="N">
              <span class="divd" id="benefit_<%=bID%>4_2"></span>
            </a></li>
            
            <li><a class="b_lft_4_odd betting" id="id1_<%=bID%>5_1" bt_league="네임드 사다리 [조합]" flag="N">
              <span class="divd" id="benefit_<%=bID%>5_1"></span>
            </a></li>
            <li style="display:none"><a class="betting" id="t_6893403" bt_league="네임드 사다리 [조합]" flag="{victory.setCheckFlag.tie}">
              <span class="name">undefined</span>
              <span class="divd">0.00</span>
            </a></li>
            <li><a class="b_rgt_4_even betting" id="id2_<%=bID%>5_2" bt_league="네임드 사다리 [조합]" flag="N">
              <span class="divd" id="benefit_<%=bID%>5_2"></span>
            </a></li>       
          </ul>
        </div>
      </div>

<%
    SQL = "dbo.UP_RetrieveInfo_GameByUser"
    reDim param(1)
    param(0) = Dber.MakeParam("@gg_type",adInteger,adParamInput,,GG_TYPE)
    param(1) = Dber.MakeParam("@jobsite",adVarchar,adParamInput,20,JOBSITE)
    Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

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
      
	    IF IG_Status = "S" Then 
	      IF GCNT = 0 Then
	        getGameTime = left(IG_StartTime,10) &" "& FormatDateTime(CDate(IG_StartTime),4) + ":" + Right(IG_StartTime,2)
	      End If
%> 
	<script>
	  //사다리용
	  $("#date_mm").html('<%=Replace(Left(dfSiteUtil.GetBetDate(IG_StartTime),5),"/","월 ")%>'+'일');
    <% 
    'H  회차 제대로 표시되게 고침
    Play_Num_View_Text = Replace(Mid(IG_Team1,1,5), "[", "")
    Play_Num_View_Text = Replace(Play_Num_View_Text, "회", "")
    Play_Num_View_Text = Replace(Play_Num_View_Text, "차", "")
    Play_Num_View_Text = " [ "& Play_Num_View_Text &" 회차 ] "
    %>
    $("#play_num_view").html("<%=Play_Num_View_Text%>");
    $("#id1_<%=RL_Idx%>_1").attr("onclick", "addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,1,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','<%=IG_Status%>'); return false;");
    $("#benefit_<%=RL_Idx%>_1").html("<%=FORMATNUMBER(IG_Team1Benefit,2)%>");

    $("#id2_<%=RL_Idx%>_2").attr("onclick", "addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,2,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','<%=IG_Status%>'); return false;");
    $("#benefit_<%=RL_Idx%>_2").html("<%=FORMATNUMBER(IG_Team2Benefit,2)%>");
	</script>
	<%
		    End IF
		  RL_League1 = RL_Leag
		  sRs.MoveNext
		  NEXT
	%>
		<form name="BetFrm" target="ProcFrm" method="post" action="Bet_Proc.asp">
			<div class="ladder_cart">
				<div class="cart_info">
					<ul>
						<li>
							<span>게임분류</span>
							<strong>[<%=name%>]</strong>
						</li>
						<li id="selBet">
							<span>게임선택</span><br>
							<strong>
								<span class="tx" id="cartTable_game"></span>
								<div id="cartTable" style="display:none"></div>
							</strong>
						</li>
						<li id="betRate">
							<span>배당률</span>
							<div id="foreCastDividendPercent">.00</div>
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
						<input type="button" class="btnMoney" money="1000" value="1,000" readonly="readonly" style="cursor: pointer; margin-left: 0px;" onclick="javascript:InputCheck_new('1000');">
						<input type="button" class="btnMoney" money="10000" value="10,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new('10000');">
						<input type="button" class="btnMoney" money="50000" value="50,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new('50000');">
						<input type="button" class="btnMoney" money="100000" value="100,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new('100000');">
						<input type="button" class="btnMoney" money="500000" value="500,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new('500000');">
						<input type="button" class="btnMoney" money="1000000" value="1,000,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new('1000000');">
						<input type="button" class="i_brw" value="올인" id="btnMax" style="cursor: pointer;" onclick="maxvalue(this);">
						<input onclick="javascript:InputCheck_new('0');" type="button" class="i_gray" value="초기화" id="btnMoneyClear" style="cursor: pointer;">
						<input type="button" class="betInfoClass" disabled="disabled" value="게임을 선택해주세요">
					</div>
					<input type="button" value="베팅하기" id="btnBett" class="btn_bet" style="cursor: pointer;" onclick="BetChk()">

					<div class="bet_disable" style="display: none;"><b style="margin-top: 20px;">지금은 베팅을 하실 수 없습니다.</b></div>
				</div>
			</div>

<!-- #include file="../_Inc/right.inc_dari.asp" -->
		</form>
	</div>
	<%
      ELSE
	%>
	<div class="ladder_cart">
    <div style="bottom:0;left:0;right:0;font-size:30px;text-align:center;color:white;background:rgba(0,0,0,0.7);height:160px;">
      <div style="top: 20px; color: white;">해당회차는 마감되었습니다<br>새로운회차가 진행되면 아래 새로고침 버튼을 누르세요
      </div>
      <button type="button" class="btn_refresh" onclick="location.reload();"><font color="white">새로고침</font>
      </button>
    </div>
  </div>
  <%
    END IF
    sRs.close
    Set sRs = Nothing
    Dber.Dispose
    Set Dber = Nothing
  %>
  <div class="ladder_notice">
    <h4>게임설명</h4>
    <ul></ul>
    <li>· 네임드의 사다리게임을 기준으로 5분단위로 진행됩니다.</li><li>· 회차는 오전 0시를 기준으로 회차가 초기화 됩니다.</li><li>· 게임하단에 표시되는 분포도의 경우 네임드를 기준으로 표기됩니다.</li>
  </div>
</div>
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
    var minutes = ("0" + (parseInt(g_countdown_time / 60))).slice(-2);
    var seconds = ("0" + (parseInt(g_countdown_time % 60))).slice(-2);
    $("#remaind_time").text(minutes  + ":" + seconds);

    g_countdown_time--;
    if (g_countdown_time > 239) {
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