function betPrice_onkeyup() {

	betPrice = $("#betPrice").val();
	betPrice = getNumber(betPrice);
	$("#betPrice").val(commaNum(betPrice));
	$("#gameMoney").text(commaNum(betPrice));
	ladCAL(0,0,0,0,0);
}


function commaNum(num) {  
	var len, point, str;  
	
	num = num + "";  
	point = num.length % 3  
	len = num.length;  
	
	str = num.substring(0, point);  
	while (point < len) {  
	  if (str != "") str += ",";  
	  str += num.substring(point, point + 3);  
	  point += 3;  
	}  
	return str;  
}


function getNumber(str){
	str = "" + str.replace(/(^\s*)|(\s*$)|,/g, ''); // trim, 콤마 제거
	return (new Number(str));
}


function moneyCHK(m){
	ckm = getNumber($("#betPrice").val());
	mone = m * 10000;
	mone = mone + ckm;
	mone = commaNum(mone);
	if(m == 0){
		$("#betPrice").val(m);
		$("#gameMoney").text(m);
	}else if(m == 99){
		userMoneys = getNumber($("#myTtMoney").text());
		if(userMoneys < 1000000){
			$("#betPrice").val(commaNum(userMoneys));
			$("#gameMoney").text(commaNum(userMoneys));
		}else{
			$("#betPrice").val("1,000,000");
			$("#gameMoney").text("1,000,000");
		}
	}else{
		$("#betPrice").val(mone);
		$("#gameMoney").text(mone);
	}
	ladCAL(0,0,0,0,0);
}
	
	
	/*    <%=gameI%>,<%=kind%>,<%=RS1_g_ID%>,1,<%=RS1_winProfit%>    */

	
	
function ladCAL(n,kind,gId,bet,gmemo,profit,gty){

	
	//alert("계산기 접근");
	mo1 = getNumber($("#gameMoney").text());
	mo2 = getNumber($("#gameOdd").text());
	mo3 = mo1 * mo2;
	mo3 = Math.floor(mo3);
	//alert(mo3);
	$("#gameTotal").text(commaNum(mo3));
	
	cartAdd(n,kind,gId,bet,gmemo,profit,gty);
}
	
	
function cartAdd(n,kind,gId,bet,gmemo,profit,gty) {
	
	if(n==0 && kind==0 && gId==0 && bet==0 && profit==0){
		//alert("베팅금입력부분 베팅카트 셋팅");
		gm = getNumber($("#betProfit").val());
		gt = getNumber($("#gameTotal").text());
		$("#betAmount").val(gt);
	}else{
		//alert("베팅항목 선택 베팅카트 셋팅");
		//$.post('cart_DB_reset.asp', {kind:kind});
		$.post('/mini/cart_proc02.asp', {Flag:n,ICT_ID:kind, IG_Idx:gId, ICT_BetNum:bet,Game_Type:gty,GMemo:gmemo}, function(result, status) {
			var txt_betPrice =  getNumber($('#betPrice').val());
			if(status == "success") {
				gm = getNumber($("#gameMoney").text());
				gt = getNumber($("#gameTotal").text());
				$("#kind").val(kind);
				//중복선택 배당 재설정
				if($("#betProfit").val() == ""){
					var rProfit = profit;
				}else{
					//차감배당률
					var crossMinus = $("#crossMinus").val();
					var rProfit = $("#betProfit").val() * profit * crossMinus;
					rProfit = rProfit.toFixed(2);
				}
				//$("#betProfit").val(profit);
				$("#betAmount").val(gt);
			}
		});
	}
}



function bet_AddFn(pMode) {
	if($(".c_darkgray c_darkgray_ov").text()){
		alert("선택된 경기가 없습니다.");
		return false;
	}
	
	//alert($(".c_darkgray c_darkgray_ov").text());
	
	if($("#dpCounter").text()=="00:00"){
		alert("구매가능시간이 종료되었습니다.");
		return false;
	}
	if(getNumber($("#gameMoney").text())==0) {
		alert("베팅금액을 입력해 주세요.");
		return false;
	}
	thisTimesBet = getNumber($("#betPrice").val());
	userMoneys = getNumber($("#myTtMoney").text());
	if(thisTimesBet < 5000 ) {
		alert('최소 베팅금액은 5,000원부터 입니다.');
		$("#betPrice").val("5,000");
		$("#gameMoney").text("5,000");
		ladCAL(0,0,0,0,0);
		return false;
	}
	if(thisTimesBet > 500000 && $("#cartCount").val() > 1) {
		alert('조합 베팅금액은 50만원을 넘을수 없습니다.');
		$("#betPrice").val("500,000");
		$("#gameMoney").text("500,000");
		ladCAL(0,0,0,0,0);
		return false;
	}
	if(thisTimesBet > 1000000 ) {
		alert('베팅금액은 100만원을 넘을수 없습니다.');
		$("#betPrice").val("1,000,000");
		$("#gameMoney").text("1,000,000");
		ladCAL(0,0,0,0,0);
		return false;
	}
	if( thisTimesBet > userMoneys ){
		alert('보유머니가 부족합니다.');
		$("#betPrice").val(commaNum(userMoneys));
		$("#gameMoney").text(commaNum(userMoneys));
		ladCAL(0,0,0,0,0);
		return false;
	}
	if(getNumber($("#gameTotal").text()) > 3000000 ) {
		alert("배당금액이 300만원을 넘을수 없습니다.");
		return false;
	}
		
	
	
	if($("#cartCount").val()==0) {
		alert("구매하실 게임을 선택해 주세요.");
		return false;
	}
	
	$("#pageMode").val(pMode);
	//$("#betKind").val("live");
	$("#abc").val(thisTimesBet);
	
	

	var confirmStr = "금액과 게임을 한번 더 확인해주세요. 이대로 베팅하시겠습니까?";
	if (pMode == "betListSave")
		confirmStr = "베팅을 저장합니다";
	
	if(confirm(confirmStr)) {
		$("#cartForm").submit();
	}
}