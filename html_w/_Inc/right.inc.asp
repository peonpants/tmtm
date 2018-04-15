<!-- 배팅카트 시작 -->
<%
SB_BETTINGMIN = Session("SB_BETTINGMIN")
SB_BETTINGMAX = Session("SB_BETTINGMAX")
SB_BENEFITMAX = Session("SB_BENEFITMAX")

'kimmj : 스페셜도 승무패와 동일하게 적용
IF LCase(Game_Type) = "live" or LCase(Game_Type) = "power" or LCase(Game_Type) = "high" or LCase(Game_Type) = "dal" or LCase(Game_Type) = "virtuals"  or LCase(Game_Type) = "powers"  or LCase(Game_Type) = "real"  or LCase(Game_Type) = "dari" Then
	SB_BETTINGMIN = 10000
	SB_BETTINGMAX = 2000000
	SB_BENEFITMAX = 6000000
End If
IF LCase(Game_Type) = "special" Or LCase(Game_Type) = "special2" Then
	SB_BETTINGMIN = 2000
	SB_BETTINGMAX = 1000000
	SB_BENEFITMAX = 3000000
End If

IF LCase(Game_Type) = "cross" Or LCase(Game_Type) = "handicap" Then
	SB_BETTINGMIN = 2000
	SB_BETTINGMAX = 2000000
	SB_BENEFITMAX = 5000000
End If
IF LCase(Game_Type) = "smp" Then
	SB_BETTINGMIN = 2000
	SB_BETTINGMAX = 10000000
	SB_BENEFITMAX = 30000000
End If
%>
<script language="javascript" type="text/javascript" src="/js/betting_slip.js" ></script>
<script type="text/javascript"> 
$(function () {
  var isFixCart = false;

  $(window).scroll(function(){
    if(!isFixCart){
    var position = $(window).scrollTop();
    if(position > 270){
        $("#betcart").stop().animate({"top": position+"px"}, 100);  
    }else{
      $("#betcart").stop().animate({"top": "270px"}, 100);
    }
  }
  });

  $("#chk_fix").click(function(){
    if($(this).is(":checked")){
      isFixCart = true;
    }else{
      isFixCart = false;
    }
  });

  $("#BetAmount").click(function() {
    $(this).val('');
  });
});

function betMax(){
  $("#BetAmount").val(<%=SB_BENEFITMAX%>)
}

function fnMoneyType(v) {
    v = v.toString();
    if (v.length > 3) {
        var mod = v.length % 3;
        var retval = (mod > 0 ? (v.substring(0,mod)) : "");
        for (i=0 ; i < Math.floor(v.length / 3); i++) {
            if ((mod == 0) && (i == 0)) {
                retval += v.substring(mod+ 3 * i, mod + 3 * i + 3);
            } else {
                retval+= "," + v.substring(mod + 3 * i, mod + 3 * i + 3);
            }
        }
        return retval;
    } else {
        return v;
    }
}

function foreCastDividendPriceCalc()
{
	var foreCastDividendPrice = 0;
	foreCastDividendPrice = document.getElementById('foreCastDividendPercent').innerHTML * document.BetFrm.BetAmount.value.split(",").join("");
	foreCastDividendPrice+="";
	var foreCastDividendPriceArr = foreCastDividendPrice.split(".");
	var tmpForeCastDividendPrice = foreCastDividendPriceArr[0];
	var len = tmpForeCastDividendPrice.length;
	foreCastDividendPrice = tmpForeCastDividendPrice.substring(0,len-1)+'0';
	
	document.getElementById('TotalBenefit').value = fnMoneyType(foreCastDividendPrice);
   
}

</script>
<script type="text/javascript"> 
	String.prototype.setComma = function()
	{ 
		var temp_str = String(this); 
		for(var i = 0 , retValue = String() , stop = temp_str.length; i < stop ; i++) retValue = ((i%3) == 0) && i != 0 ? temp_str.charAt((stop - i) -1) + "," + retValue : temp_str.charAt((stop - i) -1) + retValue; 
			return retValue; 
	} 

	function calcBenefit()
	{ 
		var betMoney = document.BetFrm.BetAmount.value.replace(/,/gi,''); // 불러온 값중에서 컴마를 제거 
		var s = betMoney;
		
		if (s == 0) {  // 첫자리의 숫자가 0인경우 입력값을 취소 시킴  
			document.BetFrm.BetAmount.value = ''; 
			return; 
		}
		 
		else { 
			document.BetFrm.BetAmount.value = s.setComma();
			
			var totalBenefitRate = document.BetFrm.TotalBenefitRate.value;
			var totalBenefit = betMoney * totalBenefitRate;
			var totalBenefit1 = parseInt(totalBenefit);
						
			document.BetFrm.TotalBenefit.value = String(totalBenefit1).setComma();
		}
	}
	
	function formatCurrency(num) {
		num = num.toString().replace(/\\|\,/g,'');
		if(isNaN(num))
			num = "0";
			sign = (num == (num = Math.abs(num)));
			//num = Math.floor(num*100+0.50B151B0001);
			num = Math.floor(num*100+0.50000000001);

			num = Math.floor(num/100).toString();

		for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
			num = num.substring(0,num.length-(4*i+3))+','+
			num.substring(num.length-(4*i+3));
			return (((sign)?'':'-') + '\\' + num);
	}

	// 카트에서 게임 삭제...
	function subCart(ictid,ictidx,igid,bn) 
	{
        ProcFrm.location.href = "/game/Cart_Proc01.asp?Game_Type=<%= Game_Type %>&Flag=sub&ICT_ID="+ictid+"&ICT_Idx="+ictidx+"&IG_Idx="+igid+"&ICT_BetNum="+bn;
	}
	
	// 카트 모두비우기...
	function subCartAll() 
	{
        ProcFrm.location.href = "/game/Cart_Proc01.asp?Game_Type=<%= Game_Type %>&Flag=subAll";
	}
	
  function BetChk()
    {
      try
      {
      var frm = document.BetFrm;
	var bMin = <%if LCase(Game_Type) = "live" or LCase(Game_Type) = "power" or LCase(Game_Type) = "high" or LCase(Game_Type) = "dal" or LCase(Game_Type) = "powers" or LCase(Game_Type) = "virtuals" or LCase(Game_Type) = "real" or LCase(Game_Type) = "dari" Then response.write "10000" else response.write Session("SB_BETTINGMIN") end if %>;

	var bMax = <%if LCase(Game_Type) = "special" Or LCase(Game_Type) = "special2" Then response.write "1000000" else if LCase(Game_Type) = "cross" Or LCase(Game_Type) = "handicap" Then response.write "2000000" else if LCase(Game_Type) = "smp" Then response.write "10000000" else response.write Session("SB_BETTINGMAX") end if %>;

	var fMax = <%if LCase(Game_Type) = "special" Or LCase(Game_Type) = "special2" Then response.write "3000000" else if LCase(Game_Type) = "cross" Or LCase(Game_Type) = "handicap" Then response.write "5000000" else if LCase(Game_Type) = "smp" Then response.write "30000000" else response.write Session("SB_BENEFITMAX") end if %>;



      // 최소배팅액...
      var betMoney = frm.BetAmount.value.replace(/,/g, "");
                              
      if (parseFloat(betMoney) < parseFloat(bMin) )
      {
        alert("최소 베팅한도 금액은 "+formatCurrency(bMin)+"원 입니다.");
        frm.TotalBenefit.value = 0;
        frm.BetAmount.focus();
        return;
      }
      
      if (parseFloat(betMoney) % 1 != 0 ) {
        alert("베팅은 1원 단위로 하실수 있습니다.");
        frm.TotalBenefit.value = 0;
        frm.BetAmount.focus();
        return;
      }
      
      // 최대배팅액...
      /*if ( parseFloat(betMoney) > parseFloat(bMax) )
      {
        alert("최대 베팅한도 금액 "+formatCurrency(bMax)+"원을 초과하였습니다.");
        frm.TotalBenefit.value = 0;
        frm.BetAmount.focus();
        return false;
      }
      
      // 적중금 상한가...
      var TotalBenefitRate = frm.TotalBenefitRate.value;
      var TotAmount = parseFloat(betMoney) * parseFloat(TotalBenefitRate);
        
      if ( (frm.TotalBenefit.value).split(",").join("") > parseFloat(fMax) ) {
        alert("최대 적중금상한 금액 "+formatCurrency(fMax)+"원을 초과하였습니다. 베팅금액을 다시 입력해주세요.");
        //frm.TotalBenefit.value = 0;
        //frm.BetAmount.focus();
        return;
      }*/
      
		if (!confirm("베팅하시겠습니까? (베팅후 베팅내역에서 확인이 가능합니다.)")) return;		
		frm.submit();
	}
	catch(e){alert(e);}
}

  function maxvalue()
  {
    var mny="0";
    var frm = document.BetFrm;
    var betMoney = frm.BetAmount.value.replace(/,/g, "");
    

    mny=<%= SB_BENEFITMAX %>/document.getElementById("foreCastDividendPercent").innerHTML;

    if(mny><%= SB_BETTINGMAX %>)
    {          
      mny=<%= SB_BETTINGMAX %>;
      if(document.getElementById("foreCastDividendPercent").innerHTML<1) mny="0";        
    }
    
    mny = String(Math.floor(mny));
    mny = mny.substr(0,mny.length-2)+ "00"; 
                          
    document.getElementById("BetAmount").value = String(Math.floor(mny));       
    
    document.getElementById("TotalBenefit").value =  String(Math.floor(Math.floor(mny)*document.getElementById("foreCastDividendPercent").innerHTML)).setComma();
  }
</script>

<td style="width:210px;">
<div id="betcart" class="style1" style="position: absolute; top: 270px; right: auto;margin-left: 10px;">
  <form name="BetFrm" target="ProcFrm" method="post" action="Bet_Proc.asp">
    <input type="hidden" name="SB_BETTINGMIN" id="SB_BETTINGMIN" value="<%= Session("SB_BETTINGMIN") %>" />
    <input type="hidden" name="SB_BETTINGMAX" value="<%=SB_BETTINGMAX%>" />
    <input type="hidden" name="SB_BENEFITMAX" value="<%=SB_BENEFITMAX%>" />
    <input type="hidden" name="Game_Type" id="Game_Type" value="<%=Game_Type%>" />
    <input type="hidden" name="TotalBenefitRate" id="TotalBenefitRate" value="" />
      <table cellpadding="0" cellspacing="0" border="0" width="200px" style="background:url('/images/cart/cart_bg.jpg') repeat-y">
          <tbody><tr>
              <td height="40">
                  <img src="/images/cart/cart_top2.jpg" alt="">
              </td>
          </tr>
          <tr>
              <td align="center" height="32px">
                  <table width="188px" cellpadding="0" cellspacing="0" border="0">
                      <tbody>
                        <tr style="color: white;font-size: 13px;">
                          <td align="center">
                            <a href="javascript:maxvalue()" style="color: white">Max</a>  
                            
                          </td>
                          <td align="center"><input type="checkbox" id="chk_fix" name="chk_fix" style="vertical-align:middle"> 카트고정</td>
                      </tr>
                  </tbody></table>
              </td>
          </tr>
          <tr>
              <td align="center" height="27px">
                  <table width="188px" cellpadding="0" cellspacing="0" border="0">
                      <tbody><tr>
                          <td align="center"><input type="image" name="ctl00$ImageButton1" onclick="window.location.reload()" title="카트 모두삭제" src="/images/cart/btn_01.jpg" style="border-width:0px;"></td>
                          <td align="center"><a href="#"><img src="/images/cart/btn_02.jpg" alt=""></a></td>
                      </tr>
                  </tbody></table>
              </td>
          </tr>
          <tr>
              <td style="color: white; font-size: 13px" align="center">
                <div style="text-align: left">베팅금액</div>
                <div style="text-align: left">최소베팅액: <font color="orange"><b><%=FormatNumber(SB_BETTINGMIN,0)%></font>원</b></div>
                <div style="text-align: left">최대베팅액: <font color="orange"><b><%=FormatNumber(SB_BETTINGMAX,0)%></font>원</b></div>
                <div style="text-align: left">최대당첨액: <font color="orange"><b><%=FormatNumber(SB_BENEFITMAX,0)%></font>원</b></div>
              </td>
          </tr>
          <tr>
              <td align="center">
                  <table id="carttbl" cellpadding="0" cellspacing="0" border="0" width="186px" bgcolor="#000000">
                      <tbody id="cartTable" style="font-family: dotum; font-size: 12px;">
                          <!-- 배팅 내용 저장 부분 -->
                      </tbody>
                  </table>
              </td>
          </tr>
          <tr>
              <td align="center">
                  <table id="carttblbtm" cellpadding="0" cellspacing="0" border="0" width="200px">
                    
                      <tbody><tr>
                          <td height="10px"></td>
                      </tr>
                      <tr>
                          <td align="center">
                              <table cellpadding="0" cellspacing="0" border="0" style="width:182px" class="bet_cart_table2">
                                  <tbody><tr class="bet_cart1">
                                      <th>배당률</th>
                                      <td align="right">
                                          <span id="foreCastDividendPercent">0.00</span>
                                      </td>
                                  </tr>
                                  <tr class="bet_cart2">
                                      <th>당첨금</th>
                                      <td align="right">
                                          <INPUT name="TotalBenefit" id="TotalBenefit" onfocus="blur();" type="text" readonly="" value="0" style="background: transparent; color: yellow; width: 83px; border:currentColor 0; text-align: right;"> 원
                                      </td>
                                  </tr>
                                  <tr class="bet_cart3">
                                      <th>배팅액</th>
                                      <td align="right">
                                          <input name="BetAmount" class="input-money" type="text" id="BetAmount" style="width: 70px;" onkeyup="foreCastDividendPriceCalc();" onkeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" value="<%=minAmount%>" maxlength="8">원
                                      </td>
                                  </tr>
                              </tbody></table>
                          </td>
                      </tr>
                      <tr>
                          <td height="10px"></td>
                      </tr>
                      <tr>
                        <td><IMG style="cursor: hand;" onclick="BetChk();" src="/images/cart/btn_bet2.jpg"></td>
                      </tr>
                  </tbody></table>
              </td>
          </tr>
          
      </tbody></table>
  </form>
</div>
</td>

<script language="JavaScript">
$(function() {

    var offset = $("#cartBox").offset();
    var topPadding = 15;

    $(window).scroll(function() {
        if ($(window).scrollTop() > offset.top) {
            $("#cartBox").stop().animate({
                marginTop: $(window).scrollTop() - offset.top + topPadding
            }, 100);
        } else {
            $("#cartBox").stop().animate({
                marginTop: 0
            });
        };
    });
});

	
function insertComma(num) {			
			if ( num.indexOf(".") == -1 ){  // (.)점이 없을때만 작동함.
				num = num.replace(/,/g, "");
				var num_str = num.toString();
				var result = '';
				
				for(var i = 0; i < num_str.length; i++) {
					var tmp = num_str.length - (i+1);
					if(i%3 == 0 && i != 0) result = ',' + result;
					result = num_str.charAt(tmp) + result;
				}
				return result;
			}else{
				return num;
			}
	}

</script>	
