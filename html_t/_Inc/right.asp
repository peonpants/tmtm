

	<div style="width:237px;height:245px;background:url(/images/infobox_grey3.png); no-repeat left top; margin-left: 1px; position: absolute;">
	<table width="237" cellpadding="0" cellspacing="0" border="0">
		<tbody><tr><td height="6"></td>
		</tr>
		<tr>
			<td height="68" valign="top">
			
				<div style="width:42%;float:left;">
					<div style="padding-left:10px;padding-top:16px;font-family:&#39;notokr-regular&#39;;color:#fff;letter-spacing:-1px;font-size:13px;text-shadow:1px 1px 0px rgba(0,0,0,0.4);">
						<span style="color:#fff600;font-family:&#39;notokr-regular&#39;"><img src="/images/level/<%=IU_LEVEL%>.png" align="absmiddle"> &nbsp;</span>&nbsp;&nbsp;<%=Session("IU_NickName")%>
					</div>
				</div>
				<div style="width:58%;float:right;">
					<div style="text-align:right;padding-right:10px;padding-top:13px;font-family:&#39;quicksand&#39;;font-size:20px;font-weight:400;color:#fff600;"><span style="font-size:15px;">￦</span><%=formatnumber(IU_Cash,0)%></div>
					<div style="text-align:right;padding-right:12px;font-family:&#39;notokr-regular&#39;;color:#fff;letter-spacing:-1px;font-size:12px;text-shadow:1px 1px 0px rgba(0,0,0,0.4);">회원님의 현재잔액</div>
				</div>
			
			</td>
		</tr>
		<tr>
			<td height="27">
				<a href="/support/answer_list.asp"><div style="width:50%;text-align:center;float:left;" class="text01"><span style="color:#ff8888;font-family:&#39;notokr-regular&#39;;">
<%
    
    TINPUT = 0 
    
    IF SESSION("SD_ID") <> "" Then
	    Set Dber = new clsDBHelper
	    SQL = "dbo.UP_CheckMemoAlramByUser "
    	
	    reDim param(1)
	    param(0) = Dber.MakeParam("@iu_id",adVarWChar,adParamInput,20,Session("SD_ID"))
	    param(1) = Dber.MakeParam("@jobsite",adVarWChar,adParamInput,20,JOBSITE)
	    
	    Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
	    If Not sRs.eof then
		    TINPUT = CDBL(sRs(0))
	    End If 
	    
	    sRs.close
	    Set sRs = Nothing
	    Dber.Dispose
	    Set Dber = Nothing 
    End IF	
%>
<%=TINPUT%>
<% IF TINPUT > 0 THEN %><embed id=player src="/mid/i_memo.swf" autostart=true hidden=true loop=false type="audio/swf"><% END IF %>)</span>
					<span class="text-gray" >개</span><font color="white">의 새로운 쪽지</div></a>
				<a href="/login/logout_proc.asp"><div style="width:50%;text-align:center;float:right" class="text01" onclick="location.href='/login/logout_proc.asp'"><font color="white">로그아웃</div></a>
			</td>
		</tr>
		<tr>
			<td height="62" valign="top">
				<div style="width:100%;padding-top:12px;text-align:center;float:right;;font-family:&#39;quicksand&#39;;font-size:20px;font-weight:400;color:#97beff;" id="mb_mileage"><font color="white"><%=formatnumber(IU_Point,0)%></div>
			</td>
		</tr>
		<tr>
			<td height="27" valign="top">
				<a href="/money/charge.asp"><div style="padding-top:5px;width:33.3%;text-align:center;float:left" class="text01"><font color="white">충전신청</div></a>
				<a href="/money/exchange.asp"><div style="padding-top:5px;width:33.3%;text-align:center;float:left" class="text01"><font color="white">환전신청</div></a>
				<div style="padding-top: 5px; width: 33.3%; text-align: center; float: left; cursor: pointer;" class="text01 PointChange" onclick="FrmChk2()"><font color="white">포인트전환</div>
			</td>
		</tr>
		<tr>
			<td height="69" valign="top">
				<a href="/member/mybet.asp"><div style="padding-top:40px;width:33.3%;text-align:center;float:left" class="text02"><font color="white">베팅내역</div></a>
				<a href="/game/betresult.asp"><div style="padding-top:40px;width:33.3%;text-align:center;float:left" class="text02"><font color="white">경기결과</div></a>
				<a href="/member/myrecom.asp"><div style="padding-top:40px;width:33.3%;text-align:center;float:left;" class="text02"><span style="padding-right:7px;font-family:&#39;notokr-regular&#39;"><font color="white">추천인내역</span></div></a>
			</td>
		</tr>
	</tbody></table>	
</div>
			