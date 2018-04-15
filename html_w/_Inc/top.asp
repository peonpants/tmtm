
<%
Response.CodePage = 65001
Response.CharSet = "UTF-8"
    '########   최신 접속 시간 입력   ##############               		        
    Current_Dir = Split(Request.ServerVariables("URL"),"/")

    IF Ubound(Current_Dir) > 1 Then
      c_dir = Current_Dir(1)
    End IF
    IF Session("SD_ID") = "" Then 
      %>
      <script type="text/javascript">
        alert("로그인이 필요합니다.");
        top.location.href = "/"
      </script>
      <%        
      response.End
    End IF

    Set Dbera = new clsDBHelper

    SQL = "UP_INFO_USER_CHK1"
    reDim param(1)
    param(0) = Dbera.MakeParam("@iu_id",adVarWChar,adParamInput,20,Session("SD_ID"))
    param(1) = Dbera.MakeParam("@jobsite",adVarWChar,adParamInput,20,JOBSITE)
    Set sRsa = Dbera.ExecSPReturnRS(SQL,param,nothing)

    IF NOT sRsa.Eof Then
      IU_Cash = sRsa("IU_Cash")
      IU_Point = sRsa("IU_Point")
      iu_ip5 = sRsa("iu_ip5")
      iu_ip10 = sRsa("iu_ip10")
      iu_is5 = sRsa("iu_is5")
      iu_is10 = sRsa("iu_is10")
      iu_isa = sRsa("iu_isa")
      iu_level = sRsa("iu_level")
      iu_nickname= sRsa("IU_NickName")
      iu_casinoid = sRsa("iu_casinoid")
      casinosite = sRsa("IU_SITE")
		  IU_REGDATE = sRsa("IU_REGDATE")
      IU_BANKNAME = sRsa("IU_BANKNAME")
      IU_BANKNUM = sRsa("IU_BANKNUM")
      IU_BANKOWNER = sRsa("IU_BANKOWNER")

      IF sRsa("IU_NickName") <> Session("IU_NickName") Then 
        'Session("IU_NickName") = sRsa("IU_NickName")
      End IF

    End IF            
    sRsa.close
    Set sRsa = Nothing

    sql = "UP_BF_TITLE_CHK"
    Set sRsb = Dbera.ExecSPReturnRS(sql, nothing, nothing)
    If sRsb.eof Or sRsb.bof Then 
      gongMsg = ""
    Else
    gongMsg = Trim(sRsb(0))
    gongMsg = Replace(gongMsg, "&lt;", "<")
    gongMsg = Replace(gongMsg, "&gt;", ">")
    gongMsg = Replace(gongMsg, "&amp;", "&")
  End If 

  sRsb.close
  Set sRsb = Nothing 

  SQL = "dbo.UP_InsertRealtime_LogByUser"
  reDim param(2)
  param(0) = Dbera.MakeParam("@iu_id",adVarWChar,adParamInput,20,Session("SD_ID"))
  param(1) = Dbera.MakeParam("@jobsite",adVarWChar,adParamInput,20,JOBSITE)
  param(2) = Dbera.MakeParam("@c_dir",adVarWChar,adParamInput,20,"main")

  Dbera.ExecSP SQL,param,Nothing
  Dbera.Dispose
  Set Dbera = Nothing         
  %>
  <!DOCTYPE html>
  <html>
  <head>
    <meta name="viewport" content="width=1000"><title><%=SITE_TITLE%></title><link rel="Shortcut Icon" href="http://wd-82.com/images/logo_webpage2.png"><link rel="Stylesheet" href="/css/style2.css">
    <!-- menu1 -->

    <SCRIPT LANGUAGE="JavaScript">
      function hide_pwd(){
        var x = document.getElementById('div_pwd');
        x.style.display='block';
        var y = document.getElementById('div_pwdfake');
        y.style.display='none';
        document.form1.userpwd.focus();
      }
    </SCRIPT>
    <script>
	function FrmChk2()
	{
		if(!confirm("포인트를 보유금액으로 전환하시겠습니까?")){
			return;
		}
		frmp.action = "/money/money_proc.asp";
		frmp.submit();	
	}
    </script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script> 
      Lpad=function(str, len) { 
       str = str + ""; 
       while(str.length < len) 
       { 
        str = "0"+str; 
      } 
      return str; 
    } 

    var iMinute=30; 
    var noticeSecond = 59; 
    var iSecond = iMinute * 60 ; 
    var timerchecker = null; 

    initTimer=function() 
    { 
      if(window.event)  { 
        iSecond = iMinute * 60 ;; 
        clearTimeout(timerchecker); 
    coverFilmMain.style.visibility='hidden'; //// 입력방지 레이어 해제 
  timer.style.visibility='hidden';  /// 자동로그아웃 경고레이어 해제 
} 

rMinute = parseInt(iSecond / 60); 
rSecond = iSecond % 60; 
if(iSecond > 0) 
{ 
if(iSecond < noticeSecond) 
{ 
        coverFilmMain.style.visibility='visible'; /// 입력방지 레이어 활성 
        timer.style.visibility='visible';  /// 자동로그아웃 경고레이어 활성 
      } 
  ///자동로그아웃 경고레이어에 경고문+남은 시간 보여주는 부분 
  timer.innerHTML ="<span style='font-size:70px; color:#FFFFFF'>자동로그아웃<font color=red>" + Lpad(rMinute, 2)+":"+Lpad(rSecond, 2) +" </span>"; 
  iSecond--; 
  timerchecker = setTimeout("initTimer()", 1000); // 1초 간격으로 체크 
} 
else 
{ 
  clearTimeout(timerchecker); 
  alert("장시간 미사용으로 자동 로그아웃 처리되었습니다."); 
location.href = "/login/logout_proc.asp"; // 로그아웃 처리 페이지 
} 
} 
 onload = initTimer;///현재 페이지 대기시간 
 document.onclick = initTimer; /// 현재 페이지의 사용자 마우스 클릭이벤트 캡춰 
document.onkeypress = initTimer;/// 현재 페이지의 키보트 입력이벤트 캡춰 
</script>
<SCRIPT type="text/javascript">     

window.history.forward();     

function noBack() { window.history.forward(); } 

</SCRIPT> 
<style>
  .daridaei {
      position: relative;
      cursor: pointer;
  }
  .daridaei .box{
      position: absolute;
      left: 50%;
      top: 40px;
      margin-left: -85px;
      width: 171px;
      z-index: 9999;
      display: none;
  }
  .active .box{
    display: block;
  }
  .daridaei .box a {
    float: left;
  }
</style> 
<STYLE type="text/css">

    body {
        background: url("/images/login/login_bg.jpg") scroll center top #000;
        margin: 0;
    }
    .notice_all {
                        color:#f7f7f7;
                        height:60px;
                        line-height:60px;
                        width:100%;
                        clear:both;
                        position:relative;
                        overflow-y:hidden;
                    }

</STYLE>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
</head>


<body id="top" onload="noBack();"     onpageshow="if (event.persisted) noBack();" onunload="">
	<form name="frmp" method="post" >
		<input type="hidden" name="EMODE" value="POINT1">
		<input type="hidden" name="IE_ID" value="<%=Session("SD_ID")%>">
		<input type="hidden" name="IU_POINT" value="<%=IU_POINT%>">
  <div id='coverFilmMain' style='z-index: 99997; position:absolute; visibility:hidden; width:100%; height:100%; background-color:#000000; filter:Alpha(opacity=50); opacity:0.5; -moz-opacity:0.6; text-align:center; font-size:12pt;color:#FFFFFF;'></div> 
  <div id="timer" style="position:absolute; width:100%; height:40%;margin-top:20%; visibility:hidden; border:0; FONT-FAMILY: '맑은 고딕','Malgun Gothic','돋움','Dotum'; color:#FFFFFF; font-size:150; font-weight:bold;text-align:center"></div> 

  <div align="center" style="width: 1010px; margin: auto">
    <table cellpadding="0" cellspacing="0" align="center">
        <tbody>
          <tr>
            <td>
                <div class="gnb_top">
                  
                    <table cellpadding="0" cellspacing="0" align="center">
                        <tbody><tr>
                            <td style="width:513px;height:80px;text-align:left;vertical-align:bottom;">
                              <a href="/main.asp" style="margin-left: -24px"><img src="/images/top/logo.gif" alt="" border="0"></a>
                                
                            </td>                               
                            <td style="width:513px;height:80px;text-align:right;">
                                <a href="/freeboard/board_list.asp"><img src="/images/top/BoardList_btn.png" alt="" border="0"></a>
                            </td>
                            <td>
                                <a href="/member/mybet.asp"><img src="/images/top/betlist1.jpg" alt="" border="0"></a>
                            </td>
                            <td>
                                <a href="/game/betresult.asp"><img src="/images/top/menu_result1.jpg" alt="" border="0"></a>
                            </td>
                            <td>
                                <a href="/support/answer_list.asp"><img src="/images/top/menu_cs2.jpg" alt="" border="0"></a>
                            </td>
                            <td>
                                <a href="/login/logout_proc.asp"><img src="/images/top/menu_logout1.jpg" alt="" border="0"></a>
                            </td>
                        </tr>
                        </tbody>
                    </table>                       
                    
                </div>
            </td>
        </tr>
        <tr><td height="5"></td></tr>
        <tr>
            <td>
                <table cellpadding="0" cellspacing="0" align="center">
                    <tbody>
                      <tr>
                        <td>
                            <a href="/game/BetGame.asp?game_type=cross"><img src="/images/top/m_1.png" onmouseover="this.src=&#39;/images/top/m_1_over.png&#39;" onmouseout="this.src=&#39;/images/top/m_1.png&#39;"></a>
                        </td>
                        <td>
                            <a href="/game/BetGame.asp?game_type=smp"><img src="/images/top/m_2.png" onmouseover="this.src=&#39;/images/top/m_2_over.png&#39;" onmouseout="this.src=&#39;/images/top/m_2.png&#39;"></a>
                        </td>
                        <td>
                            <a href="/game/BetGame.asp?game_type=handicap"><img src="/images/top/m_3.png" onmouseover="this.src=&#39;/images/top/m_3_over.png&#39;" onmouseout="this.src=&#39;/images/top/m_3.png&#39;"></a>
                        </td>
                        <td>
                            <a href="/game/BetGame.asp?game_type=special"><img src="/images/top/m_4.png" onmouseover="this.src=&#39;/images/top/m_4_over.png&#39;" onmouseout="this.src=&#39;/images/top/m_4.png&#39;"></a>
                        </td>
                        <td>
                            <a href="/game/BetGame.asp?game_type=special2"><img src="/images/top/m_5.png" onmouseover="this.src=&#39;/images/top/m_5_over.png&#39;" onmouseout="this.src=&#39;/images/top/m_5.png&#39;"></a>
                        </td>
                        <td>
                            <a href="/game/BetGame.asp?game_type=dal"><img src="/images/top/m_17.png" onmouseover="this.src=&#39;/images/top/m_17_over.png&#39;" onmouseout="this.src=&#39;/images/top/m_17.png&#39;"></a>
                        </td>
                        
                        <td>
                            <a href="/game/BetGame.asp?game_type=power"><img src="/images/top/m_7.png" onmouseover="this.src=&#39;/images/top/m_7_over.png&#39;" onmouseout="this.src=&#39;/images/top/m_7.png&#39;"></a>
                        </td>
                        <td>
                            <a href="/game/BetGame.asp?game_type=powers"><img src="/images/top/m_14.png" onmouseover="this.src=&#39;/images/top/m_14_over.png&#39;" onmouseout="this.src=&#39;/images/top/m_14.png&#39;"></a>
                        </td>
                        
                        <td class="daridaei" onmouseover="$(this).addClass('active')" onmouseout="$(this).removeClass('active')">
                              <img src="/images/top/m_19.png" onmouseover="this.src=&#39;/images/top/m_19_over.png&#39;" onmouseout="this.src=&#39;/images/top/m_19.png&#39;">
                              <div class="box">
                                  <a href="/game/BetGame.asp?game_type=casino_help"><img src="/images/top/menu_ladder19.png" align="absmiddle" border="0"></a>
                                  <a href="/game/BetGame.asp?game_type=<% If IU_CASINOID = "" Or IsNull(IU_CASINOID) Then %>casino_help<% Else %>casino<% End If %>"><img src="/images/top/menu_ladder199.png" align="absmiddle" border="0"></a>
                              </div>
                        </td>
                        <td class="daridaei" onmouseover="$(this).addClass('active')" onmouseout="$(this).removeClass('active')">
                            <img src="/images/top/m_18.png" onmouseover="this.src='/images/top/m_18_over.png'" onmouseout="this.src=&#39;/images/top/m_18.png&#39;">
                            <div class="box">
                                <a href="javascript:alert('업데이트 준비 중입니다.');"><img src="/images/top/menu_ladder18.png" align="absmiddle" border="0"></a>
                                <a href="javascript:alert('업데이트 준비 중입니다.');"><img src="/images/top/menu_ladder188.png" align="absmiddle" border="0"></a>
                            </div>
                        </td>
                        <td>
                            <a href="javascript:alert('업데이트 준비 중입니다.')"><img src="/images/top/m_13.png" onmouseover="this.src=&#39;/images/top/m_13_over.png&#39;" onmouseout="this.src=&#39;/images/top/m_13.png&#39;"></a>
                        </td>
                        
                    </tr>
                </tbody></table>
            </td>
        </tr>  
        <tr><td height="15"></td></tr>          
        <tr>
            <td>
                <!-- 내정보 -->
                <div class="gnb_top_my">
                    <ul class="info">
                        <li class="my">
                            <img id="ctl00_img_lv" src="/images/level/level_<%=iu_level%>.png" style="border-width:0px;">
                            <span id="ctl00_lbl_name"><%=iu_nickname%></span>
                            님 어서오세요.
                        </li>
                        <li class="money">
                            <strong>캐시 :</strong>
                            <span id="ctl00_lbl_money"><%=formatnumber(IU_Cash,0)%></span> 원
                        </li>
                        <li class="point">
                            <strong>포인트 :</strong>
                            <span id="ctl00_lbl_point"><%=formatnumber(IU_Point,0)%></span> 점
                        </li>
                        <li class="memo">
                            <strong>쪽지 :</strong>
                            <a href="/support/answer_list.asp">(<span id="ctl00_lbl_memo"></span></a><a href="/support/answer_list.asp">                       <span id="i_rank" name="i_rank"  class="menubar_1">

    <%

        TINPUT = 0 
        
        IF SESSION("SD_ID") <> "" Then
            Set Dber = new clsDBHelper
            SQL = "dbo.UP_CheckMemoAlramByUser "
            
            reDim param(1)
            param(0) = Dber.MakeParam("@iu_id",adVarWChar,adParamInput,20,Session("SD_ID"))
            param(1) = Dber.MakeParam("@jobsite",adVarWChar,adParamInput,20,JOBSITE)
            
            Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
            If Not sRs.eof then
                TINPUT = CDBL(sRs(0))
            End If 
            
            sRs.close
            Set sRs = Nothing
            Dber.Dispose
            Set Dber = Nothing 
        End IF  
    %>
    <%=TINPUT%>
    <% IF TINPUT > 0 THEN %><embed id=player src="/mid/recv_mail.wav" autostart=true hidden=true loop=false type="audio/wav"><% END IF %>
            </span><span  class="menubar_default"></span>)</a> 통
                        </li>
                    </ul>
                    <ul class="btn">
                        <li><a href="/money/Charge.asp" style="color:#ff0;font-size:14px;font-weight:bold" class="c_btn">충전신청</a></li>
                        <li><a href="/money/Exchange.asp" style="color:#ff0;font-size:14px;font-weight:bold" class="c_btn">환전신청</a></li>
                        <li><!-- <input type="submit" value="포인트전환" onclick="FrmChk2();" style="color:#ff0;font-size:14px;font-weight:bold" class="c_btn"> -->
                          <a href="javascript:FrmChk2()" style="color:#ff0;font-size:14px;font-weight:bold" class="c_btn">포인트전환</a>
                        </li>
                        <li><a href="/support/answer_write2.asp" style="color:#ff0;font-size:14px;font-weight:bold" class="c_btn">간편계좌문의</a></li>
                        <li><a href="/member/info.asp" style="color:#ff0;font-size:14px;font-weight:bold" class="c_btn">마이페이지</a></li>
                    </ul>
                </div>
                <!-- //내정보 -->
            </td>
        </tr>
		</form>
        <tr><td height="10"></td></tr>
        <tr>
            <td>
                <!-- 공지사항 -->
                <div class="gnb_notice">
                    <script type="text/javascript" src="/images/top/textScroll.js.다운로드"></script>
                    <div id="bKey">
                       <marquee width="850" class="content5"><font color="white">
							<%
								Set Dber = new clsDBHelper
								SQLLIST = "SELECT * FROM Board_Free Where BF_STATUS = 1 AND BF_SITE='DUMP' and bf_level=3 order by bf_idx desc "

								reDim param(0)
								param(0) = Dber.MakeParam("@jobsite",adVarWChar,adParamInput,20,JOBSITE)

								Set Rs = Dber.ExecSQLReturnRS(SQLLIST,param,nothing)
								INPC = Rs.RecordCount
								If Not Rs.EOF THEN
									For RE = 1 TO INPC
										IF Rs.EOF THEN
											EXIT FOR
										END IF

										Moving_Link = Rs("BF_Title")
										Moving_Text = Rs("BF_CONTENTS")
										Moving_Text= Replace(Moving_Text, "&lt;", "<")
										Moving_Text= Replace(Moving_Text, "&gt;", ">")
%>
										<strong><span id="ctl00_lbl_news1" style="margin-right: 10px"><font color="yellow">
                      <%=Moving_Text%>
                    </font>&nbsp;&nbsp;&nbsp;</span></strong>
<%

										Rs.MoveNext
									Next
								end if
								Rs.CLOSE
								SET Rs = Nothing

								Dber.Dispose
								Set Dber = Nothing
							%>
							
                </marquee>
                    </div>
                    <div id="Display_clock"></strong></div>
                </div>
                <!-- //공지사항 -->
            </td>
         </tr>
    </tbody></table>
    <table width="1000" cellspacing="0" cellpadding="0" border="0" align="center">
        <tbody><tr>
            <td style="height:7px"></td>
        </tr>
        <tr valign="middle">
            <td>
                <a href="http://www.livescore.in/" target="_blank">
                    <img src="/images/link/link_soccer.png" border="0"></a>
            </td>
            <td>
                <a href="http://www.npb.or.jp/" target="_blank">
                    <img src="/images/link/link_npb.png" border="0"></a>
            </td>
            <td>
                <a href="http://www.nhl.com/" target="_blank">
                    <img src="/images/link/link_nhl.png" border="0"></a>
            </td>
            <td>
                <a href="http://www.nba.com/" target="_blank">
                    <img src="/images/link/link_nba.png" border="0"></a>
            </td>
            <td>
                <a href="http://mlb.mlb.com/home" target="_blank">
                    <img src="/images/link/link_mlb.png" border="0"></a>
            </td>
            <td>
                <a href="http://sports.news.naver.com/" target="_blank">
                    <img src="/images/link/like_naver.png" border="0"></a>
            </td>
            <td>
                <a href="http://livego24.com/" target="_blank">
                    <img src="/images/link/livego24.png" border="0"></a>
            </td>
            <td>
                <a href="http://www.espn.com/" target="_blank">
                    <img src="/images/link/link_espn.png" border="0"></a>
            </td>
            <td>
                <a href="http://www.named.com/" target="_blank">
                    <img src="/images/link/link_named.png" border="0"></a>
            </td>
        </tr>
    </tbody>
  </table>