<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<!-- #include file="../_Inc/clock.asp" -->
<%
    '---------------------------------------------------------
    '   @Title : 게시판 글쓰기 페이지
    '   @desc  : 
    '---------------------------------------------------------
    IB_IDX            = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("IB_IDX")), 0, 1, 9999999) 
    NN            = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("NN")), 0, 1, 9999999) 
    strIB_IDX = IB_IDX
    IF IB_IDX <> 0 Then
        strGameInfo = dfSiteUtil.GetBetInfo(IB_IDX)         
        'BF_Contents = strGameInfo 
    End IF   

    '####### 다중 배팅 내역 불러오기
    arrIB_IDX = Trim(dfRequest.Value("arrIB_IDX"))
    arrNN = Trim(dfRequest.Value("arrNN"))    
    arrTrue = False
    IF IB_IDX = 0 And arrIB_IDX <> "" And arrNN <> "" Then
        arrIB_IDX = Split(arrIB_IDX,",")
        arrNN = Split(arrNN,",")
        IF ubound(arrIB_IDX) = ubound(arrNN) Then
            arrTrue = True
            For i = 0 to ubound(arrIB_IDX)
                IF NOT IsNumeric(arrIB_IDX(i)) OR NOT IsNumeric(arrNN(i)) Then
                    arrTrue = False
                    Exit For        
                End IF
            Next
        End IF
    End IF
    
    
    IF arrTrue = True Then
        strIB_IDX = Trim(dfRequest.Value("arrIB_IDX"))
        strGameInfo = dfSiteUtil.GetBetInfo(Trim(dfRequest.Value("arrIB_IDX"))) 
        'BF_Contents = strGameInfo 
    End IF    

   
%>
<script type="text/javascript">
function FreAdd() {
	if (document.FreContent.BF_TITLE.value == "") { alert("\n 글제목을 입력하세요. \n"); document.FreContent.BF_TITLE.focus(); return false; }
	if (document.FreContent.BF_CONTENTS.value == "") { alert("\n 글내용을 입력하세요. \n"); document.FreContent.BF_CONTENTS.focus(); return false; }
	return true	
}


</script>
<style>

</style>
<form name="FreContent" method="post" action="/freeboard/board_Proc.asp" onsubmit="return FreAdd()">
<input type="hidden" name="EMODE" value="FREEADD">
<input type="hidden" name="BF_WRITER" value="<%=Session("IU_NickName")%>">
<div id="wrap">
	<div id="subwrap">
		<div class="subbody" style="">
			<div id="sub-content">

<DIV class="subbody">
<div class="game_view dark_radius game_title white">
  게시판 <span>BOARD LIST</span></DIV></DIV>
<DIV id="sub-content" style="width: 100%;">
			<!--<h2><img src="/html/POKERFACE/images/title11.png" alt="자유게시판" /></h2>-->
			<div id="betting_list">
							<%
                            '배팅 내역 올리기
                            IF strGameInfo <> "" Then
                            %>                
                            <tr>
                                <td class="trIngGame" colspan="2" style="padding-top:4;" >
                                <%= strGameInfo %>
                                <input type="hidden" name="IB_IDX" value="<%= strIB_IDX %>" />
                                </td>
                            </tr>                            
                            <%
                            End IF
                            %>   </div>
			<table width="100%" border="0" cellspacing="3" cellpadding="0" class="table2">
				<tbody>
				<tr>
					<td align="center" class="font_12_808080"><b>제목</b></td>
					<td align="left" class="tbl_left">
						<input name="BF_TITLE" type="text" class="inputb_01" id="subject" size="115" value="" required="">
					</td>
				</tr>
				<tr height="200">
					<td align="center"><b>내용</b></td>
					<td align="left" class="tbl_left">
						<table width="100%" border="0" cellspacing="1" cellpadding="0">
							<tbody><tr>
								<td height="180">
									<textarea name="BF_CONTENTS" id="content" cols="80" rows="15" style="height:200;" class="textb_01"></textarea>
								<span class="font_11_yellow" style="padding:0px 0px 5px 10px">내용은 최소 <font color="#FF5603">6</font>자 이상 등록가능합니다.</span></td>
							</tr>
						</tbody></table>
					</td>	
				</tr>
					</tbody>
				</table>
				<div class="btn_box">
					<input type="submit" class="btna_02_submit" value="글쓰기">
					<a onclick="javascript:history.back();" class="btna_02">목록</a>
				</div>
			</div>
		</div>
	</div>
</form></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR>
        <TR>
          <TD height="20"></TD></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD>
<!-- #include file="../_Inc/footer.asp" -->