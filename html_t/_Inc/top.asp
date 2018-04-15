<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=1000"><title><%=SITE_TITLE%></title><link rel="Shortcut Icon" href="http://wd-82.com/images/logo_webpage2.png">
    <!-- menu1 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script>
  function maint() {
    alert("점검 중입니다.");
  }
</script>
<%
  Response.CodePage = 65001
  Response.CharSet = "UTF-8"                        
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
      TINPUT = 0
      Set Dber = new clsDBHelper
      SQL = "dbo.UP_CheckMemoAlramByUser"
      reDim param(1)
      param(0) = Dber.MakeParam("@iu_id",adVarWChar,adParamInput,20,Session("SD_ID"))
      param(1) = Dber.MakeParam("@jobsite",adVarWChar,adParamInput,20,JOBSITE)

      Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
      If Not sRs.eof then
        TINPUT = CDBL(sRs(0))
      End If 
      sRs.close
      Set sRs = Nothing

      SQL = "UP_INFO_USER_CHK1"
      reDim param(1)
      param(0) = Dber.MakeParam("@iu_id",adVarWChar,adParamInput,20,Session("SD_ID"))
      param(1) = Dber.MakeParam("@jobsite",adVarWChar,adParamInput,20,JOBSITE)
      Set sRsa = Dber.ExecSPReturnRS(SQL,param,nothing)

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

      End IF            
      sRsa.close
      Set sRsa = Nothing
      sql = "UP_BF_TITLE_CHK"
      Set sRsb = Dber.ExecSPReturnRS(sql, nothing, nothing)
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
      param(0) = Dber.MakeParam("@iu_id",adVarWChar,adParamInput,20,Session("SD_ID"))
      param(1) = Dber.MakeParam("@jobsite",adVarWChar,adParamInput,20,JOBSITE)
      param(2) = Dber.MakeParam("@c_dir",adVarWChar,adParamInput,20,"main")
      Dber.ExecSP SQL,param,Nothing
      Dber.Dispose
      Set Dber = Nothing
       
%>
<script>
	function FrmChk2()
	{
		if(!confirm("포인트를 보유금액으로 전환하시겠습니까?")){
			return;
		}
		frmp.action = "/money/money_proc.asp";
		frmp.submit();	
	}

  function LoginFrmChk() 
  {
    var frm = document.LoginFrm;
    if ((frm.IU_ID.value.length < 4)) 
    {
      alert("회원님의 ID를 입력해 주세요");
      return false; 
    }
    
    if ((frm.IU_PW.value == "") || (frm.IU_PW.value.length < 4))  
    {
      alert("회원님의 패스워드를 입력해 주세요.");
      frm.IU_PW.focus();
      return false;         
    }

    frm.action = "/Login/index.asp";
    frm.submit();
  }
</script>
 
<link rel="stylesheet" href="/css/common.css" type="text/css"> 
<link rel="stylesheet" href="/css/font.css" type="text/css"> 
<link rel="stylesheet" href="/css/main.css" type="text/css"> 
<link rel="stylesheet" href="/css/style.css" type="text/css"> 
<link rel="stylesheet" href="/css/toastr.css" type="text/css"> 
<link rel="stylesheet" href="/css/un_common.css" type="text/css"> 
<link rel="stylesheet" href="/css/yes_style.css" type="text/css"> 
</head>

<body id="top" >
  <form name="frmp" method="post" >
    <input type="hidden" name="EMODE" value="POINT1">
    <input type="hidden" name="IE_ID" value="<%=Session("SD_ID")%>">
    <input type="hidden" name="IU_POINT" value="<%=IU_POINT%>">
  <div id="top_line">
    <% IF Session("SD_ID") <> "" Then %>
    <div class="topWrap" style="display:block;">
      <div class="fl_l">
        <div class="fl_l">
          <span><%=iu_nickname%></span>님 환영합니다.</div>
        <div>
          <img src="/images/top_money.png">보유머니 :
          <span id="mb_point"><%=formatnumber(IU_Cash,0)%></span>원</div>
        
        <div class="PointChange" intmp="1000" style="cursor: pointer;">
          <img src="/images/top_point.png">보유포인트 :
          <span id="mb_mileage" onclick="FrmChk2()"><%=formatnumber(IU_Point,0)%></span>P</div>
        <div>
          <a href="/support/answer_list.asp">
            <img src="/images/top_memo.png">받은쪽지함 : <%=TINPUT%>개</a>
        </div>
        <div>
          <a href="/member/mybet.asp">베팅내역</a>
        </div>
        <div>
          <a href="/member/info.asp">마이페이지</a>
        </div>
        <div>
          <a href="/login/logout_proc.asp">로그아웃</a>
        </div>
      </div>
    </div>
    <% End If %>
  </div></form>
  <div id="header">
    <div class="head">
    <h1 class="logo">
      <a href="/main.asp">
        <img src="/images/top/logo.png" style="width:40%;margin-top: 9px; margin-left: 40px;">
      </a>
    </h1>
    <div class="tmenu">
      <ul>
        <li>
          <a href="/game/betgame.asp?game_type=cross">크로스&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
          <a href="/game/betgame.asp?game_type=handicap">핸디캡&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
          <a href="/game/betgame.asp?game_type=special">스페셜&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
        </li>
        
        <li>
          <a href="#">네임드&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
          <ul class="dark_radius box_size">
            <li>
              <a href="/game/betgame.asp?game_type=live">사다리</a>
            </li>
            <li>
              <a href="/game/betgame.asp?game_type=dari">다리다리</a>
            </li>
            <li>
              <a href="/game/betgame.asp?game_type=dal">달팽이</a>
            </li>
          </ul>
        </li>
        <li>
          <a href="#">로투스&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
          <ul class="dark_radius box_size">
            <li>
              <a href="/game/betgame.asp?game_type=lotusoe">홀짝</a>
            </li>
            <li>
              <a href="/game/betgame.asp?game_type=lotusb">바카라</a>
            </li>
          </ul>
        </li>
        <li>
          <a href="/game/betgame.asp?game_type=virtuals">가상축구&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
        <li>
          <a href="#">나눔로또&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
          <ul class="dark_radius box_size">
            <li>
              <a href="/game/betgame.asp?game_type=power">파워볼</a>
            </li>
            <li>
              <a href="/game/betgame.asp?game_type=powers">파워사다리</a>
            </li>
          </ul>
        </li>

        <li>
          <a href="/member/mybet.asp">베팅내역&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
          <a href="/game/BetResult.asp">경기결과&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
          <a href="/freeboard/Board_List.asp?game_type=m8">게시판&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
          <a href="/support/Answer_List.asp">고객센터&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
        </li>
        <% If Session("SD_ID") = "" then%>
        <div class="fl_r isLoginFalse" style="display: block;">
          <span>
            <a class="log_pop">로그인</a>
          </span>
          <span class="fl_r">
            <a href="/info.asp">회원가입</a>
          </span>
        </div>
        <% End If %>
      </ul>
    </div>
    <div id="popup1" class="popup-div popup-style">
      <div class="popup_cont" style="height: auto;">
        <div class="login_pop">
          <span>SAMPLE를 방문해주셔서 감사합니다!
            <br>로그인 하시면 사이트를 이용하실 수 있습니다.</span>
            <div style="position:relative;">
              <form id="login_frm" name="LoginFrm">
                <input placeholder="USER ID" type="text" name="IU_ID" id="userid">
                <input placeholder="PASSWORD" type="password" name="IU_PW" id="passwd">
                <!-- <input placeholder="CAPTCHA" type="text" name="captcha" id="captcha">
                 <img class="captcha_img make" src="/captcha_make.php?nocache=2018-03-26_13:25:32&amp;token=ac64c4dc524a63885158bde749e969&amp;0&amp;1&amp;2&amp;3&amp;4&amp;5&amp;6&amp;7&amp;8&amp;9&amp;10&amp;11&amp;12&amp;13&amp;14&amp;15&amp;16&amp;17&amp;18&amp;19&amp;20&amp;21&amp;22&amp;23&amp;24&amp;25&amp;26&amp;27&amp;28&amp;29&amp;30&amp;31&amp;32&amp;33&amp;34&amp;35&amp;36&amp;37&amp;38&amp;39&amp;40&amp;41&amp;42&amp;43&amp;44&amp;45&amp;46&amp;47&amp;48&amp;49&amp;50&amp;51&amp;52&amp;53&amp;54&amp;55&amp;56&amp;57&amp;58&amp;59&amp;60&amp;61&amp;62&amp;63&amp;64&amp;65&amp;66&amp;67&amp;68&amp;69&amp;70&amp;71&amp;72&amp;73&amp;74&amp;75&amp;76&amp;77&amp;78&amp;79&amp;80&amp;81&amp;82&amp;83&amp;84&amp;85&amp;86&amp;87&amp;88&amp;89&amp;90&amp;91&amp;92&amp;93" style="position:absolute;right:0;top:102px;margin:10px 5px; vertical-align:middle;"> -->
                <input type="button" class="dark_radius box_size" id="login_btn" value="LOGIN" onclick="LoginFrmChk()">
              </form>
            </div>
            <span>아직 회원이 아니라면 지금 가입하세요!</span>
            <a href="/member/join_Chack.asp" class="orange_btn">JOIN NOW</a>
          </div>
        </div>
      </div>

      <script>

        function log_pop() {
          $("body").append("<div id='modal_bg' class='b-modal'></div>");
          $("body").append($("#popup1"));
          $("#popup1").css({"opacity": "1", "display": "block", "position": "absolute", "left": "780px", "top": "200px"});
          $("#userid").focus();

          $("#modal_bg").click(function (event) {
            $(this).remove();
            $("#popup1").css({"opacity": "0", "display": "none"});
          });
        }

        $(function () {
          if ("false" == "true") {
            $(".isLoginTrue").css("display", "block");
            $("img.isLoginTrue").css("display", "inline-block");
            $("#login_frm").remove();
          } else {
            $("#userid, #passwd, #captcha").keypress(function (event) {
              if (event.keyCode == 13) {
                $("#login_frm").submit();
              }
            });
            $("div.isLoginFalse").css("display", "blocK");
            $("#top").delegate(".isLoginFalse", "click", function (event) {
              event.preventDefault();
              event.stopPropagation();
              event.stopImmediatePropagation();
              log_pop();
              //alert('로그인 후 이용해주세요');
            });
          }

          $(".log_pop").click(function (event) {
            log_pop();
          });
        });
      </script>
    </div>
  </div>
