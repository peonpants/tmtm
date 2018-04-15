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
%>

<script type="text/javascript">
  function goDel1()
    {
      ProcFrm.location.href = "Answer_Proc.asp?EMODE=answer_alldel";
    }
  function delchk(id){
    
      ProcFrm.location.href = "Answer_Proc.asp?EMODE=selctedDEL&BC_IDX="+id;
  }

  function checkGroup(obj){
    var btnAll = ['해제', '선택'];
    var btnRev = ['△', '▲'];
    var chkBox = document.getElementsByName('chk[]');
    var chkLen = chkBox.length;
    switch (obj.name) {
      case 'chkAll':
      switch (obj.value) {
        case btnAll[0]: obj.value = btnAll[1]; var chkAll = 0; break;
        case btnAll[1]: obj.value = btnAll[0]; var chkAll = 1; break;
      }
      if (!chkLen) chkBox.checked = chkAll;
      else
        for (var i=0; i < chkLen; i++){
          chkBox[i].checked = chkAll;
        }
        break;
      }
    }

  function as_auto()	{
  	document.boardForm.submit();
  }
</SCRIPT>

 
<STYLE type="text/css">
	#lists td {
		border-bottom: 1px dashed #464646;
		padding: 4px 0;
		color:#000;
		background:#fff;
		font-size:12px!important;
	}
</STYLE>
 
<SCRIPT type="text/javascript">
$(function() {
	$('#btnDeleteAll').click(function(event) {
		if (confirm("모두 삭제하시겠습니까?") == true) {
			var frm = this.form;
			frm.MemoMode.value = 'del_all';
			frm.submit();
		}
	});
	$('#btnConfirmAll').click(function(event) {
		if (confirm("모두 확인하시겠습니까?") == true) {
			var frm = this.form;
			frm.MemoMode.value = 'confirm_all';
			frm.submit();
		}
	});
});
</SCRIPT>

<DIV id="wrap">
<DIV id="subwrap">
<DIV class="subbody">
<DIV id="sub-content">
<DIV class="game_view dark_radius game_title white">고객센터 <SPAN>CUSTOMER</SPAN>
				 </DIV>
<TABLE width="100%" class="table2" style="background: rgb(11, 119, 131);" 
border="0" cellspacing="0" cellpadding="0">
  <COLGROUP>
  <COL width="10%">
  <COL width="60%">
  <COL width="20%">
  <COL width="20%"></COLGROUP>
  <THEAD>
  <TR class="font_11_333">
    <TH align="center">번호</TH>
    <TH align="center">제목</TH>
    <TH align="center">보낸사람</TH>
    <TH align="center">시간</TH>
  <TBODY id="lists">
<SCRIPT type="text/javascript">
					<!--
						(function() {
							// 닉네임을 가져온다.
							var mb_nick = $("li strong").eq(0).text();
							$("td.userid").each(function() {
								$(this).text(mb_nick);
								var obj = $(this).next().next();
								if (obj.text() == "-") {
									obj.next().html("<font color=\"#ff0000\">미확인</font>");
								}
							});
						})();
					//-->
					</SCRIPT>
  									 </TBODY></TABLE>
<TABLE width="100%">
  <TBODY>
<%
    '########  리스트를 위한 Where 절     ##############
    Set Dber = new clsDBHelper

    
    '########  게시판 리스트 불러옴     ##############
    SQLR = " Board_Customer Where BC_ID = '"& Session("SD_ID") &"' AND bc_delyn = 0 and BC_Status=1"

	
    SQL = "SELECT COUNT(*) AS TN From "& SQLR &""

	Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)
	
	
	TN = CDBL(sRs(0))
	sRs.CLOSE
	SET sRs = Nothing

	PGCOUNT = INT(TN/PGSIZE)
	IF PGCOUNT * PGSIZE <> TN THEN 
		PGCOUNT = PGCOUNT+1
	END IF

    SQL =  " SELECT TOP " & PGSIZE & " BC_IDX, BC_WRITER, BC_TITLE, BC_REGDATE, BC_REPLY, BC_READ FROM  "& SQLR &"  AND BC_IDX NOT IN (SELECT TOP " & ((PAGE - 1) * PGSIZE)   & " BC_IDX FROM "& SQLR &" ORDER BY BC_IDX DESC )  ORDER BY BC_IDX DESC "
    
	Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)

	IF NOT  sRs.eof THEN
		NEXTPAGE = CINT(PAGE)+1
		PREVPAGE = CINT(PAGE)-1
		NN = TN - (PAGE-1) * PGSIZE
	ELSE
		TN = 0
		PGCOUNT = 0
	END If
	
	IF TN = 0 THEN	
%>
<%	
    ELSE

        FOR fr = 1 TO PGSIZE
        IF sRs.EOF THEN
            EXIT FOR
        END IF

        BC_IDX			= sRs(0)
        BC_WRITER		= sRs(1)
        BC_TITLE		= sRs(2)
        BC_REGDATE		= sRs(3)
        BC_REPLY		= sRs(4)
        BC_READ			= sRs(5)	
        
        trHeight = "30"
        IF BC_REPLY = "1" THEN 
            trHeight = "40"
        End IF
%>
				<tr>
					<td colspan="4" valign="top" bgcolor="#212121">
						<table width="100%" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="10%" /><col /><!--<col width="4%" />--><col width="14%" style="" /><col width="8%" style="" /><col width="6%" style="display:none" />
							</colgroup>
							
							<tbody id="lists">
							<tr class="board_body"><td align="center" class="num_style">1</td><td align="left" class="font_12_808080 tbl_left"><a href="/support/Answer_Read.asp?BC_IDX=<%=BC_IDX%>&page=<%=PAGE%>"><%=BC_TITLE%></a>&nbsp;<img src="/html/SAMPLE/images/bet-icon.png" class="file bettinfo" seq="" style="display:none;vertical-align:middle" />&nbsp;<span class="font_11_red1 num_style"><% IF BC_REPLY = "1" THEN %><FONT COLOR="RED">(답변완료)<%else%><FONT COLOR="RED">(답변대기)<% END IF %></span></td><!--<td></td>--><td style=";text-align:left;padding-left:22px;color:#000;font-weight:bold;"><img src="http://mpluspic.com/Upload/member/grade/201710181511251116814608657.gif?201408" align="absmiddle" /> &nbsp; 관리자</td><td align="center" class="num_style" style=";color:#000;"><%=REPLACE(Left(bc_regdate,10),"-","/")%></td><td align="center" class="num_style" style="display:none;color:#FFCC00;"></td></tr>
							</tbody>
						</table>
					</td>
				</tr>
<%  NN = NN - 1 
    sRs.MoveNext
    Next 
    END IF 
    sRs.close
    Set sRs = Nothing
    Dber.Dispose
    Set Dber = Nothing 
%>
  <TR>

    <TD width="20%">&nbsp;</TD>
    <TD align="center"></TD>
    <TD width="20%" align="right">
	<A href="/support/Answer_write.asp"><INPUT class="btna_02" type="button" value="문의하기"></a>
    <INPUT class="btna_03" onclick="javascript:goDel1();" type="button" value="모두삭제">
    </TD></TR></TBODY></TABLE></DIV>
</DIV>

<!-- #include file="../_Inc/footer.asp" -->
