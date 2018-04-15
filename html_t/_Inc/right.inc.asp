<%
SB_BETTINGMIN = Session("SB_BETTINGMIN")
SB_BETTINGMAX = Session("SB_BETTINGMAX")
SB_BENEFITMAX = Session("SB_BENEFITMAX")

IF LCase(Game_Type)  = "special" Then
    SB_BETTINGMAX = 500000
    SB_BENEFITMAX = 1500000
End IF
%>
<script type="text/javascript"> 
  $(function () {

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
    
    document.getElementById('TotalBenefit').innerHTML = fnMoneyType(foreCastDividendPrice);
    $("input[name='TotalBenefit']").val(fnMoneyType(foreCastDividendPrice));
  }
  
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
  
  function BetChk()
    {
      try
      {
      var frm = document.BetFrm;
      var bMin = <%= Session("SB_BETTINGMIN") %> ;
            var bMax = <%if LCase(Game_Type)  = "special" then response.write "500000" else response.write Session("SB_BETTINGMAX") end if%>;
            var fMax = <%if LCase(Game_Type)  = "special" then response.write  "1500000" else response.write Session("SB_BENEFITMAX") end if%>;
      
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
<form name="BetFrm" method="post" action="Bet_Proc.asp">
  <input type="hidden" name="SB_BETTINGMIN" id="SB_BETTINGMIN" value="<%= Session("SB_BETTINGMIN") %>" />
  <input type="hidden" name="SB_BETTINGMAX" value="<%=SB_BETTINGMAX%>" />
  <input type="hidden" name="SB_BENEFITMAX" value="<%=SB_BENEFITMAX%>" />
  <input type="hidden" name="Game_Type" id="Game_Type" value="<%=Game_Type%>" />
  <input type="hidden" name="TotalBenefitRate" id="TotalBenefitRate" value="" />
  <input type="hidden" name="TotalBenefit" value="" />
<div class="bettingCart">
  <div class="betting_time dark_radius box_size" style="height:82px;">
    <div class="cartbtn">
      <a href="/money/charge.asp" class="box_size isLoginFalse"><img src="/images/money_icon.png">충전신청</a>
      <a href="/money/exchange.asp" class="box_size isLoginFalse"><img src="/images/money_icon.png">환전신청</a>
    </div>
  </div>
  
  <div class="betting_title white">
    <h3>베팅카트</h3>
    <div id="img_pin" onclick="moving_control(this)"></div>
    <div class="position">
      <span><a href="javascript:location.reload()"><img src="/images/bettingCart_reset.png"></a></span>
    </div>
  </div>
  <div class="betting_money_set">
    <div class="betting_left">보유금액</div>
    <div class="betting_right" id="BET_SLIM_MONEY"><%=iu_cash%> 원</div>
    <div class="betting_left">배팅금액</div>
    <div class="betting_right">
      <input id="BetAmount" name="BetAmount" class="base_money" type="text" onkeyup="foreCastDividendPriceCalc();" onkeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" value="<%=SB_BETTINGMIN%>"> 원
    </div>
    <div class="betting_left">배당율</div>
    <div class="betting_right"><span id="foreCastDividendPercent" >0.00</span></div>
    <div class="betting_left" style="margin:0;">예상적중금</div>
    <div class="betting_right" style="margin:0;"><span id="TotalBenefit"> 원</div>
  </div></form>
  <div id="cartTable" class="table" style="width:100%; background: #fff"></div>
  <div class="cartmoney">
    <a class="btnMoney" style="cursor: pointer;" href="javascript:InputCheck_new('10000')">10,000원</a>
    <a class="btnMoney" style="cursor: pointer;" href="javascript:InputCheck_new('50000')">50,000원</a>
    <a class="btnMoney" style="cursor: pointer;" href="javascript:InputCheck_new('100000')">100,000원</a>
    <a class="btnMoney" style="cursor: pointer;" href="javascript:InputCheck_new('250000')">250,000원</a>
    <a class="btnMoney" style="cursor: pointer;" href="javascript:InputCheck_new('500000')">500,000원</a>
    <a class="btnMoney" style="cursor: pointer;" href="javascript:InputCheck_new('1000000')">1,000,000원</a>
  </div>
  <p class="btnBox">
    <a id="btnMax" style="cursor: pointer;" href="javascript:maxvalue()">MAX</a>
    <a id="btnMoneyClear" style="cursor: pointer;" href="javascript:InputCheck_new('0')">초기화</a>
    <a id="btnBett" style="cursor: pointer;" onclick="BetChk()">베팅하기</a>
  </p>
  <div class="betting_money_set" style="margin-top:10px;">
    <div class="betting_left" style="border-top-left-radius:5px">최소베팅금액</div>
    <div class="betting_right" style="border-top-right-radius:5px;width:206px;"><span id="min_price"><%=FormatNumber(SB_BETTINGMIN,0)%></span> 원</div>
    <div class="betting_left">최대베팅금액</div>
    <div class="betting_right"><span id="max_price"><%=FormatNumber(SB_BETTINGMAX,0)%></span> 원</div>
    <div class="betting_left" style="border-bottom-left-radius:5px;">최대당첨금액</div>
    <div class="betting_right" style="border-bottom-right-radius:5px;width:206px;"><span id="max_eprice"><%=FormatNumber(SB_BENEFITMAX,0)%></span> 원</div>
  </div>
</div>
</form>
<script type="text/javascript">
  $(function() {
    var msie6 = $.browser == 'msie' && $.browser.version < 7;
    if (!msie6) {
      var top = $('.bettingCart').offset().top;
      $(window).scroll(function (event) {

        var y = $(this).scrollTop();

        if (y > top && moving_stat) $('.bettingCart').addClass('fixed');
        else $('.bettingCart').removeClass('fixed');
      });
    }
  });
  var moving_stat = 1; // 메뉴의 스크롤을 로딩시 on/off설정 1=움직임 0은 멈춤
  function moving_control(obj) {
    if(!moving_stat){ 
      moving_stat = 1;
      $(obj).removeClass("down");
    }
    else{ 
      moving_stat = 0;
      $(obj).addClass("down");
    }
  }
  var scrollTimer;
  var ag = navigator["userAgent"].toLowerCase();
  var win = (ag.indexOf("android") != -1 || ag.indexOf("iphone") != -1) ? parent.window : window;
  $(win).scroll(function(){ //윈도우에 스크롤값이 변경될때마다
    var $win = $(this);
    clearTimeout(scrollTimer);
    scrollTimer = setTimeout(function() {
      if (moving_stat) {
        var __scrollTop = $win.scrollTop();

        if (__scrollTop >= 160) {
          $("#scrollingLayer").animate({"top": (__scrollTop - 160) + "px"}, 300);
        } else {
          $("#scrollingLayer").animate({"top":"0px"}, 300);
        }
      }
    }, 40);
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