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
    'on error resume next
     '########   페이징 셋팅    ##############
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
	    
	    ' 취소 내역 조회 
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
    


    '########   배팅 내역 리스트 불러옴    ##############

    SQL = "SELECT COUNT(*) AS TN From "& SQLR &""
    Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)

    TN = CDBL(sRs(0))
    sRs.CLOSE
    SET sRs = Nothing

    PGCOUNT = INT(TN/PGSIZE)
    IF PGCOUNT * PGSIZE <> TN THEN 
        PGCOUNT = PGCOUNT+1
    END IF


    START_ROWNUM	=	CINT(CINT(CINT(PGSIZE) * CINT(CINT(PAGE) -1)) + 1)
    END_ROWNUM		=	CINT(CINT(PGSIZE) * CINT(PAGE))

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
        alert("각 베팅내역의 경기일시 옆 체크박스를 클릭하시면 다수의 배팅내역 등록이 가능합니다");
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
      
<TABLE width="1010" border="0" cellspacing="0" cellpadding="0">
  <TBODY>
  <TR>
    <TD align="center">
      <TABLE width="1010" border="0" cellspacing="0" cellpadding="0">
        <TBODY>
        <TR>
          <TD width="100%" valign="top"><!--  Mypage Menu -->                  
                               
            <TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
              <TBODY>
              <TR>
                <TD width="100%" align="left"><IMG align="absmiddle" src="/images/game/bettinglist.png"> 
                              </TD></TR></TBODY></TABLE>
            <TABLE width="100%" height="61" border="0" cellspacing="0" 
            cellpadding="0">
              <TBODY>
              <TR>
                <TD align="left" style="font-size: 12px;"><FONT color="#00ff72">◎ 
                  </FONT><FONT color="#ff0000">베팅취소는 진행중인 게임내에서 베팅 후 10분이내, 게임시작 
                  10분전,                     하루 총 3회 취소 가능합니다. </FONT>             
                      <BR><FONT color="#00ff72">◎ </FONT><FONT 
                  color="#ff0000">진행중인 게임은 베팅삭제가 되지 않으며 베팅 결과가 나온 게임만            
                      삭제 됩니다.</FONT>             </TD>
                <TD align="right">
                  <TABLE width="305" border="0" cellspacing="0" 
                    cellpadding="0"><TBODY>
                    <TR>
                      <TD><A href="/member/info.asp"><IMG src="/images/game/info_011.jpg" 
                        border="0"></A>                         </TD>
                      <TD><A href="/member/myrecom.asp"><IMG src="/images/game/info_031.jpg" 
                        border="0"></A>                         </TD>
                      <TD><A href="/member/mybet.asp"><IMG src="/images/game/info_041_on.jpg" 
                        border="0"></A>                         
                  </TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>

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

        IB_IDX		= sRs(0)
        IB_TYPE		= sRs(1)
        IG_IDX		= sRs(2)
        IB_NUM		= sRs(3)
        IB_BENEFIT	= sRs(4)
        IB_AMOUNT	= sRs(5)
        IB_STATUS	= sRs(6)
        IB_REGDATE	= sRs(7)
     

        '취소 가능 경기인지 체크한다.
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


            <TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
              <TBODY>
              <TR class="game_head">
                <TH width="10%" height="30" align="center"><input type="checkbox" name="betNum" value="<%= IB_IDX %>|<%= NN %>" />&nbsp;경기일시                
                       </TH>
                <TH width="4%" align="center">                        종목       
                                </TH>
                <TH width="10%" align="center">                        리그      
                                 </TH>
                <TH width="28%" align="center">                        승(HOME) 
                                      </TH>
                <TH width="5%" align="center">무                     </TH>
                <TH width="28%" align="center">                        패(AWAY) 
                                      </TH>
                <TH width="7%" align="center">점수                     </TH>
                <TH width="8%" align="center">                        결과       
                                </TH></TR></TBODY></TABLE>
            <TABLE width="100%" style="text-align: center; border-spacing: 2px 2px;" 
            border="0" cellspacing="0" cellpadding="0">
              <TBODY>
<%

iii=0
    SQL =  "UP_RetrieveINFO_BETTING_DETAILByPreview"

    reDim param(0)
    param(0) = Dber.MakeParam("@IB_Idx",adInteger,adParamInput, ,IB_Idx)
			
    Set sRs2 = Dber.ExecSPReturnRS(SQL,param,nothing)
    NOTC = sRs2.RecordCount
    
    IF NOT sRs2.Eof Then
    	        
        For j = 0 to NOTC - 1
            
            IG_IDX		= sRs2("IG_IDX")
	        RL_League		= sRs2("RL_League")
	        RL_IMAGE		= sRs2("RL_IMAGE")	  
			RL_Image		= "<img align='absmiddle' src='" & dfSiteUtil.GetLeagueImage(RL_Image) & "' width='26' />"
	        IG_Team1		= sRs2("IG_Team1")
	        IG_Team2		= sRs2("IG_Team2")
	        IG_Status		= sRs2("IG_Status")
	        IG_Result		= sRs2("IG_Result")
	        IG_StartTime	= sRs2("IG_StartTime")
	        IG_Team1Benefit = sRs2("IG_Team1Benefit")
	        IG_DrawBenefit	= sRs2("IG_DrawBenefit")
	        IG_Team2Benefit	= sRs2("IG_Team2Benefit")
	        IG_Score1		= sRs2("IG_Score1")
	        IG_Score2		= sRs2("IG_Score2")
	        IG_Type			= sRs2("IG_Type")
	        IG_Handicap		= sRs2("IG_Handicap")
	        IG_Draw		    = sRs2("IG_Draw")
	        IBD_NUM         = sRs2("IBD_NUM")
	        IBD_RESULT      = sRs2("IBD_RESULT")
	        IBD_RESULT_BENEFIT = sRs2("IBD_RESULT_BENEFIT")
	        IBD_BENEFIT = sRs2("IBD_BENEFIT")
        
            IG_Result = Trim(IG_Result)
            
            df = DATEDIFF("s",now(),Cdate(IG_StartTime))
            
            IF boolBET_CANCEL2 AND CDBL(df) < 0 Then            
                boolBET_CANCEL2 = False
            End IF     
                        
                        
            IF (IG_Status = "E") OR (IG_Status = "S") Then
                IG_Result = 3
            End IF
                    

	        IF IG_Type <> "0" THEN 
		        IG_DrawBenefit = IG_Handicap
	        END IF


            
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
            
            IF IBD_RESULT_BENEFIT = 1 Then
               ' txtIBD_RESULT = "<font color='B50D0D'>1배처리</font>"
                IG_Result = 4            
            End IF
            
            SCORE = IG_SCORE1 & " : " & IG_SCORE2
            
            '#### 진행 중인지 체크한다.
            IF IBD_RESULT = 9  Then
               totalIBD_RESULT = 9 
               IBD_RESULT_BENEFIT = IBD_BENEFIT
            End IF           
             
            'response.Write IBD_RESULT & "--" & IBD_RESULT_BENEFIT & "<br>"
            TotalBenefit = Cdbl(TotalBenefit) * Cdbl(IBD_RESULT_BENEFIT)
            TotalBenefitA = Cdbl(TotalBenefitA) * Cdbl(IBD_BENEFIT)                        
        	       
%>
              <TR>
                <TD width="10%" height="30" align="center" class="gradiCell"><%=dfSiteUtil.GetBetDate(IG_StartTime)%></TD>
                <TD width="4%" align="center" class="GroupCell"><%=RL_Image%></TD>
                <TD width="10%" align="left" class="gradiCell">
                                      <SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_league"><%=RL_League%></SPAN> 
                                  </TD>
                <TD width="28%" align="left" class="<% If IBD_NUM = 1 Then %>CssSelect2<% Else %>CssTeam<% End If %>" style="background: rgb(30, 30, 30); border: 1px solid rgb(0, 0, 0); border-image: none;" endcell=""><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_home" 
                  style="width: 99%; display: inline-block;"><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_Label1" 
                  style="width: 85%; display: inline-block;"><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_hometeam" 
                  style="width: 85%; text-align: left; display: inline-block;"><%=IG_Team1%></SPAN><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_over" 
                  style="width: 14%; text-align: right; display: inline-block;"></SPAN></SPAN><SPAN 
                  id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_homeodds" 
                  style="width: 14%; text-align: right; display: inline-block;"><%=FORMATNUMBER(IG_Team1Benefit,2)%></SPAN></SPAN> 
                                  </TD>
                <TD width="5%" align="center" class="<% If IBD_NUM = 0 Then %>CssSelect2<% Else %>CssTeam<% End If %>" style="background: rgb(30, 30, 30); border: 1px solid rgb(0, 0, 0); border-image: none;" 
                endcell=""><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_drawodds" 
                  style="width: 99%; text-align: center; display: inline-block;"><%= dfSiteUtil.getDrawValue(IG_TYPE, IG_DrawBenefit ,IG_Handicap) %></SPAN> 
                                  </TD>

                <TD width="28%" align="left" class="<% If IBD_NUM = 2 Then %>CssSelect2<% Else %>CssTeam<% End If %>" style="background: rgb(30, 30, 30); border: 1px solid rgb(0, 0, 0); border-image: none;" 
                endcell=""><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl4_lbl_away" 
                  style="width: 100%; display: inline-block;"><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl4_lbl_awayodds" 
                  style="width: 14%; text-align: left; display: inline-block;"><%=FORMATNUMBER(IG_Team2Benefit,2)%></SPAN><SPAN 
                  id="ctl00_ContentPlaceHolder1_lst_game_ctrl4_lbl_totalaway" 
                  style="width: 85%; text-align: right; display: inline-block;"><SPAN 
                  id="ctl00_ContentPlaceHolder1_lst_game_ctrl4_lbl_under" style="width: 14%; text-align: left; display: inline-block;"></SPAN><SPAN 
                  id="ctl00_ContentPlaceHolder1_lst_game_ctrl4_lbl_awayteam" 
                  style="width: 85%; text-align: right; display: inline-block;"><%=IG_Team2%></SPAN></SPAN></SPAN></TD>              </TD>





                <TD width="7%" align="center" class="gradiCell"><FONT color="white"><SPAN 
                  id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_homescore"><%=IG_Score1%>:<%=IG_Score2%></SPAN> 
                                      </FONT>                 </TD>
                <TD width="8%" align="center" class="gradiCell"><B><FONT 
                  color="#ffcd28"><SPAN id="ctl00_ContentPlaceHolder1_lst_game_ctrl0_lbl_result" 
                  style="width: 99%; text-align: center; display: inline-block;"><%= txtIBD_RESULT %></SPAN> 
                                          </FONT></B>                 </TD></TR>
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
            
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

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

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>
<tr><td colspan='10'><table width='100%' border='0' cellspacing='0' cellpadding='0' style='border:4px solid #232323; color: ffffff'><tbody><tr><td style='height:70px; padding:10px;'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tbody><tr><td style='height:30px; width:10%; text-align:center;'><font color=ffffff>베팅시간</td><td style='height:30px; width:20%; text-align:center;'><font color=ffffff>선택된 경기수</td><td style='height:30px; width:15%; text-align:center'><font color=ffffff>총 배당률</td><td style='height:30px; width:15%; text-align:center'><font color=ffffff>배팅금액</td><td style='height:30px; width:20%; text-align:center'><font color=ffffff>예상적중금액</td><td style='height:30px; width:20%; text-align:center'><font color=ffffff>적중결과</td></tr><tr>
<td style='height:30px; width:10%; text-align:center; font-size:14px; color:#bc2d1e; font-weight:bold;'><%=dfSiteUtil.GetFullDate(IB_REGDATE)%>
</td>
<td style='height:30px; width:15%; text-align:center; font-size:14px; color:#bc2d1e; font-weight:bold;'><%=iii%>
</td><td style='height:30px; width:15%; text-align:center; font-size:14px; color:#fff04d; font-weight:bold;'><%=FORMATNUMBER(TotalBenefit,2)%>
</td><td style='height:30px; width:20%; text-align:center; font-size:14px; color:#fff04d; font-weight:bold;'><%=FormatNumber(IB_AMOUNT,0)%>
</td><td style='height:30px; width:20%; text-align:center; font-size:14px; color:#fff04d; font-weight:bold;'><%=FormatNumber(BenefitAmountA,0)%>
</td><td style='height:30px; width:20%; text-align:center; font-size:14px; color:#bc2d1e; font-weight:bold;'><%=txttotalIBD_RESULT(totalIBD_RESULT)%>
</td></tr>
<tr>
<TD align="right" colspan="10"><% IF BETTING_CANCEL AND boolBET_CANCEL1 AND boolBET_CANCEL2 Then %>
					    <a href="#" onFocus="this.blur();" onclick="goCancel(<%=IB_IDX%>);"><img border="0" src='/images/game/btn_s_cancel.gif' align="absmiddle"></a>
					    <% End IF %><a href="#" onFocus="this.blur();"><img src="/images/game/btn_s_delete.gif" border="0" onclick="goDel(<%=IB_IDX%>, <%= IB_STATUS %>);" style="cursor:pointer" align="absmiddle"/></a></TD></TR>
</tbody></table></td></tr></tbody></table></td></tr>
</tbody></table>
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



            <P align="right">
			<A onclick="goDel2();"><img src="/images/game/bet_alldel1.jpg"></a>
<IMG id="betReg" src="/images/game/bet_chkwrite1.jpg" onclick="goBoardMuty();">
</P>


                                        </TD></TR></TBODY></TABLE>
<DIV id="paging">
<DIV class="paging">


<img src='/images/mybet/page_begin.gif' align='absmiddle' style='cursor:hand' onclick="javascript:window.self.location.href='MyBet.asp?PAGE=1'">&nbsp;
<%	
	IF STARTPAGE = 1 THEN
		Response.Write "<img src='/images/mybet/page_prev.gif'  align='absmiddle'> &nbsp;"
	ELSEIF STARTPAGE > SETSIZE THEN
		Response.Write "<img src='/images/mybet/page_prev.gif' align='absmiddle' style='cursor:hand' onclick=javascript:window.self.location.href='MyBet.asp?PAGE="&STARTPAGE-SETSIZE&"'>&nbsp;"
	END IF 
%>
&nbsp;	
<%	FOR i = STARTPAGE TO SETSIZE + STARTPAGE - 1

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
</DIV></DIV>
										</TD></TR></TBODY></TABLE>

<!-- #include file="../_Inc/footer_right.asp" -->