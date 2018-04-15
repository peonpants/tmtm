
<!-- #include file="../../_Common/Api/lta_function.asp" -->
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<script type="text/javascript" src="/FusionCharts/FusionCharts.js"></script>
<script type="text/javascript">
<!--
function RepAdd() {
	if (document.RepContent.BFR_CONTENT.value == "") { alert("\n 댓글 내용을 입력하세요. \n"); document.RepContent.BFR_CONTENT.focus(); return false; }
	if (document.RepContent.BFR_CONTENT.value.length < 5) { alert("\n 댓글 내용은 5자이상 입력하셔야 합니다. \n"); document.RepContent.BFR_CONTENT.focus(); return false; }
	return true	}
//-->
</script>

<%
				Set Dber = new clsDBHelper
				
                PAGE  = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("PAGE")), 1, 1, 9999999) 
	            Search = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("Search")), 0, 1, 2)
	            Term = dfSiteUtil.F_initNumericParam(Trim(REQUEST("Term")), 0, 1, 3)
	            Find = dfSiteUtil.SQL_Injection_T(Trim(dfRequest.Value("Find")))
	            BF_IDX  = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("BF_IDX")), 1, 1, 9999999) 
				BF_IDX	= CDBL(REQUEST("BF_IDX"))
                
                pageOption = "&Term=" & Term & "&Search=" & Search & "&Find=" & Server.URLEncode(Find)
                
                
	SQL = "UP_INFO_Board_Free_HIT_UPD"
	reDim param(0)
	param(0) = Dber.MakeParam("@BF_IDX",adInteger,adParamInput,,BF_IDX)

	Dber.ExecSP SQL,param,nothing
	
	SQL = "UP_INFO_Board_Free_SHOW"
	reDim param(0)
	param(0) = Dber.MakeParam("@BF_IDX",adInteger,adParamInput,,BF_IDX)

	Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
                
    IF sRs.EOF Then
%>
    <script type="text/javascript">
        alert("정상적인 접근 바랍니다.");
        history.back();
    </script>
<%                
    End IF
                
				BF_TITLE	= sRs("BF_TITLE")
				BF_CONTENTS = sRs("BF_CONTENTS")
				BF_WRITER	= sRs("BF_WRITER")
				BF_HITS		= sRs("BF_HITS")
				BF_REGDATE	= sRs("BF_REGDATE")
				BF_REPLYCNT	= CDbl(sRs("BF_REPLYCNT"))
				IG_IDX = sRs("IG_IDX")
				IB_IDX = sRs("IB_IDX")
				BF_WRITER_LEVEL = sRs("BF_WRITER_LEVEL")
				                                
                                    
				sRs.Close
				Set sRs=Nothing
				
		        IF NOT isNull(IB_IDX) And Len(IB_IDX) <> 0 Then
                    arrIB_IDX = Split(IB_IDX,",")                
                    cntIB_IDX  = ubound(arrIB_IDX) 

                    'IF cntIB_IDX <> 0 Then
                        strGameInfo = dfSiteUtil.GetBetInfo(IB_IDX)    

                    'End IF   
                End IF
  
                IF BF_WRITER = "관리자" or BF_WRITER = "이벤트" Then
                    BF_WRITER_LEVEL = "A"
                   strBF_WRITER =   BF_WRITER
                Else
                   strBF_WRITER =   BF_WRITER
                End IF        				
bf_contents = Replace(bf_contents, Chr(13) & Chr(10), "<br>")
%>
<div id="wrap">
	<div id="subwrap">
		<div class="subbody" style="">
			<div id="sub-content">

<DIV class="subbody">
<div class="game_view dark_radius game_title white">
  게시판 <span>BOARD LIST</span></DIV></DIV>
<DIV id="sub-content" style="width: 100%;">
<TABLE width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
  <TBODY>
  <TR>
    <TD valign="top" colspan="2">
      <DIV style="background: rgb(64, 64, 57); padding: 15px 0px;">
      <TABLE width="100%" style="color: rgb(255, 255, 255);" border="0" 
      cellspacing="0" cellpadding="0">
        <TBODY>
        <TR>
          <TD width="75%" align="left" class="font_12_808080" style="padding-left: 12px; font-size: 12px;"><STRONG><%=BF_TITLE%></STRONG>									 <SPAN class="num_style"><IMG width="11" 
            height="9" src="/images/freeboard/content_files/Forum_CommentCnt.gif"> (4)</SPAN>
          <IMG style="width: 23px; height: 11px;" src="/images/freeboard/content_files/new.gif"></TD>
          <TD><SPAN class="small_font"><STRONG>DATE</STRONG> : <%=Left(dfSiteUtil.GetFullDate(bf_regdate),10)%>
            &nbsp;|&nbsp;</SPAN><SPAN class="small_font"><STRONG>NAME</STRONG> : <IMG align="absmiddle" src="/images/level/<%=BF_WRITER_LEVEL%>.gif">&nbsp;<SPAN style="color: rgb(255, 180, 0); font-size: 11px; font-weight: normal;"><%=strBF_WRITER%></SPAN> &nbsp;|&nbsp;</SPAN><SPAN class="small_font" style="display: none;"><STRONG>HIT </STRONG> : </SPAN></TD></TR></TBODY></TABLE></DIV>
      <DIV style="padding: 4px 4px 4px 14px;background: #616153;border-top: 1px solid #111;border-bottom: 1px solid #111;font-family:tahoma"><font color="white">배팅내역</font></DIV>

<!--베팅내역-->
  <%=strGameInfo%>
<!--베팅내역끝-->
      <TABLE width="100%" border="0" cellspacing="3" cellpadding="0">
        <TBODY>
        <TR>
          <TD align="center" 
style="padding: 0px 0px 10px; color: rgb(0, 0, 0);">
            <TABLE width="100%" border="0" cellspacing="1" cellpadding="0">
              <TBODY>
              <TR>
                <TD align="left" valign="top" style="padding: 0px 15px 10px; line-height: 15pt; font-size: 12px; border-top-color: rgb(70, 70, 70); border-top-width: 1px; border-top-style: dashed;"><BR><%=  viewstr(BF_CONTENTS) %></TD></TR></TBODY></TABLE></TD></TR>
        <TR>
          <TD align="left">
            <TABLE width="100%" align="center" cellspacing="0" 
              cellpadding="0"><TBODY>
              <TR>
                <TD style="padding: 7px 0px; border-top-color: rgb(17, 17, 17); border-top-width: 1px; border-top-style: solid;" 
                colspan="2">

                  <DIV style="display: none;"><SELECT name="_temp1" id="_temp1" 
                  style="background: rgb(242, 242, 242); font: 12px/normal normal; padding: 1px 0px; width: 150px; color: rgb(0, 0, 0); font-size-adjust: none; font-stretch: normal;"><OPTION 
                    value="">회원등급</OPTION>																							 </SELECT>&nbsp;
                  											<INPUT name="mb_nick" id="mb_nick" style="background: rgb(242, 242, 242); font: 12px/normal normal; padding: 4px 3px 2px; color: rgb(0, 0, 0); font-size-adjust: none; font-stretch: normal;" type="text" size="20">
                  											 <INPUT name="regdate" id="regdate" style="background: rgb(242, 242, 242); font: 12px/normal normal; padding: 4px 3px 2px; color: rgb(0, 0, 0); font-size-adjust: none; font-stretch: normal;" type="text" size="18">
                  										 </DIV></TD></TR>
              <TR>
                <TD align="left" valign="top">
                  <TABLE width="100%" border="0" cellspacing="1" 
cellpadding="0">
                    <TBODY>
						<%
                            IF not ADMIN_REPLY_USE AND BF_WRITER = "관리자" Then
                        %>
						<%
						        
                                response.Write "<hr color='#FFFFFF' style='height:1px' /><div align='center'><font color='white'>의견글을 달 수 없는 게시물입니다.</font></div>"
                                response.Write "<hr color='#FFFFFF' style='height:1px' />"
						%>
						<%
						Else
						%>
  <form name="RepContent" method="post" action="/freeboard/board_Proc.asp" onsubmit="return RepAdd()">
							<input type="hidden" name="EMODE" value="REPADD">
	                        <input type="hidden" name="PAGE" value="<%=PAGE%>">
	                        <input type="hidden" name="BF_IDX" value="<%=BF_IDX%>">
	                        <input type="hidden" name="Search" value="<%=Search%>">
	                        <input type="hidden" name="Find" value="<%=Find%>">
	                        <input type="hidden" name="Term" value="<%=Term%>">
	                        <input type="hidden" name="BFR_WRITER" value="<%=Session("IU_NickName")%>">
                    <TR>
                      <TD height="64"><TEXTAREA name="BFR_CONTENT" class="textb_02" style="overflow: hidden;" rows="4"></TEXTAREA>
                      </TD></TR>
																	 
					</TBODY></TABLE></TD>
                <TD width="60" align="center" valign="center"><INPUT src="/images/freeboard/content_files/btn_write.gif" type="image" value="댓글등록"></TD></TR></TBODY></TABLE></TD></TR></form>
						<%
						End If
						%>

<!-- 코멘트 리스트시작 -->
						<%	IF BF_REPLYCNT > 0 THEN	%>
                        <%	
	                        SQL = "SELECT BFR_IDX, BFR_CONTENTS, BFR_WRITER, BFR_REGDATE, BFR_WRITER_LEVEL FROM Board_Free_Reply WHERE BF_IDX = ? ORDER BY BFR_REGDATE ASC"
	                        reDim param(0)
	                        param(0) = Dber.MakeParam("@BF_IDX",adInteger,adParamInput,,BF_IDX)
                        	
	                        Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
	                        REPC = sRs.RecordCount

	                        FOR RE = 1 TO REPC
                        		   
	                        IF sRs.EOF THEN
		                        EXIT FOR
	                        END IF
                        		   
	                        BFR_IDX			= sRs(0)
	                        BFR_CONTENTS	= sRs(1)
                        
                            IF Len(BFR_CONTENTS) > 0 THEN
	                            BFR_CONTENTS	= Replace(BFR_CONTENTS,chr(13)&chr(10),"<br>")
	                            BFR_CONTENTS	= RePlace(BFR_CONTENTS,"  ","&nbsp;&nbsp;")
                            END IF
                        
                            BFR_WRITER		= sRs(2)
                            BFR_REGDATE		= sRs(3)	
                            BFR_WRITER_LEVEL    = sRs(4)
							IF BFR_WRITER = "관리자" Then
               				   strBFR_WRITER = "관리자"
           				    Else
             			       strBFR_WRITER =   BFR_WRITER
          				    End IF    
                        %>
        <TR>
          <TD align="center" style="padding: 10px 0px; border-bottom-color: rgb(70, 70, 70); border-bottom-width: 1px; border-bottom-style: dashed;">
            <TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
              <TBODY>
              <TR>
                <TD height="44" align="left" class="font_12_57" valign="top" 
                style="padding: 0px 15px 5px 5px;">
                  <TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
                    <TBODY>
                    <TR>
                      <TD align="left" style="padding: 0px 10px 10px 0px; color: rgb(0, 0, 0);"><IMG 
                        align="absmiddle" src="/images/level/<%=BFR_WRITER_LEVEL%>.gif">&nbsp;<STRONG><%=strBFR_WRITER%></STRONG> 
                        |</TD>
                      <TD align="right">
					  <!--<IMG width="21" height="20" title="수정" class="page_white_wrench" src="/images/freeboard/content_files/btn_c_modify.gif" seq="1764428">
                        <IMG width="21" height="20" title="삭제" class="trash" src="/images/freeboard/content_files/btn_c_del.gif" seq="1764428">--></TD></TR></TBODY></TABLE>
						<SPAN id="cmd_content1764428" style="color: rgb(0, 0, 0); font-size: 12px;"><%=viewstr(BFR_CONTENTS)%></SPAN></TD></TR></TBODY></TABLE></TD></TR>
<!-- 코멘트 리스트끝 -->
					<%	sRs.Movenext
							Next
							sRs.close	
							Set sRs=Nothing
							Dber.Dispose
							Set Dber = Nothing 
							End If 
					%>
        <TBODY id="comment_edit_1764434"></TBODY></TABLE></TD></TR></TBODY></TABLE>
<TABLE width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
  <TBODY>
  <TR>
    <TD align="left" style="padding: 12px 0px;"><IMG width="39" height="18"  onclick="javascript:history.back();" src="/images/freeboard/content_files/btn_list.gif"></TD>
    <TD align="right" style="padding: 12px;"></TD></TR></TBODY></TABLE></DIV></DIV></DIV></FORM>
<SCRIPT>
$("li","#top_menu").hover(function(){
	$(this).stop().animate({"opacity":"1"},300);
	$("var",this).stop().animate({"top":"0px"},100);
}, function(){
	$(this).stop().animate({"opacity":"0.6"},300);
	$("var",this).stop().animate({"top":"-3px"},100);
});

// TOP버튼 활성화
$(window).scroll(function(){
	var ys = $(this).scrollTop();
	if(ys >= 100){
		$("#go_top").show();
	}
	else {
		$("#go_top").hide();
	}
});

// TOP버튼 애니메이션
function go_top() {
	$('html,body').animate({scrollTop:0}, 400);
}
</SCRIPT>
 
<SCRIPT language="JScript" for="player" event="NewStream()">
	// 첫번째 미디어 실행하고 나서 PlayCount 가 끝나고 새루온 미디어가 실행시에 뜬다.
</SCRIPT>
 
<SCRIPT language="JScript" for="player" event="EndOfStream(lResult)"></SCRIPT>
 
<SCRIPT language="JScript" for="player" event="Buffering(bStart)">
	str=(bStart)?'버퍼링중':'버퍼링완료';
	window.status=str;
</SCRIPT>
 </BODY></HTML>

<!-- #include file="../_Inc/footer.asp" -->