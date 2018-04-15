<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<%
    IB_IDX            = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("IB_IDX")), 0, 1, 9999999) 
    NN            = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("NN")), 0, 1, 9999999) 
    strIB_IDX = IB_IDX
    IF IB_IDX <> 0 Then
        strGameInfo = dfSiteUtil.GetBetInfo(IB_IDX)  
    End IF   
    
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
    End IF    
%>
              
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="800" align="left"><IMG align="absmiddle" src="/images/board/board.png"> 
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
              Set Dber = new clsDBHelper
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
                Dber.Dispose
                Set Dber = Nothing 
            %>
                                    
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    
  </tr>
  <tr>
    <td>
      <form name="FreContent" method="post" action="/freeboard/board_Proc.asp" onsubmit="return FreAdd();">
        <table cellpadding="0" width="100%" border="0" align="center" cellspacing="1" bgcolor="#2b2b2b">
        <input type="hidden" name="EMODE" value="FREEADD">
        <input type="hidden" name="BF_WRITER" value="<%=Session("IU_NickName")%>"> 
          <TABLE width="100%" class="board_view" style="border-collapse: collapse;" 
          border="0" cellspacing="0" cellpadding="0">
            <TR>
              <TH width="100" align="center"><FONT color="white">작성자</FONT></TH>
              <TD align="left">&nbsp;<FONT color="white" size="2">&nbsp;<%=iu_nickname%></FONT></TD></TR>
            <TR>
              <TH width="100" align="center"><FONT color="white">글제목</TH>
              <TD style="padding: 0px;"><INPUT name="BF_TITLE" style="padding: 0px 10px; border: 0px currentColor; border-image: none; width: 100%; height: 30px; color: white; box-sizing: border-box; background-color: black;" type="text" maxlength="50"></TD>
            </TR>
          </TABLE>
          <TABLE width="100%" style="margin: 20px 0px 0px; border-collapse: collapse;" 
          border="0" cellspacing="0" cellpadding="0"><!-- 베팅내역 -->     
                            
            <TBODY>
            <TR>
              <TD colspan="2">
                <TABLE class="gradienttable" id="ctl00_ContentPlaceHolder1_tblBet" 
                style="width: 100%;" 
          border="0"></TABLE></TD></TR></TBODY></TABLE>
          <TABLE width="100%" class="board_view" style="border-collapse: collapse;" 
          border="0" cellspacing="0" cellpadding="0">
            <TBODY>
              <TR>
                <TH width="100" align="center"><FONT color="white">글 내용</TH>
                <TD style="padding: 0px;"><TEXTAREA name="BF_CONTENTS" style="padding: 10px; border: 0px currentColor; border-image: none; width: 100%; height: 276px; color: white; line-height: 18px; box-sizing: border-box; background-color: black;" rows="2" cols="20"></TEXTAREA></TD>
              </TR>
            <% 'bet
            IF strGameInfo <> "" Then
            %>                
              <tr>
                <td class="trIngGame" colspan="2" style="padding-top:4;" >
                <%= strGameInfo %>
                <input type="hidden" name="IB_IDX" value="<%= strIB_IDX %>" />
                </td>
              </tr>                            
            <% End IF%>  
            </TBODY></TABLE><BR>
          <TABLE width="100%" style="border-collapse: collapse;" border="0" 
          cellspacing="0" cellpadding="0">
            <TR>
              <TD height="25" colspan="2"></TD></TR>
            <TR>
              <TD width="100%" align="center" colspan="2"><INPUT name="ctl00$ContentPlaceHolder1$ibtn_write" 
                title="확인" align="absmiddle" id="ctl00_ContentPlaceHolder1_ibtn_write" 
                style="border-width: 0px;" onclick="if(!FreAdd()) return false;" 
                type="image" src="/images/board/btn_ok1.jpg"></TD>
            </TR>
            <TR>
              <TD height="25" colspan="2"></TD>
            </TR>
          </TABLE>
      </form>
    </td>
  </tr>
</table>
<script type="text/javascript">
function FreAdd() {
  if (document.FreContent.BF_TITLE.value == "") { alert("\n 글제목을 입력하세요. \n"); document.FreContent.BF_TITLE.focus(); return false; }
  if (document.FreContent.BF_CONTENTS.value == "") { alert("\n 글내용을 입력하세요. \n"); document.FreContent.BF_CONTENTS.focus(); return false; }
  return true 
}

</script>
<!-- #include file="../_Inc/footer_right.asp" -->