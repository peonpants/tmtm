<%	
getGameTime = ""
	Set Dber = new clsDBHelper

	SQL = "UP_INFO_Cart_DEL"
	reDim param(1)
	param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

	Dber.ExecSP SQL,param,Nothing
	
	Dber.Dispose
	Set Dber = Nothing 

	IF LCase(Game_Type)  = "smp" Then
		GameList_Title = "승무패"
		Game_Home = "홈/승"
		Game_Draw = "무"
		Game_Away = "원정/패"
	ElseIF LCase(Game_Type)  = "handicap" Then
		GameList_Title = "핸디오버"
		Game_Home = "홈/오버"
		Game_Draw = "핸디/기준값"
		Game_Away = "원정/언더"
	ElseIF LCase(Game_Type)  = "special" Then
		GameList_Title = "스페셜"
		Game_Home = "홈/오버"
		Game_Draw = "핸디/기준값"
		Game_Away = "원정/언더"
	End IF
IF LCase(Game_Type)  = "power" Then
onn1="on_"
ElseIf LCase(Game_Type)  = "powers" Then
onn2="on_"
ElseIf LCase(Game_Type)  = "virtuals" Then
onn3="on_"
ElseIf LCase(Game_Type)  = "nine" Then
onn4="on_"
ElseIf LCase(Game_Type)  = "choice" Then
onn5="on_"
ElseIf LCase(Game_Type)  = "mgm" Then
onn6="on_"
ElseIf LCase(Game_Type)  = "bacarat" Then
onn7="on_"
ElseIf LCase(Game_Type)  = "dice" Then
onn8="on_"
ElseIf LCase(Game_Type)  = "toms" Then
onn9="on_"
ElseIf LCase(Game_Type)  = "live" Then
onn10="on_"
ElseIf LCase(Game_Type)  = "dari" Then
onn11="on_"
ElseIf LCase(Game_Type)  = "dal" Then
onn12="on_"

End If

%>
<%	
IF LCase(Game_Type)  = "cross" OR LCase(Game_Type)  = "handicap" OR LCase(Game_Type)  = "real" OR LCase(Game_Type)  = "special" Then
LC_YN="N"
Else
LC_YN="Y"
End If 
%>



<script type="text/javascript" src="/js/newjs/moment.min.js"></script>

<link rel="stylesheet" type="text/css" href="/css/newcss/betting.css">
<link rel="stylesheet" type="text/css" href="/css/newcss/game.css">
<style>
/*사다리게임*/
.ladder_wrap{background:url('/images/game/bg_ladder.png') -40px 0;width:100%;}
.ladder_wrap .state .row_e{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat 0 -40px;}
.ladder_wrap .state .row_o{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat -40px -40px;}
.ladder_wrap .state .row_l{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat 0 -77px;}
.ladder_wrap .state .row_r{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat -40px -77px;}
.ladder_wrap .state .row_3{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat 0 -115px;}
.ladder_wrap .state .row_4{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat -40px -115px;}
.ladder_wrap .state .row_l3e{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat -350px -40px;}
.ladder_wrap .state .row_r4e{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat -390px -40px;}
.ladder_wrap .state .row_r3o{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat -430px -40px;}
.ladder_wrap .state .row_l4o{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat -470px -40px;}

.ladder_wrap .end_pos_e .tx{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat 0 -40px;}
.ladder_wrap .end_pos_o .tx{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat -40px -40px;}
.ladder_wrap .start_pos_l .tx{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat 0 -77px;}
.ladder_wrap .start_pos_r .tx{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat -40px -77px;}
.ladder_wrap .line_num_3 .tx{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat 0 -115px;}
.ladder_wrap .line_num_4 .tx{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat -40px -115px;}
.ladder_wrap .mix_l3e .tx{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat -350px -40px;}
.ladder_wrap .mix_r4e .tx{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat -390px -40px;}
.ladder_wrap .mix_r3o .tx{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat -430px -40px;}
.ladder_wrap .mix_l4o .tx{margin:5px 13px 0 14px;width:27px;height:27px;text-indent:-9000px;background:url('/images/game/ladder_result.png') no-repeat -470px -40px;}


.ladder_tit{background:url('/images/game/bg_ladder.png') -40px 0;width:100%;padding:28px 0 20px;}
.ladder_tit h3{width:457px;height:72px;background:url('/images/game/ladderpowers_img.png') 0 0 no-repeat;text-indent:-999999px;margin:0px auto 0;}
.ladder_top{overflow-y:hidden;overflow-x:hidden;position:relative;margin:0 0px 0 40px;height:651px;}
.ladder_top .ladder_area iframe{width:870px;height:700px;}

/*.ladder_top .ladder_area{position:absolute;top:-184px;left:-65px;}*/
.ladder_top .ladder_area{width:870px;height:700px;overflow:hidden;margin:0 auto;}
.ladder_now_bet{width:170px;position:absolute;right:0;top:0;}
.ladder_now_bet{position:relative;float:right;margin:0 25px 0 0;padding:25px 0px 0 7px !important;width:165px !important;height:404px;background:url('/images/game/ladderpowers_img.png') 0 -79px no-repeat;;}
.ladder_now_bet a.btn_refresh{position:absolute;top:6px;right:9px;background:url('/images/game/ladderpowers_img.png') -174px -79px no-repeat;width:25px;height:25px;display:block;text-indent:-999999px;}
.ladder_now_bet h3{width:157px;padding-bottom:15px;height:15px;line-height:15px;text-align:center;letter-spacing:-1px;font-size:12px;font-family:'돋움',dotum;border-bottom:1px solid #c6c1b2;}
.ladder_now_bet ul{width:155px;height:355px;}
.ladder_now_bet li{clear:both;position:relative;height:35px;line-height:35px;border-bottom:1px solid #c6c1b2;}
.ladder_now_bet ul .tx{float:left;width:40px;margin-top:3px !important;}
.ladder_now_bet ul span.money{float:left;width:90px;font-size:12.5px;text-align:right;font-weight:bold;color:#222;letter-spacing:-0.5px;}
.ladder_cnt{clear:both;display:block;}
.ladder_cnt:after{clear:both;display:block;content:'';}
.ladder_cnt>div:after{clear:both;display:block;content:'';}
.ladder_cnt .ladder_choice{background:url('/images/game/bg_ladder_table.png')0 0 no-repeat;width:100%;height:160px;margin-bottom:2px;overflow:hidden;}
.ladder_cnt .ladder_choice a{box-sizing:border-box;color:#533620;outline:0;cursor:pointer;display:block;background:url('/images/game/bg_ladder_table.png') no-repeat;font-family:'Noto Sans',맑은 고딕,'Malgeun Gothic','맑은 고딕',dotum;font-weight:300;font-size:12px;overflow:hidden;padding-top:32px;}
.ladder_cnt .ladder_choice .b_odd{background-position:0 -379px;width:72px;height:110px;padding-top:60px;}
.ladder_cnt .ladder_choice .b_even{background-position:-81px -379px;width:72px;height:110px;padding-top:60px;}
.ladder_cnt .ladder_choice .b_lft{background-position:-254px -379px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_rgt{background-position:-335px -379px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_3_odd{background-position:-254px -437px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_4_even{background-position:-335px -437px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_lft_3_oven{background-position:-515px -379px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_lft_4_odd{background-position:-596px -379px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_rgt_3_odd{background-position:-515px -437px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_rgt_4_even{background-position:-596px -437px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_odd:hover,
.ladder_cnt .ladder_choice .b_odd.btn-mouseclick{background-position:0 -512px;width:72px;height:110px;padding-top:60px;}
.ladder_cnt .ladder_choice .b_even:hover,
.ladder_cnt .ladder_choice .b_even.btn-mouseclick{background-position:-81px -512px;width:72px;height:110px;padding-top:60px;}
.ladder_cnt .ladder_choice .b_lft:hover,
.ladder_cnt .ladder_choice .b_lft.btn-mouseclick{background-position:-254px -512px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_rgt:hover,
.ladder_cnt .ladder_choice .b_rgt.btn-mouseclick{background-position:-335px -512px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_3_odd:hover,
.ladder_cnt .ladder_choice .b_3_odd.btn-mouseclick{background-position:-254px -570px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_4_even:hover,
.ladder_cnt .ladder_choice .b_4_even.btn-mouseclick{background-position:-335px -570px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_lft_3_oven:hover,
.ladder_cnt .ladder_choice .b_lft_3_oven.btn-mouseclick{background-position:-515px -512px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_lft_4_odd:hover,
.ladder_cnt .ladder_choice .b_lft_4_odd.btn-mouseclick{background-position:-596px -512px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_rgt_3_odd:hover,
.ladder_cnt .ladder_choice .b_rgt_3_odd.btn-mouseclick{background-position:-515px -570px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_rgt_4_even:hover,
.ladder_cnt .ladder_choice .b_rgt_4_even.btn-mouseclick{background-position:-596px -570px;width:72px;height:52px;}

.ladder_cnt .ladder_choice .b_odd:active{background-position:0 -512px;width:72px;height:110px;padding-top:60px;}
.ladder_cnt .ladder_choice .b_even:active{background-position:-81px -512px;width:72px;height:110px;padding-top:60px;}
.ladder_cnt .ladder_choice .b_lft:active{background-position:-254px -512px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_rgt:active{background-position:-335px -512px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_3_odd:active{background-position:-254px -570px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_4_even:active{background-position:-335px -570px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_lft_3_oven:active{background-position:-515px -512px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_lft_4_odd:active{background-position:-596px -512px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_rgt_3_odd:active{background-position:-515px -570px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_rgt_4_even:active{background-position:-596px -570px;width:72px;height:52px;}

.ladder_cnt .ladder_choice .b_odd.focus{background-position:0 -512px;width:72px;height:110px;padding-top:60px;}
.ladder_cnt .ladder_choice .b_even.focus{background-position:-81px -512px;width:72px;height:110px;padding-top:60px;}
.ladder_cnt .ladder_choice .b_lft.focus{background-position:-254px -512px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_rgt.focus{background-position:-335px -512px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_3_odd.focus{background-position:-254px -570px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_4_even.focus{background-position:-335px -570px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_lft_3_oven.focus{background-position:-515px -512px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_lft_4_odd.focus{background-position:-596px -512px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_rgt_3_odd.focus{background-position:-515px -570px;width:72px;height:52px;}
.ladder_cnt .ladder_choice .b_rgt_4_even.focus{background-position:-596px -570px;width:72px;height:52px;}

.ladder_cnt .ladder_choice>div{float:left;padding:25px 0;}
.ladder_cnt .ladder_choice>div ul{width:155px;margin-left:78px;}
.ladder_cnt .ladder_choice>div li{float:left;width:50%;text-align:center;}
.ladder_cnt .ladder_choice .game_info{width:160px;text-align:center;font-size:13px;}
.ladder_cnt .ladder_choice .game_info strong,.ladder_cnt .ladder_choice .game_info span,.ladder_cnt .ladder_choice .game_info em{font-family:'Noto Sans',맑은 고딕,'Malgeun Gothic','맑은 고딕',dotum;}
.ladder_cnt .ladder_choice .game_info .btn_refresh{margin:0 auto;background:url('/images/game/ladderpowers_img.png') -206px -79px no-repeat;width:94px;height:26px;display:block;text-indent:-999999px;}
.ladder_cnt .ladder_choice .game_info span{color:#fff;}
.ladder_cnt .ladder_choice .game_info strong.order{color:#ffce25;}
.ladder_cnt .ladder_choice .game_info em{display:block;font-style:normal;color:#fff;}
.ladder_cnt .ladder_choice .game_info strong.count{display:block;color:#fff0c7;font-size:30px;padding:0px 0 5px;line-height:35px;font-family:'Noto Sans',맑은 고딕,'Malgeun Gothic','맑은 고딕',dotum;}
.ladder_cnt .ladder_choice .ladder_2nd ul{margin-left:100px;}
.ladder_cnt .ladder_choice .ladder_3rd ul{margin-left:110px;}
.ladder_cnt .ladder_choice .ladder_2nd li,.ladder_cnt .ladder_choice .ladder_3rd li{margin-bottom:7px;}
.ladder_cnt .ladder_cart *{box-sizing:content-box;}
.ladder_cnt .ladder_cart .cart_info{display:block;width:155px;float:left;margin-right:60px;padding:20px 0px 0 5px;}
.ladder_cnt .ladder_cart .cart_info li{padding:7px 15px;}
.ladder_cnt .ladder_cart .cart_info span{display:inline-block;color:#fff;font-size:13px;margin-right:3px;width:55px;text-align:left;font-family:'Noto Sans',맑은 고딕,'Malgeun Gothic','맑은 고딕',dotum;}
.ladder_cnt .ladder_cart .cart_info input{background:none;width:100%;font-style:normal;font-weight:bold;color:#ffeaad;font-size:14px;}
.ladder_cnt .ladder_cart .cart_info #foreCastDividendPercent{background:none;width:100%;font-style:normal;font-weight:bold;color:#ffeaad;font-size:14px;}
.ladder_cnt .ladder_cart .cart_info strong{color:#f7c725;font-size:11px;}
.ladder_cnt .ladder_cart .cart_info span.tx{width:100%;height:27px;display:inline-block;margin:0;}
.ladder_cnt .ladder_cart .cart_pay{float:left;width:660px;position:relative;padding:15px 20px 15px 15px;}
.ladder_cnt .ladder_cart{clear:both;display:block;background:url('/images/game/bg_ladder_table.png')0 -162px no-repeat;width:100%;height:160px;}
.ladder_cnt .ladder_cart .bet_money{float:left;display:block;background-color:#f0f0f0;-webkit-border-radius: 5px; 	-moz-border-radius:5px;border-radius: 5px;border:1px solid #7f3c24;width:258px;height:31px;padding:5px 10px;margin:1px 1px 4px;line-height:2.42857143}
.ladder_cnt .ladder_cart .bet_money label{font-weight:bold;color:#222;font-size:14px;display:inline-block;margin-right:4px;letter-spacing:-0.5px;}
.ladder_cnt .ladder_cart .bet_money input{text-align:right;background:#f0f0f0;color:#e42828;width:190px;float:right;font-size:20px;font-family:'Noto Sans',맑은 고딕,'Malgeun Gothic','맑은 고딕',dotum;letter-spacing:-0.5px;font-weight:bold;}
.ladder_cnt .ladder_cart .bet_money.i_blue input{color:#106de1 !important;}
.ladder_cnt .ladder_cart .bet_btn_inner{clear:both;width:565px;}
.ladder_cnt .ladder_cart .bet_btn_inner [type=button]{outline:0;cursor:pointer;background:url('/images/game/bg_ladder_table.png') -681px -380px no-repeat;font-family:'Noto Sans',dotum;letter-spacing:-0.5px;font-weight:bold;font-size:15px;color:#533620;width:92px;height:37px;margin:1px;float:left;text-align:center;}
.ladder_cnt .ladder_cart .bet_btn_inner [type=button]:hover{background-position:-681px -512px !important;}
.ladder_cnt .ladder_cart .bet_btn_inner .i_blue{color:#2b5c99 !important;}
.ladder_cnt .ladder_cart .bet_btn_inner .i_brw{color:#b04b00 !important;}
.ladder_cnt .ladder_cart .bet_btn_inner .i_gray{color:#666 !important;}
.ladder_cnt .ladder_cart input.btn_bet{cursor:pointer;display:block;position:absolute;right:10px;top:15px;font-family:'Noto Sans',맑은 고딕,'Malgeun Gothic','맑은 고딕',dotum;letter-spacing:-0.5px;font-weight:bold;font-size:15px;letter-spacing:0 !important;background:#4c1f09 !important;width:100px;height:125px;color:#fff !important;-webkit-border-radius: 5px; 	-moz-border-radius:5px;border-radius: 5px;border:1px solid #000;text-align:center;}
.ladder_cnt .ladder_cart .bet_money_free{float:left;display:block;background-color:#eee9e4;-webkit-border-radius: 5px; 	-moz-border-radius:5px;border-radius: 5px;border:1px solid #7f3c24;width:258px;height:29px;padding:6px 10px 0;margin:1px 1px;}
.ladder_cnt .ladder_cart .bet_money_free label{font-weight:bold;color:#222;font-size:13px;display:inline-block;margin-right:4px;letter-spacing:-0.5px;}
.ladder_cnt .ladder_cart .bet_money_free input{text-align:right;background:#eee9e4;color:#111;width:200px;font-size:15px;font-family:'Noto Sans',맑은 고딕,'Malgeun Gothic','맑은 고딕',dotum;letter-spacing:-0.5px;font-weight:bold;}

.ladder_btm{clear:both;display:block;}
.ladder_btm:after{clear:both;display:block;content:'';}
.ladder_btm .ladder_chart{margin:20px 20px;}
.ladder_btm .ladder_chart:after{clear:both;display:block;content:'';}
.ladder_btm .ladder_chart h4{width:144px;height:18px;margin-bottom:14px;background:url('/images/game/ladderpowers_img.png') -174px -113px no-repeat;text-indent:-999999px;}
.ladder_btm .ladder_chart .ladder_chart_area iframe{width:890px;height:360px;margin:0 auto;}
.ladder_wrap .ladder_chart_inner{overflow:scroll;height:auto;overflow-y:hidden;background-color:#f7f0e0;border-bottom:2px solid #b05e45;}
.ladder_wrap .evenfirst .tx{margin:5px 0 0;width:27px;height:27px;background:url('/images/game/ladder_result.png') no-repeat -350px -73px;}
.ladder_wrap .evensecond .tx{margin:5px 0 0;width:27px;height:27px;background:url('/images/game/ladder_result.png') no-repeat -390px -73px;}
.ladder_wrap .oddsecond .tx{margin:5px 0 0;width:27px;height:27px;background:url('/images/game/ladder_result.png') no-repeat -430px -73px;}
.ladder_wrap .oddfirst .tx{margin:5px 0 0;width:27px;height:27px;background:url('/images/game/ladder_result.png') no-repeat -470px -73px;}
.ladder_wrap .ladder_chart_inner th{text-align:center;height:32px;line-height:32px;font-size:11px;font-weight:normal;font-family:dotum;color:#5f4d27;background:url('/images/game/bg_ladder_table.png') -1px -331px no-repeat;}
.ladder_wrap .ladder_chart_inner td{border-right:1px solid #e1dacc;padding:2px 7px;}
.ladder_wrap .ladder_chart_inner .tx{display:block;text-align:center;line-height:26px;font-size:10px;letter-spacing:-1px;color:#fff;}
.ladder_wrap .ladder_chart_inner .tx em{font-style:normal;}
.ladder_btm .ladder_bet_list{margin:20px;}
.ladder_btm .ladder_bet_list:after{clear:both;display:block;content:'';}
.ladder_btm .ladder_bet_list table{width:100%;}
.ladder_btm .ladder_bet_list h4{width:56px;height:18px;margin-bottom:14px;background:url('/images/game/ladderpowers_img.png') -174px -135px no-repeat;text-indent:-999999px;}
.ladder_btm .ladder_bet_list th{text-align:center;height:32px;line-height:32px;font-size:11px;font-weight:normal;font-family:dotum;color:#5f4d27;background:url('/images/game/bg_ladder_table.png') -1px -331px no-repeat;}
.ladder_btm .ladder_bet_list tbody{border-bottom:2px solid #b16046;}
.ladder_btm .ladder_bet_list tbody td{border-bottom:1px solid #e1dacc;background-color:#f7f0e0;padding:12px 0;text-align:center;font-size:12px;color:#333;}
.ladder_btm .ladder_bet_list em{font-style:normal;}
.ladder_btm .ladder_bet_list .tx{display:block;margin:0 auto;}
.ladder_btm .ladder_bet_list .num{font-size:11px;line-height:11px;}
.ladder_btm .ladder_bet_list .date,.ladder_btm .ladder_bet_list .time{color:#222;line-height:20px;line-height:11px;}
.ladder_btm .ladder_bet_list .date strong{display:block;line-height:19px;}
.ladder_btm .ladder_bet_list .time strong{display:block;font-weight:normal;line-height:19px;}
.ladder_btm .ladder_bet_list .sort{color:#000;letter-spacing:-0.5px;font-size:12px;}
.ladder_btm .ladder_bet_list .per{color:#111;}
.ladder_btm .ladder_bet_list .money01,.ladder_btm .ladder_bet_list .money02{text-align:right;font-size:12px;line-height:20px;}
.ladder_btm .ladder_bet_list .money01 strong{font-weight:normal;}
.ladder_btm .ladder_bet_list td strong.ing,.ladder_btm .ladder_bet_list td strong.lots{color:#13427d;}
.ladder_btm .ladder_bet_list td strong.hit{color:#ef0000;}
.ladder_btm .ladder_bet_list td strong.no_hit{color:#8d8d8d;}
.ladder_btm .ladder_bet_list .result strong{display:block;font-size:12px;color:#111;}
.ladder_btm .ladder_bet_list tfoot td{padding:15px 0;}
.ladder_btm .ladder_bet_list tfoot input{-webkit-border-radius: 5px; 	-moz-border-radius:5px;border-radius: 5px;border:1px solid #9a8e81;font-size:14px;line-height:33px;width:90px;height:35px;color:#fff;font-weight:bold;color:#fff;font-family:맑은 고딕,'Malgeun Gothic','맑은 고딕';}
.ladder_btm .ladder_bet_list tfoot input.btn_ladder_all{background:#883019;margin-right:5px;}
.ladder_btm .ladder_bet_list tfoot input.btn_ladder_del{background:#a0381d;}
.ladder_btm .ladder_bet_list tfoot .btn_ladder_all_bet{float:right;text-align:center;display:block;background:#5a2505;-webkit-border-radius: 5px; 	-moz-border-radius:5px;border-radius: 5px;border:1px solid #9a8e81;font-size:14px;line-height:33px;width:110px;height:35px;color:#fff;font-weight:bold;color:#fff;font-family:맑은 고딕,'Malgeun Gothic','맑은 고딕';}
.ladder_btm .paging{clear:both;text-align:right;}
.ladder_btm .paging a{text-transform:uppercase;display:inline-block;padding:0 4px;font-size:13px;font-family:'Noto Sans',맑은 고딕,'Malgeun Gothic','맑은 고딕',dotum !important;}
.ladder_btm .paging a.pg_next,.ladder_btm .paging a.pg_prev{font-weight:bold;color:#222;padding:0 7px;border:none;}
.ladder_btm .paging a.on{font-weight:bold;}
.ladder_notice{background:#695e58;padding:25px 20px;}
.ladder_notice h4{background:url('/images/game/ladderpowers_img.png') -176px -158px no-repeat;width:66px;height:14px;text-indent:-999999px;margin-bottom:15px;}
.ladder_notice li{font-size:11px;color:#b8b0ae;font-family:dotum;line-height:20px;}
#footer{clear:both;display:block;border-top:1px solid #ddd;}

.bet_disable{position:absolute;top:0;bottom:0;left:0;right:0;padding-top:60px;font-size:30px;text-align:center;color:white;background:rgba(0,0,0,0.7);display:none;}
</style>
			<table width="854"  height="1310" border="0" cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td align="center">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"  bgcolor="000000">
						<tbody>
							<tr>
								<td bgcolor="000000">&nbsp;</td>
								<td width="29" align="center" valign="top" background="/images/cross/bg_contents_L.jpg" ><img src="/images/cross/bg_contents_L2.jpg" width="29" height="6"></td>
								<td height="1310" valign="top" style="width: 1200px;">
<div id="sub-area" style="width:1173px;">

<div class="subbody">
		<div id="sub-content">

<div id="content" class="sub_cnt">

<div class="ladder_wrap">
		<div class="ladder_tit"><h3>파워사다리게임</h3></div>
		<div class="ladder_top">
<div class="ladder_area">
				<iframe id="game_frame" src="bslip.asp" style="width:830px; height: 682px;" scrolling="no"></iframe>
			</div>
</div>
<div class="ladder_cnt">
			<!-- 게임선택 -->
			<input type="hidden" id="game_hour" name="game_hour" value="21">
			<div class="ladder_choice">
				<div class="game_info">
					<span id="date_mm">일</span><strong class="order" id="play_num_view"></strong>
							<em><span id="date_hh"></span>:<span id="date_ii"></span>:<span id="date_ss"></span></em>
							<strong class="count" id="remaind_time">00:00</strong>
							<button type="button" class="btn_refresh" onclick="location.reload();">새로고침
						</button>
				</div>
				<div class="ladder_1st">
					<h4 class="hidden">1게임 홀/짝</h4>
					<ul>
						<li><a class="b_odd betting" id="id1_701_1" bt_league="네임드 사다리 [홀/짝]" flag="N">
							<span class="divd" id="benefit_701_1"></span>
						</a></li>
						<li style="display:none"><a class="betting" id="t_6893399" bt_league="네임드 사다리 [홀/짝]" flag="{victory.setCheckFlag.tie}">
							<span class="name">undefined</span>
							<span class="divd"></span>
						</a></li>
						<li><a class="b_even betting" id="id2_701_2" bt_league="네임드 사다리 [홀/짝]" flag="N">
							<span class="divd"  id="benefit_701_2"></span>
						</a></li>
					</ul>
				</div>
				<div class="ladder_2nd">
					<h4 class="hidden">2게임 출발줄 줄갯수</h4>
					<ul>
						<li><a class="b_lft betting" id="id1_702_1" bt_league="네임드 사다리 [출발점 좌/우]" flag="N">
							<span class="divd" id="benefit_702_1"></span>
						</a></li>
						<li style="display:none"><a class="betting" id="t_6893400" bt_league="네임드 사다리 [출발점 좌/우]" flag="{victory.setCheckFlag.tie}">
							<span class="name">undefined</span>
							<span class="divd"></span>
						</a></li>
						<li><a class="b_rgt betting" id="id2_702_2" bt_league="네임드 사다리 [출발점 좌/우]" flag="N">
							<span class="divd" id="benefit_702_2"></span>
						</a></li>
						
						<li><a class="b_4_even betting" id="id1_703_1" bt_league="네임드 사다리 [3줄 / 4줄]" flag="N">
							<span class="divd" id="benefit_703_1"></span>
						</a></li>
						<li style="display:none"><a class="betting" id="t_6893401" bt_league="네임드 사다리 [3줄 / 4줄]" flag="{victory.setCheckFlag.tie}">
							<span class="name">undefined</span>
							<span class="divd"></span>
						</a></li>
						<li><a class="b_3_odd betting" id="id2_703_2" bt_league="네임드 사다리 [3줄 / 4줄]" flag="N">
							<span class="divd" id="benefit_703_2"></span>
						</a></li>
					</ul>
				</div>
				<div class="ladder_3rd">
					<h4 class="hidden">3게임 좌우 출발 3/4줄</h4>
					<ul>
						<li><a class="b_lft_3_oven betting" id="id1_704_1" bt_league="네임드 사다리 [조합]" flag="N">
							<span class="divd" id="benefit_704_1"></span>
						</a></li>
						<li style="display:none"><a class="betting" id="t_6893402" bt_league="네임드 사다리 [조합]" flag="{victory.setCheckFlag.tie}">
							<span class="name">undefined</span>
							<span class="divd">0.00</span>
						</a></li>
						<li><a class="b_rgt_3_odd betting" id="id2_704_2" bt_league="네임드 사다리 [조합]" flag="N">
							<span class="divd" id="benefit_704_2"></span>
						</a></li>
						
						<li><a class="b_lft_4_odd betting" id="id1_705_1" bt_league="네임드 사다리 [조합]" flag="N">
							<span class="divd" id="benefit_705_1"></span>
						</a></li>
						<li style="display:none"><a class="betting" id="t_6893403" bt_league="네임드 사다리 [조합]" flag="{victory.setCheckFlag.tie}">
							<span class="name">undefined</span>
							<span class="divd">0.00</span>
						</a></li>
						<li><a class="b_rgt_4_even betting" id="id2_705_2" bt_league="네임드 사다리 [조합]" flag="N">
							<span class="divd" id="benefit_705_2"></span>
						</a></li>

					<div class="bet_disable" style="display: none; color:red;">지금은 베팅을 하실 수 없습니다.</div>							
					</ul>
				</div>
			</div>







		 <%
					'########   리스트 출력을 위해 Where 만들기   ##############

					IF LCase(Game_Type)  = "smp" Then
						GG_TYPE = 0
					ElseIF LCase(Game_Type)  = "handicap" Then
						GG_TYPE = 1
					ElseIF LCase(Game_Type)  = "cross" Then
						GG_TYPE = 2
					ElseIF LCase(Game_Type)  = "real" then
						GG_TYPE = 20
					ElseIF LCase(Game_Type)  = "live" then
						GG_TYPE = 10
					ElseIF LCase(Game_Type)  = "dari" then
						GG_TYPE = 11
					ElseIF LCase(Game_Type)  = "dal" then
						GG_TYPE = 12
					ElseIF LCase(Game_Type)  = "high" then
						GG_TYPE = 13
					ElseIF LCase(Game_Type)  = "aladin" then
						GG_TYPE = 14
					ElseIF LCase(Game_Type)  = "power" then
						GG_TYPE = 15
					ElseIF LCase(Game_Type)  = "mgm" then
						GG_TYPE = 16
					ElseIF LCase(Game_Type)  = "virtuals" then
						GG_TYPE = 17
					ElseIF LCase(Game_Type)  = "bacarat" then
						GG_TYPE = 18
					ElseIF LCase(Game_Type)  = "dice" then
						GG_TYPE = 19
					ElseIF LCase(Game_Type)  = "choice" then
						GG_TYPE = 21
					ElseIF LCase(Game_Type)  = "nine" then
						GG_TYPE = 22
					ElseIF LCase(Game_Type)  = "powers" then
						GG_TYPE = 23
					ElseIF LCase(Game_Type)  = "toms" then
						GG_TYPE = 24
					Else
						GG_TYPE = 1
					End If

					Set Dber = new clsDBHelper

					'########   진행 중인 게임 리스트 출력    ##############

						StrWhere = "(IG_Status = 'S' OR IG_Status = 'E') AND (IG_SITE = ? OR IG_SITE = 'All') "

						IF Sel_Sports <> "" AND Sel_Sports <> "ALL" THEN
							StrWhere = StrWhere & " AND RL_Sports='" & Sel_Sports & "' "
						END IF

						IF Sel_League <> "" THEN
							StrWhere = StrWhere & " AND RL_League='" & Sel_League & "' "
						END IF

						StrWhere = StrWhere & "AND (RL_SPORTS = '공지사항' or rl_sports = '이벤트') "
						'########   진행 중인 스페셜 게임 리스트 출력    ##############

						SQL = "SELECT IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, I7_IDX, IG_CONTENT FROM Info_Game WHERE "&StrWhere&" ORDER BY ig_status desc,IG_STARTTIME ASC, rl_league asc, IG_TEAM1 ASC,ig_type asc"

						reDim param(0)
						param(0) = Dber.MakeParam("@jobsite",adVarWChar,adParamInput,20,JOBSITE)
						Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)


					INPC = sRs.RecordCount


					RL_League1 =  0

					If Not sRs.EOF THEN

						For RE = 1 TO INPC

						IF sRs.EOF THEN
							EXIT FOR
						END IF

						IG_Idx			= sRs(0)
						RL_Idx			= sRs(1)
						RL_Sports		= sRs(2)
						RL_League		= sRs(3)
						RL_Image		= sRs(4)
						RL_Image		= "<img align='absmiddle' src='" & dfSiteUtil.GetLeagueImage(RL_Image) & "' width='20' />"
						IG_StartTime	= sRs(5)
						IG_Team1		= sRs(6)
						IG_Team2		= sRs(7)
						IG_Handicap		= sRs(8)
						IG_Team1Benefit	= sRs(9)
						IG_DrawBenefit	= sRs(10)
						IG_Team2Benefit	= sRs(11)
						IG_Status		= sRs(12)
						IG_Type			= sRs(13)
						IG_VSPoint		= sRs(14)
						IG_Memo			= sRs(15)
						I7_IDX		    = Trim(sRs("I7_IDX"))
						IG_CONTENT      = Trim(sRs("IG_CONTENT"))


						IF isNull(I7_IDX) OR I7_IDX = "0" THEN  I7_IDX = ""
						IF RL_League1 <> RL_League Then

				If rl_sports = "이벤트" And  LCase(Game_Type) = "cross" then
				%> 		 
					<div class="title-name01"><%=RL_Image%>&nbsp; <strong><%=RL_League%></strong></div><!-- League End -->				 <!-- GameRow Start -->	
				<%
				End if
						End If 
				If rl_sports = "이벤트" And LCase(Game_Type) = "cross" then
				%>



		<%		ElseIf rl_sports = "공지사항" then
		%>

		<%
		End if

						'#########3 이전 리그 값을 변수에 담는다.
						RL_League1 = RL_League

						sRs.MoveNext

						NEXT

					END IF

					sRs.close
					Set sRs = Nothing
					Dber.Dispose
					Set Dber = Nothing
				%>
<!--공지사항 끝 -->





		 <%
					'########   리스트 출력을 위해 Where 만들기   ##############

					IF LCase(Game_Type)  = "smp" Then
						GG_TYPE = 0
					ElseIF LCase(Game_Type)  = "handicap" Then
						GG_TYPE = 1
					ElseIF LCase(Game_Type)  = "cross" Then
						GG_TYPE = 2
					ElseIF LCase(Game_Type)  = "real" then
						GG_TYPE = 20
					ElseIF LCase(Game_Type)  = "live" then
						GG_TYPE = 10
					ElseIF LCase(Game_Type)  = "dari" then
						GG_TYPE = 11
					ElseIF LCase(Game_Type)  = "dal" then
						GG_TYPE = 12
					ElseIF LCase(Game_Type)  = "high" then
						GG_TYPE = 13
					ElseIF LCase(Game_Type)  = "aladin" then
						GG_TYPE = 14
					ElseIF LCase(Game_Type)  = "power" then
						GG_TYPE = 15
					ElseIF LCase(Game_Type)  = "mgm" then
						GG_TYPE = 16
					ElseIF LCase(Game_Type)  = "virtuals" then
						GG_TYPE = 17
					ElseIF LCase(Game_Type)  = "bacarat" then
						GG_TYPE = 18
					ElseIF LCase(Game_Type)  = "dice" then
						GG_TYPE = 19
					ElseIF LCase(Game_Type)  = "choice" then
						GG_TYPE = 21
					ElseIF LCase(Game_Type)  = "nine" then
						GG_TYPE = 22
					ElseIF LCase(Game_Type)  = "powers" then
						GG_TYPE = 23
					ElseIF LCase(Game_Type)  = "toms" then
						GG_TYPE = 24
					Else
						GG_TYPE = 1
					End If

					Set Dber = new clsDBHelper

					'########   진행 중인 게임 리스트 출력    ##############
					IF LCase(Game_Type)  <> "special" Then

						SQL = "dbo.UP_RetrieveInfo_GameByUser"

						reDim param(1)
						param(0) = Dber.MakeParam("@gg_type",adInteger,adParamInput,,GG_TYPE)
						param(1) = Dber.MakeParam("@jobsite",adVarchar,adParamInput,20,JOBSITE)
						Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)


					Else
						StrWhere = "(IG_Status = 'S' OR IG_Status = 'E') AND (IG_SITE = ? OR IG_SITE = 'All') "

						IF Sel_Sports <> "" AND Sel_Sports <> "ALL" THEN
							StrWhere = StrWhere & " AND RL_Sports='" & Sel_Sports & "' "
						END IF

						IF Sel_League <> "" THEN
							StrWhere = StrWhere & " AND RL_League='" & Sel_League & "' "
						END IF

						StrWhere = StrWhere & "AND IG_SP = 'Y' and RL_SPORTS <> '실시간' and rl_sports <> '이벤트' "
						'########   진행 중인 스페셜 게임 리스트 출력    ##############

						SQL = "SELECT IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, I7_IDX, IG_CONTENT FROM Info_Game WHERE "&StrWhere&" ORDER BY ig_status desc,IG_STARTTIME ASC, rl_league asc, IG_TEAM1 ASC,ig_type asc"

						reDim param(0)
						param(0) = Dber.MakeParam("@jobsite",adVarWChar,adParamInput,20,JOBSITE)
						Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

					End IF

					INPC = sRs.RecordCount

					GCNT = 0
					RL_League1 =  0

					If Not sRs.EOF THEN

						For RE = 1 TO INPC

						IF sRs.EOF THEN
							EXIT FOR
						END IF

						IG_Idx			= sRs(0)
						RL_Idx			= sRs(1)
						RL_Sports		= sRs(2)
						RL_League		= sRs(3)
						RL_Image		= sRs(4)
						RL_Image		= "<img align='absmiddle' src='" & dfSiteUtil.GetLeagueImage(RL_Image) & "' width='26' />"
						IG_StartTime	= sRs(5)
						IG_Team1		= sRs(6)
						IG_Team2		= sRs(7)
						IG_Handicap		= sRs(8)
						IG_Team1Benefit	= sRs(9)
						IG_DrawBenefit	= sRs(10)
						IG_Team2Benefit	= sRs(11)
						IG_Status		= sRs(12)
						IG_Type			= sRs(13)
						IG_VSPoint		= sRs(14)
						IG_Memo			= sRs(15)
						I7_IDX		    = Trim(sRs("I7_IDX"))
						IG_CONTENT      = Trim(sRs("IG_CONTENT"))


						IF isNull(I7_IDX) OR I7_IDX = "0" THEN  I7_IDX = ""
						IF RL_League1 <> RL_League Then


				%> 		
				
				<%
						End If 
					IF IG_Status = "S" Then	'마감된 경기 리스트
				%>	 
				


			<% IF GCNT = 0 Then
				getGameTime = left(IG_StartTime,10) &" "& FormatDateTime(CDate(IG_StartTime),4) + ":" + Right(IG_StartTime,2)
			
			%> 
				
			<% End If%>











<script>
//	$("#date_mm").html('<%=Replace(Left(dfSiteUtil.GetBetDate(IG_StartTime),5),"/","월 ")%>'+'일');
//	$("#play_num_view").html("<%=Mid(IG_Team1,1,5)%>");
//	$("#id1_<%=RL_Idx%>_1").attr("onclick", "subCartAll(); addCart_live('<%=Session("SD_ID")%>',<%=IG_Idx%>,1,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>'); return false;");
//	$("#benefit_<%=RL_Idx%>_1").html("<%=FORMATNUMBER(IG_Team1Benefit,2)%>");
//	$("#id2_<%=RL_Idx%>_2").attr("onclick", "subCartAll(); addCart_live('<%=Session("SD_ID")%>',<%=IG_Idx%>,2,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>'); return false;");
//	$("#benefit_<%=RL_Idx%>_2").html("<%=FORMATNUMBER(IG_Team2Benefit,2)%>");
//
	$("#date_mm").html('<%=Replace(Left(dfSiteUtil.GetBetDate(IG_StartTime),5),"/","월 ")%>'+'일');
	$("#play_num_view").html("<%=Mid(IG_Team1,1,5)%>");
	$("#id1_<%=RL_Idx%>_1").attr("onclick", "addCart_live('<%=Session("SD_ID")%>',<%=IG_Idx%>,1,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','id1_<%=RL_Idx%>_1'); return false;");
	$("#benefit_<%=RL_Idx%>_1").html("<%=FORMATNUMBER(IG_Team1Benefit,2)%>");
	$("#id2_<%=RL_Idx%>_2").attr("onclick", "addCart_live('<%=Session("SD_ID")%>',<%=IG_Idx%>,2,'<%=Game_Type%>','<%=dfSiteUtil.GetFullDate(IG_StartTime)%>/<%=REPLACE(IG_Team1,"&","")%>:<%=REPLACE(IG_Team2,"&","")%>/<%=IG_Type%>','<%=IG_Handicap%>','id2_<%=RL_Idx%>_2'); return false;");
	$("#benefit_<%=RL_Idx%>_2").html("<%=FORMATNUMBER(IG_Team2Benefit,2)%>");

</script>







	<%
						Else	'배팅가능 경기 리스트
				%>

		<%
		End IF

						'#########3 이전 리그 값을 변수에 담는다.
						RL_League1 = RL_League

						sRs.MoveNext

						Next
				%>
<form  name="BetFrm" target="ProcFrm" method="post" action="Bet_Proc.asp">



<!-- //게임선택 -->
			<!-- 베팅카트 -->
			<div class="ladder_cart">
				<div class="cart_info">
					<ul>
						<li>
							<span>게임분류</span>
							<strong>[파워사다리]</strong>
						</li>
						<li id="selBet">
							<span>게임선택</span>
							<strong>
								<span class="tx" id="cartTable_game"></span>
								<div id="cartTable" style="display:none"></div>
							</strong>
						</li>
						<li id="betRate">
							<span>배당률</span>
							<div id="foreCastDividendPercent"><%=numdel(TotalBenefitRate)%></div>
						</li>
						<li style="display:none">
							<span id="min_price">5000</span>
							<span id="max_price">1000000</span>
							<span id="max_eprice">3,000,000</span>
						</li>
					</ul>
				</div>
				<!-- 금액선택 -->
				<div class="cart_pay">
					<h4 class="hidden">베팅금액선택</h4>
					<div class="bet_money">
						<label for="betExp2">베팅 금액</label>
						<input type="text" id="BetAmount" name="BetAmount" value="0">
					</div>
					<div class="bet_money i_blue">
						<label for="betExp3">적중 금액</label>
						<input type="text" id="TotalBenefit" name="TotalBenefit" value="0" readonly="">
					</div>
					<div class="bet_btn_inner">
								<input type="button" class="btnMoney" money="1000" value="1,000" readonly="readonly" style="cursor: pointer; margin-left: 0px;" onclick="javascript:InputCheck_new(this,'1000');">
								<input type="button" class="btnMoney" money="10000" value="10,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new(this,'10000');">
								<input type="button" class="btnMoney" money="50000" value="50,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new(this,'50000');">
								<input type="button" class="btnMoney" money="100000" value="100,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new(this,'100000');">
								<input type="button" class="btnMoney" money="500000" value="500,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new(this,'500000');">
								<input type="button" class="btnMoney" money="1000000" value="1,000,000" readonly="readonly" style="cursor: pointer;" onclick="javascript:InputCheck_new(this,'1000000');">
								<!--<input type="button" class="i_blue" value="잔돈" onclick="">-->
								<input type="button" class="i_brw" value="올인" id="btnMax" style="cursor: pointer;" onclick="maxvalue(this);">
								<input onclick="javascript:InputCheck_new(this,'0');" type="button" class="i_gray" value="초기화" id="btnMoneyClear" style="cursor: pointer;">
								<!--
								<div class="bet_money_free">
									<label for="betExp4">직접입력</label>
									<input type="text" name="betExp4" value="0" onkeyup="selectAmountDirect(this.value)">
								</div>
								-->
					</div>
					<input type="button" value="베팅하기" id="btnBett" class="btn_bet" style="cursor: pointer;" onclick="BetChk()">
					<div class="bet_disable" style="display: none; color:red;">지금은 베팅을 하실 수 없습니다.</div>
				</div>
			</div>
			<!-- //베팅카트 -->
		</div>

		<!--베팅내역
		<div id="wrapper_result">
			<iframe name="resultname" scrolling = "no" src="/result_in_game.asp?bt_type=6&pagesize=5" id="resultname"></iframe>
		</div>
		-->

		<div class="ladder_notice">
			<h4>알아두세요</h4>
			<ul>
				<li>· 파워사다리 회차는 오전 0시 기준으로 회차가 초기화 됩니다.</li>
				<li>· 한번 베팅한 게임은 베팅취소 및 베팅수정이 불가합니다.</li>
				<li>· 베팅은 본인의 보유 예치금 기준으로 베팅 가능하며, 추첨결과에 따라 명시된 배당률 기준으로 적립해드립니다.</li>
				<li>· 부적절한 방법(ID도용, 불법프로그램, 시스템 베팅 등)으로 베팅을 할 경우 무효처리되며, 전액몰수/강제탈퇴 등 불이익을 받을 수 있습니다.</li>
				<li>· 파워사다리 게임의 모든 배당률은 당사의 운영정책에 따라 언제든지 상/하향 조정될 수 있습니다.</li>
				<li>· 본 서비스는 뉴트리 파워사다리게임 결과를 기준으로 정산처리됩니다.</li>
				<li>· 본 서비스는 당사의 운영정책에 따라 조기 종료되거나 이용이 제한될 수 있습니다.</li>
			</ul>
		</div>

		</div>
		</div>
	</div> <!-- sub-content -->
				<%
					ELSE
				%>
			<div class="ladder_cart">
				<div style="bottom:0;left:0;right:0;font-size:30px;text-align:center;color:white;background:rgba(0,0,0,0.7);height:323px;">
					<div style="top: 20px; color: white;">해당회차는 마감되었습니다</br>새로운회차가 진행되면 아래 새로고침 버튼을 누르세요</div>
					<button type="button" class="btn_refresh" onclick="location.reload();"><font color="white">새로고침</font></button>
				</div>
			</div>
		</div>
		<div class="ladder_notice">
			<h4>알아두세요</h4>
			<ul>
				<li>· 파워사다리 회차는 오전 0시 기준으로 회차가 초기화 됩니다.</li>
				<li>· 한번 베팅한 게임은 베팅취소 및 베팅수정이 불가합니다.</li>
				<li>· 베팅은 본인의 보유 예치금 기준으로 베팅 가능하며, 추첨결과에 따라 명시된 배당률 기준으로 적립해드립니다.</li>
				<li>· 부적절한 방법(ID도용, 불법프로그램, 시스템 베팅 등)으로 베팅을 할 경우 무효처리되며, 전액몰수/강제탈퇴 등 불이익을 받을 수 있습니다.</li>
				<li>· 파워사다리 게임의 모든 배당률은 당사의 운영정책에 따라 언제든지 상/하향 조정될 수 있습니다.</li>
				<li>· 본 서비스는 뉴트리 파워사다리게임 결과를 기준으로 정산처리됩니다.</li>
				<li>· 본 서비스는 당사의 운영정책에 따라 조기 종료되거나 이용이 제한될 수 있습니다.</li>
			</ul>
		</div>

		</div>
		</div>
	</div> <!-- sub-content -->						  
				<%
					END IF

					sRs.close
					Set sRs = Nothing
					Dber.Dispose
					Set Dber = Nothing
				%>
<script type="text/javascript">

var g_now_datetime = undefined;
var g_end_time = 4;
var g_countdown_time = 0;
var g_refresh_count = 0;

function countdown()
{
	g_now_datetime.add(1, 'seconds');
	$('#date_hh').text(("0" + g_now_datetime.hour()).slice(-2));
	$('#date_ii').text(("0" + g_now_datetime.minute()).slice(-2));
	$('#date_ss').text(("0" + g_now_datetime.seconds()).slice(-2));
	
//H	var minutes = ("0" + (parseInt(g_countdown_time / 60))).slice(-2);
	var minutes = ("0" + (parseInt(g_countdown_time / 60))).slice(-2);
	var seconds = ("0" + (parseInt(g_countdown_time % 60))).slice(-2);
	$("#remaind_time").text(minutes  + ":" + seconds);

	

	g_countdown_time--;
//H 디버깅코드 삽입-------------------시작
//	$('#dibugHber').prepend('<li>'+g_countdown_time+' | '+g_end_time+' | '+g_refresh_count + '</li>');
//	if (g_countdown_time < 200) {
//	}
//H 디버깅코드 삽입-------------------끝


	//HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
	//H 마감이후에 버튼 클릭 안되게 수정
	if (g_countdown_time > 239) {
	//다음회차인거로 
		$('#play_num_view').css('color','#FFFF00').css('font-weight','bold').css('text-shadow','2px 2px 2px #555');
		
	}else{
		$('#play_num_view').css('color','#ffce25').css('font-weight','bold').css('text-shadow','2px 2px 2px #555');
	}

	if (g_countdown_time < 0) {
		g_countdown_time = 0;
		if (++g_refresh_count >= 100) {
			location.reload();
		}
	}	
	setTimeout(countdown, 1000);
}

(function () {
	$(".btnMoney").attr('readonly', 'readonly');
	for (var i = 0; i < 1; i++)
	{
		var home_id = "";
		var tie_id = "";
		var away_id = "";
		var d = new Date();
		
		if (i == 0) {
			$('.bet_disable').hide();
			g_now_datetime = moment(getTimeStamp().replace("_", " "));
			var bt_stime = moment("<%=getGameTime%>");


			
			//$('#date_mm').text(g_now_datetime.month() + 1);
			//$('#date_dd').text(g_now_datetime.date());
			
			var duration = moment.duration(bt_stime.diff(g_now_datetime));
			g_countdown_time = duration.asSeconds();
			
			
			if (g_countdown_time < 0) {
				$('#remaind_time').text("00:00");
				$('.bet_disable').show();
			} else {
				var minutes = ("0" + (parseInt(g_countdown_time / 60))).slice(-2);
				var seconds = ("0" + (parseInt(g_countdown_time % 60))).slice(-2);
				$('#remaind_time').text(minutes + ":" + seconds);
			}
			setTimeout(countdown, 1000);
		}
	}
})();
function getTimeStamp() {
  var d = new Date();
  var s =
    leadingZeros(d.getFullYear(), 4) + '-' +
    leadingZeros(d.getMonth() + 1, 2) + '-' +
    leadingZeros(d.getDate(), 2) + ' ' +

    leadingZeros(d.getHours(), 2) + ':' +
    leadingZeros(d.getMinutes(), 2) + ':' +
    leadingZeros(d.getSeconds(), 2);

  return s;
}

function getTimeStamp2(da) {
var d = new Date();
d = da;
  var s =
    leadingZeros(d.getFullYear(), 4) + '-' +
    leadingZeros(d.getMonth() + 1, 2) + '-' +
    leadingZeros(d.getDate(), 2) + ' ' +

    leadingZeros(d.getHours(), 2) + ':' +
    leadingZeros(d.getMinutes(), 2) + ':' +
    leadingZeros(d.getSeconds(), 2);

  return s;
}

function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}


</script>
<!-- #include file="../_Inc/right.inc_dari.asp" -->
</form>
<script>
$(function () {

  var msie6 = $.browser == 'msie' && $.browser.version < 7;

  if (!msie6) {
	var top = $('#comment').offset().top - parseFloat($('#comment').css('margin-top').replace(/auto/, 0));
	$(window).scroll(function (event) {
	  // what the y position of the scroll is
	  var y = $(this).scrollTop();

	  // whether that's below the form
	  if (y >= top) {
		// if so, ad the fixed class
		$('#comment').addClass('fixed');
	  } else {
		// otherwise remove it
		$('#comment').removeClass('fixed');
	  }
	});
  }
});
</script>
<script type="text/javascript">
	function del_all() {
		$("#betting_cartbox").find(".btnBettDel").each(function() {
			$(this).trigger("click");
		});
	}
	var moving_stat = 1; // 메뉴의 스크롤을 로딩시 on/off설정 1=움직임 0은 멈춤
	function moving_control() {
		if(!moving_stat){ 
			moving_stat = 1;
		}
		else{ 
			moving_stat = 0; 
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
</script>


<script>



	
	$("#sub-content").delegate("a.betting", "mouseenter mouseleave mousedown click", function (e) {

		var obj = this;
		switch (e.type) {
		case "mouseenter":
			if ($(this).text() !== "-" && $(this).text() !== "VS" && $(this).attr("flag") !== "N") {
				$(this).addClass("btn-mouseenter");
			}
			break;
		case "mouseleave":
			$(this).removeClass("btn-mouseenter");
			break;
		case "focus":
			this.blur();
			break;
		case "click":
			this.blur();
			if ($(obj).attr("flag") != "Y") {
				if ($(this).hasClass("btn-mouseclick") === false) {

					$(".btn-mouseclick").removeClass("btn-mouseclick");
					$(this).addClass("btn-mouseclick");

				} else { // 베팅해제
					$(this).removeClass("btn-mouseclick");
				
				}
			}
			break;
		} // switch-case
	});

 </script>

 									</tbody>
									</table>
								</td>
								<td width="29" align="center" valign="top" background="/images/cross/bg_contents_R.jpg"><img src="/images/cross/bg_contents_R2.jpg" width="29" height="6"></td>
								<td bgcolor="#1C1C1C">&nbsp;</td>
							</tr>

						</tbody>
						</table>
					</td>
				</tr>
			</tbody>
			</table>
