<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<!-- #include file="../_Inc/clock.asp" -->

<%
  mainPage = True
  SETSIZE = 50
  PGSIZE = 50

  PAGE = dfSiteUtil.F_initNumericParam(dfRequest.Value("PAGE")  ,1,1,2147483647)
  
  IF REQUEST("PAGE") = "" THEN
      PAGE = 1
      STARTPAGE = 1
  ELSE
      PAGE = CINT(REQUEST("PAGE")) 
      STARTPAGE = INT(PAGE/SETSIZE)

      IF STARTPAGE = (PAGE/SETSIZE) THEN
          STARTPAGE = PAGE-SETSIZE + 1
      ELSE
          STARTPAGE = INT(PAGE/SETSIZE) * SETSIZE + 1
      END IF
  END IF
  '########   Where 셋팅    ##############
  SQLR = " Info_Betting WHERE IB_ID = '"&Session("SD_ID") & "' AND IB_SITE = '"& JOBSITE &"' AND IB_DEL = 'N' AND IB_REGDATE >= dateadd(day,-14,getdate())"


  Set Dber = new clsDBHelper
  Dim boolBET_CANCEL  
  Dim boolBET_CANCEL1 , boolBET_CANCEL2
  boolBET_CANCEL = False

  '######## 배팅 취소 가능자인지 체크     ######################
  IF BETTING_CANCEL Then
      SQL = "UP_GetINFO_BETTING_CANCEL"
        reDim param(1)
      param(0) = Dber.MakeParam("@IBC_ID",adVarWChar,adParamInput,20,SESSION("SD_ID"))
      param(1) = Dber.MakeParam("@DATE_TERM",adInteger,adParamInput,,BETTING_CANCEL_DATE_TERM) '시간값
      
      Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
        
        IF sRs.Eof Then   
            boolBET_CANCEL = True
        Else
           
            IF cInt(sRs("IBC_CNT")) < BETTING_CANCEL_COUNT Then
                boolBET_CANCEL = True
            End IF
        End IF
      SET sRs = NOTHING
    End IF
    
    SQL = "SELECT COUNT(*) AS TN From "& SQLR &""
    Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)

    TN = CDBL(sRs(0))
    sRs.CLOSE
    SET sRs = Nothing

    PGCOUNT = INT(TN/PGSIZE)
    IF PGCOUNT * PGSIZE <> TN THEN 
        PGCOUNT = PGCOUNT+1
    END IF


    START_ROWNUM  = CINT(CINT(CINT(PGSIZE) * CINT(CINT(PAGE) -1)) + 1)
    END_ROWNUM    = CINT(CINT(PGSIZE) * CINT(PAGE))

    SET sRs=Server.CreateObject("ADODB.Recordset") 
    sRs.CursorType=1
        
    SQL = "SELECT TOP " & PGSIZE & " IB_IDX, IB_TYPE, IG_IDX, IB_NUM, IB_BENEFIT, IB_AMOUNT, IB_STATUS, IB_REGDATE FROM "& SQLR &" AND IB_IDX NOT IN (SELECT TOP " & ((PAGE - 1) * PGSIZE)   & " IB_IDX  FROM "& SQLR &" ORDER BY  IB_RegDate DESC ) ORDER BY IB_RegDate DESC"

    Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

    IF NOT sRs.EOF THEN
        NEXTPAGE = CINT(PAGE) + 1
        PREVPAGE = CINT(PAGE) - 1
        NN = TN - (PAGE-1) * PGSIZE
    ELSE
        TN = 0
        PGCOUNT = 0
    END If
%>  
<script type="text/javascript">
  function goDel(IB_IDX, IB_STATUS)
  {
    var answer = confirm("삭제하시겠습니까?")
    if (answer){
      location.href="/game/Del_Bet.asp?IB_IDX="+IB_IDX+"&Page=<%=Page%>&Search=<%=Search%>&Find=<%=Find%>&b1=" + IB_STATUS;
    }
    return false;
  }
  <% IF BETTING_CANCEL Then %>
  var submitted = false;
  function goCancel(IB_IDX)
  {
    if(submitted == true) { return false; }
    var answer = confirm("배팅을 취소 하시겠습니까?")
    if (answer){
      location.href="/game/Cancel_Bet.asp?IB_IDX="+IB_IDX+"&Page=<%=Page%>&Search=<%=Search%>&Find=<%=Find%>";
    submitted = true;
    }
    return false;
  }
  <% End IF %>
  function goBoard(IB_IDX, NN)
  {
    var answer = confirm("게시판으로 이동하시겠습니까?")
    if (answer){
      location.href="/freeboard/Board_Write.asp?IB_IDX="+IB_IDX+"&NN="+NN+"&Page=<%=Page%>&Search=<%=Search%>&Find=<%=Find%>";
    }
    return false;
  }
  function goSupport(IB_IDX, NN)
  {
    var answer = confirm("고객센터로 이동하시겠습니까?")
    if (answer){
      location.href="/support/Answer_Write.asp?IB_IDX="+IB_IDX+"&NN="+NN+"&Page=<%=Page%>&Search=<%=Search%>&Find=<%=Find%>";
    }
    return false;
  }
  function goBoardMuty()
  {
    var cnt = 0 ;
    var arrIB_IDX ="";
    var arrNN ="";
    for(var i = 0;i<document.getElementsByName("betNum").length;i++)
    {
        if(document.getElementsByName("betNum")[i].checked)
        {
            if(cnt != 0 ) arrIB_IDX += "," ;
            if(cnt != 0 ) arrNN += "," ;
            arrIB_IDX += document.getElementsByName("betNum")[i].value.split("|")[0] ;
            arrNN += document.getElementsByName("betNum")[i].value.split("|")[1] ;
            cnt++;    
        }                   
    }
    if(cnt == 0 )
    {
        alert("베팅내역을 1개이상 선택하세요.");
    }
    else
    {    
      var answer = confirm("게시판으로 이동하시겠습니까?")
      if (answer){
        location.href="/freeboard/Board_Write.asp?arrIB_IDX="+arrIB_IDX+"&arrNN="+arrNN+"&Page=<%=Page%>&Search=<%=Search%>&Find=<%=Find%>";
      }      
    }               
  }

  function goDel1()
  {
    var cnt = 0 ;
    var arrIB_IDX ="";
    var arrNN ="";
    for(var i = 0;i<document.getElementsByName("betNum").length;i++)
    {
        if(document.getElementsByName("betNum")[i].checked)
        {
            if(cnt != 0 ) arrIB_IDX += "," ;
            if(cnt != 0 ) arrNN += "," ;
            arrIB_IDX += document.getElementsByName("betNum")[i].value.split("|")[0] ;
            arrNN += document.getElementsByName("betNum")[i].value.split("|")[1] ;
            cnt++;    
        }                   
    }
    if(cnt == 0 )
    {
        alert("각 베팅내역의 경기일시 옆 체크박스를 클릭하시면 다수의 배팅내역 삭제가 가능합니다");
    }
    else
    {    
      var answer = confirm("선택 삭제를 하시겠습니까?")
      if (answer){
        location.href="/game/Del_Bet2.asp?IB_IDX="+arrIB_IDX+"&arrNN="+arrNN+"&Page=<%=Page%>&Search=<%=Search%>&Find=<%=Find%>";
      }      
    }      
          
  }

  function goDel2(IB_IDX)
  {
    var answer = confirm("전체 삭제를 하시겠습니까?")
    if (answer){
     location.href="/game/Del_Bet3.asp?Page=<%=Page%>&Search=<%=Search%>&Find=<%=Find%>";
    }
    return false;
  }
</script>
<style>

</style>
<div id="wrap">
	<div id="subwrap">
		<div class="subbody" style="">
			<div id="sub-content">
<div class="game_view dark_radius game_title white">
  베팅내역 <span>BETTING LIST</span>
</div>
<%  
IF TN = 0 THEN
%>
<%  
ELSE
    Dim txttotalIBD_RESULT(9)
        txttotalIBD_RESULT(0) = "<font color='00a2ff'>실패</font>"
        txttotalIBD_RESULT(1) = "<font color='red'>적중</font>"
        txttotalIBD_RESULT(2) = "1배처리"
        txttotalIBD_RESULT(3) = "1배처리"
        txttotalIBD_RESULT(9) = "진행중"
    FOR ii = 1 TO PGSIZE
        IB_IDX1             = 0 
        BenefitAmount       = 1
        BenefitAmountA      = 1
        TotalBenefit        = 1
        TotalBenefitA       = 1
        totalIBD_RESULT     = 5 '0  : 실패, 1  : 성공, 2 : 취소, 3 : 적중특례 , 5 : 진행중 , 9 : 진행중   
         
        IF sRs.EOF THEN
            EXIT FOR
        END IF
        IB_IDX    = sRs(0)
        IB_TYPE   = sRs(1)
        IG_IDX    = sRs(2)
        IB_NUM    = sRs(3)
        IB_BENEFIT  = sRs(4)
        IB_AMOUNT = sRs(5)
        IB_STATUS = sRs(6)
        IB_REGDATE  = sRs(7)

        'able to cancel?
        boolBET_CANCEL2 = True
        IF boolBET_CANCEL AND cStr(IB_STATUS) = "0" Then

          boolBET_CANCEL1 = False
            SQL = "UP_GetINFO_BETTING_DATE"
            reDim param(2)
            param(0) = Dber.MakeParam("@IB_Idx",adInteger,adParamInput, ,IB_IDX)
            param(1) = Dber.MakeParam("@DATE_TERM",adInteger,adParamInput, ,BETTING_CANCEL_TERM)
            param(2) = Dber.MakeParam("@IB_ID",adVarWChar,adParamInput,20,SESSION("SD_ID"))
            Set sRs2 = Dber.ExecSPReturnRS(SQL,param,nothing)
            IF NOT sRs2.Eof Then
                boolBET_CANCEL1 = True
            Else
                boolBET_CANCEL1 = False
            End IF
            SET sRs2 = NOTHING
        End IF        
%>

<table class="bettingtable01">
  <caption class="hidden">스페셜</caption>
  <colgroup>
    <col width="11%"><col width="13%"><col width="28%"><col width="6%"><col width="28%"><col width="7%"><col width="6%">
  </colgroup>
    <tr>
      <th scope="col" style="font-size: 11px;">경기일시</th>
      <th scope="col" style="font-size: 11px;">리그</th>
      <th scope="col" style="font-size: 11px;">[승]홈팀</th>
      <th scope="col" style="font-size: 11px;">무/기</th>
      <th scope="col" style="font-size: 11px;">[패]원정팀</th>
      <th scope="col" style="font-size: 11px;">결과</th>
      <th scope="col" style="font-size: 11px;">정보</th>
    </tr>
</table>
<%
  iii=0
  SQL =  "UP_RetrieveINFO_BETTING_DETAILByPreview"
  reDim param(0)
  param(0) = Dber.MakeParam("@IB_Idx",adInteger,adParamInput, ,IB_Idx)
    
  Set sRs2 = Dber.ExecSPReturnRS(SQL,param,nothing)
  NOTC = sRs2.RecordCount
  IF NOT sRs2.Eof Then
    For j = 0 to NOTC - 1
        
      IG_IDX    = sRs2("IG_IDX")
      RL_League   = sRs2("RL_League")
      RL_IMAGE    = sRs2("RL_IMAGE")    
      RL_Image    = "<img align='absmiddle' src='" & dfSiteUtil.GetLeagueImage(RL_Image) & "' width='26' />"
      IG_Team1    = sRs2("IG_Team1")
      IG_Team2    = sRs2("IG_Team2")
      IG_Status   = sRs2("IG_Status")
      IG_Result   = sRs2("IG_Result")
      IG_StartTime  = sRs2("IG_StartTime")
      IG_Team1Benefit = sRs2("IG_Team1Benefit")
      IG_DrawBenefit  = sRs2("IG_DrawBenefit")
      IG_Team2Benefit = sRs2("IG_Team2Benefit")
      IG_Score1   = sRs2("IG_Score1")
      IG_Score2   = sRs2("IG_Score2")
      IG_Type     = sRs2("IG_Type")
      IG_Handicap   = sRs2("IG_Handicap")
      IG_Draw       = sRs2("IG_Draw")
      IBD_NUM         = sRs2("IBD_NUM")
      IBD_RESULT      = sRs2("IBD_RESULT")
      IBD_RESULT_BENEFIT = sRs2("IBD_RESULT_BENEFIT")
      IBD_BENEFIT = sRs2("IBD_BENEFIT")
    
      IG_Result = Trim(IG_Result)
      
      df = DATEDIFF("s",now(),Cdate(IG_StartTime))
      
      IF boolBET_CANCEL2 AND CDBL(df) < 0 Then  boolBET_CANCEL2 = False
      IF (IG_Status = "E") OR (IG_Status = "S") Then IG_Result = 3
      IF IG_Type <> "0" THEN IG_DrawBenefit = IG_Handicap

      IF IG_Type = "1" Then
          txtIG_Type  = "핸디캡"   
          IG_DRAWBENEFIT =  IG_HANDICAP
      ElseIF IG_Type = "2" Then
          txtIG_Type  = "오버/언더"  
          IG_DRAWBENEFIT =  IG_HANDICAP  
      Else
          txtIG_Type  = "승무패"    
      End IF
      
      IF IBD_NUM = "1" Then
          choice  = "승"    
      ElseIF IBD_NUM = "0" Then
          choice  = "무"    
      ElseIF IBD_NUM = "2" Then
          choice  = "패"    
      End IF
      iii = iii+1

      IF IBD_RESULT = "0" Then    
          txtIBD_RESULT = "<font color='00a2ff'>실패</font>"
      ElseIF IBD_RESULT = "1" Then
           txtIBD_RESULT = "<font color='red'><b>적중</b></font>"
      ElseIF IBD_RESULT = "2" Then
          txtIBD_RESULT = "<font color='F35000'><b>취소</b></font>"
      ElseIF IBD_RESULT = "3" Then
          txtIBD_RESULT = "<font color='F35000'><b>적특</b></font>"
      Else
          txtIBD_RESULT = "<font color=chartreuse>진행</font>"
      End IF
      
      IF IBD_RESULT_BENEFIT = 1 Then IG_Result = 4                    
      SCORE = IG_SCORE1 & " : " & IG_SCORE2
      
      '#### 진행 중인지 체크한다.
      IF IBD_RESULT = 9  Then
         totalIBD_RESULT = 9 
         IBD_RESULT_BENEFIT = IBD_BENEFIT
      End IF           
      TotalBenefit = Cdbl(TotalBenefit) * Cdbl(IBD_RESULT_BENEFIT)
      TotalBenefitA = Cdbl(TotalBenefitA) * Cdbl(IBD_BENEFIT)                        
%>
<table class="bettingtable01"> <!-- loop -->
  <colgroup>
    <col width="11%"><col width="13%"><col width="29%"><col width="6%"><col width="29%"><col width="7%"><col width="6%">
  </colgroup>
  <tr>
    <td colspan="7" style="padding: 4px 0;"></td></tr><tr class="betting-active">
      <td class="bt_stime"><%=dfSiteUtil.GetBetDate(IG_StartTime)%></td>
    <td class="league"><%=RL_Image%> <strong><%=RL_League%></strong></td>
    <td><a class="tleft-btn <% If IBD_NUM = 1 Then %>tleft-btn03<% Else %><% End If %>" bgcolor="#707018"><span class="team-l"><%=IG_Team1%></span><span class="point-r"><%=FORMATNUMBER(IG_Team1Benefit,2)%></span></a></td>
    <td style="text-align: center;"><a class="tcenter-btn" bgcolor="">VS</a></td>
    <td><a class="tright-btn <% If IBD_NUM = 2 Then %>tright-btn03<% Else %><% End If %>" bgcolor=""><span class="point-l"><%=FORMATNUMBER(IG_Team2Benefit,2)%></span><span class="team-r"><%=IG_Team2%></span></a></td>
    <td nowrap=""><span style="display:block;text-align:center;color:#000;font-weight:bold;font-size:12px;letter-spacing:-1px">0:00분후</span></td>
    <td style="text-align:center;font-size:12px;letter-spacing:-1px"><%= txtIBD_RESULT %></td>
  </tr>
  <tr>
    <td colspan="7" style="padding: 4px 0;"></td>
  </tr>
  <%
      sRs2.MoveNext    
    NEXT
  End IF

  BenefitAmount = Cdbl(IB_Amount)  * CDbl(dfSiteUtil.numdel2(TotalBenefit*100))/100         
  BenefitAmountA = Cdbl(IB_Amount)  * CDbl(dfSiteUtil.numdel2(TotalBenefit*100))/100
  
  IF Cdbl(TotalBenefit) = 1 Then
      totalIBD_RESULT = 2
      resultBgColor1 = "cartno"
  ElseIF Cdbl(TotalBenefit) = 0 Then                
      totalIBD_RESULT = 0
      resultBgColor1 = "failGame"
  Else                    
    IF Cdbl(totalIBD_RESULT) = 9 Then               
        totalIBD_RESULT = 9 
        resultBgColor1 = "cartno"
    Else
        totalIBD_RESULT = 1 
        resultBgColor1 = "cartyes"
    End IF                    
  End IF

  II_PLUS_DR = ""
  II_SAVE_DR = ""
  II_TYPE = ""
  II_SA = ""

  SET sRs4=Server.CreateObject("ADODB.Recordset") 
  SQLLIST = "SELECT * FROM INFO_item where ib_idx='"& IB_Idx  &"'"
  Set sRs4 = Dber.ExecSQLReturnRS(SQLLIST,nothing,nothing)

  if Not sRs4.eof then
  II_PLUS_DR = sRs4("II_PLUS_DR") 
  II_SAVE_DR = sRs4("II_SAVE_DR") 
  II_TYPE = sRs4("II_TYPE") 
  II_SA = sRs4("II_SA") 
  end if
  sRs4.CLOSE
  SET sRs4 = NOTHING

  if II_type = "IP" and II_PLUS_DR = "5" then
  TotalBenefit = TotalBenefit * 1.05
    BenefitAmountA = Cdbl(IB_Amount)  * CDbl(dfSiteUtil.numdel2((TotalBenefit*1.05)*100))/100
  end if
  if II_type = "IP" and II_PLUS_DR = "10" then
  TotalBenefit = TotalBenefit * 1.1
    BenefitAmountA = Cdbl(IB_Amount)  * CDbl(dfSiteUtil.numdel2((TotalBenefit*1.1)*100))/100
  end if

  if II_type = "ISA" and II_SA <> "" then
    SET sRs5=Server.CreateObject("ADODB.Recordset") 
    SQLG = "select * from info_game where ig_idx='"& II_SA  &"'"
    Set sRs5 = Dber.ExecSQLReturnRS(SQLG,nothing,nothing)

    if Not sRs5.eof then
    ISA_GNAME = sRs5("ig_team1") 
    end if
  end if
%>
  <tr>
    <td colspan="4" style="padding: 4px 4px 4px 14px;background: #082435;border-top: 1px solid #111;border-bottom: 1px solid #111;font-family:tahoma;color:#fff;">
      배당율 : <span style="color:#FBD504;"><%=FORMATNUMBER(TotalBenefit,2)%></span>/ 베팅금액 : <span style="color:#FBD504;"><%=FormatNumber(IB_AMOUNT,0)%></span> 원/ 예상적중금액 : <span style="color:#FBD504;"><%=FormatNumber(BenefitAmountA,0)%></span> 원
    </td>
    <td colspan="4" style="text-align: right;padding: 4px 12px 4px 2px;background: #082435;border-top: 1px solid #111;border-bottom: 1px solid #111;;font-family:tahoma;color:#fff">&nbsp;<span>베팅날짜 : <span> <%=dfSiteUtil.GetFullDate(IB_REGDATE)%></span> </span> <input type="checkbox" name="betNum" style="margin-left: 12px;" value="<%= IB_IDX %>|<%= NN %>"> 
    <% IF BETTING_CANCEL AND boolBET_CANCEL1 AND boolBET_CANCEL2 Then %>
      <input type="button" value="베팅취소" class="btn btn-danger btn-xs select btnCancel input_bg" style="height:29px" onclick="goCancel(<%=IB_IDX%>)"><% End IF %>
    </td>
  </tr>
  <tr>
    <td colspan="7" style="padding: 12px 0;background:#fff;"></td>
  </tr>
</table> <!-- loop end -->
<%                        
      BenefitAmount       = 1
      BenefitAmountA      = 1
      TotalBenefit        = 1
      TotalBenefitA       = 1
      totalIBD_RESULT     = 5
      NN = NN - 1 
      sRs.MoveNext
      Next 
    sRs2.Close
    Set sRs2 = Nothing    
  END IF 
  sRs.Close
  Set sRs = Nothing
%>

<div class="btn_bx">
  <a href="javascript:goBoardMuty();" class="btna_02 bbs_copy" ><span>베팅내역첨부</span></a>
  <div class="stitle_btn btna_02" onclick="goDel2()">베팅내역 전체삭제</div>
</div>

<div class="page_box">
  <div id="paging">
    <img src='/images/mybet/page_begin.gif' align='absmiddle' style='cursor:hand' onclick="javascript:window.self.location.href='MyBet.asp?PAGE=1'">&nbsp;
<%  
  IF STARTPAGE = 1 THEN
    Response.Write "<img src='/images/mybet/page_prev.gif'  align='absmiddle'> &nbsp;"
  ELSEIF STARTPAGE > SETSIZE THEN
    Response.Write "<img src='/images/mybet/page_prev.gif' align='absmiddle' style='cursor:hand' onclick=javascript:window.self.location.href='MyBet.asp?PAGE="&STARTPAGE-SETSIZE&"'>&nbsp;"
  END IF 
%>
&nbsp;  
<%  FOR i = STARTPAGE TO SETSIZE + STARTPAGE - 1

  IF i > PGCOUNT THEN
    EXIT FOR
  END IF

  IF PAGE = i THEN
    Response.Write " <a class='now' href=MyBet.asp?PAGE="&i&" >"& i & "</a>&nbsp;"
  ELSE
    Response.Write " <a class='rest' href=MyBet.asp?PAGE="&i&" >"& i & "</a>&nbsp;"
  END IF

NEXT 
%>
&nbsp;  
<%  
  IF PGCOUNT < SETSIZE  THEN '현재 페이지가 페이지 셋크기보다 적거나 페이지리스트가 전체페이지보다 적으면
    Response.write "<img src='/images/mybet/page_next.gif'  align='absmiddle'>"
  ELSEIF i > PGCOUNT THEN
     Response.write "<img src='/images/mybet/page_next.gif'  align='absmiddle'>"
  ELSE
    Response.Write "<img src='/images/mybet/page_end.gif'  align='absmiddle' style='cursor:hand' onclick=javascript:window.self.location.href='MyBet.asp?PAGE="&STARTPAGE+SETSIZE&"'>"
  END IF
%>
  <P></P>
  </div>
</div>
<!-- #include file="../_Inc/footer.asp" -->