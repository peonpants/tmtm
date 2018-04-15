<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../../_Common/Api/lta_object.asp" -->
<!-- #include file="../../_Common/Api/lta_function.asp" -->

<%	
    '########   리퀘스트    ##############

    PAGE  = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("PAGE")), 1, 1, 9999999) 
    Search = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("Search")), 0, 1, 2)
    Term = dfSiteUtil.F_initNumericParam(Trim(REQUEST("Term")), 0, 1, 3)
    Find = dfSiteUtil.SQL_Injection_T(Trim(dfRequest.Value("Find")))
    EMODE = dfSiteUtil.SQL_Injection_T(Trim(dfRequest.Value("EMODE")))
    BF_IDX  = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("BF_IDX")), 1, 1, 9999999) 
    IB_IDX = dfSiteUtil.SQL_Injection_T(Trim(dfRequest.Value("IB_IDX")))
    
    pageOption = "&Term=" & Term & "&Search=" & Search & "&Find=" & Server.URLEncode(Find)    	
	Set Dber = new clsDBHelper


    '#### 게시판 도배 방지
	'SQL = "select BFR_WRITER from BOARD_FREE_DISABLE WHERE BFR_WRITER = ?"
	
	SQL = "UP_INFO_BOARD_WCHK"
	reDim param(0)

	param(0) = Dber.MakeParam("@BF_WRITER",adVarWChar,adParamInput,20,Session("SD_ID"))
	
	Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

	IF NOT sRs.EOF Then
%>
<script type="text/javascript">
alert("회원님은 게시판 쓰기 권한이 없습니다. 관리자에게 문의하세요.");
history.back();
</script>
<%       
        response.End	       
	End IF

	sRs.Close
	Set sRs=Nothing
    
	IF EMODE = "FREEADD" THEN

        '########   게시판 등록 처리    ##############
		BF_Writer	= XSS_T(REQUEST("BF_Writer"))
		BF_Title	= XSS_T(Checkit(Trim(REQUEST("BF_Title"))))
		content_body = XSS_T(Checkit(Trim(REQUEST("BF_CONTENTS"))))
	
        '########   게시판 등록     ##############
        '########   글쓰기 레벨     ##############
		if Session("IU_LEVEL") = "9" then
		
		SQL = "UP_INFO_BOARD_LEVEL_CHK"
		reDim param(0)
		param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		
		Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
			If NOT sRs.EOF OR NOT sRs.BOF then
				bn_level = sRs(0)
				sRs.Close
				Set sRs=Nothing
			End If
		else
		bn_level=Session("IU_LEVEL")
		end if
		
		SQL = "UP_INFO_BOARD_INS"
		reDim param(6)
		param(0) = Dber.MakeParam("@BF_TITLE",adVarWChar,adParamInput,100,BF_TITLE)
		param(1) = Dber.MakeParam("@BF_WRITER",adVarWChar,adParamInput,20,BF_WRITER)
		param(2) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(3) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		param(4) = Dber.MakeParam("@content_body", adLongVarWChar, adParamInput, Len(content_body)*2, content_body)
        param(5) = Dber.MakeParam("@IB_IDX",adVarWChar,adParamInput,100,IB_IDX)
        param(6) = Dber.MakeParam("@BF_WRITER_LEVEL",adInteger,adParamInput,,bn_level)
        				
		Dber.ExecSP SQL,param,nothing
                              
        IF POINT_USE AND POINT_FREE > 0 Then              
        '하루 게시물 건수를 조회한다.
	        startDate = date() 
	        endDate = startDate & " 23:59:59"
	        startDate = startDate & " 00:00:00"

            'SQL = "select lp_id from LOG_POINTINOUT where lp_id = ? And LP_DATE > ? And LP_DATE < ? and LP_COMMENTS = ?"
        	
			SQL = "UP_INFO_POINT_CHK"
            reDim param(3)
            param(0) = Dber.MakeParam("@lp_id",adVarWChar,adParamInput,20,Session("SD_ID"))
            param(1) = Dber.MakeParam("@sDate",adVarWChar,adParamInput,20,startDate)
            param(2) = Dber.MakeParam("@eDate",adVarWChar,adParamInput,20,endDate)
            param(3) = Dber.MakeParam("@ip_comments",adVarWChar,adParamInput,20,"게시물등록")
            
            Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
            
            INPC = sRs.RecordCount
            IF INPC < POINT_FREE_COUNT Then                     
                '포인트 정보를 넣는다.
		        SQL_SP = "UP_insertLOG_POINT"
        		
		        reDim param(3)
		        param(0) = Dber.MakeParam("@LP_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		        param(1) = Dber.MakeParam("@LP_TYPE",adInteger,adParamInput,20,1)
		        param(2) = Dber.MakeParam("@LP_POINT",adInteger,adParamInput,20,POINT_FREE)
		        param(3) = Dber.MakeParam("@LP_COMMENTS",adVarWChar,adParamInput,50,"게시물등록")

		        Dber.ExecSP SQL_SP,param,Nothing
            End IF		        
        End IF		              
        
		Dber.Dispose
		Set Dber = Nothing 
		
		WITH RESPONSE
			.WRITE "<script language='javascript'>" & VbCrLf
			.WRITE "alert('작성하신 글이 등록되었습니다.');" & VbCrLf
			.WRITE "location.href='/freeboard/board_list.asp'" & VbCrLf
			.WRITE "</script>" & VbCrLf
			.END
		END WITH

	ELSEIF EMODE = "FREEMOD" THEN
        '########   게시판 수정     ##############
        
		BF_IDX		= REQUEST("BF_IDX")
		BF_Title	= XSS_T(Checkit(Trim(REQUEST("BF_Title"))))
		content_body = XSS_T(Checkit(Trim(REQUEST("BF_CONTENTS"))))
		
		SQL = "UP_INFO_BOARD_PW"
		reDim param(0)
		param(0) = Dber.MakeParam("@BF_IDX",adInteger,adParamInput,,BF_IDX)
		
		Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

		BF_PW = sRs(0)

		sRs.Close
		Set sRs=Nothing

		IF Session("SD_ID") = BF_PW Then

			If Not content_body = "" Then
				
				SQL = "UP_INFO_BOARD_UPD"
				reDim param(2)
				param(0) = Dber.MakeParam("@BF_TITLE",adVarWChar,adParamInput,100,BF_TITLE)
				param(1) = Dber.MakeParam("@content_body", adLongVarWChar, adParamInput, Len(content_body)*2, content_body)
				param(2) = Dber.MakeParam("@content_number", adInteger, adParamInput, , BF_IDX)
				
				Dber.ExecSP SQL,param,Nothing
			End If  

			Dber.Dispose
			Set Dber = Nothing 
			URL = "/freeboard/board_read.asp?BF_IDX="&BF_IDX&"&Page="&Page & pageOption
			RESPONSE.REDIRECT URL
		Else
			Dber.Dispose
			Set Dber = Nothing 
			WITH RESPONSE
				.WRITE "<script language='javascript'>" & VbCrLf
				.WRITE "alert('수정 권한이 없습니다.');" & VbCrLf
				.WRITE "history.back();" & VbCrLf
				.WRITE "</script>" & VbCrLf
				.END
			END WITH
		END IF

	ELSEIF EMODE = "FREEDEL" THEN
        '########   글 삭제     ##############

		BF_IDX		= REQUEST("BF_IDX")
		BF_WRITER	= REQUEST("BF_WRITER")

		IF Session("IU_NickName") = BF_WRITER THEN

			SQL = "UP_INFO_BOARD_DEL"
			reDim param(0)
			param(0) = Dber.MakeParam("@BF_IDX", adInteger, adParamInput, , BF_IDX)
			Dber.ExecSP SQL,param,Nothing
			
			Dber.Dispose
			Set Dber = Nothing

			URL = "/freeboard/board_list.asp?BF_IDX=&Page="&Page & pageOption
			RESPONSE.REDIRECT URL
		Else
			Dber.Dispose
			Set Dber = Nothing
			WITH RESPONSE
				.WRITE "<script language='javascript'>" & VbCrLf
				.WRITE "alert('삭제 권한이 없습니다.');" & VbCrLf
				.WRITE "history.back();" & VbCrLf
				.WRITE "</script>" & VbCrLf
				.END
			END WITH
		END IF
	ELSEIF EMODE = "REPADD" THEN
        '########   댓글 수정     ##############
		BF_IDX		= REQUEST("BF_IDX")
		BF_IDX_NEW		= REQUEST("BF_IDX_NEW")
		BFR_WRITER	= REQUEST("BFR_WRITER")
		BFR_CONTENT	= Checkit(REQUEST("BFR_CONTENT"))
        '########   글쓰기 레벨     ##############
		if Session("IU_LEVEL") = "9" then
		
		SQL = "UP_INFO_BOARD_LEVEL_CHK"
		reDim param(0)
		param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		
		Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

		bn_level = sRs(0)
		sRs.Close
		Set sRs=Nothing
		else
		bn_level=Session("IU_LEVEL")
		end if

		
		SQL = "UP_INFO_BOARD_REPLY_INS"
		reDim param(3)
		param(0) = Dber.MakeParam("@BF_IDX", adInteger, adParamInput, , BF_IDX)
		param(1) = Dber.MakeParam("@BFR_CONTENT", adVarWChar, adParamInput, 4000, BFR_CONTENT)
		param(2) = Dber.MakeParam("@BFR_WRITER", adVarWChar, adParamInput, 20, BFR_WRITER)
		param(3) = Dber.MakeParam("@BFR_WRITER_LEVEL", adInteger, adParamInput, , bn_level)
		
		Dber.ExecSP SQL,param,Nothing
        
		'SQL="UPDATE Board_Free SET BF_REPLYCNT=BF_REPLYCNT+1 WHERE BF_IDX = ? "
		
		SQL = "UP_INFO_BOARD_INS_CNT"
		reDim param(0)
		param(0) = Dber.MakeParam("@BF_IDX", adInteger, adParamInput, , BF_IDX)
		Dber.ExecSP SQL,param,Nothing
	
	    IF POINT_USE AND POINT_FREE_REPLY > 0 Then  
	    
	        startDate = date() 
	        endDate = startDate & " 23:59:59"
	        startDate = startDate & " 00:00:00"

        	
			SQL = "UP_INFO_POINTLOG_CHK"
            reDim param(3)
            param(0) = Dber.MakeParam("@lp_id",adVarWChar,adParamInput,20,Session("SD_ID"))
            param(1) = Dber.MakeParam("@sDate",adVarWChar,adParamInput,20,startDate)
            param(2) = Dber.MakeParam("@eDate",adVarWChar,adParamInput,20,endDate)
            param(3) = Dber.MakeParam("@lp_comments",adVarWChar,adParamInput,20,"댓글등록")
            
            Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
            
            INPC = sRs.RecordCount
            
            IF INPC < POINT_FREE_REPLY_COUNT Then   
            	    
                '포인트 정보를 넣는다.
		        SQL_SP = "UP_insertLOG_POINT"
        		
		        reDim param(3)
		        param(0) = Dber.MakeParam("@LP_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		        param(1) = Dber.MakeParam("@LP_TYPE",adInteger,adParamInput,20,1)
		        param(2) = Dber.MakeParam("@LP_POINT",adInteger,adParamInput,20,POINT_FREE_REPLY)
		        param(3) = Dber.MakeParam("@LP_COMMENTS",adVarWChar,adParamInput,50,"댓글등록")

		        Dber.ExecSP SQL_SP,param,Nothing
            End IF
            		        
        End IF			
		Dber.Dispose
		Set Dber = Nothing 
		URL = "/freeboard/board_read.asp?BF_IDX="&BF_IDX&"&Page="&Page & pageOption
		RESPONSE.REDIRECT URL
        
	ELSEIF EMODE = "REPDEL" THEN
        '########   댓글 삭제     ##############
        
		BF_IDX		= REQUEST("BF_IDX")
		BFR_IDX		= REQUEST("BFR_IDX")
		BFR_WRITER	= REQUEST("BFR_WRITER")

		IF Session("IU_NickName") = BFR_WRITER THEN
			'SQL="DELETE FROM Board_Free_Reply Where BFR_IDX = ?"

			SQL = "UP_INFO_Board_Reply_DEL"
			reDim param(0)
			param(0) = Dber.MakeParam("@BFR_IDX", adInteger, adParamInput, , BFR_IDX)
			Dber.ExecSP SQL,param,Nothing
			

			SQL = "UP_INFO_Board_Reply_UPD"
			reDim param(0)
			param(0) = Dber.MakeParam("@BF_IDX", adInteger, adParamInput, , BF_IDX)
			Dber.ExecSQL SQL,param,Nothing			
			
			Dber.Dispose
			Set Dber = Nothing
			URL = "/freeboard/board_read.asp?BF_IDX="&BF_IDX&"&Page="&Page & pageOption
			RESPONSE.REDIRECT URL
		Else
			Dber.Dispose
			Set Dber = Nothing
			WITH RESPONSE
				.WRITE "<script language='javascript'>" & VbCrLf
				.WRITE "alert('삭제 권한이 없습니다.');" & VbCrLf
				.WRITE "history.back();" & VbCrLf
				.WRITE "</script>" & VbCrLf
				.END
			END WITH
		END IF

	ELSEIF EMODE = "QNAADD" THEN
        '########   고개센터 등록     ##############
		Bc_Writer	= XSS_T(REQUEST("Bc_Writer"))
		Bc_Title	= XSS_T(Checkit(Trim(REQUEST("Bc_Title"))))
		For xo = 1 To Request.Form("TEditor_b").Count 
			content_body = content_body + Request.Form("TEditor_b")(xo)
		Next	
		If Trim(content_body) = "" Then
		WITH RESPONSE
			.WRITE "<script language='javascript'>" & VbCrLf
			.WRITE "alert('글 내용을 입력해주세요.');" & VbCrLf
			.WRITE "history.back(-1);" & VbCrLf
			.WRITE "</script>" & VbCrLf
			.END
		END WITH		
		response.end
		End If 
		content_body = XSS_T(ReplaceContents(content_body))
		If Len(content_body) > 3900 Then
			Dber.Dispose
			Set Dber = Nothing
			WITH RESPONSE
				.WRITE "<script language='javascript'>" & VbCrLf
				.WRITE "alert('1800자 이상은 등록되지 않습니다.');" & VbCrLf
				.WRITE "history.back(-1);" & VbCrLf
				.WRITE "</script>" & VbCrLf
				.END
			END WITH

		End If 	

		SQL = "UP_INFO_Board_Customer_INS"
		reDim param(4)
		param(0) = Dber.MakeParam("@BC_WRITER", adVarWChar, adParamInput, 20, BC_WRITER)
		param(1) = Dber.MakeParam("@IU_ID", adVarWChar, adParamInput, 20, Session("SD_ID"))
		param(2) = Dber.MakeParam("@BC_TITLE", adVarWChar, adParamInput, 100, BC_TITLE)
		param(3) = Dber.MakeParam("@content_body", adVarWChar, adParamInput, 4000, content_body)
		param(4) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)	
		Dber.ExecSP SQL,param,Nothing
		Dber.Dispose
		Set Dber = Nothing
		WITH RESPONSE
			.WRITE "<script language='javascript'>" & VbCrLf
			.WRITE "alert('작성하신 문의글이 등록되었습니다.');" & VbCrLf
			.WRITE "location.href='/support/Answer_List.asp'" & VbCrLf
			.WRITE "</script>" & VbCrLf
			.END
		END WITH

	ELSEIF EMODE = "QNAMOD" THEN

	ELSEIF EMODE = "QNADEL" THEN
        '########   고개센터 삭제     ##############
		SelUser = Request("SelUser")
		TotalCount = Request("SelUser").Count
		
		FOR i = 1 TO TotalCount
			BC_IDX = Trim(REQUEST("SelUser")(i))

			SQL = "UP_INFO_Board_Customer_UPD"
			reDim param(0)
			param(0) = Dber.MakeParam("@BC_IDX", adInteger, adParamInput, , BC_IDX)
			Dber.ExecSQL SQL,param,Nothing
			
		NEXT
		Dber.Dispose
		Set Dber = Nothing
		WITH RESPONSE
			.WRITE "<script language='javascript'>" & VbCrLf
			.WRITE "alert('삭제 처리가 완료되었습니다.');" & VbCrLf
			.WRITE "parent.location.reload();" & VbCrLf
			.WRITE "</script>" & VbCrLf
			.END
		END WITH

	ELSEIF EMODE = "QNADELE" THEN
        '########   고개센터 삭제     ##############
		BC_IDX		= REQUEST("BC_IDX")
		BC_WRITER	= REQUEST("BC_WRITER")

		IF Session("IU_NickName") = BC_WRITER Or BC_WRITER = "관리자" THEN
			'SQL="update board_customer set bc_delyn = 1 ,bc_read = 1 where bc_idx = ?"

			SQL = "UP_INFO_Board_Customer_UPD"
			reDim param(0)
			param(0) = Dber.MakeParam("@BC_IDX", adInteger, adParamInput, , BC_IDX)
			Dber.ExecSQL SQL,param,Nothing

			Dber.Dispose
			Set Dber = Nothing
			URL = "/support/Answer_List.asp?Page="&Page&"&Search="&Search&"&Find="&Find&""
			RESPONSE.REDIRECT URL
		Else
			Dber.Dispose
			Set Dber = Nothing
			WITH RESPONSE
				.WRITE "<script language='javascript'>" & VbCrLf
				.WRITE "alert('삭제 권한이 없습니다.');" & VbCrLf
				.WRITE "history.back();" & VbCrLf
				.WRITE "</script>" & VbCrLf
				.END
			END WITH
		END IF

	END IF

	Dber.Dispose
	Set Dber = Nothing 
%>