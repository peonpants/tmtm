<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<!-- #include file="../_Inc/clock.asp" -->
<%

    '########   페이징 관련 셋팅    ##############
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
%>
<div id="wrap">
	<div id="subwrap">
		<div class="subbody" style="">
			<div id="sub-content">
<div class="game_view dark_radius game_title white">
  게시판 <span>BOARD LIST</span>
		<div id="sub-content" style="width:100%;">
			<table width="100%" align="center" cellpadding="0" cellspacing="0" class="table2">
				<tbody>
				<tr>
					<td colspan="2" valign="top">
						<table width="100%" cellspacing="0" cellpadding="0" style="background: #565656;">
							<colgroup>
								<col width="10%"><col><col width="14%" style=""><col width="8%" style=""><col width="6%" style="display:none">
							</colgroup>
							<tbody>
								<tr class="font_11_333">
									<th align="center" style="padding: 2px 0;">번호
									</th><th align="center" style="padding: 2px 0;">제목
									</th><th align="center" style=";text-align:center;padding: 2px 0;">작성자
									</th><th align="center" style=";text-align:center;padding: 2px 0;">작성일
									</th><th align="center" style="display:none;text-align:center;padding: 2px 0;">HIT
								</th></tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" valign="top" bgcolor="#212121">
						<table width="100%" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="10%"><col><col width="14%" style=""><col width="8%" style=""><col width="6%" style="display:none">
							</colgroup>
							<tbody id="nlists"><tr class="board_head">
<!--이벤트 컨텐츠 시작 -->
<%
    '########  리스트를 위한 Where 절     ##############
	Set Dber = new clsDBHelper
	 	
	SQLR = " dbo.BOARD_FREE Where BF_Status=1 AND BF_Level = 0 "

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
    
  
  '### 상위 5개 이벤트만보이게 하기

        SQL = "SELECT TOP 3 BF_IDX, BF_TITLE, BF_WRITER, BF_HITS, BF_REGDATE, BF_REPLYCNT, BF_LEVEL, IB_IDX, BF_WRITER_LEVEL, isNull(BF_RECOM,0) AS BF_RECOM FROM dbo.BOARD_FREE with(nolock)  Where  BF_Status=1 AND BF_Level = 2 ORDER BY BF_REGDATE DESC"
        Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)
        
        IF NOT sRs.EOF THEN
            Do Until sRs.Eof
		BF_IDX			= sRs("BF_IDX")
		BF_TITLE		= sRs("BF_TITLE")
		IF Search = 1 Then
		    BF_TITLE = Replace(BF_TITLE,Find,"<span style='color:#ff0000; font-weight: bold;'>"&Find&"</span>")
        End IF		    
		BF_WRITER		= sRs("BF_WRITER")
		IF Search = 2 Then
		    BF_WRITER = Replace(BF_WRITER,Find,"<span style='color:#ff0000; font-weight: bold;'>"&Find&"</span>")
        End IF		 		
		BF_REGDATE		= dfSiteUtil.GetFullDate(sRs("BF_REGDATE"))
		BF_REGDATE = Left(BF_REGDATE,10)

            BF_REPLYCNT		= sRs("BF_REPLYCNT")
            BF_REGDATE		= dfSiteUtil.GetFullDate(sRs("BF_REGDATE"))
			BF_REGDATE = Left(BF_REGDATE,10)
            BF_REPLYCNT		= sRs("BF_REPLYCNT")
            BF_RECOM = sRs("BF_RECOM")
            IF BF_REPLYCNT > 0 Then
                strReplyTail = "&nbsp;[" & BF_REPLYCNT & "]"
            Else                
                strReplyTail = "&nbsp;"
            End IF		
            BF_HITS  = sRs("BF_HITS")
            strBF_WRITER = "관리자"
%>

							<tr>
							<td align="center"><img src="/images/board/board_new1.gif"></td><td align="left" class="font_12_808080 tbl_left"><a href="/freeboard/board_Read.asp?BF_IDX=<%=BF_IDX%>&page=<%=PAGE%><%= pageOption %>"><font style="font-size:14px;font-weight:bold;color:#ff0000;"><%=BF_TITLE%></font></font></font></a><font color="#FDCA00">&nbsp;</font></td><td style=";color:#000;text-align:left;padding-left:22px;"><img src="/images/level/a.gif" align="absmiddle"> &nbsp; REACTION</td><td align="center" class="num_style" style=";color:#000;text-align:center"><%=Right(BF_REGDATE,5)%></td>
							</tr>
<!--이벤트 컨텐츠 끝-->
<!--공지사항 컨텐츠 시작 -->
 <%    
                sRs.MoveNext
            Loop
        End If
    '########  게시판 리스트 불러옴     ##############
    SQL = "SELECT TOP 20 BF_IDX, BF_TITLE, BF_WRITER, BF_HITS, BF_REGDATE, BF_REPLYCNT, BF_LEVEL, IB_IDX, BF_WRITER_LEVEL, isNull(BF_RECOM,0) AS BF_RECOM FROM dbo.BOARD_FREE with(nolock)  Where BF_Status=1 AND BF_Level = 1 ORDER BY BF_REGDATE DESC"
    
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

		BF_IDX			= sRs("BF_IDX")
		BF_TITLE		= sRs("BF_TITLE")
		IF Search = 1 Then
		    BF_TITLE = Replace(BF_TITLE,Find,"<span style='color:#ff0000; font-weight: bold;'>"&Find&"</span>")
        End IF		    
		BF_WRITER		= sRs("BF_WRITER")
		IF Search = 2 Then
		    BF_WRITER = Replace(BF_WRITER,Find,"<span style='color:#ff0000; font-weight: bold;'>"&Find&"</span>")
        End IF		 		
		BF_HITS			= sRs("BF_HITS")
		BF_REGDATE		= dfSiteUtil.GetFullDate(sRs("BF_REGDATE"))
		BF_REGDATE = Left(BF_REGDATE,10)
		BF_REPLYCNT		= sRs("BF_REPLYCNT")
		BF_LEVEL		= CDbl(sRs("BF_LEVEL"))		
		IB_IDX		    = sRs("IB_IDX")
		
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
							<tr>
							<td align="center"><img src="/images/freeboard/board_new.gif"></td><td align="left" class="font_12_808080 tbl_left"><a href="/freeboard/board_Read.asp?BF_IDX=<%=BF_IDX%>&page=<%=PAGE%><%= pageOption %>"><font style="font-size:14px;font-weight:bold;color:#ff0000;"><%=BF_TITLE%></font></font></font></a><font color="#FDCA00">&nbsp;</font></td><td style=";color:#000;text-align:left;padding-left:22px;"><img src="/images/level/a.gif" align="absmiddle"> &nbsp;Tomorrow Land</td><td align="center" class="num_style" style=";color:#000;text-align:center"><%=Right(BF_REGDATE,5)%></td>
							</tr>
<!--공지사항 컨텐츠 끝-->
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

		BF_IDX			= sRs("BF_IDX")
		BF_TITLE		= sRs("BF_TITLE")
		IF Search = 1 Then
		    BF_TITLE = Replace(BF_TITLE,Find,"<span style='color:#ffffff; font-weight: bold;'>"&Find&"</span>")
        End IF		    
		BF_WRITER		= sRs("BF_WRITER")
		IF Search = 2 Then
		    BF_WRITER = Replace(BF_WRITER,Find,"<span style='color:#ffffff; font-weight: bold;'>"&Find&"</span>")
        End IF		 		
		BF_HITS			= sRs("BF_HITS")
		BF_REGDATE		= dfSiteUtil.GetFullDate(sRs("BF_REGDATE"))
		BF_REGDATE = Left(BF_REGDATE,10)
		BF_REPLYCNT		= sRs("BF_REPLYCNT")
		BF_LEVEL		= CDbl(sRs("BF_LEVEL"))		
		IB_IDX		    = sRs("IB_IDX")
		
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
            strBetTail = "<IMG align='absmiddle' src='/images/freeboard/bet-icon.png'>&nbsp;"
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


<!--게시판 컨텐츠 시작-->

<tbody id="lists">

<tr class="board_body"><td align="center" class="num_style"><%=BF_IDX%></td><td align="left" class="font_12_808080 tbl_left"><a href="/freeboard/board_Read.asp?BF_IDX=<%=BF_IDX%>&page=<%=PAGE%><%= pageOption %>"><%=BF_TITLE%></a>&nbsp<%=strBetTail%>&nbsp;<span class="font_11_red1 num_style"><%=strReplyTail%></span></td><td style=";text-align:left;padding-left:22px;color:#000;font-weight:bold;"><img src="/images/level/<%=BF_WRITER_LEVEL%>.gif" align="absmiddle"> &nbsp; <%= strBF_WRITER %></td><td align="center" class="num_style" style=";color:#000;"><%=Left(bf_regdate,"10")%></td><td align="center" class="num_style" style="display:none;color:#FFCC00;"></td></tr>

			
<%  NN = NN - 1 
    sRs.MoveNext
    Next 
    END IF 
    sRs.close
    Set sRs = Nothing
    Dber.Dispose
    Set Dber = Nothing 
%>

<table width="100%" cellspacing="0" cellpadding="0" align="center">
				<tbody><tr>
					<td width="250" height="20" align="left">
						<input type="button" value="선택삭제" class="btna_02" id="btnDel" style="display:none">
						<input type="button" value="선택복사" class="btna_02" id="btnCopy" style="display: none; cursor: pointer;">
						<input type="button" value="선택이동" class="btna_02" id="btnMove" style="display: none; cursor: pointer;">
					</td>
					<td align="center" class="pageN">
						<table cellspacing="0" cellpadding="0" id="speedpage">
<tbody><tr>
<td align="center" style="PADDING:2px 4px 0 2px" valign="middle">
                        <img src='/img/btn_first.gif'  align='absmiddle'  style='cursor:hand'  onclick=javascript:window.self.location.href='/freeboard/board_list.asp?PAGE=1'>
                        <%	
                            
                            
                            
                            IF STARTPAGE = 1 THEN
                                Response.Write "<img src='/img/btn_prev.gif'  align='absmiddle'>  "
                            ELSEIF STARTPAGE > SETSIZE THEN
                                Response.Write "<img src='/img/btn_prev.gif'  align='absmiddle' style='cursor:hand'  onclick=javascript:window.self.location.href='/freeboard/board_list.asp?PAGE="&STARTPAGE-SETSIZE& pageOption & "'> "
                            END IF 
                        %>
                        &nbsp;
                        <%	FOR i = STARTPAGE TO SETSIZE + STARTPAGE - 1

                            IF i > PGCOUNT THEN
                                EXIT FOR
                            END IF

                            IF PAGE = i THEN
                                Response.Write " <strong><font color='white'>"& i &"</font></strong> "
                            ELSE
                                Response.Write " <a href=/freeboard/board_list.asp?PAGE="&i & pageOption &" class='style9'>"& i & "</a>  "
                            END IF

                        NEXT 
                        %>
                        &nbsp;
                        <%	
                            IF PGCOUNT < SETSIZE  THEN '현재 페이지가 페이지 셋크기보다 적거나 페이지리스트가 전체페이지보다 적으면
                                Response.write "<img src='/img/btn_end.gif'  align='absmiddle'>"
                            ELSEIF i > PGCOUNT THEN
                                Response.write "<img src='/img/btn_end.gif'  align='absmiddle'>"
                            ELSE
                                Response.Write "<img src='/img/btn_next.gif'  align='absmiddle' style='cursor:hand'  onclick=javascript:window.self.location.href='/freeboard/board_list.asp?PAGE="&STARTPAGE+SETSIZE & pageOption &"'>"
                            END IF
                        %>
</tr></tbody></table>
					</td>
					<td width="280" align="right" style="padding-right: 2px;">

						<a href="/freeboard/board_write.asp" type="button" class="btna_02">글쓰기</a>
					</td>
				</tr>
			</tbody></table>
			<br>

		</div>
	</div>
</div>
<!--게시판 컨텐츠 끝-->


<div id="go_top" onclick="go_top();" style="display: none;">TOP</div>

<!-- #include file="../_Inc/footer.asp" -->