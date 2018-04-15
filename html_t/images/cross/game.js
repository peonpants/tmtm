
function mouseOver(obj)
{
	if(obj.className=="selected") return;
	if(obj.className=="normal") obj.className="select";
	//else if(obj.className=='select') obj.className="normal";
}
function mouseOut(obj)
{
	if(obj.className=="selected") return;
	if(obj.className=="select") obj.className="normal";
}
function selectedGame(obj,id,pos,divi,h_nm,a_nm,h_div,t_div,a_div,j_idx,l_idx, l_nm, kind)
{
	//alert("aaa");
	var ele = null;
	if(obj.className=='normal' || obj.className=='select') {
	//alert("asd");
		obj.className="selected";
		if(pos!=1){
		
			ele = document.getElementById(id+"_1");
			if(ele && ele!=null){
				if(ele.className=="selected") {
					ele.className="normal";
				}
			}
		}
		ele = null;
		if(pos!=3){
			ele = document.getElementById(id+"_3");
			if(ele && ele!=null){
				if(ele.className=="selected") ele.className="normal";
			}
		}
		ele = null;
		if(pos!=2){
			ele = document.getElementById(id+"_2");
			if(ele && ele!=null){
				if(ele.className=="selected") ele.className="normal";
			}
		}
		addBettingSlip(id,pos,divi,h_nm,a_nm,h_div,t_div,a_div,j_idx,l_idx,l_nm,kind);
	}else if(obj.className=='selected'){
		
		obj.className="normal";
		delBettingSlip(id);
	}
}
var betting_list	=	new Array();
function betting(g_idx,select_idx,home_nm,away_nm,dividend,h_div,t_div,a_div,j_idx,l_idx,l_nm,kind)
{
	this.select_idx		=	select_idx;
	this.game_idx		=	g_idx;
	this.home_nm		=	home_nm;
	this.away_nm		=	away_nm;
	this.dividend		=	dividend;
	this.home_div		=	h_div;
	this.tie_div		=	t_div;
	this.away_div		=	a_div;
	this.jongmok_idx	=	j_idx;
	this.league_idx		=	l_idx
	this.league_nm		=	l_nm;
	this.kind		=	kind;
}
function drawBetSlip()
{
	var bs = document.getElementById("betting_result");
	var bet = null;
	var iHtml = "";
	

	if(betting_list.length>0){
		iHtml	+=	'<table class="bettingResultTable" align="center">\n';
		
	
		for(i=0;i<betting_list.length;i++)
		{
			bet	=	betting_list[i];
			var choice = (bet.select_idx==1)?"승":(bet.select_idx==2)?"무":"패";
			var bnft  =  bet.dividend;
			var what = (bet.select_idx==1)?bet.home_nm:(bet.select_idx==2)?"무":bet.away_nm;
			var lborder1='', lborder2='';
			var rborder1='', rborder2='';
			iHtml	+=	"	<tr><td height='1'></td></tr>"

			if (bet.select_idx==1) {lborder1 = '<b style="color:#ffd44f;">'; lborder2 = '</b>'; }
			if (bet.select_idx==3) {rborder1 = '<b style="color:#ffd44f;">'; rborder2 = '</b>'; }

			iHtml += '<tr>\n';
			iHtml += '<td style="height:6px;"></td>\n';
			iHtml += '</tr>\n';

			iHtml += '<tr>\n';
			iHtml += '<td>\n';
			iHtml += '<span style="float:right;"><a href=javascript:delBettingSlip("'+ bet.game_idx +'")><img src="/images/btn_s_del2.gif"></a></span></td>\n';
			iHtml += '</tr>\n';

			iHtml += '<tr>\n';
			iHtml += '<td>'+ lborder1 + bet.home_nm + lborder2 + '</td>\n';
			iHtml += '</tr>\n';

			iHtml += '<tr>\n';
			iHtml += '<td>'+ rborder1 + bet.away_nm + rborder2 + '</td>\n';
			iHtml += '</tr>\n';

			iHtml += '<tr>\n';
			iHtml += '<td style="text-align:right;">'+ choice +' ('+ bnft +')</td>\n';
			iHtml += '</tr>\n';

			iHtml += '<tr>\n';
			iHtml += '<td style="height:5px;"></td>\n';
			iHtml += '</tr>\n';

			iHtml += '<tr>\n';
			iHtml += '<td style="height:2px; text-align:center;"><IMG SRC="/images/betslip_img1.png" alt="" /></td>\n';
			iHtml += '</tr>\n';
		}
		iHtml += '<tr>\n';
		iHtml += '<td style="height:20px; text-align:center;"><span onclick="emptyBetslip();" style="cursor:pointer">[전부 비우기]</span></td>\n';
		iHtml += '</tr>\n';

		iHtml += '<tr>\n';
		iHtml += '<td style="height:5px;"></td>\n';
		iHtml += '</tr>\n';
		iHtml	+=	"</table>";
	}
	bs.innerHTML = iHtml;
}
function fixed(str,no)
{
	var	ret	=	str;
	var dot	=	str.indexOf(".");
	if(dot>0){
		ret	=	str.substring(0,no+dot+1);
	}
	return	ret;
}
function calculrate()
{
	var i			=	0;
	var odds		=	0.0;
	var winMoney	=	0;
	var bet = null;
	var ele = document.getElementById("bet_money_tmp");
	var str	=	ele.value;
	

	if(str==null || str.length==0) str = "0";
	str	=	replaceComma(str);
//alert(str);
//alert("222222");
	var betMoney = parseInt(str);
//alert("3333333");
	for(i=0;i<betting_list.length;i++){
		bet	=	betting_list[i];
		if(i==0) odds = bet.dividend;
		else odds	*=	bet.dividend;
	}

	//odds = (Math.floor(odds * 100) / 100);
	odds = odds.toFixed(2);
	winMoney	=	Math.floor(betMoney*odds);

	str	=	""+odds;
	document.getElementById("dividend_tmp").innerHTML=""+fixed(str,2);//odds.toFixed(2);
	document.getElementById("win_money_tmp").innerHTML=insertComma(""+winMoney);
	document.getElementById("bet_cnt").innerHTML	=	""+betting_list.length;
	dividend	=	odds;
	win_money	=	winMoney;
	return winMoney;
}
function changeBetMoney()
{
	calculrate();
}
function addBettingSlip(g_id,pos,divi,h_nm,a_nm,h_div,t_div,a_div,j_idx,l_idx, l_nm, kind)
{
	var i = 0;
	var bet = null;
	var ck = 0;
	//if(betting_list && betting_list!=null && betting_list.length>0){
	for(i=0;i<betting_list.length;i++){
		bet	=	betting_list.shift();
		if(bet.game_idx==g_id){
			if(bet.select_idx!=pos){
				bet.dividend = divi;
				bet.select_idx = pos;
				ck++;
				betting_list.push(bet);
			}
		}else betting_list.push(bet);
	}
	//}
	if(ck ==0){
		bet = new betting(g_id,pos,h_nm,a_nm,divi,h_div,t_div,a_div,j_idx,l_idx, l_nm, kind);
		betting_list.push(bet);
	}
	drawBetSlip();
	calculrate();
}
function delBettingSlip(g_id)
{
	var i = 0;
	var bet = null;
	var g = null;
	var l = betting_list.length;
	for(i=0;i<l;i++){
		bet	=	betting_list.shift();
		if(bet.game_idx!=g_id){
			betting_list.push(bet);
			i--;
			l--;
		}else{
			g = document.getElementById(""+bet.game_idx+"_"+bet.select_idx);
			if(g){
				g.className="normal";
			}
		}
	}
	drawBetSlip();
	calculrate();
}
function emptyBetslip()
{
	var i = 0;
	var bet = null;
	var g = null;
	var l = betting_list.length;
	for(i=0;i<l;i++){
		bet	=	betting_list.shift();
		g = document.getElementById(""+bet.game_idx+"_"+bet.select_idx);
		if(g){
		g.className="normal";
		}
	}
	drawBetSlip();
	calculrate();
}

//-->

	


//숫자만
function checkDigitOnly( digitChar )
{
	if ( digitChar == null ) return false ;

	for(var i=0;i<digitChar.length;i++){
		var c=digitChar.charCodeAt(i);
		if( !(  0x30 <= c && c <= 0x39 )){
			return false ;
		}
	}
	return true ;
}
//한글만
function checkKoreanOnly( koreanChar )
{
	if ( koreanChar == null ) return false ;

	for(var i=0; i < koreanChar.length; i++){ 
		var c=koreanChar.charCodeAt(i); 
		//( 0xAC00 <= c && c <= 0xD7A3 ) 초중종성이 모인 한글자 
		//( 0x3131 <= c && c <= 0x318E ) 자음 모음 
		if( !( ( 0xAC00 <= c && c <= 0xD7A3 ) || ( 0x3131 <= c && c <= 0x318E ) ) ) {
			return false ; 
		}
	}
	return true ;
}
//영문만
function checkEnglishOnly( englishChar )
{

	if ( englishChar == null ) return false ;

	for( var i=0; i < englishChar.length;i++){
		var c=englishChar.charCodeAt(i);
		if( !( (  0x61 <= c && c <= 0x7A ) || ( 0x41 <= c && c <= 0x5A ) ) ) {
			return false ;       
		}
	}
	return true ;
}
//영숫자만
function checkEnglishDigitOnly( englishChar )
{

	if ( englishChar == null ) return false ;

	for( var i=0; i < englishChar.length;i++){
		var c=englishChar.charCodeAt(i);
		if(!((0x61 <= c && c <= 0x7A ) || ( 0x41 <= c && c <= 0x5A )) && !(0x30 <= c && c <= 0x39))
		{
			return false ;       
		}
	}
	return true ;
}
//한글숫자만
function checkKoreanDigitOnly( koreanChar )
{
	if ( koreanChar == null ) return false ;

	for(var i=0; i < koreanChar.length; i++){ 
		var c=koreanChar.charCodeAt(i); 
		//( 0xAC00 <= c && c <= 0xD7A3 ) 초중종성이 모인 한글자 
		//( 0x3131 <= c && c <= 0x318E ) 자음 모음 
		if (c==40 || c==41) {}
		else if( (!((0xAC00 <= c && c <= 0xD7A3 ) || ( 0x3131 <= c && c <= 0x318E)) && !(0x30 <= c && c <= 0x39)) && (!((0x61 <= c && c <= 0x7A ) || ( 0x41 <= c && c <= 0x5A )) && !(0x30 <= c && c <= 0x39))) {
			return false ;
		}
	}
	return true ;
}

function changePoint()
{
	if(!confirm("포인트를 보유금액으로 전환하시겠습니까?")){
		return;
	}
	document.formPoint.change_point.value	=	"change";
	document.formPoint.submit();
}
function logout()
{
	if(!confirm("로그아웃 하시겠습니까?")){
		return;
	}
	document.location.href="/logout.php";
}


function replaceComma(str)
{
	if(str==null || str.length==0) return "";
	while(str.indexOf(",")>-1){
		str = str.replace(",","");
	}
	return str;
}
function insertComma(str)
{
	var rightchar = replaceComma(str);
	var moneychar="";
	for(index=rightchar.length-1;index>=0;index--){
		splitchar = rightchar.charAt(index);
		if(isNaN(splitchar)){
			alert(splitchar+"숫자가 아닙니다.\n다시 입력해주십시오.");
			return "";
		}
		moneychar = splitchar+moneychar;
		if(index%3==rightchar.length%3 && index  !=0) {
			moneychar = ','+moneychar;
		}
	}
	str = moneychar;
	return str;
}
function numChk(num)
{
	var rightchar = replaceComma(num.value);
	var moneychar="";
	for(index=rightchar.length-1;index>=0;index--){
		splitchar = rightchar.charAt(index);
		if(isNaN(splitchar)){
			alert("'"+splitchar+"' 숫자가 아닙니다.\n다시 입력해주십시오.");
			num.value="";
			num.focus();
			return false;
		}
		moneychar = splitchar+moneychar;
		if(index%3==rightchar.length%3 && index  !=0) {
			moneychar = ','+moneychar;
		}
	}
	num.value = moneychar;
	return true;
}




function flashShow(url, w, h, id, bg, win){

	domain = document.URL;
	parse = domain.split("/");
	loc = parse[3];
	loc_par = '';

	switch(loc){
		case "Company":
			loc_par = '1';
			break;
		case "Glyco":
			loc_par = '2';
			break;
		case "Community":
			loc_par = '3';
			break;
		case "Data":
			loc_par = '4';
			break;
		case "Customer":
			loc_par = '5';
			break;
		case "MyOffice":
			loc_par = '6';
			break;
	}

	var flashStr=
	"<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='"+w+"' height='"+h+"' id='"+id+"' align='middle'>"+
	"<param name='movie' value='"+url+"' />"+
	"<param name='menu' value='false' />"+
	"<param name='quality' value='high' />"+
	"<param name=wmode value='transparent' />"+
	"<param name='FlashVars' value='main="+loc_par+"&'>"  +
	"<embed src='"+url+"' wmode='transparent' menu='false' quality='high' width='"+w+"' height='"+h+"' name='"+id+"' align='middle' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />"+
	"</object>";
	document.write(flashStr);
}
