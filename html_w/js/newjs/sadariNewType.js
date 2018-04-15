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
	str = "" + str.replace(/(^\s*)|(\s*$)|,/g, ''); // trim, �޸� ����
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

	
	//alert("���� ����");
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
		//alert("���ñ��Էºκ� ����īƮ ����");
		gm = getNumber($("#betProfit").val());
		gt = getNumber($("#gameTotal").text());
		$("#betAmount").val(gt);
	}else{
		//alert("�����׸� ���� ����īƮ ����");
		//$.post('cart_DB_reset.asp', {kind:kind});
		$.post('/mini/cart_proc02.asp', {Flag:n,ICT_ID:kind, IG_Idx:gId, ICT_BetNum:bet,Game_Type:gty,GMemo:gmemo}, function(result, status) {
			var txt_betPrice =  getNumber($('#betPrice').val());
			if(status == "success") {
				gm = getNumber($("#gameMoney").text());
				gt = getNumber($("#gameTotal").text());
				$("#kind").val(kind);
				//�ߺ����� ��� �缳��
				if($("#betProfit").val() == ""){
					var rProfit = profit;
				}else{
					//��������
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
		alert("���õ� ��Ⱑ �����ϴ�.");
		return false;
	}
	
	//alert($(".c_darkgray c_darkgray_ov").text());
	
	if($("#dpCounter").text()=="00:00"){
		alert("���Ű��ɽð��� ����Ǿ����ϴ�.");
		return false;
	}
	if(getNumber($("#gameMoney").text())==0) {
		alert("���ñݾ��� �Է��� �ּ���.");
		return false;
	}
	thisTimesBet = getNumber($("#betPrice").val());
	userMoneys = getNumber($("#myTtMoney").text());
	if(thisTimesBet < 5000 ) {
		alert('�ּ� ���ñݾ��� 5,000������ �Դϴ�.');
		$("#betPrice").val("5,000");
		$("#gameMoney").text("5,000");
		ladCAL(0,0,0,0,0);
		return false;
	}
	if(thisTimesBet > 500000 && $("#cartCount").val() > 1) {
		alert('���� ���ñݾ��� 50������ ������ �����ϴ�.');
		$("#betPrice").val("500,000");
		$("#gameMoney").text("500,000");
		ladCAL(0,0,0,0,0);
		return false;
	}
	if(thisTimesBet > 1000000 ) {
		alert('���ñݾ��� 100������ ������ �����ϴ�.');
		$("#betPrice").val("1,000,000");
		$("#gameMoney").text("1,000,000");
		ladCAL(0,0,0,0,0);
		return false;
	}
	if( thisTimesBet > userMoneys ){
		alert('�����Ӵϰ� �����մϴ�.');
		$("#betPrice").val(commaNum(userMoneys));
		$("#gameMoney").text(commaNum(userMoneys));
		ladCAL(0,0,0,0,0);
		return false;
	}
	if(getNumber($("#gameTotal").text()) > 3000000 ) {
		alert("���ݾ��� 300������ ������ �����ϴ�.");
		return false;
	}
		
	
	
	if($("#cartCount").val()==0) {
		alert("�����Ͻ� ������ ������ �ּ���.");
		return false;
	}
	
	$("#pageMode").val(pMode);
	//$("#betKind").val("live");
	$("#abc").val(thisTimesBet);
	
	

	var confirmStr = "�ݾװ� ������ �ѹ� �� Ȯ�����ּ���. �̴�� �����Ͻðڽ��ϱ�?";
	if (pMode == "betListSave")
		confirmStr = "������ �����մϴ�";
	
	if(confirm(confirmStr)) {
		$("#cartForm").submit();
	}
}