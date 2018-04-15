<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<%
  SETSIZE = 10
  PGSIZE = 20
    
  PAGE  = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("PAGE")), 1, 1, 9999999) 
  Search = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("Search")), 0, 1, 2)
  Term = dfSiteUtil.F_initNumericParam(Trim(REQUEST("Term")), 0, 1, 3)
  Find = dfSiteUtil.SQL_Injection_T(Trim(dfRequest.Value("Find")))
  pageOption = "&Term=" & Term & "&Search=" & Search & "&Find=" & Server.URLEncode(Find)
    
  IF PAGE= "" THEN
    PAGE = 1
    STARTPAGE = 1
  ELSE
    PAGE = CINT(PAGE) 
    STARTPAGE = INT(PAGE/SETSIZE)

    IF STARTPAGE = (PAGE/SETSIZE) THEN
      STARTPAGE = PAGE-SETSIZE + 1
    ELSE
      STARTPAGE = INT(PAGE/SETSIZE) * SETSIZE + 1
    END IF
  END IF

Set Dber = new clsDBHelper
  
SQLR = " dbo.BOARD_FREE Where BF_Status=1 AND BF_Level = 0 "
SQLR = SQLR &" And BF_REGDATE > dateadd(day,-365,getdate())"  

SQL = "SELECT COUNT(*) AS TN FROM "& SQLR &""
Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)

TOMEM = CDbl(sRs(0))
sRs.close
Set sRs = Nothing
IF Search <> 0 And Term <> 0 And Find <> "" Then
        
  If Search = 1 Then
      SQLR = SQLR &" And BF_TITLE like '%"&Find&"%'"  
  ElseIf Search = 2 Then
    SQLR = SQLR &" And BF_WRITER like '%"&Find&"%'"
  End If 
  'response.Write SQLR
  SQL = "SELECT COUNT(*) AS TN From "& SQLR &""

  Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)
  TN = CDbl(sRs("TN"))
  sRs.close
  Set sRs = Nothing   
Else
  TN = TOMEM      
End IF

PGCOUNT = INT(TN/PGSIZE)
IF PGCOUNT * PGSIZE <> TN THEN 
  PGCOUNT = PGCOUNT+1
END If
%>
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
                <TD align="left" style="width: 800px;"><IMG src="/images/board/board.png"> 
                </TD>
                <td width="200" align="right" valign="top" rowspan="4">
                <table border="0" cellpadding="0" cellspacing="0" width="200px" height="270px" style="background-image: url('/images/freeboard/reply1.jpg');
                    background-repeat: no-repeat;">
                    <tr>
                        <td width="18" height="70px">
                        </td>
                        <td width="163">
                        </td>
                        <td width="19">
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td valign="top">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <%
                SQL = "SELECT TOP 7 BF_IDX, BFR_CONTENTS FROM Board_Free_Reply ORDER BY BFR_REGDATE DESC"
                    
                    
                    Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)
                    REPC = sRs.RecordCount

                    FOR RE = 1 TO REPC
                           
                        IF sRs.EOF THEN EXIT FOR
                               
                        re_IDX        = sRs(0)
                        re_CONTENTS    = sRs(1)
                    
                        IF Len(re_CONTENTS) > 0 THEN
                            re_CONTENTS    = Replace(re_CONTENTS,chr(13)&chr(10),"<br>")
                            re_CONTENTS    = RePlace(re_CONTENTS,"  ","&nbsp;&nbsp;")
                        END IF
            %>
                                <tr>
                                    <td height="20px">
                                        <a href="board_Read.asp?BF_IDX=<%=re_IDX%>"><%=re_CONTENTS%></a>
                                    </td>
                                </tr>
            <%
                sRs.Movenext
                Next
                sRs.close   
                Set sRs=Nothing
            %>
                                    
                            </table>
                            
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
              </TR>
              <TR>
                <TD>
                  <TABLE style="width: 800px;" border="0" cellspacing="0" 
                  cellpadding="0">
                    <TBODY>
                    <TR>
                      <TD width="100%" align="left" style="border-bottom-color: rgb(76, 76, 76); border-bottom-width: 1px; border-bottom-style: solid;">
                        <DIV>
                        <TABLE class="noticestyle" id="ctl00_ContentPlaceHolder1_GridView1" 
                        style="border-width: 0px; width: 100%; border-collapse: collapse;" 
                        border="0" rules="rows" cellspacing="0" 
                          cellpadding="0"><TBODY>
                          <TR class="list_title">
                            <TH style="width: 70px; height: 30px;" 
                              scope="col">번호</TH>
                            <TH style="width: 490px;" scope="col">제목</TH>
                            <TH class="list_title" style="width: 120px;" scope="col">작성자</TH>
                            <TH style="width: 120px;" scope="col">작성일</TH></TR>
<%
SQL = "SELECT TOP 20 BF_IDX, BF_TITLE, BF_WRITER, BF_HITS, BF_REGDATE, BF_REPLYCNT, BF_LEVEL, IB_IDX, BF_WRITER_LEVEL, isNull(BF_RECOM,0) AS BF_RECOM FROM dbo.BOARD_FREE with(nolock)  Where (bf_site like 'DUMP%') AND BF_Status=1 AND BF_Level = 1 ORDER BY BF_REGDATE DESC"
Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)

IF NOT sRs.EOF THEN
  NEXTPAGE = CINT(PAGE) + 1
  PREVPAGE = CINT(PAGE) - 1
  NN = TN - (PAGE-1) * PGSIZE
  NN = NN + 72296
ELSE
  TN = 0
  PGCOUNT = 0
END If

IF TN = 0 THEN  
  ELSE
  eventCnt = 0
  
  FOR i = 1 TO PGSIZE
    IF sRs.EOF THEN
      EXIT FOR
    END IF
  BF_IDX      = sRs("BF_IDX")
  BF_TITLE    = sRs("BF_TITLE")
  IF Search = 1 Then
    BF_TITLE = Replace(BF_TITLE,Find,"<span style='color:#ff0000; font-weight: bold;'>"&Find&"</span>")
  End IF        
  BF_WRITER   = sRs("BF_WRITER")
  IF Search = 2 Then
    BF_WRITER = Replace(BF_WRITER,Find,"<span style='color:#ff0000; font-weight: bold;'>"&Find&"</span>")
  End IF        
  BF_HITS     = sRs("BF_HITS")
  BF_REGDATE    = dfSiteUtil.GetFullDate(sRs("BF_REGDATE"))
  BF_REGDATE = Left(BF_REGDATE,10)
  BF_REPLYCNT   = sRs("BF_REPLYCNT")
  BF_LEVEL    = CDbl(sRs("BF_LEVEL"))   
  IB_IDX        = sRs("IB_IDX")
  
  If sRs("BF_WRITER_LEVEL") > 0 Then
  BF_WRITER_LEVEL = sRs("BF_WRITER_LEVEL")
  Else
  BF_WRITER_LEVEL = 1
  End if

  BF_RECOM = sRs("BF_RECOM")
  IF BF_LEVEL = 1 THEN
    BF_Part = "notice"
  ELSEIF BF_LEVEL = 2 THEN
    BF_Part = "event"         
  END IF    
  
  If BF_LEVEL = 1 Or BF_LEVEL = 2 Then
    fontColor = ""
  Else
    fontColor = ""                    
  End IF 
      
  strBetTail = ""
  strReplyTail = ""
  IF NOT isNull(IB_IDX) Then
    strBetTail = "<IMG width='15' align='absmiddle' src='/images/board/attach_bet.png'>&nbsp;"
  End IF    
        
  IF BF_REPLYCNT > 0 Then
    strReplyTail = "&nbsp;[" & BF_REPLYCNT & "]"
  End IF            
        
  IF BF_WRITER = "관리자" Then
      strBF_WRITER = "관리자"
  Else
  strBF_WRITER = BF_WRITER
  End IF  
%> 
                          <TR style="border-width: 0px; height: 35px; color: white; background-color: black;">
                            <TD><FONT color="white"><SPAN id="ctl00_ContentPlaceHolder1_GridView1_ctl21_lbl_num" 
                              style="display: none;"><%=BF_IDX%></SPAN>               
                                                            <IMG align="absmiddle" 
                              style="border: currentColor; border-image: none;" 
                              src="/images/board/mainnotice.png">              
                                                             </FONT>             
                                                          </TD>
                            <TD><a href="/freeboard/board_Read.asp?BF_IDX=<%=BF_IDX%>&page=<%=PAGE%><%= pageOption %>"><SPAN 
                              id="ctl00_ContentPlaceHolder1_GridView1_ctl21_lbl_usrtitle"><FONT 
                              color="#ffffff"><FONT color="yellow"><%=BF_TITLE%></FONT></FONT>                     
                                                          </SPAN></A>            
                                                           </TD>
                            <TD>
                              <DIV align="center"><SPAN id="ctl00_ContentPlaceHolder1_GridView1_ctl21_lbl_ad"><IMG 
                              src="/images/top/logo.gif" width="63" height="20">                
                                                           </SPAN>               
                                                            </DIV></TD>
                            <TD></TD></TR>
<%  
    NN = NN - 1 
    sRs.MoveNext
  Next 
END IF 
sRs.close
Set sRs = Nothing

'########  게시판 리스트 불러옴     ##############
SQL = "SELECT TOP " & PGSIZE & " BF_IDX, BF_TITLE, BF_WRITER, BF_HITS, BF_REGDATE, BF_REPLYCNT, BF_LEVEL, IB_IDX, BF_WRITER_LEVEL, isNull(BF_RECOM,0) AS BF_RECOM FROM "& SQLR &" AND BF_IDX NOT IN (SELECT TOP " & ((PAGE - 1) * PGSIZE)   & " BF_IDX  FROM "& SQLR &" ORDER BY BF_Level Desc, bf_regdate desc) ORDER BY BF_Level Desc, bf_regdate desc"

Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)
IF NOT sRs.EOF THEN
  NEXTPAGE = CINT(PAGE) + 1
  PREVPAGE = CINT(PAGE) - 1
  NN = TN - (PAGE-1) * PGSIZE
  NN = NN + 3296
ELSE
TN = 0
PGCOUNT = 0
END If

IF TN = 0 THEN  
ELSE
eventCnt = 0

FOR i = 1 TO PGSIZE
  IF sRs.EOF THEN
    EXIT FOR
  END IF

  BF_IDX      = sRs("BF_IDX")
  BF_TITLE    = sRs("BF_TITLE")
  IF Search = 1 Then
    BF_TITLE = Replace(BF_TITLE,Find,"<span style='color:#ffffff; font-weight: bold;'>"&Find&"</span>")
  End IF        
  BF_WRITER   = sRs("BF_WRITER")
  IF Search = 2 Then
    BF_WRITER = Replace(BF_WRITER,Find,"<span style='color:#ffffff; font-weight: bold;'>"&Find&"</span>")
  End IF        
  BF_HITS     = sRs("BF_HITS")
  BF_REGDATE    = dfSiteUtil.GetFullDate(sRs("BF_REGDATE"))
  BF_REGDATE = Left(BF_REGDATE,10)
  BF_REPLYCNT   = sRs("BF_REPLYCNT")
  BF_LEVEL    = CDbl(sRs("BF_LEVEL"))   
  IB_IDX        = sRs("IB_IDX")

  If sRs("BF_WRITER_LEVEL") > 0 Then
    BF_WRITER_LEVEL = sRs("BF_WRITER_LEVEL")
  Else
    BF_WRITER_LEVEL = 1
  End if

  If BF_WRITER_LEVEL = 6 Then
    BF_WRITER_LEVEL = 5
  End If

  If BF_WRITER_LEVEL = 9 Then
    BF_WRITER_LEVEL = 3
  End If
  BF_RECOM = sRs("BF_RECOM")
  IF BF_LEVEL = 1 THEN
    BF_Part = "Notice"
  ELSEIF BF_LEVEL = 2 THEN
    BF_Part = "Event"         
  END IF    

  If BF_WRITER = "관리자" Then
    fontColor = "style='color: #d96500; font-weight: bold;'"
  Else
    fontColor = ""
  End IF 

  strBetTail = ""
  strReplyTail = ""
  IF NOT isNull(IB_IDX) Then
    strBetTail = "<IMG width='15' align='absmiddle' src='/images/board/attach_bet.png'>&nbsp;"
  End IF    

  IF BF_REPLYCNT > 0 Then
    strReplyTail = "&nbsp;[" & BF_REPLYCNT & "]"
  End IF            

  IF BF_WRITER = "관리자" Then
    strBF_WRITER = "<font style='font-family: Dotum; color: #d35a35;'>관리자</font>"
  Else
    strBF_WRITER =  BF_WRITER
  End IF  
%> 

							</TBODY></TABLE></DIV></TD></TR>
                    <TR>
                      <TD width="100%" align="left">
                        <DIV>
                        <TABLE class="noticestyle" id="ctl00_ContentPlaceHolder1_View_List" 
                        style="border-width: 0px; width: 100%; border-collapse: collapse;" 
                        border="0" rules="rows" cellspacing="0" 
                          cellpadding="0"><TBODY>

<%  
    NN = NN - 1 
    sRs.MoveNext
  Next 
END IF 
sRs.close
Set sRs = Nothing

'########  게시판 리스트 불러옴     ##############
SQL = "SELECT TOP " & PGSIZE & " BF_IDX, BF_TITLE, BF_WRITER, BF_HITS, BF_REGDATE, BF_REPLYCNT, BF_LEVEL, IB_IDX, BF_WRITER_LEVEL, isNull(BF_RECOM,0) AS BF_RECOM FROM "& SQLR &" AND BF_IDX NOT IN (SELECT TOP " & ((PAGE - 1) * PGSIZE)   & " BF_IDX  FROM "& SQLR &" ORDER BY BF_Level Desc, bf_regdate desc) ORDER BY BF_Level Desc, bf_regdate desc"

Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)
IF NOT sRs.EOF THEN
  NEXTPAGE = CINT(PAGE) + 1
  PREVPAGE = CINT(PAGE) - 1
  NN = TN - (PAGE-1) * PGSIZE
  NN = NN + 3296
ELSE
TN = 0
PGCOUNT = 0
END If

IF TN = 0 THEN  
ELSE
eventCnt = 0

FOR i = 1 TO PGSIZE
  IF sRs.EOF THEN
    EXIT FOR
  END IF

  BF_IDX      = sRs("BF_IDX")
  BF_TITLE    = sRs("BF_TITLE")
  IF Search = 1 Then
    BF_TITLE = Replace(BF_TITLE,Find,"<span style='color:#ffffff; font-weight: bold;'>"&Find&"</span>")
  End IF        
  BF_WRITER   = sRs("BF_WRITER")
  IF Search = 2 Then
    BF_WRITER = Replace(BF_WRITER,Find,"<span style='color:#ffffff; font-weight: bold;'>"&Find&"</span>")
  End IF        
  BF_HITS     = sRs("BF_HITS")
  BF_REGDATE    = dfSiteUtil.GetFullDate(sRs("BF_REGDATE"))
  BF_REGDATE = Left(BF_REGDATE,10)
  BF_REPLYCNT   = sRs("BF_REPLYCNT")
  BF_LEVEL    = CDbl(sRs("BF_LEVEL"))   
  IB_IDX        = sRs("IB_IDX")

  If sRs("BF_WRITER_LEVEL") > 0 Then
    BF_WRITER_LEVEL = sRs("BF_WRITER_LEVEL")
  Else
    BF_WRITER_LEVEL = 1
  End if

  If BF_WRITER_LEVEL = 6 Then
    BF_WRITER_LEVEL = 5
  End If

  If BF_WRITER_LEVEL = 9 Then
    BF_WRITER_LEVEL = 3
  End If
  BF_RECOM = sRs("BF_RECOM")
  IF BF_LEVEL = 1 THEN
    BF_Part = "Notice"
  ELSEIF BF_LEVEL = 2 THEN
    BF_Part = "Event"         
  END IF    

  If BF_WRITER = "관리자" Then
    fontColor = "style='color: #d96500; font-weight: bold;'"
  Else
    fontColor = ""
  End IF 

  strBetTail = ""
  strReplyTail = ""
  IF NOT isNull(IB_IDX) Then
    strBetTail = "<IMG width='15' align='absmiddle' src='/images/board/ico_02.png'>&nbsp;"
  End IF    

  IF BF_REPLYCNT > 0 Then
    strReplyTail = "&nbsp;[" & BF_REPLYCNT & "]"
  End IF            

  IF BF_WRITER = "관리자" Then
    strBF_WRITER = "<font style='font-family: Dotum; color: #d35a35;'>관리자</font>"
  Else
    strBF_WRITER =  BF_WRITER
  End IF  
%> 
                          <TR style="height: 35px; color: rgb(44, 44, 44); background-color: black;">
                            <TD><INPUT name="ctl00$ContentPlaceHolder1$View_List$ctl02$hid_type" id="ctl00_ContentPlaceHolder1_View_List_ctl02_hid_type" type="hidden" value="0"> 
                                                                          <SPAN 
                              id="ctl00_ContentPlaceHolder1_View_List_ctl02_lbl_num" 
                              style="width: 50px; display: inline-block;"><%=BF_IDX%></SPAN> 
                                                                      </TD>
                            <TD>
                              <DIV align="left"><a href="/freeboard/board_Read.asp?BF_IDX=<%=BF_IDX%>&page=<%=PAGE%><%= pageOption %>"><SPAN 
                              id="ctl00_ContentPlaceHolder1_View_List_ctl02_lbl_usrtitle" 
                              style="width: 470px; display: inline-block;"><%=BF_TITLE%><%=strBetTail%><%=strReplyTail%><FONT 
                              color="#ff6600" size="1"></FONT>                   
                                                            </SPAN></A>          
                                                                 </DIV></TD>
                            <TD>
                              <DIV align="left"><SPAN id="ctl00_ContentPlaceHolder1_View_List_ctl02_lbl_user" 
                              style="width: 120px; display: inline-block;"><IMG align="absmiddle" alt="" src="/images/level/level_<%=BF_WRITER_LEVEL%>.png">&nbsp;<FONT color="white"><%=strBF_WRITER%></FONT> 
                                                                          
                              </SPAN>                                            
                               </DIV></TD>
                            <TD><SPAN id="ctl00_ContentPlaceHolder1_View_List_ctl02_lbl_writedate" 
                              style="width: 100px; display: inline-block;"><%=BF_REGDATE%></SPAN> 
                                                                      </TD></TR>
<%  
    NN = NN - 1 
    sRs.MoveNext
  Next 
END IF 
sRs.close
Set sRs = Nothing
Dber.Dispose
Set Dber = Nothing 
%>
                          <TR align="center" style="color: white;">
                            <TD colspan="4"><BR>
                              <TABLE width="100%" border="0" cellspacing="0" 
                              cellpadding="0">
                                <TBODY>
                                <TR>
                                <TD height="30" align="center"><DIV id="write_btn"><%if Writeable = "Y" then%><a href="/freeboard/Board_Write.asp"><IMG src="/images/board/writer_btn.png"></A><% end if %></DIV>
<DIV id="paging">
<DIV class="paging">



<img src='/images/mybet/page_begin.gif' align='absmiddle' style='cursor:hand' onclick="javascript:window.self.location.href='/freeboard/board_list.asp?PAGE=1'">&nbsp;
<%	
	IF STARTPAGE = 1 THEN
		Response.Write "<img src='/images/mybet/page_prev.gif'  align='absmiddle'> &nbsp;"
	ELSEIF STARTPAGE > SETSIZE THEN
		Response.Write "<img src='/images/mybet/page_prev.gif' align='absmiddle' style='cursor:hand' onclick=javascript:window.self.location.href='/freeboard/board_list.asp?PAGE="&STARTPAGE-SETSIZE& pageOption & "'>&nbsp;"
	END IF 
%>
&nbsp;	
<%	FOR i = STARTPAGE TO SETSIZE + STARTPAGE - 1

	IF i > PGCOUNT THEN
		EXIT FOR
	END IF

	IF PAGE = i THEN
		'Response.Write " <a class='now' href=MyBet.asp?PAGE="&i&" >"& i & "</a>&nbsp;"
		Response.Write " <a class='now' href='/freeboard/board_list.asp?PAGE="&i & pageOption &"'>"& i & "</a>&nbsp;"
	ELSE
		'Response.Write " <a class='rest' href=MyBet.asp?PAGE="&i&" >"& i & "</a>&nbsp;"
		Response.Write " <a class='rest' href='/freeboard/board_list.asp?PAGE="&i & pageOption &"'>"& i & "</a>&nbsp;"
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
		Response.Write "<img src='/images/mybet/page_end.gif'  align='absmiddle' style='cursor:hand' onclick=javascript:window.self.location.href='/freeboard/board_list.asp?PAGE="&STARTPAGE+SETSIZE & pageOption &"'>"
	END IF
%>						
<P></P>

</DIV></DIV>
<DIV style="height: 20px;"></DIV></DIV></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></DIV></TD></TR>
                    <TR>
                      <TD height="20"></TD></TR>
                    <TR>
                      <TD align="center">
                        <DIV id="ctl00_ContentPlaceHolder1_Panel1" style="overflow: hidden;" 
                        onkeypress="javascript:return WebForm_FireDefaultButton(event, 'ctl00_ContentPlaceHolder1_ibtn_search')">
                           &nbsp;&nbsp; 
                                     <a href="/freeboard/board_write.asp"><img src="/images/board/btn_write1.jpg"></a>&nbsp;
                        </DIV></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE><BR><BR></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
<!-- #include file="../_Inc/footer_right.asp" -->