<link rel="stylesheet" href="/css/game.css" type="text/css">

<%
	getGameTime = ""
  Set Dber = new clsDBHelper

  SQL = "UP_INFO_Cart_DEL"
  reDim param(1)
  param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
  param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

  Dber.ExecSP SQL,param,Nothing

	onn1="on_"
  GG_TYPE = 15 'power'

%>
	
<div class="powerball_wrap" id="sub-content" style="width:940px;margin: auto">
	<div class="powerball_top">
    <iframe src="http://ntry.com/scores/powerball/live.php" style="width:830px; height: 646px"></iframe>
  </div>
	
	<div class="powerball_cnt">
    <div class="powerball_choice">
      <h3 class="hidden">게임선택</h3>
      <div class="powerball_choice_inner">
        <div class="powerball_1st">
          <h4>1게임 : 일반볼 홀/짝</h4>
          <div>
            <ul>
              <li><a class="btn_odd betting" id="id1_501_1" bt_league="일반볼" flag="N">
                <span class="per divd" id="benefit_501_1"></span>
              </a></li>
              <li style="display:none"><a class="betting" id="t_6939594" bt_league="일반볼" flag="N">
                <span class="name">undefined</span>
                <span class="divd">0.00</span>
              </a></li>
              <li><a class="btn_even betting" id="id2_501_2" bt_league="일반볼" flag="N">
                <span class="per divd" id="benefit_501_2"></span>
              </a></li>
            </ul>
          </div>
        </div>
        <div class="powerball_2nd">
          <h4>2게임 : 파워볼 홀/짝</h4>
          <div>
            <ul>
              <li><a class="btn_odd betting" id="id1_502_1" bt_league="파워볼" flag="N">
                <span class="per divd" id="benefit_502_1"></span>
              </a></li>
              <li style="display:none"><a class="betting" id="t_6939592" bt_league="파워볼" flag="N">
                <span class="divd">0.00</span>
              </a></li>
              <li><a class="btn_even betting" id="id2_502_2" bt_league="파워볼" flag="N">
                <span class="per divd" id="benefit_502_2"></span>
              </a></li>
            </ul>
          </div>
        </div>
        <div class="powerball_3rd">
          <h4>3게임 : 일반볼 구간</h4>
          <div>
            <ul>
              <li><a class="btn_sm betting" id="id1_503_1" bt_league="일반볼" flag="N">
                <span class="per divd" id="benefit_503_1"></span>
              </a></li>
            </ul>
            <ul>
              <li><a class="btn_md betting" id="id3_503_3" bt_league="일반볼" flag="N">
                <span class="per divd" id="benefit_503_3"></span>
              </a></li>
            </ul>
            <ul>
              <li><a class="btn_bi betting" id="id2_503_2" bt_league="일반볼" flag="N">
                <span class="per divd" id="benefit_503_2"></span>
              </a></li>
            </ul>
          </div>
        </div>
        <div class="powerball_6th">
          <h4>4게임 : 파워볼 언오버</h4>
          <div>
            <ul>
              <li><a class="btn_pbOver betting" id="id1_504_1" bt_league="파워볼" flag="N">
                <span class="per divd" id="benefit_504_1"></span>
              </a></li>
              <li style="display:none"><a class="betting" id="t_6939593" bt_league="파워볼" flag="N">
                <span class="divd"></span>
              </a></li>
              <li><a class="btn_pbUnder betting" id="id2_504_2" bt_league="파워볼" flag="N">
                <span class="per divd" id="benefit_504_2"></span>
              </a></li>
            </ul>
          </div>
        </div>
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
	  $("#date_mm").html('<%=Replace(Left(dfSiteUtil.GetBetDate(IG_StartTime),5),"/","월 ")%>'+'일');
    $("#play_num_view").html("<%=Mid(IG_Team1,1,5)%>");

    $("#id1_<%=RL_Idx%>_1").attr("onclick", "addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,1,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','<%=IG_Status%>'); return false;");
    $("#benefit_<%=RL_Idx%>_1").html("<%=FORMATNUMBER(IG_Team1Benefit,2)%>");
    $("#id2_<%=RL_Idx%>_2").attr("onclick", "addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,2,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','<%=IG_Status%>'); return false;");
    $("#benefit_<%=RL_Idx%>_2").html("<%=FORMATNUMBER(IG_Team2Benefit,2)%>");
    $("#id3_<%=RL_Idx%>_3").attr("onclick", "addCart(this,'<%=Session("SD_ID")%>',<%=IG_Idx%>,0,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','<%=IG_Status%>'); return false;");
    
    $("#benefit_<%=RL_Idx%>_3").html("<%= dfSiteUtil.getDrawValue(IG_TYPE, IG_DrawBenefit ,IG_Handicap) %>");
	</script>
	<%
		  End IF
		  RL_League1 = RL_Leag
		  sRs.MoveNext
		  NEXT
	%>
		<form name="BetFrm" target="ProcFrm" method="post" action="Bet_Proc.asp">
			<div class="powerball_cart">
				<div class="cart_info">
        <ul>
          <li>
            <span>게임분류</span>
            <strong>[파워볼]</strong>
          </li>
          <li id="selBet">
            <span>게임선택</span>
            <strong>
              <span class="tx" id="cartTable_game"></span>
              <div id="cartTable" style="display:none"></div>
            </strong>
          </li>
          <li>
            <span>배당률</span>
            <div id="foreCastDividendPercent"><%=numdel(TotalBenefitRate)%></div>
          </li>
          <li style="display:none">
            <span id="min_price">5000</span>
            <span id="max_price">500000</span>
            <span id="max_eprice">1,375,000</span>
          </li>
        </ul>
      </div>
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
              <input type="button" class="btnMoney" money="1000" value="1,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new('1000');">
              <input type="button" class="btnMoney" money="10000" value="10,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new('10000');">
              <input type="button" class="btnMoney" money="50000" value="50,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new('50000');">
              <input type="button" class="btnMoney" money="100000" value="100,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new('100000');">
              <input type="button" class="btnMoney" money="500000" value="500,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new('500000');">
              <input type="button" class="btnMoney" money="1000000" value="1,000,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new('1000000');">
              <input type="button" class="i_brw" value="올인" id="btnMax" style="cursor: pointer;" onclick="maxvalue(this);">
              <input onclick="javascript:InputCheck_new('0');" type="button" class="i_gray" value="초기화" id="btnMoneyClear" style="cursor: pointer;">
              
            </div>
        <input type="button" value="베팅하기" id="btnBett" class="btn_bet" style="cursor: pointer;" onclick="BetChk()">
      </div>
			</div>

<!-- #include file="../_Inc/right.inc_dari.asp" -->
		</form>
	</div>
	<%
      ELSE
	%>
	<div class="powerball_notice">
    <div style="bottom:0;left:0;right:0;font-size:30px;text-align:center;color:white;background:rgba(0,0,0,0.7);height:300px;">
      <div style="top: 20px; color: white;">해당회차는 마감되었습니다<br>새로운회차가 진행되면 아래 새로고침 버튼을 누르세요</div>
      <button type="button" class="btn_refresh" onclick="location.reload();"><font color="white">새로고침</font></button>
      </div>
    </div>
  <%
    END IF
    sRs.close
    Set sRs = Nothing
    Dber.Dispose
    Set Dber = Nothing
  %>
  <div class="powerball_notice">
    <h4>알아두세요!</h4>
    <ul>
      <li>· 본 서비스는 나눔로또의 파워볼 결과를 기준으로 정산처리 하며, 파워볼의 결과와 무관합니다.</li>
      <li>· 한번 베팅한 게임은 베팅취소 및 베팅수정이 불가합니다.</li>
      <li>· 베팅은 본인의 보유 예치금 기준을 베팅가능하며, 추첨결과에 다라 명시된 배당률 기준으로 적립해드립니다.</li>
      <li>· 부적절한 방법(ID도용, 불법프로그램, 시스템 베팅 등)으로 베팅을 할 경우 무효처리되며, 전액몰수/강제탈퇴 등 불이익을 받을 수 있습니다.</li>
      <li>· 파워볼게임의 모든 배당률은 당사의 운영정책에 따라 언제든지 상/하향 조정될 수 있습니다.</li>
      <li>· 본 서비스는 당사의 운영정책에 따라 조기 종료되거나 이용이 제한될 수 있습니다.</li>
    </ul>
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