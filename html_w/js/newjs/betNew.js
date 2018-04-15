var itemstr = '<table border="0" cellpadding="0" cellspacing="0" width="200">\n';
itemstr += '  <tr><td height="3"></td></tr><tr><td width="100%">\n';
itemstr += '  <table border="0" cellpadding="0" cellspacing="1" width="200" bgcolor="#444444">\n';
itemstr += '  <tr><td width=100%><table border="0" cellpadding="0" cellspacing="0" width="100%">\n';
itemstr += '  <tr style="background:#2a2a2a;" height="19">\n';
itemstr += '  <td><table cellspacing="0" cellpadding="0" width="100%"><tr>\n';
itemstr += '  <td width="76%">\n';
itemstr += '  <table cellspacing="0" cellpadding="0" width="100%"><tr>\n';
itemstr += '  <td width="25" align="right"><img src="/league/$limg" width="20" height="14"></td>\n';
itemstr += '  <td style="font-family:돋움;font-size:11px;color:#aaaaaa;padding:2 0 0 3px;letter-spacing:-1px;">$lname</td>\n';
itemstr += '  </tr></table>\n';
itemstr += '  </td>\n';
itemstr += '  <td align="right" width="24%"><table cellspacing="0" cellpadding="0" width="100%"><tr>\n';
itemstr += '  <td align="right" style="padding-right:3px;" width="70%"><span style="font-family:tahoma;font-size:11px;color:#ffe200;font-weight:bold;">$ratio</span></td>\n';
itemstr += '  <td style="padding-right:5px;" width="30%" align="right"><IMG style="CURSOR: pointer" onclick="del_bet($betid)" src="/img/bet_delete.gif" border="0"></td>\n';
itemstr += '  </tr></table></td>\n';
itemstr += '  </tr></table></td>\n';
itemstr += '  </tr>\n';
itemstr += '  <tr><td colspan=2 bgcolor=#111111><table border="0" cellpadding="0" cellspacing="0" width="100%">\n';
itemstr += '  <tr style="padding-top:4px;">\n';
itemstr += '  <td width=86% class="h11s"><font color="#aaaaaa">홈</font> $team1</td>\n';
itemstr += '  <td width=14% align="right" class="h11sr">$betteam1</td>\n';
itemstr += '  </tr>\n';
itemstr += '  <tr style="padding:3 0 1 0px;">\n';
itemstr += '  <td class="h11s"><font color="#aaaaaa">원</font> $team2</td>\n';
itemstr += '  <td align="right" class="h11sr">$betteam2</td>\n';
itemstr += '  </tr>\n';
itemstr += '  </table></td></tr></table></td></tr></table></td></tr>\n';
itemstr += '</table>\n';


Array.prototype.remove = function(from, to) {
	var rest = this.slice((to || from)+1 || this.length);
	this.length = from<0 ? this.length+from : from;
	return this.push.apply(this, rest);
}
function check_bet(e) {  
	if (window.event) {
		e = window.event;
	}
	var src = getSrcElement(e);
	add_bet(src);
}
function add_bet(src) {
	var num = src.getAttribute("num");
	var lnum = src.getAttribute("lnum");
	var chk1 = getObject("chk1_"+num);
	var chk2 = getObject("chk2_"+num);
	var chk3 = getObject("chk3_"+num);
	
	if (chk1 && src != chk1) {
		chk1.checked = false;
	}
	if (chk2 && src != chk2) {
		chk2.checked = false;
	}
	if (chk3 && src != chk3) {
		chk3.checked = false;
	}
	var team1 = getObject("team1_"+num).innerHTML;
	var team2 = getObject("team2_"+num).innerHTML;
	var ratio = getObject("bet"+src.value+"_"+num).innerHTML;
	var bet1 = getObject("bet1_"+num);
	var leaguename = getObject("item_" + num).getAttribute("leaguename");
	var leagueimg = getObject("item_" + num).getAttribute("leagueimg");

	if (bet1) {
		bet1 = bet1.innerHTML;
	}
	var bet2 = getObject("bet2_"+num);
	if (bet2) {
		bet2 = bet2.innerHTML;
	}
	var bet3 = getObject("bet3_"+num);
	if (bet3) {
		bet3 = bet3.innerHTML;
	} else {
		bet3 = "0";
	}
	var obj = getObject("num_"+num);
	var gametype = obj.getAttribute("gametype");
	if (!gametype) {
		alert('gametype:n');
	}
	
	if (src.checked) {
		var item = new Item(leaguename,leagueimg,num, team1, team2, src.value, ratio, bet1, bet2, bet3, gametype, lnum);
		bet.addItem(item);
		var isdisabled = true;
	} else {
		bet.removeItem(num);
		var isdisabled = false;
	}
	if (gametype == '1' || gametype == '2') {
		var arr = document.getElementsByTagName("input");
		if (arr.length) {
			for (i=0; i<arr.length; i++) {
				if (arr[i].getAttribute("type") == 'checkbox') {
					var arrLnum = arr[i].getAttribute("lnum");
					var arrNum = arr[i].getAttribute("num");
					var arrBet = arr[i].getAttribute("bet");
					var arrGt = arr[i].getAttribute("gt");
					if (arrGt == '1' || arrGt == '2')
					{
						if (arrLnum == lnum && arrNum != num && arrGt != gametype) {
							if (arrBet != '0')
							{
								arr[i].disabled = isdisabled;
							}
							else {
								arr[i].disabled = true;
							}
						}
					}
				}
			}
		}
	}
		var nCNT = tb_list.rows.length;
		
		if (nCNT > 10){
			alert("최대 10경기까지 선택하실수 있습니다   " );
			return false;
		}else{
			calc();
		}
}
function del_bet(num)
{
	for(var i=1;i<=3;i++)
	{
		var chk = getObject("tdbet" + i + "_" + num);
		set_check(chk,false);
	}
	bet.removeItem(num);
	calc();
}
var bet = new BetList();
function Item(leaguename,leagueimg,betid,team1,team2,betteam,ratio,bet1,bet2,bet3,game_type,lnum,num) {
    this._leaguename = leaguename;
    this._leagueimg = leagueimg;
    this._betid = betid;
	this._team1 = team1;
	this._team2 = team2;
	this._betteam = betteam;
	this._ratio = ratio;
	this._bet1 = bet1;
	this._bet2 = bet2;
	this._bet3 = bet3;
	this._game_type= game_type;
	this._lnum= lnum;
	this._num= num;
}
Item.prototype._betid;
Item.prototype._team1;
Item.prototype._team2;
Item.prototype._betteam;
Item.prototype._ratio;
Item.prototype._bet1;
Item.prototype._bet2;
Item.prototype._bet3;
Item.prototype._game_type;
Item.prototype._lnum;
Item.prototype._num;

function BetList() {
	this._items = new Array();
}
BetList.prototype._totalprice;
BetList.prototype._point;
BetList.prototype._bet;
BetList.prototype._items;
BetList.prototype.addItem = function(item) {
	this.removeItem(item._betid);
	this._items.push(item);
	add_bet_list(item);
}
BetList.prototype.removeItem = function(num) {
	var pos = -1;
	for (var i = 0; i<this._items.length; i++) {
		if (this._items[i]._betid == num) {
			pos = i;
			break;
		}
	}
	if (pos>=0) {
		del_bet_list(num);
		this._items.remove(pos, pos);
	}
}
BetList.prototype.getList = function() {
	var re = "";
						for (var i = 0; i<this._items.length; i++) {
							re += this._items[i]._betid
							re += "||"+this._items[i]._betteam
							re += "||"+this._items[i]._team1
							re += "||"+this._items[i]._team2
							re += "||"+this._items[i]._ratio
							re += "||"+this._items[i]._bet1
							re += "||"+this._items[i]._bet2
							re += "||"+this._items[i]._bet3
							re += "||"+this._items[i]._game_type
							re += "||"+this._items[i]._lnum
							re += "||"+this._items[i]._num+"#\n";
						}
	return re;
}
BetList.prototype.setPoint = function(point) {
	this._point = point;
}
BetList.prototype.exec = function() {
	this._bet = 0;
	for (var i = 0; i<this._items.length; i++) {
		if (i == 0) {
			this._bet = 1;
		}
		this._bet = this._bet*(this._items[i]._ratio*100);
		this._bet = this._bet/100;
	}
	this._bet = Floor(this._bet, 2);
	this._totalprice = Math.floor(this._point*this._bet);

}
BetList.prototype.ClearAll = function() {
	this._items = new Array();
	var tb = getObject("tb_list");
	while (tb.rows.length>0) {
		tb.deleteRow(0);
	}
	var arr = document.getElementsByTagName("input");
	if (arr.length) {
		for (i=0; i<arr.length; i++) {
			/*if (arr[i].checked) {
				arr[i].checked = false;
			}*/
			if (arr[i].disabled) {
				var arrBet = arr[i].getAttribute("bet");
				if (arrBet != '0')
				{
					arr[i].disabled = false;
				}
				else {
					arr[i].disabled = true;
				}
			}
		}
	}
	this.exec();
}
function add_bet_list(item) {
	

	/*var nCNT = tb_list.rows.length;
	alert(nCNT);
	if (nCNT > 10){
		alert("최대 10경기까지 선택하실수 있습니다   " );
		return false;
	}else{
		calc();
	}*/

	var str = bet.getList();
	var tb = getObject("tb_list");
	var tr = tb.insertRow(tb.rowIndex);
	tr.id = "tb_row_"+item._betid;
	var td = tr.insertCell(0);
	td.innerHTML = get_item_html(item);
}
function del_bet_list(num) {
	var tb = getObject("tb_list");
	var row = getObject("tb_row_"+num);
	tb.deleteRow(row.rowIndex);
}
function get_item_html(item) {
	var re = itemstr;
	var gametype = item._game_type;
	var betteam_str1 = "";
	var betteam_str2 = "";
	var team_str1 = "";
	var team_str2 = "";

	if (gametype == '4')
	{
		str2 = '오버';
		str1 = '언더';
	}
	else {
		str1 = '승';
		str2 = '패';
	}
	
	if (item._betteam == "1") {
		if(gametype=="1"||gametype=="2") betteam_str1 = "<font color='ff9300'>승</font>";
		if(gametype=="4") betteam_str1 = "<font color='ff9300'>언더</font>";
		team_str1 = "<font color='ffe200'>"+item._team1+"</font>";
		team_str2 = item._team2;
	} else if (item._betteam == "2") {
		if(gametype=="1"||gametype=="2") betteam_str2 = "<font color='ff9300'>패</font>";
		if(gametype=="4") betteam_str2 = "<font color='ff9300'>오버</font>";
		team_str1 = item._team1;
		team_str2 = "<font color='ffe200'>"+item._team2+"</font>";
	} else if (item._betteam == "3") {
		if(gametype=="1"||gametype=="2") betteam_str1 = "<font color='ff9300'>무</font>";betteam_str2 = "<font color='ffe200'>무</font>";
		team_str1 = "<font color='ffe200'>"+item._team1+"</font>";
		team_str2 = "<font color='ffe200'>"+item._team2+"</font>";
	}

	re = re.replace("$betid", item._betid);
	re = re.replace("$team1", team_str1);
	re = re.replace("$team2", team_str2);
	re = re.replace("$betteam1", betteam_str1);
	re = re.replace("$betteam2", betteam_str2);
	re = re.replace("$ratio", item._ratio);
	re = re.replace("$lname", item._leaguename);
	re = re.replace("$limg", item._leagueimg);




	return re;
}
function calc() {
	var point = getObject("betprice").value;
	point = point.replace(/,/gi,"");
	point = parseInt(point);
	bet.setPoint(point);
	bet.exec();
	var betstr = bet._bet;
	if (betstr.toFixed) {
		betstr = betstr.toFixed(2);
	}
	getObject("sp_bet").innerHTML = betstr;
	getObject("sp_total").innerHTML = MoneyFormat(bet._totalprice);
	betForm.result_rate.value = betstr;
	max_amount = parseInt(eval("VarMaxAmount"));
	if (bet._totalprice>max_amount) {
		alert("최대적중금은 "+MoneyFormat(max_amount)+"를 넘을 수 없습니다.");
		getObject("betprice").value = "";
		calc();
		//del_all();
	}

}
function betting(type) {
	var min_bet = 0;
	var max_bet = 0;
	var max_amount = 0;
	min_bet = parseInt(eval("VarMinBet"));
	max_bet = parseInt(eval("VarMaxBet"));
	max_amount = parseInt(eval("VarMaxAmount"));
	var game_cnt = getObject("game_cnt").value;
	var event_ok = getObject("event_ok").value;
	var gametype = getObject("gametype").value;

	if (isNaN(bet._point)) {
		alert("베팅액을 입력해주세요.");
		return;
	}

	if (bet._point<min_bet || bet._point>max_bet) {
		alert("베팅액은 "+MoneyFormat(min_bet)+"~"+MoneyFormat(max_bet)+"원 사이입니다.");
		return;
	}
	
	/*var b_num = bet._point % 100

	if (b_num > 0){
		alert("100 단위로 배팅이 가능합니다.  ");
		return;
	}*/

	if (bet._totalprice>max_amount) {
		alert("최대적중금은 "+MoneyFormat(max_amount)+"를 넘을 수 없습니다.");
		return;
	}
	if (bet._totalprice == 0 || bet._items.length == 0) {
		alert("베팅할 경기를 선택하십시오.");
		return;
	}
	/*if (bet._items.length < 1) {
		alert("최소 1경기 이상 선택하실수 있습니다.");
		return;
	}
	if (gametype=="1" && bet._items.length < 2){
		alert("승무패 경기는 최소 2경기 이상 선택하셔야 합니다.");
		return;			
	}
	if (event_ok =='3' && bet._items.length < game_cnt) {
		alert("이벤트는 "+game_cnt+"경기 모두 선택하셔야 합니다.");
		return;
	}*/

	if (bet._items.length > 10) {
		alert("최대 10경기까지 선택하실수 있습니다.");
		return;
	}

	if (bet._point>VarMoney) {
		//alert("베팅금액이 현재금보다 클 수 없습니다.");
		//return;
	}
	if (type == "cart") {
		betForm.mode.value = type;
	}
	else {
		betForm.mode.value = "betting";
		if (!confirm("배팅완료후 5분이내에 취소가 가능합니다.\n배팅하시겠습니까?")) {
			return;
		}
	}
	betForm.betmoney.value = bet._point;
	betForm.betcontent.value = bet.getList();
	betForm.submit();
}
function init() {
	return;
}
BetList.prototype.dealAll = function()
{
	this._items = new Array();
	var tb = getObject("tb_list");
	while(tb.rows.length>0)
		tb.deleteRow(0);

	var arr=document.getElementsByTagName("input");
	if(arr.length)
	{
		for(i=0;i<arr.length;i++)
		{
			var num=arr[i].value;
			var obj=getObject("tdbet1_"+num);
			if(get_check(obj)) set_check(obj,false);
			var obj=getObject("tdbet2_"+num);
			if(get_check(obj)) set_check(obj,false);
			var obj=getObject("tdbet3_"+num);
			if(get_check(obj)) set_check(obj,false);
		}
	}

	this.exec();
}

function del_all() {
	bet.dealAll();
	bet.ClearAll();
	calc();
}
function highlight(obj, isHover)
{
	var cssClass = obj.className;
	if(cssClass == "" || cssClass == "MouseOver")
	{	// RotatingTeaser
		obj.className = isHover ? "MouseOver" : "";
		return;
	}
	
	var color;
	if(isHover)
	{
		color = "#ffffff";
		obj.style.backgroundColor = "#093f99";
		obj.style.borderColor = "#426cff #001071 #001071 #426cff";
	}
	else
	{
		color = "";
		obj.style.backgroundColor = "";
		obj.style.borderColor = "";
	}

	obj.style.color = color;					// set color of this element
	var tds = obj.getElementsByTagName("TD");	// and all child TDs
	for(var i=0; i<tds.length; i++)
		tds[i].style.color = color;
}
function get_check(obj)
{
		
	if(obj.className=="unselected") return false;
	else return true;
}
function set_check(obj,checked)
{
	if(obj.className!="unselected" && obj.className!="selected") return;

	if(checked) {
		obj.className="selected";
		highlight(obj,true);
		obj.checked = "true";
	}
	else 
	{
		obj.className="unselected";
		highlight(obj,false);
		obj.checked = "false";
	}
}

function check_bet2(src,sel)
{

	if (src.className=="listitem") return;
	add_bet_new(src,sel);
}
function add_bet_new(src,sel)
{
	var num = src.getAttribute("num");
	var lnum = src.getAttribute("lnum");
	var leaguename = getObject("item_" + num).getAttribute("leaguename");
	var leagueimg = getObject("item_" + num).getAttribute("leagueimg");

	var game_type = getObject("game_type_" + num);if(game_type)game_type=game_type.innerHTML;

	if(!get_check(src)) 
		set_check(src,true);
	else 
		set_check(src,false);

	
	
	var chk1=getObject("tdbet1_" + num);
	var chk2=getObject("tdbet2_" + num);
	var chk3=getObject("tdbet3_" + num);

	
	if(chk1 && sel!=1 && chk1.className=="selected") set_check(chk1,false);
	if(chk2 && sel!=2 && chk2.className=="selected") set_check(chk2,false);
	if(chk3 && sel!=3 && chk3.className=="selected") set_check(chk3,false);

	var team1 = getObject("team1_" + num).innerHTML;
	var team2 = getObject("team2_" + num).innerHTML;
	var ratio = getObject("item_"  + num).getAttribute("bet"+sel);
	
	


	var bet1 = getObject("item_"  + num).getAttribute("bet1");
	var bet2 = getObject("item_"  + num).getAttribute("bet2");
	var bet3 = getObject("item_"  + num).getAttribute("bet3");
	var hand;


/*
	if (game_type=="1")
	{
		bet3=getObject("bet3_" + num);if(bet3)bet3=bet3.innerHTML;
		hand="0";
	}
	else
	{
		hand = getObject("handicap_" + num);if(hand)hand=hand.innerHTML;else hand="0";
		bet3="0";
	}
*/
	if(src.className=="selected")
	{
		var item = new Item(leaguename,leagueimg,num,team1,team2,sel,ratio,bet1,bet2,bet3,game_type,lnum,num);

		bet.addItem(item);
	}else{
		bet.removeItem(num);
	}
	//alert(bet.getList());
	calc();

	var stype=getObject("stype");
	if(stype.value=="1"){
		var nCNT = tb_list.rows.length		
		if (nCNT > 10){
			alert("승무패 경기는 열폴더까지만 가능합니다." );
			bet.removeItem(num);
			set_check(src,false);
			calc();
			return false;
		}	
	}else if(stype.value=="2") {
		var nCNT = tb_list.rows.length		
		/*if (nCNT > 1){
			alert("핸디캡/언더오버 경기는 한폴더만 가능합니다." );
			bet.removeItem(num);
			set_check(src,false);
			calc();
			return false;
		}*/
	}else if(stype.value=="3") {
		var nCNT = tb_list.rows.length		
		if (nCNT > 10){
			alert("스페셜 경기는 열폴더까지만 가능합니다." );
			bet.removeItem(num);
			set_check(src,false);
			calc();
			return false;
		}
	}
}