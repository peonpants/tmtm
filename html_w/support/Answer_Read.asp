<!-- #include file="../../_Common/Api/lta_function.asp" -->
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<%
mainPage = True
%>
	
<%
		Set Dber = new clsDBHelper

		Page	= REQUEST("Page")
		Find	= REQUEST("Find")
		Search	= REQUEST("Search")
		BC_IDX	= REQUEST("BC_IDX")
			
		SQL = "UP_INFO_Board_Customer_HIT_UPD"
		reDim param(0)
		param(0) = Dber.MakeParam("@BC_IDX",adInteger,adParamInput,,BC_IDX)

		Dber.ExecSP SQL,param,Nothing	

		SQL = "SELECT BC_WRITER, BC_TITLE, BC_CONTENTS, BC_REGDATE, BC_STATUS, BC_REPLY, BC_READ FROM Board_Customer Where BC_IDX = ?"

		reDim param(0)
		param(0) = Dber.MakeParam("@BC_IDX",adInteger,adParamInput,,BC_IDX)
		
		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

		BC_WRITER	= sRs(0)
		BC_TITLE	= sRs(1)
		BC_CONTENTS	= sRs(2)
		BC_REGDATE	= sRs(3)
		BC_STATUS	= sRs(4)
		BC_REPLY	= sRs(5)
		BC_READ		= sRs(6)

		sRs.close
		Set sRs = Nothing
		IF Len(BC_CONTENTS) > 0 THEN
			BC_CONTENTS	= Replace(BC_CONTENTS,chr(13)&chr(10),"<br>")
			BC_CONTENTS	= RePlace(BC_CONTENTS,"  ","&nbsp;&nbsp;")
		END IF

		IF BC_REPLY = "1"  And BC_WRITER <> "관리자" THEN
			SQL = "SELECT BCR_Contents FROM Board_Customer_Reply Where BCR_RefNum = ?"

			reDim param(0)
			param(0) = Dber.MakeParam("@BC_IDX",adInteger,adParamInput,,BC_IDX)
		
			Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

			BCR_Contents	= sRs(0)

			BCR_Contents	= Replace(BCR_Contents,chr(13)&chr(10),"<br>")
			BCR_Contents	= RePlace(BCR_Contents,"  ","&nbsp;&nbsp;")

			sRs.Close
			Set sRs=Nothing

		END IF
	%>
<img src="/images/freeboard/cs2.png" align="absmiddle">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="board_view" style="color: white">
    <tbody>
        <tr>
            <th width="100px" align="center">
                제목
            </th>
            <td align="left">
                <%=BC_TITLE%>
            </td>
        </tr>
        <tr>
        	<th width="100px" align="center">
                내용
            </th>
            <td><%=viewstr(BC_CONTENTS)%></td>
        </tr>
    </tbody>
</table>

<div style="height:100px;margin: 17px 17px;" align="right"><a href="/support/answer_list.asp"><img src="/images/freeboard/btn_list1.jpg" alt=""></a>
</div>
<%if BCR_Contents <> "" then%>
<table class="board_view" style="color: white">
	<tr>
		<th>답변</th>
		<td><%=viewstr(BCR_Contents)%></td>
	</tr>
</table>
<%end if%>
<!-- #include file="../_Inc/footer_right.asp" -->