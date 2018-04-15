<!-- 배팅카트 시작 -->
<%
SB_BETTINGMIN = Session("SB_BETTINGMIN")
SB_BETTINGMAX = Session("SB_BETTINGMAX")
SB_BENEFITMAX = Session("SB_BENEFITMAX")

If Session("IU_Level") = 2 And (LCase(Game_Type) = "live" Or LCase(Game_Type) = "powers" Or LCase(Game_Type) = "dari") Then
SB_BETTINGMAX = 1500000
SB_BENEFITMAX = 2940000
End If
If Session("IU_Level") >= 3 And (LCase(Game_Type) = "live" Or LCase(Game_Type) = "powers" Or LCase(Game_Type) = "dari") Then
SB_BETTINGMAX = 2000000
SB_BENEFITMAX = 3920000
End If

'kimmj : 스페셜도 승무패와 동일하게 적용
IF LCase(Game_Type)  = "special" Then
    SB_BETTINGMAX = 500000
    SB_BENEFITMAX = 1500000
End IF
%>                  
<script type="text/javascript"> 
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

	    if(document.getElementById("max") != null)
	    {
	        if(document.getElementById("max").checked == true)
	        {
			    maxvalue(document.getElementById("max"));
		    }
	    }	    
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
		
		// 배팅체크...
		function BetChk()
		{
            try
            {

			
		        var frm = document.BetFrm;
		        var bMin = <%= Session("SB_BETTINGMIN") %> ;

		        var bMax = <%if LCase(Game_Type)  = "special" then response.write "500000" else if Session("IU_Level") = 2 And (LCase(Game_Type) = "live" Or LCase(Game_Type) = "powers" Or LCase(Game_Type) = "dari") then  response.write "1500000" else if Session("IU_Level") >= 3 And (LCase(Game_Type) = "live" Or LCase(Game_Type) = "powers" Or LCase(Game_Type) = "dari") Then response.write "2000000" else response.write Session("SB_BETTINGMAX") end if%>;

		        var fMax = <%if LCase(Game_Type)  = "special" then response.write "1500000" else if Session("IU_Level") = 2 And (LCase(Game_Type) = "live" Or LCase(Game_Type) = "powers" Or LCase(Game_Type) = "dari") then  response.write "2940000" else if Session("IU_Level") >= 3 And (LCase(Game_Type) = "live" Or LCase(Game_Type) = "powers" Or LCase(Game_Type) = "dari") Then response.write "3920000" else response.write Session("SB_BENEFITMAX") end if%>;


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
		        if ( parseFloat(betMoney) > parseFloat(bMax) )
		        {
			        alert("최대 베팅한도 금액 "+formatCurrency(bMax)+"원을 초과하였습니다.");
			        frm.TotalBenefit.value = 0;
			        frm.BetAmount.focus();
			        return;
		        }
        		
		        // 적중금 상한가...
				
		        var TotalBenefitRate = frm.TotalBenefitRate.value;
		
		        var TotAmount = parseFloat(betMoney) * parseFloat(TotalBenefitRate);
		        if ( (frm.TotalBenefit.value).split(",").join("") > parseFloat(fMax) ) {
			        alert("최대 적중금상한 금액 "+formatCurrency(fMax)+"원을 초과하였습니다. 베팅금액을 다시 입력해주세요.");
			        //frm.TotalBenefit.value = 0;
			        //frm.BetAmount.focus();
			        return;
						
		        }
		        			
    		    if (!confirm("베팅하시겠습니까? (베팅후 베팅내역에서 확인이 가능합니다.)")) return;		
				
		        frm.submit();
            }
            catch(e){alert(e);}
		}
		
        function maxvalue(obj)
        {
            var mny="0";
           // if(obj.checked == true)
            //{
                var frm = document.BetFrm;
                var betMoney = frm.BetAmount.value.replace(/,/g, "");
                
				
                mny=<%= SB_BENEFITMAX %>/document.getElementById("foreCastDividendPercent").innerHTML;
				
				if(mny><%= SB_BETTINGMAX %>)
                {          
                    mny=<%= SB_BETTINGMAX %>;
                    if(document.getElementById("foreCastDividendPercent").innerHTML<1) mny="0";        
                }
                
                mny = String(Math.floor(mny));
                mny = mny.substr(0,mny.length-2); 
                mny = mny + "00";
                                
	            document.getElementById("BetAmount").value = String(Math.floor(mny)).setComma();        
	            //document.getElementById("TotalBenefit").value =  String(Math.floor(mny)*document.getElementById("foreCastDividendPercent").innerHTML).setComma();
	            document.getElementById("TotalBenefit").value =  String(Math.floor(Math.floor(mny)*document.getElementById("foreCastDividendPercent").innerHTML)).setComma();
	            //document.all.item("tmp_win_mny").innerHTML=addComma(Math.floor(Math.floor(mny)*document.bet.bet_rate.value));
          //  }
          //  else
          //  {
                //document.getElementById("BetAmount").value="0";
	            //document.getElementById("TotalBenefit").value ="0";
          //  }
        }
	function Right(str, n){
	  if (n <= 0)
	     return "";
	  else if (n > String(str).length)
	     return str;
	  else {
	     var iLen = String(str).length;
	     return String(str).substring(iLen, iLen - n);
	  }
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

	var cartStr= "";
	var cartCnt = 0;
	var total_beDang = 1;
	var view_total_beDang;
	var totalBeDangPer = 0;

	function scrollCk()
	{
		var scrollID = document.getElementById("scrollID");
		var cartScroll = document.getElementById("bt_fixed");
		
		if(cartScroll.checked)
		{
			//scrollID.src = "/images/btn_scr.gif"			
			cartScroll.checked = false;
		}else
		{
		
			//scrollID.src = "/images/btn_pin_on.gif"
			cartScroll.checked = true;
		}
		
	}
	//세자리마다 콤마찍기
	function setComma(num,formName,element){ 
	 var code = window.event.keyCode;
	 var form = eval("document."+formName+"."+element);
	 var returnVal = delComma(num.value);
	 var re=/[^0-9]/gi;
	 returnVal = returnVal.replace(re,"");
	 while(returnVal.match(/^(-?\d+)(\d{3})/)){
	  returnVal = returnVal.replace(/^(-?\d+)(\d{3})/,'$1,$2');
	 }
	 form.value = returnVal;

	}

	//콤마 삭제하기
	function delComma(val){
	 var com = val.replace(/,/g,"");
	 return com;
	}
</script>

<input type="hidden" name="SB_BETTINGMIN" id="SB_BETTINGMIN" value="<%= Session("SB_BETTINGMIN") %>" />
<input type="hidden" name="SB_BETTINGMAX01" id="SB_BETTINGMAX01" value="<%= Session("SB_BETTINGMAX") %>" />
<input type="hidden" name="SB_BENEFITMAX01" id="SB_BENEFITMAX01" value="<%= Session("SB_BENEFITMAX") %>" />
<input type="hidden" name="Game_Type" id="Game_Type" value="<%=Game_Type%>" />
<input type="hidden" name="TotalBenefitRate" id="TotalBenefitRate" value="" />	
