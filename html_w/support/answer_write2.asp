<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<%

IB_IDX = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("IB_IDX")), 0, 1, 9999999) 
NN  = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("NN")), 0, 1, 9999999) 
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
   if (document.FreContent.BC_TITLE.value == "") { alert("\n 글제목을 입력하세요. \n"); document.FreContent.BC_TITLE.focus(); return false; }
   if (document.FreContent.BC_CONTENTS.value == "") { alert("\n 글내용을 입력하세요. \n"); document.FreContent.BC_CONTENTS.focus(); return false; }
   return true	
 }
</script>
<img src="/images/freeboard/cs2.png" align="absmiddle">
<form name="FreContent" method="post" action="Answer_Proc.asp" onsubmit="return FreAdd()">
  <table border="0" width="100%" cellpadding="0" cellspacing="0" style="border-collapse: collapse; color: white" class="board_view">
    <input type="hidden" name="EMODE" value="QNAADD">
    <input type="hidden" name="BC_WRITER" value="<%=Session("IU_NickName")%>">
    <input type="hidden" name="BC_Type" value="0" checked/>
  
    <tbody>
        <tr>
          <th width="100px" align="center">
              제목
          </th>
          <td>
              <input name="BC_TITLE" type="text" maxlength="14" id="ctl00_ContentPlaceHolder1_txtTitle" style="color:White;background-color:Black;border-color:#4C4C4C;border-width:1px;border-style:Solid;height:30px;width:100%;box-sizing: border-box; padding: 0 10px" value="충전계좌문의">
          </td>
        </tr>
        <tr>
          <th align="center">
              문의내용</th>
          <td>
            <textarea name="BC_CONTENTS" rows="2" cols="20" id="ctl00_ContentPlaceHolder1_txtContent" onkeydown="return CheckStrLen(this,300)" style="color:White;background-color:Black;border-color:#4C4C4C;border-width:1px;border-style:Solid;height:276px;width:100%;box-sizing: border-box; padding: 10px">충전계좌문의</textarea>
          </td>
        </tr>
    </tbody>
  </table>
  
  <div style="height:100px;margin: 17px 17px;" align="right">
    <a href="javascript:FreContent.submit();"><img src="/images/freeboard/btn_ok1.jpg" alt=""></a>
    <a href="answer_List.asp"><img src="/images/freeboard/btn_cancel1.jpg" alt=""></a>
  </div>
</form>

<!-- #include file="../_Inc/footer_right.asp" -->