<!-- #include file="../../_Code/Game/BetGame.Code.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<!-- #include file="../_Inc/clock.asp" -->
<script language="javascript">
	var WebClock = function(){
	this.drawTarget = "devClock";
	
	//설정 시작
	this.color = "cec996"; //글자색
	this.backgroundColor = "#000"; //배경색
	this.align = "right"; //정렬(left, center, right)
	this.fontType = "Bauhaus 93"; //글꼴
	this.fontSize = 30; //시계 글꼴크기(참고: am,pm은 이 사이즈의 80%)
	this.calendarFontSize = 16; //달력부분 글꼴크기

	//설정 끝
	this.strWeek =  ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"];

	var _year, _month, _day, _hours, _minutes, _seconds, _cnt = 0;
	
	this.start = function(){
		
		var now = new Date(_year, _month, _day, _hours, _minutes, _seconds);
		now.setSeconds(now.getSeconds() + _cnt);

		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		var day = now.getDate();
		var hours = now.getHours();
		var minutes = now.getMinutes();
		var seconds = now.getSeconds();

		hours = hours < 10 ? "0" + hours : hours;
		minutes = minutes < 10 ? "0" + minutes : minutes;
		seconds = seconds < 10 ? "0" + seconds : seconds;
		
		this.layerTime.innerHTML = hours + ":" + minutes + ":" + seconds;
		_cnt++;
		setTimeout(function(){oWebClock.start();}, 1000);
	};
	
	this.init = function(){
		this.layerTime = document.createElement("span");
		this.layerAmPm = document.createElement("span");
		this.layerAmPm.style.fontSize = "0.8em";
		
		this.layerCalendar = document.createElement("div");
		this.layerCalendar.style.fontSize = this.calendarFontSize + "px";
		
		this.layerClock = document.createElement("div");
		this.layerClock.style.fontWeight = "bold";
		
		var layerTarget = document.getElementById(this.drawTarget);
		
		this.layerClock.appendChild(this.layerTime);

<%
	Dim currDate : currDate = Now
%>
		// 서버 시간 설정
		_year = <%=Year(currDate)%>;
		_month = <%=Month(currDate) - 1%>;
		_day = <%=Day(currDate)%>;
		_hours = <%=Hour(currDate)%>;
		_minutes = <%=Minute(currDate)%>;
		_seconds = <%=Second(currDate)%>;

		this.start();
	};
};
var oWebClock = new WebClock();
if(document.all){
	window.attachEvent("onload", function(){oWebClock.init();});
}else{
	window.addEventListener("load", function(){oWebClock.init();}, false);
};

//-->
</script>
<%
	Game_Type	= REQUEST("Game_Type")
    Set Dber = new clsDBHelper
    SQL = "SELECT [7M_USE] FROM dbo.SET_7M_USE WITH (NOLOCK)"

    Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)
    IF NOT sRs.Eof Then
        A_7M_USE = sRs(0)
    ELSE
        A_7M_USE = 1
    End IF

	sRs.close
	Set sRs = Nothing
	Dber.Dispose
	Set Dber = Nothing

			IF LCase(Game_Type)  = "casino" THEN 	'로하이메뉴 등록
		%>
			<!-- #include file="BetGame_Type_casino.asp" -->
		<%
			elseIF LCase(Game_Type)  = "casino_help" THEN 	'로하이메뉴 등록
		%>
			<!-- #include file="BetGame_Type2.asp" -->
		<%
			else
		%>
			<!-- #include file="BetGame_Type.asp" -->
		<%
			end if

	A_7M_USE = 0
    IF cStr(A_7M_USE) = "1" Then
%>

<script type="text/javascript" id="jsLiveScore" src="liveScore.js.asp?ver=<%= dfSiteUtil.GetFullDate(now()) %>"></script>
<%
    Else
%>
<script type="text/javascript">
var sDt2 = "" ;
</script>
<%
    End IF
%>
<script type="text/javascript">
function changeGameView(game_view)
{
    if(game_view == "") return;
    ProcFrm.location.href = "/game/changeGameView.asp?game_view=" + game_view
}
</script>
<iframe name="exeFrame" width="0" height="0" frame></iframe>


<script type="text/javascript">
if(document.getElementById("divBanner") != null) document.getElementById("divBanner").style.display = "none";

var STATE_ARR = ["", "전반전", "하프타임", "후반전", "경기종료", "Pause", "Cancel", "Extra", "Extra", "Extra", "120 Minutes", "Pen", "Finished", "Postponed", "Cut", "Undecided", "Gold", ""];

function showLiveScore(I7_IDX, team1, team2, dis)
{

    if(typeof(sDt2[I7_IDX]) != "object") return;
    scoreArray = sDt2[I7_IDX] ;
    document.getElementById("divMsgScore").style.left=document.body.scrollLeft + event.clientX;
    document.getElementById("divMsgScore").style.top=document.body.scrollTop + event.clientY
    document.getElementById("divMsgScore").style.display = dis ;
    document.getElementById("tdMsgScoreTeam").innerHTML = team1 + " : " + team2 ;
    document.getElementById("tdMsgScoreContent").innerHTML = STATE_ARR[scoreArray[0]] + " : " + scoreArray[1] + "-" + scoreArray[2] ;

}
function switchBtn(tdid)
{
	$("#"+tdid).removeClass("CssSelect").addClass("CssTeam");
}

function InputCheck_new(obj, vl)
{

	var frm = document.BetFrm;
	if(frm.BetAmount.value == "" || parseInt(vl,10) == 0) frm.BetAmount.value = 0        
	frm.BetAmount.value = parseInt(frm.BetAmount.value,10) +parseInt(vl,10);   
	var foreCastDividendPrice = 0;
	foreCastDividendPrice = document.getElementById('foreCastDividendPercent').innerHTML * document.BetFrm.BetAmount.value;
	foreCastDividendPrice+="";
	var foreCastDividendPriceArr = foreCastDividendPrice.split(".");
	var tmpForeCastDividendPrice = foreCastDividendPriceArr[0];
	var len = tmpForeCastDividendPrice.length;
	foreCastDividendPrice = tmpForeCastDividendPrice.substring(0,len-1)+'0';
	
	document.getElementById('TotalBenefit').value = fnMoneyType(foreCastDividendPrice);
}

function calcPointNum(num)
{
    var sNum = num.toString();

    if(sNum.indexOf('.') < 0)
        sNum += '.';

    sNum += '00';

    var sNums = sNum.split('.');
    var newNum = sNums[0] + '.' + sNums[1].substring(0, 2);

    return newNum;
}

function subCartNew(ig_idx, bet_num)
{
   if(document.getElementById('BN_'+ ig_idx).value == bet_num) //del
   {
       document.getElementById('cartTable').removeChild(document.getElementById('batlist_' + ig_idx));
       
       calcBenetfitTotal();
   }
}

//20141010 사다리 인포카트 ( delete함수 )
function subCart(ictid,ictidx,igid,bn,tdID) 
{	

	ProcFrm.location.href = "/game/Cart_Proc01.asp?Game_Type=<%= Game_Type %>&Flag=sub&ICT_ID="+ictid+"&ICT_Idx="+ictidx+"&IG_Idx="+igid+"&ICT_BetNum="+bn;
	$("#"+tdID).removeClass("CssSelect").addClass("CssTeam");
}


function addCart(obj, iuid,igidx,betnum,Gty,Gmemo,handi)
{
	
	ProcFrm.location.href = "/Game/Cart_Proc01.asp?Game_Type=<%=Game_Type%>&Flag=add&ICT_ID="+iuid+"&IG_Idx="+igidx+"&ICT_BetNum="+betnum+"&GMemo="+Gmemo+"&ig_handicap="+handi+"&tdID="+obj.id;
}


function calcBenetfitTotal()
{
    var totalBnft = 1.00;

    var bnfts = document.getElementsByName('IB_Benefit')

    if(bnfts.length > 0)
    {
        for(i=0; i<bnfts.length ; i++)
        {

            totalBnft = totalBnft * bnfts[i].value ;
        }

        totalBnft = parseFloat(totalBnft * 100)/100;
    }
    else
        totalBnft = 0.00;

    document.getElementById("foreCastDividendPercent").innerHTML = calcPointNum(totalBnft);
    document.getElementById("TotalBenefitRate").value = calcPointNum(totalBnft);

    foreCastDividendPriceCalc();
}
function new_win(link)
{
	if(link!="#") location.href = ""+link+"";
}

function Gmemo(URL)
{
	window.open(URL, 'Game_Memo','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=350,height=220');
}

function overGame(obj)
{
	if(document.getElementById(obj).style.backgroundColor != "#00287d") document.getElementById(obj).style.backgroundColor = "#ff9900";
}

function outGame(obj)
{
	if(document.getElementById(obj).style.backgroundColor != "#00287d") document.getElementById(obj).style.backgroundColor = "#5a5a5a";
}

function printGameMemo(gameID)
{
    exeFrame.location.href = "ajaxBbsMemo.asp?IG_IDX=" + gameID ;
}

function viewSports(sType)
{

    var tblGameList = document.getElementById("tblGameList");
    var trGameChart = tblGameList.getElementsByTagName('tr');

    if(trGameChart.length > 0)
    {
        for(var i=0;i<trGameChart.length;i++)
        {
            if(trGameChart[i].getAttribute("sports"))
            {
                if(sType == "0")
                {
                    if(trGameChart[i].style.display == "none")
                        trGameChart[i].style.display = "";
                }
                else
                {
                    if(trGameChart[i].getAttribute("sports") == sType)
                    {
                        if(trGameChart[i].style.display == "none")
                            trGameChart[i].style.display = "";
                    }
                    else
                    {
                        if(trGameChart[i].style.display == "") trGameChart[i].style.display = "none";
                    }
                }
            }
            if(trGameChart[i].className == "chart" && trGameChart[i].style.display == "") trGameChart[i].style.display = "none";
        }
    }
}
</script>

<!-- #include file="../_Inc/footer.game.inc.asp" -->