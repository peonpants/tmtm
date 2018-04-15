<!-- #include file="../_Code/main.Code.asp" -->
<!-- #include file="_Inc/popup.inc.asp" -->
<!-- #include file="_Inc/top.asp" -->
<style>
#side {
    width: 220px;
    float: left;
}
.main_list_title {
    width: 220px;
    height: 40px;
    text-align: center;
    line-height: 40px;
    font-size: 17px;
    background: #5e6168;
    border: 1px solid #cacaca;
    box-sizing: border-box;
    font-family: "Roboto", sans-serif;
    font-weight: 600;
    letter-spacing: 1px;
    border-radius: 5px 5px 0 0;
}
#side .side_menu1 {
    width: 220px;
    border: 1px solid #dfdfdf;
    box-sizing: border-box;
    border-top: 0;
    background: #fff;
    border-radius: 0 0 5px 5px;
    margin: 0 0 10px;
}
#side .side_menu1 li {
    border-bottom: 1px solid #eaeaea;
    height: 44px;
    font-weight: 600;
    position: relative;
}
#side .side_menu1 li:last-child {
    border-bottom: 0;
}
#side .side_menu1 li a {
    display: block;
    line-height: 44px;
}
#side .side_menu1 li:hover a {
    color: #fbb726;
}
#side .side_menu1 li:nth-child(1) a {
    background: url("../images/a11.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(2) a {
    background: url("../images/a11.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(3) a {
    background: url("../images/a2.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(4) a {
    background: url("../images/a3.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(5) a {
    background: url("../images/cside_icon05.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(6) a {
    background: url("../images/cside_icon06.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(7) a {
    background: url("../images/cside_icon07.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(8) a {
    background: url("../images/cside_icon08.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(1):hover a {
    background: #363942 url("../images/a11.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(2):hover a {
    background: #363942 url("../images/a11.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(3):hover a {
    background: #363942 url("../images/a2.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(4):hover a {
    background: #363942 url("../images/a3.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(5):hover a {
    background: #363942 url("../images/cside_icon05on.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(6):hover a {
    background: #363942 url("../images/cside_icon06on.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(7):hover a {
    background: #363942 url("../images/cside_icon07on.png") no-repeat 25px 63%;
}
#side .side_menu1 li:nth-child(8):hover a {
    background: #363942 url("../images/cside_icon08on.png") no-repeat 25px 63%;
}
#side .side_menu1 li span {
    margin-left: 65px;
    display: block;
}
#side .side_menu1 li em {
    position: absolute;
    right: 20px;
    top: 10px;
    font-size: 11px;
    background: #5e6168;
    border: 1px solid #5e6168;
    border-radius: 3px;
    width: 37px;
    height: 22px;
    color: #fff;
    line-height: 22px;
    font-weight: 400;
    text-align: center;
}
#r_side .cs_center {
	position:relative;
    width: 240px;
    height: 158px;
    box-sizing: border-box;
    /*border: 1px solid #dfdfdf;*/
    /*background: #fff url("../images/cs_icon.gif") no-repeat 90% 19px;*/
    border-radius: 5px;
    color: #222;
    font-weight: 600;
}
#r_side .cs_center div {
    /*width: 184px;
    margin: 15px auto 0;
    line-height: 22px;*/
}
#r_side .cs_center img {
	width: 100%;
}
#r_side .cs_center p {
    color: #a9a9a9;
}
</style>
<div id="container">
    <div id="side">
        <div class="main_list_title orange">CROSS GAME LIST</div>
        <div class="side_menu">
            <ul>
                <li><a href="/game/betgame.asp?game_type=cross&GGG_TYPE=1"><span>축구</span><em></em></a></li>
                <li><a href="/game/betgame.asp?game_type=cross&GGG_TYPE=2"><span>야구</span><em></em></a></li>
                <li><a href="/game/betgame.asp?game_type=cross&GGG_TYPE=3"><span>농구</span><em></em></a></li>
                <li><a href="/game/betgame.asp?game_type=cross&GGG_TYPE=4"><span>배구</span><em></em></a></li>
                <li><a href="/game/betgame.asp?game_type=cross&GGG_TYPE=5"><span>하키</span><em></em></a></li>
            </ul>
        </div>
        <div class="main_list_title orange">MINIGAME</div>
        <div class="side_menu1">
            <ul>
                <li><a href="/game/betgame.asp?game_type=lotusoe"><span>로투스 홀짝</span><em></em></a></li>
                <li><a href="/game/betgame.asp?game_type=lotusb"><span>로투스 바카라</span><em></em></a></li>
                <li><a href="/game/betgame.asp?game_type=live"><span>네임드</span><em></em></a></li>
                <li><a href="/game/betgame.asp?game_type=power"><span>파워볼</span><em></em></a></li>
                <li><a href="/game/betgame.asp?game_type=virtuals"><span>가상축구</span><em></em></a></li>
            </ul>
        </div>
    </div>
    <div id="content">
        <div class="flexslider">

            <div class="flex-viewport" style="overflow: hidden; position: relative;">
                <ul class="slides">
					<li><img src="/images/main/fl_back.jpg"></li>
					
                </ul>
            </div>
        </div>
        
        <div class="content_bottom">
            <div class="bottom_cont main_lt fl_l">
                <div class="main_top_title dark_gray"><a href="/game/betgame.asp?game_type=cross" class="box_size isLoginFalse">Today Games<img src="/images/plus_btnon.png"></a></div>
                <div class="main_rt_content">
                   <div class="rankingbox">
						<div id="banner_1">
		<%
							Set Dber = new clsDBHelper

							'########   진행 중인 게임 리스트 출력    ##############
							
							SQL = "SELECT  Top 50 RL_League, RL_Sports,  RL_Image ,  IG_StartTime, IG_Team1, IG_Team2, IG_HANDICAP, IG_TEAM1BENEFIT, IG_TEAM2BENEFIT, IG_DRAWBENEFIT, IG_TEAM1BETTING, IG_TEAM2BETTING, IG_TYPE, ( IG_TEAM1BETTING + IG_DRAWBETTING + IG_TEAM2BETTING ) AS ALL_BETTING  FROM Info_Game WHERE IG_Status = 'S' and RL_SPORTS <> '실시간' and IG_EVENT = 'N' ORDER BY ALL_BETTING DESC"
							
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

								If IG_TYPE=1 Then
								GAMETYPE="HANDI"
								ElseIf IG_TYPE=2 Then
								GAMETYPE="O/V"
								ElseIf IG_TYPE=0 Then
								GAMETYPE="WINER"
								End IF

		%>
						<a href="#">
							<div class="table">
							<div class="table_row">
							<div class="table_cell"><span class="rank_num"><%=i%></span></div>
							<div class="table_cell"><%=left(IG_STARTTIME,10)%></div>
							<div class="table_cell"><span class="in_put"><%=GAMETYPE%></span><strong><%= IG_Team1 %></strong></div>
							<div>VS</div>
							<div class="table_cell" >&nbsp;&nbsp;&nbsp;<strong><%= IG_Team2 %></strong></div>
							</div>
							</div>
						</a>
		<%
								sRs.MoveNext
								NEXT
								End IF		
		sRs.close
  		Set sRs = Nothing
		%>							
						</div>
					</div>
                </div>
            </div>
            <div class="bottom_cont main_rt fl_r">
                <div class="main_top_title dark_gray"><a href="/freeboard/board_list.asp" class="box_size isLoginFalse">NOTICE<img src="/images/plus_btnon.png"></a></div>
                <div class="main_rt_content">
					<div class="rankingbox">
						<div id="banner_2">
		<%
		SQL2 = "SELECT top 6 * FROM BOARD_FREE where BF_LEVEL=1 ORDER BY BF_REGDATE DESC"
      	Set Rs = Dber.ExecSQLReturnRS(SQL2,nothing,nothing)
		If Not Rs.EOF THEN
	      	For i = 0 TO 6
		        IF Rs.EOF THEN 
		          EXIT FOR
		        END IF
		        BF_TITLE  = Rs("BF_TITLE")
		        BF_REGDATE = Rs("BF_REGDATE")
		        BF_idx = Rs("BF_idx")
		%>							
					<a href="/freeboard/board_Read.asp?BF_IDX=<%=BF_idx%>&page=1&Term=0&Search=0&Find=">
						<div class="table">
						<div class="table_row">
						<div class="table_cell"><span class="rank_num"><%=BF_idx%></span></div>
						<div class="table_cell"><%=left(BF_REGDATE,10)%></div>
						<div class="table_cell" style="width: 200px;"><font color="red">Y-3</font><%=Left(split(BF_TITLE, "&#10024;")(1), 20)%></div>
						</div>
						</div>
					</a>
		<%
			Rs.MoveNext
			Next
		End If
		Rs.close
  		Set Rs = Nothing
  		Dber.Dispose
  		Set Dber = Nothing
		%>						
						</div>
					</div>
				</div>
            </div>
        </div>
    </div>
    <div id="r_side">
        <div class="side_mypage">
            <div class="main_list_title orange">INFOMATION</div>
			<!-- #include file="_Inc/right.asp" -->
		</div>
        <div class="cs_center">
			<div style="position:relative; margin-top: 250px;">
			<div class="main_list_title orange"></div>
<script language="javascript" type="text/javascript"> 
// NvScroll() 시작 : 
 
function NvScroll() {
	this.version = "0.2";
	this.name = "wsScroll";
	this.item = new Array();
	this.itemcount = 0;
	this.currentspeed = 0;
	this.scrollspeed = 50;
	this.pausedelay = 1000;
	this.pausemouseover = false;
	this.stop = false;
	this.type = 1;
	this.height = 130;
	this.width = 180;
	this.stopHeight = 0;
	this.i = 0;
	this.add = function() {
		var text = arguments[0];
		this.item[this.itemcount] = text;
		this.itemcount = this.itemcount + 1;
	};
	this.add2 = function() {
		var url = arguments[0];
		var title = arguments[1];
		this.item[this.itemcount] = "<a href=" + url + ">" + title + "</a>";
		this.itemcount = this.itemcount + 1;
	};
	this.start = function() {
		if (this.itemcount == 1) {
			this.add(this.item[0]);
		}
		this.display();
		this.currentspeed = this.scrollspeed;
		if (this.type == 1 || this.type == 2) {
			this.stop = true;
			setTimeout(this.name + '.scroll()', this.currentspeed);
			window.setTimeout(this.name + ".stop = false", this.pausedelay);
		} else if (this.type == 3) {
			this.stop = true;
			setTimeout(this.name + '.rolling()', this.currentspeed);
			window.setTimeout(this.name + ".stop = false", this.pausedelay);
		}
	};
	this.display = function() {
		document.write('<div id="' + this.name + '" style="height:' + this.height + '; width:' + this.width + '; position:relative; overflow:hidden; " OnMouseOver="' + this.name + '.onmouseover(); " OnMouseOut="' + this.name + '.onmouseout(); ">');
   		for (var i = 0; i < this.itemcount; i++) {
   			if (this.type == 1) {
   				document.write('<div id="' + this.name + 'item' + i + '"style="left:0px; width:' + this.width + '; position:absolute; top:' + (this.height * i) + 'px; ">');
   				document.write(this.item[i]);
   				document.write('</div>');
   			} else if (this.type == 2 || this.type == 3) {
   				document.write('<div id="' + this.name + 'item' + i + '"style="left:' + (this.width * i) + 'px; width:' + this.width + '; position:absolute; top:0px; ">');
   				document.write(this.item[i]);
   				document.write('</div>');
   			}
   		}
   		document.write('</div>');
   	};
   	this.scroll = function() {
   		if (this.pause == true) {
   			window.setTimeout(this.name + ".scroll()", this.pausedelay);
   			this.pause = false;
   		} else {
   			this.currentspeed = this.scrollspeed;
   			if (!this.stop) {
   				for (i = 0; i < this.itemcount; i++) {
   					obj = document.getElementById(this.name + 'item' + i).style;
   					if (this.type == 1) {
   						obj.top = parseInt(obj.top) - 1;
   						if (parseInt(obj.top) <= this.height * (-1)) obj.top = this.height * (this.itemcount - 1);
   						if (parseInt(obj.top) == 0) this.currentspeed = this.pausedelay;
   					} else if (this.type == 2) {
   						obj.left = parseInt(obj.left) - 1;
   						if (parseInt(obj.left) <= this.width * (-1)) obj.left = this.width * (this.itemcount - 1);
   						if (parseInt(obj.left) == 0) this.currentspeed = this.pausedelay;
   					}
   				}
   			}
   			window.setTimeout(this.name + ".scroll()", this.currentspeed);
   		}
   	};
   	this.rolling = function() {
   		if (this.stop == false) {
   			this.next();
   		}
   		window.setTimeout(this.name + ".rolling()", this.scrollspeed);
   	}
   	this.onmouseover = function() {
   		if (this.pausemouseover) {
   			this.stop = true;
   		}
   	};
   	this.onmouseout = function() {
   		if (this.pausemouseover) {
   			this.stop = false;
   		}
   	};
   	this.next = function() {
   		for (i = 0; i < this.itemcount; i++) {
   			obj = document.getElementById(this.name + 'item' + i).style;
   			if (parseInt(obj.left) < 1) {
   				width = this.width + parseInt(obj.left);
   				break;
   			}
   		}
   		for (i = 0; i < this.itemcount; i++) {
   			obj = document.getElementById(this.name + 'item' + i).style;
   			if (parseInt(obj.left) < 1) {
   				obj.left = this.width * (this.itemcount - 1);
   			} else {
   				obj.left = parseInt(obj.left) - width;
   			}
   		}
   	}
   	this.prev = function() {
   		for (i = 0; i < this.itemcount; i++) {
   			obj = document.getElementById(this.name + 'item' + i).style;
   			if (parseInt(obj.left) < 1) {
   				width = parseInt(obj.left) * (-1);
   				break;
   			}
   		}
   		if (width == 0) {
   			total_width = this.width * (this.itemcount - 1);
   			for (i = 0; i < this.itemcount; i++) {
   				obj = document.getElementById(this.name + 'item' + i).style;
   				if (parseInt(obj.left) + 1 > total_width) {
   					obj.left = 0;
   				} else {
   					obj.left = parseInt(obj.left) + this.width;
   				}
   			}
   		} else {
   			for (i = 0; i < this.itemcount; i++) {
   				obj = document.getElementById(this.name + 'item' + i).style;
   				if (parseInt(obj.left) < 1) {
   					obj.left = 0;
   				} else {
   					obj.left = parseInt(obj.left) + width;
   				}
   			}
   		}
   	}
   	this.unext = function() {
   		this.onmouseover();
   		this.next();
   		window.setTimeout(this.name + ".onmouseout()", this.pausedelay);
   	}
   	this.uprev = function() {
   		this.onmouseover();
   		this.prev();
   		window.setTimeout(this.name + ".onmouseout()", this.pausedelay);
   	}
}
// NvScroll() 끝
</script>
				<%

	Set Dber = new clsDBHelper
		SQLLIST = "SELECT * FROM Board_Free Where BF_STATUS = 1 and bf_level=3 order by bf_idx desc "

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

							If InStr(Moving_Link,"idx=") > 0 Then
'								Moving_Text = "<SCRIPT language=javascript>Nsscroll.add('<a href=./Board_Read.asp?"&Moving_Link&" ><span class=hotnotice_main>"&viewstr(Moving_Text)&"</span></a>');</SCRIPT>"
								Moving_Text = "<SCRIPT language=javascript>Nsscroll.add('<a href=/freeboard/Board_Read.asp?bf_"&Moving_Link&" ><div>"&Moving_Text&"</div></a>');</SCRIPT>"
								response.write Moving_Text

							Else

								Moving_Text = "<SCRIPT language=javascript>Nsscroll.add('"&Moving_Text&"');</SCRIPT>"
								response.write Moving_Text							
							End If 


	Rs.MoveNext
		NEXT
	end if
									Rs.CLOSE
									SET Rs = Nothing

	Dber.Dispose
	Set Dber = Nothing




											%>


<!---------------------------------------------흐르는 공지------------------------------------------------------------------>
<!---------------------------------------------흐르는 공지------------------------------------------------------------------>
																	<script language="javascript"> 
																	Nsscroll.start();
																	</script></a>
			</div>
        </div>
        <div class="r_banner">
            <img src="" style="border-radius:5px;">
        </div>
    </div>
</div>
<!-- #include file="_Inc/footer.asp" -->