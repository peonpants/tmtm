<!-- #include file="../../_Common/Api/lta_function.asp" -->
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../_Inc/top.asp" -->
<%
mainPage = 3
%>
<script>
function Del(){
  var answer = confirm("삭제하시겠습니까?")
  if (answer){
	location.href="Answer_Proc.asp?EMODE=QNADELE&BC_IDX=<%=BC_IDX%>&BC_WRITER=<%=BC_WRITER%>&page=<%=PAGE%>&Search=<%=Search%>&Find=<%=Find%>";
  }
  return false;
}
</script>

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

%>
<%
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
<div id="sub-area">
	<div class="subbody" style="">
		<div id="sub-content">
			<div class="game_view dark_radius game_title white">
				고객센터 <span>CUSTOMER</span>
			</div>
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="2" valign="top">
					<div style="padding:15px 0px 15px 0px;background: #0b7783;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" style="color:#fff;">
							<tr>
								<td width="75%" align="left" class="font_12_808080" style="padding-left: 12px;font-size: 12px;">
									<strong>제목:<%=viewstr(BC_TITLE)%></strong>
									<span class="num_style"></span>
								</td>
								<td>
									<span class="small_font" style=""><strong>DATE</strong> :<%=BC_REGDATE%></span>
									</BR><span class="small_font" style=""><strong>NAME</strong> : <img src="http://mpluspic.com/Upload/member/grade/201710181511251116814608657.gif?201408" align="absmiddle">&nbsp;<span style="font-weight:normal;color:#ffb400;font-size:11px">관리자</span></span>
								</td>
							</tr>
						</table>
					</div>
					<div class="table4_head">배팅내역</div>
					<div id="betting_list"></div>
					<table width="100%" border="0" cellspacing="3" cellpadding="0">
						<tr>
							<td align="center" style="padding:0 0px 10px 0px;color:#000;">
								<table width="100%" border="0" cellspacing="1" cellpadding="0">
								<tr>
									<td align="left" valign="top" style="padding:0 15px 10px 15px;line-height:15pt;font-size:12px;border-top: 1px dashed #464646;">
										<br>내용:<%=viewstr(BC_CONTENTS)%></td>
								</tr>
								</table>
							</td>
						</tr>
					</table>
					<%if BCR_Contents <> "" then%>
					<table width="100%" border="0" cellspacing="3" cellpadding="0">
						<tr>
							<td align="center" style="padding:0 0px 10px 0px;color:#000;">
								<table width="100%" border="0" cellspacing="1" cellpadding="0">
								<tr>
									<td align="left" valign="top" style="padding:0 15px 10px 15px;line-height:15pt;font-size:12px;border-top: 1px dashed #464646;">
										<br>답변:<%=viewstr(BCR_Contents)%></td>
								</tr>
								</table>
							</td>
						</tr>
					</table>
					<% end if %>
				</td>
			</tr>
			</table>
		</div>
	</div>
</div>
<!-- #include file="../_Inc/footer.asp" -->