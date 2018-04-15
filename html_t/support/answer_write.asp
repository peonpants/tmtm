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
<STYLE type="text/css">
<!--
	object.flash {
		vertical-align:middle
	}
	div.dd img {
		height:20px;
	} 
-->
</STYLE>

<DIV id="sub-area">
<DIV class="subbody">
<DIV id="sub-content">
<DIV class="game_view dark_radius game_title white">고객센터 <SPAN>CUSTOMER</SPAN>
			 </DIV><!--<h2><img src="/html/SAMPLE/images/title12.png" alt="고객센터" /></h2>-->
<form name="FreContent" method="post" action="/support/Answer_Proc.asp" onsubmit="return FreAdd()">
<input type="hidden" name="EMODE" value="QNAADD">
<input type="hidden" name="BC_WRITER" value="<%=Session("IU_NickName")%>">
<input type="hidden" name="BC_Type" value="0" checked/>
<DIV class="subtitlebox">고객센터 글쓰기</DIV>
<DIV id="betting_list"></DIV>
<TABLE width="100%" class="table2" border="0" cellspacing="3" cellpadding="0">
  <TBODY>
  <TR>
    <TH width="10%" align="center"><B>작성자</B></TH>
    <TD align="left" class="tbl_left"><INPUT name="writer" class="submit25" id="text1" type="text" value="<%=Session("IU_NickName")%>" readonly>
      					 </TD></TR>
  <TR>
    <TH align="center" class="font_12_808080"><B>제목</B></TH>
    <TD align="left" class="tbl_left"><INPUT name="BC_TITLE" tabindex="1" id="subject" class="inputb_01" type="text" size="115">
      					 </TD></TR>
 
  <TR>
    <TH align="center"><B>내용</B></TH>
    <TD align="left" class="tbl_left">
      <DIV id="height_control"></DIV>
      <TABLE width="100%" border="0" cellspacing="1" cellpadding="0">
        <TBODY>
        <TR>
          <TD height="150"><TEXTAREA name="BC_CONTENTS" tabindex="2" class="textb_01" style="overflow: hidden;" rows="13"></TEXTAREA>
            								 </TD></TR></TBODY></TABLE></TD></TR>
</TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
<DIV class="btn_box"><INPUT class="btna_02" type="submit" value="글쓰기">
<A class="btna_02" onclick="regCancel()">목록</A>				 </DIV></DIV></DIV></DIV></FORM>

<iframe name="HiddenFrm" src="/Blank.html" frameborder="0" width="0" height="0" frameborder="0"></iframe>
<iframe name="ProcFrm" src="/Blank.html" frameborder="0" width="0" height="0" frameborder="0"></iframe>
<!-- #include file="../_Inc/footer.asp" -->