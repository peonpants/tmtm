<!-- #include file="../../_Common/Api/lta_function.asp" -->
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<script type="text/javascript" src="/FusionCharts/FusionCharts.js">
  function RepAdd() {
  if (document.RepContent.BFR_CONTENT.value == "") { alert("\n 댓글 내용을 입력하세요. \n"); document.RepContent.BFR_CONTENT.focus(); return false; }
  if (document.RepContent.BFR_CONTENT.value.length < 1) { alert("\n 댓글 내용은 5자이상 입력하셔야 합니다. \n"); document.RepContent.BFR_CONTENT.focus(); return false; }
  return true }
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

                        strGameInfo = dfSiteUtil.GetBetInfo(IB_IDX)    

                End IF
  
                IF BF_WRITER = "관리자" or BF_WRITER = "이벤트" Then
                    BF_WRITER_LEVEL = "A"
                   strBF_WRITER =   BF_WRITER
                Else
                   strBF_WRITER =   BF_WRITER
                End IF  
				
				If BF_WRITER_LEVEL = "9" Then
		
		
				BF_WRITER_LEVEL = 3

				End If

bf_contents = Replace(bf_contents, Chr(13) & Chr(10), "<br>")
%>               
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="800" align="left">
                <div class="title_box">
                    <img src="/images/board/board.png" align="absmiddle" />
                    <table cellpadding="0" cellspacing="0" border="0" style="font-size: small;position:absolute;right:5px;bottom:5px">
                        <tr>
                            <td style="white-space:nowrap">
                                <IMG align="absmiddle" alt="" src="/images/level/level_<%=BF_WRITER_LEVEL%>.png">&nbsp;<span id="ctl00_ContentPlaceHolder1_lbl_writename"><font color="white"><%=strBF_WRITER%></span>&nbsp;&nbsp;
                                <span id="ctl00_ContentPlaceHolder1_lblDate"><font color="white"><%=Left(dfSiteUtil.GetFullDate(bf_regdate),10)%></span>&nbsp;
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
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
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%" cellspacing="0" cellpadding="0" border="0" class="board_view">
                    <tr>
                        <th width="100px" align="center"><font color="white">제목
                        </th>
                        <td>
                            <span id="ctl00_ContentPlaceHolder1_lbl_title"><font color="white"><%=BF_TITLE%></span>
                        </td>
                    </tr>
                </table>
                <br />
                <table cellspacing="0" cellpadding="0" width="100%" class="board_view">
                    <tr>
                        <td>
                            <span id="ctl00_ContentPlaceHolder1_txtContents"><br /><br /><font color="white"><%=  viewstr(BF_CONTENTS) %><br /><br /></span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="bet">
                <!-- 베팅내역 -->
            <%=strGameInfo%>
            </td>
        </tr>
        <tr class="replay">
            <td>
                <table width="100%" cellpadding="0" cellspacing="0" border="0" style="font-size: small;">
            <%	IF BF_REPLYCNT > 0 THEN	
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
                            <tr>
                                <td width="10px">
                                </td>
                                <td width="200px" height="35px">
                                    <input type="hidden" name="ctl00$ContentPlaceHolder1$Repeater1$ctl00$hid_idx" id="ctl00_ContentPlaceHolder1_Repeater1_ctl00_hid_idx" value="102065" />
                                    <input type="hidden" name="ctl00$ContentPlaceHolder1$Repeater1$ctl00$hid_level" id="ctl00_ContentPlaceHolder1_Repeater1_ctl00_hid_level" value="1" />
                                    <span id="ctl00_ContentPlaceHolder1_Repeater1_ctl00_lbl_usr">
                                        <IMG align="absmiddle" alt="" src="/images/level/level_<%=BFR_WRITER_LEVEL%>.png">
                                        <span id="ctl00_ContentPlaceHolder1_Repeater1_ctl00_lbl_name"><font color="white"><%=strBFR_WRITER%></span></span>
                                    
                                </td>
                                <td align="left" width="550px">
                                    &nbsp;&nbsp;&nbsp;<span id="ctl00_ContentPlaceHolder1_Repeater1_ctl00_lbl_comment"><font color="white"><%=viewstr(BFR_CONTENTS)%></span>
                                </td>
                                <td width="90px" align="left"><font color="white"><%=dfSiteUtil.GetShotDate(BFR_REGDATE)%></td>
                                <td width="20px" align="center">
                                    
                                </td>
                            </tr>
<%	sRs.Movenext
	Next
	sRs.close	
	Set sRs=Nothing
	Dber.Dispose
	Set Dber = Nothing 
	End If 
%>
                        
                </table>
                <br />
                <br />
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
<%
	'// 글쓰기 권한체크...
	Set Dber = new clsDBHelper
	SQL = "SELECT top 1(ic_idx) FROM info_charge WHERE Ic_ID = ? AND Ic_SITE = ? "
	
	reDim param(1)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

		Writeable = "N"
	If Not sRs.eof Then
		Writeable = "Y"
	End If 

	IF session("IU_LEVEL") = 9 Then
		Writeable = "Y"
	End IF	

	sRs.close
	Set sRs = Nothing
%>

                <!-- 댓글 작성 부분 -->
                <table width="100%" cellspacing="0" cellpadding="0" class="commend_write">
                    <tr height="40px">
                        
                                <td width="200px" align="center">
                                    <font size="2" color="white">
                                        <IMG align="absmiddle" alt="" src="/images/level/level_<%=IU_LEVEL%>.png">&nbsp;<%=IU_NICKNAME%></font></td>
                            
                        <td width="510px" height="80px" align="center">
                            <textarea name="BFR_CONTENT" rows="2" cols="20" id="ctl00_ContentPlaceHolder1_txtComment" onkeydown="return CheckStrLen(this,80)" style="color:White;background-color:Black;border-color:#1C1C1C;border-width:1px;border-style:solid;height:50px;width:500px;"></textarea>
                        </td>
                        <td width="160px" align="center">
                            <input type="image" name="ctl00$ContentPlaceHolder1$ibtnComment" id="ctl00_ContentPlaceHolder1_ibtnComment" align="absmiddle" src="/images/board/btn_ok1.jpg" style="border-width:0px;" />
                        </td>
                    </tr>
                </table>
</form>
 <%

	End IF
%>
                
                <!-- 수정, 삭제, 목록 버튼 -->
                <table border="0" cellspacing="5" cellpadding="10" width="100%">
                    <tr>
                        <td align="center">
                            <a href="/freeboard/board_list.asp"><img src="/images/board/btn_cancel1.jpg" style="border-width:0px;" /></a>
                        </td>
                    </tr>
                </table>
                <input name="ctl00$ContentPlaceHolder1$hid_no" type="hidden" id="ctl00_ContentPlaceHolder1_hid_no" value="210222" />
                <input name="ctl00$ContentPlaceHolder1$strIdx" type="hidden" id="ctl00_ContentPlaceHolder1_strIdx" value="3181084,3181082,3181081," />
                <input name="ctl00$ContentPlaceHolder1$hid_bettype" type="hidden" id="ctl00_ContentPlaceHolder1_hid_bettype" value="승무패,승무패,승무패," />
                <input name="ctl00$ContentPlaceHolder1$hid_name" type="hidden" id="ctl00_ContentPlaceHolder1_hid_name" value="알파고쏭" />
                <input name="ctl00$ContentPlaceHolder1$hid_type" type="hidden" id="ctl00_ContentPlaceHolder1_hid_type" value="0" />
                
                
            </td>
        </tr>
    </table>

                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
<!-- #include file="../_Inc/footer_right.asp" -->