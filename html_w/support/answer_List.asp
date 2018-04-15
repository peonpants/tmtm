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
<img src="/images/freeboard/cs2.png" align="absmiddle">
<table class="noticestyle" cellspacing="0" cellpadding="0" rules="rows" border="0" id="ctl00_ContentPlaceHolder1_GridView1" style="border-width:0px;border-style:None;width:100%;border-collapse:collapse;font-size: small;text-align: center; border-collapse: collapse; border: 1px solid #000000;">
  <tbody>
    <tr>
      <th scope="col" style="height:30px;width:70px;">번호</th>
      <th scope="col" style="width:415px;">상담내역</th>
      <th scope="col" style="width:200px;">작성일</th>
      <th scope="col" style="width:100px;">작성자</th>
      <th scope="col" style="width:50px;">삭제</th>
    </tr>

<%
  Set Dber = new clsDBHelper
  SQLR = " Board_Customer Where BC_ID = '"& Session("SD_ID") &"' AND bc_read<100 AND bc_delyn = 0 and BC_Status=1 "

  SQL = "SELECT COUNT(*) AS TN From "& SQLR &""
  Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)

  TN = CDBL(sRs(0))
  sRs.CLOSE
  SET sRs = Nothing

  PGCOUNT = INT(TN/PGSIZE)
  IF PGCOUNT * PGSIZE <> TN THEN 
    PGCOUNT = PGCOUNT+1
  END IF

  SQL =  " SELECT TOP " & PGSIZE & " BC_IDX, BC_WRITER, BC_TITLE, BC_REGDATE, BC_REPLY, BC_READ FROM  "& SQLR &"  AND BC_IDX NOT IN (SELECT TOP " & ((PAGE - 1) * PGSIZE)   & " BC_IDX FROM "& SQLR &" ORDER BY BC_REGDATE DESC )  ORDER BY BC_REGDATE DESC "
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
  ELSE
    FOR fr = 1 TO PGSIZE
    IF sRs.EOF THEN
      EXIT FOR
  END IF

  BC_IDX      = sRs(0)
  BC_WRITER   = sRs(1)
  BC_TITLE    = sRs(2)
  BC_REGDATE    = sRs(3)
  BC_REPLY    = sRs(4)
  BC_READ     = sRs(5)  

  trHeight = "30"
  IF BC_REPLY = "1" THEN 
    trHeight = "40"
  End IF
%>
    <tr class="cssRow" style="color:#2C2C2C;background-color:Black;height:35px;">
      <td>
        <font color="white">
            <input type="hidden" name="ctl00$ContentPlaceHolder1$GridView1$ctl02$hid_num" id="ctl00_ContentPlaceHolder1_GridView1_ctl02_hid_num" value="1122644">
            <input type="hidden" name="ctl00$ContentPlaceHolder1$GridView1$ctl02$hid_state" id="ctl00_ContentPlaceHolder1_GridView1_ctl02_hid_state" value="6">
            
            <span id="ctl00_ContentPlaceHolder1_GridView1_ctl02_lbl_notice" style="color: #00ff00; font-weight: bold">
                <font color="#fbca11"><%=BC_IDX%></font>
            </span>
        </font>
      </td>
      <td>
        <div align="left">
          <a id="ctl00_ContentPlaceHolder1_GridView1_ctl02_lnk_title" href="Answer_Read.asp?BC_IDX=<%=BC_IDX%>"><div align="left"><font color="white"><%=BC_TITLE%></font><font style="color: orange; font-size: 12px;"><% IF BC_REPLY = "1" THEN %> [ 답변완료 ]<% END IF %></font></div>
          </a>
        </div>
      </td>
      <td>
          <font color="white"><%=year(BC_REGDATE)&"-"&month(BC_REGDATE)&"-"&day(BC_REGDATE)%></font>
      </td>
      <td>
        <span id="ctl00_ContentPlaceHolder1_GridView1_ctl02_lbl_ad">
          <%=iu_nickname%>
        </span>
      </td>
      <td><a href="javascript:delchk(<%=BC_IDX%>)" style="color:tomato">삭제</a></td>
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
  </tbody>
</table>

<div style="height:100px;margin: 17px 17px;" align="right">
  <a href="javascript:goDel1()"><img src="/images/freeboard/btndel.png" alt=""></a>
  <a href="answer_write.asp" id="ctl00_ContentPlaceHolder1_ibtn_write"><img src="/images/freeboard/btnWrite.png" alt="글쓰기"></a>
  </div>

<!-- #include file="../_Inc/footer_right.asp" -->
