<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->

<%
		
		IB_IDX		= Trim(REQUEST("IB_IDX"))
		arrNN		= Trim(REQUEST("arrNN"))
    
		PAGE	= REQUEST("PAGE")
		Search	= REQUEST("Search")
		Find	= REQUEST("Find")
		b1 = REQUEST("b1")
		bType	= REQUEST("bType")

		TotalCnt	= REQUEST("IB_IDX").Count

		arrIB_Idx = SPLIT(IB_IDX, ",")

        
		URL = "/member/MyBet.asp?Page="&Page&"&Search="&Search&"&Find="&Find&""
		

	    FOR fi=0 to ubound(arrIB_Idx)
	    
			IF IB_IDX <> "" Then	 
			
			Set Dber = new clsDBHelper
			'response.write arrIB_Idx(fi) & "<br>"

				'########   배팅 내역 Update함    ##############
				'If CDbl(b1) > 0 Then
				'	sql = "update info_betting set ib_del = 'Y' where ib_idx = ? "				
				'else
				'	sql = "update info_betting set ib_del = 'Y' where ib_idx = ? and ib_status = 1"			
				'End If 
				sql = "select isNull(IBD_Result,9) as IBD_RESULT,IBD_BENEFIT, IBD_Result_BENEFIT from dbo.INFO_BETTING_DETAIL where IB_IDX = ?"
				Dim GameIng
				GameIng = True
				reDim param(0)
				param(0) = Dber.MakeParam("@IB_IDX",adInteger,adParamInput,,arrIB_Idx(fi))		
				
				Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
				
				NOTC = sRs.RecordCount

				IF NOT sRs.Eof Then    	        
					For i = 0 to NOTC - 1
						IBD_RESULT      = sRs("IBD_RESULT")
						
						'#### 진행 중인지 체크한다.
						IF IBD_RESULT <> 9  Then
						   GameIng = False
						   Exit For
						End IF        
										
						sRs.MoveNext  
					Next
				Else
		%>
		<script type="text/javascript">
			alert("배팅내역이 존재하지 않습니다.");
			location.href= "<%= URL %>";
		</script>
		<%                    
					response.End
				End IF
														
				IF GameIng Then
		%>
		<script type="text/javascript">
			alert("진행중인 배팅은 삭제되지 않습니다.");
			location.href= "<%= URL %>";
		</script>
		<%                    
					response.End		
				End IF
				
					
			'#### 배팅 시작 혹은 배팅 마감 경기가 있으면 삭제 취소됨
			SQL = " select ig_starttime from info_game with(nolock) where ig_idx in (select ig_idx from info_betting_detail where ib_idx = ?  ) AND (IG_Status = 'S' OR IG_Status = 'E')  "

			reDim param(0)
			param(0) = Dber.MakeParam("@IB_IDX",adInteger,adParamInput,,arrIB_Idx(fi)) 
			
			Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
			
				IF NOT sRs.Eof Then

			%>
				<script type="text/javascript">
					alert("모든 경기가 마감뒤 삭제 가능 합니다.");
					location.href = "<%= URL %>";
				</script>
			<%
					response.end                           
				End IF  
				   
			'#### 배팅내역에서 삭제함( 사용자 페이지에서 보이지 않게 함	        
				

				SQL = "UP_INFO_Betting_DEL_1"
				reDim param(0)
				param(0) = Dber.MakeParam("@IB_IDX",adInteger,adParamInput,,arrIB_Idx(fi))
				Dber.ExecSP SQL,param,Nothing
				
				Dber.Dispose
				Set Dber = Nothing 
			End IF
		NEXT
				
%>
		<script type="text/javascript">
			alert("선택 배팅 내역이 삭제되었습니다.\n진행중인 배팅은 삭제되지 않습니다.");
			location.href = "<%= URL %>";
		</script>