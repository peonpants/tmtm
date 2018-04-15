<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<%
    '---------------------------------------------------------
    '   @Title :  환전 및 충전 처리 페이지
    '   @desc  :  
    '   @commnet : 모드값에 따른 환전 충전 처리 프로세스 페이지
    '---------------------------------------------------------
%>
<%
	EMODE	= Trim(REQUEST("EMODE"))

	Set Dber = new clsDBHelper
	
	 '########   충전 프로세스    ##############
	IF EMODE = "MONEY01" THEN

		IC_ID		= Session("SD_ID")
		IC_Name		= Trim(REQUEST.Form("IC_Name"))
		IC_Amount	= REPLACE(Trim(REQUEST.Form("IC_Amount")), ",", "")
        '########   입금 금액 체크    ##############               
		IF (IC_Amount mod 1000) <> 0 THEN
			With Response
				.write "<script type='text/javascript'>" & vbcrlf
				.write "alert('천원 단위로 가능합니다.');" & vbcrlf
				.write "</script>" & vbcrlf
				.End
			End With
		END IF

        '########   입금 처리    ##############               
		'SQL = "INSERT INTO Info_Charge (IC_ID, IC_Name, IC_Amount, IC_SITE)  VALUES ( ?, ?, ?, ? )"

		SQL = "UP_INFO_CHARGE_INS"

		reDim param(3)

		param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,12,Session("SD_ID"))
		param(1) = Dber.MakeParam("@IC_Name",adVarWChar,adParamInput,20,IC_Name)
		param(2) = Dber.MakeParam("@IC_Amount",adInteger,adParamInput, 20,IC_Amount)
		param(3) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		
		Dber.ExecSP SQL,param,Nothing	

		Dber.Dispose
		Set Dber = Nothing 
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	    %>

		<script type='text/javascript'>
			parent.location.href="charge.asp";
			alert("충전신청이 접수되었습니다.\n\n 은행의 입금이 확인되는데로 충전이 이루어집니다.");
		</script>	<%
    '########   충전 취소 처리    ##############               
	ELSEIF EMODE = "MONEY02" THEN

        '########   충전 내역 체크    ##############               
		IC_IDX = REQUEST("IC_IDX")
		'SQL = "select * from info_charge where IC_IDX = ? AND (IC_Status = 1 or IC_Status = 2)"
		
		SQL = "UP_INFO_CHARGE_LST"
		reDim param(0)
		param(0) = Dber.MakeParam("@IC_IDX",adInteger,adParamInput,,IC_IDX)

		Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

		If Not sRs.EOF Then
			sRs.close
			Set sRs = Nothing
			Dber.Dispose
			Set Dber = Nothing
		%>
		<script type='text/javascript'>
			parent.location.href="charge.asp";
			alert("충전신청이 진행중입니다.");
		</script>	
		<%
		else
		    
		    '########   충전 취소    ##############               
		    'SQL = "DELETE Info_Charge WHERE IC_IDX = ? AND IC_Status = 0"

			SQL = "UP_INFO_CHARGE_DEL"
		    reDim param(0)
		    param(0) = Dber.MakeParam("@IC_IDX",adInteger,adParamInput,,IC_IDX)

		    Dber.ExecSP SQL,param,Nothing	

		    sRs.close
		    Set sRs = Nothing
		    Dber.Dispose
		    Set Dber = Nothing
		%>
		<script type='text/javascript'>
			parent.location.href="charge.asp";
			alert("충전신청이 삭제되었습니다.");
		</script>	
		<%
		End If 
	'########   환전    ##############               
	ELSEIF EMODE = "MONEY03" THEN

		IE_ID = Session("SD_ID")
		IE_NickName = Session("IU_NickName")
		IE_Amount = REPLACE(Trim(REQUEST.Form("IE_Amount")), ",", "")
		IU_CheckPhone = REQUEST.Form("IU_CheckPhone")

        '########## 환전 인증번호 설정 정보를 가져온다.
		'SQL = "SELECT SITE_EXCHANGE FROM dbo.INFO_SITE_EXCHANGE WITH(NOLOCK)"
		
		SQL = "UP_INFO_SITE_EXCHANGE_LST"
		Set sRs = Dber.ExecSPReturnRS(SQL,nothing,nothing)

		SITE_EXCHANGE	= sRs(0)

		sRs.Close				
		Set sRs = Nothing	    
		
		

        '########   캐쉬정보 불러옴    ##############               	
		'SQL = "SELECT IU_CASH FROM INFO_USER WHERE IU_ID = ? AND IU_SITE = ? "

		SQL = "UP_INFO_CASH_SHOW"

		reDim param(1)
		param(0) = Dber.MakeParam("@IE_ID",adVarWChar,adParamInput,20,IE_ID)
		param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

		Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

		IU_CASH	= sRs(0)

		sRs.Close
		Set sRs = Nothing
        
'        IF cStr(SITE_EXCHANGE) = "1" Then        
'		    IF Len(IU_CheckPhone) <> 6 Then
'			    Dber.Dispose
'			    Set Dber = Nothing	
'			    With Response
'				    .write "<script type='text/javascript'>" & vbcrlf
'				    .write "alert('인증번호는 6자리입니다.');" & vbcrlf
'				    .write "</script>" & vbcrlf
'				    .End
'			    End With
'		    END IF
'       End IF		    
		
		IF Cdbl(IE_Amount) < 10000 Then
			Dber.Dispose
			Set Dber = Nothing	
			With Response
				.write "<script type='text/javascript'>" & vbcrlf
				.write "alert('환전 신청금액은 10,000원 이상 입력해 주세요.\n확인후 다시 신청해주세요.');" & vbcrlf
				.write "</script>" & vbcrlf
				.End
			End With
		END IF
				
		IF Cdbl(IU_Cash) < Cdbl(IE_Amount) Then
			Dber.Dispose
			Set Dber = Nothing	
			With Response
				.write "<script type='text/javascript'>" & vbcrlf
				.write "alert('환전가능금액보다 환전신청금액이 많습니다.\n확인후 다시 신청해주세요.');" & vbcrlf
				.write "</script>" & vbcrlf
				.End
			End With
		END IF

		IF (IE_Amount mod 1000) <> 0 Then
			Dber.Dispose
			Set Dber = Nothing		
			With Response
				.write "<script type='text/javascript'>" & vbcrlf
				.write "alert('천원 단위로 가능합니다.');" & vbcrlf
				.write "</script>" & vbcrlf
				.End
			End With
		END IF
        
        
        IF cStr(SITE_EXCHANGE) = "1" Then
            '######## 사용 중인 핸드폰 체크 ##############
	        'SQL = "SELECT IU_MOBILE FROM Info_User WHERE IU_ID = ? AND IU_SITE = ?"   
			
			SQL = "UP_INFO_USER_MOBILE_CHK"
	        reDim param(1)
	        param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,100,Session("SD_ID"))
	        param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

	        Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

	        IF sRs.EOF THEN
		        With Response
			        sRs.Close
			        Set sRs = Nothing
			        Dber.Dispose
			        Set Dber = Nothing
			        .Write "<script language=javascript>" & vbCrLf
			        .Write "alert('정상적인 접근바랍니다.');" & vbCrLf
			        .Write "</script>" & vbCrLf
			        .END
		        END With
            Else
                phoneNum = sRs("IU_MOBILE")		
	        END IF

	        sRs.Close
	        Set sRs = Nothing		
    	        
            '########  핸드폰 인증번호 체크 ##############
	        SQL = "dbo.UP_GetINFO_PHONEByJoinPHONE"
    		
	        reDim param(1)
	        param(0) = Dber.MakeParam("@IU_Mobile",adVarWChar,adParamInput,100,phoneNum)
	        param(1) = Dber.MakeParam("@IU_CheckPhone",adVarWChar,adParamInput,100,IU_CheckPhone)

	        Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

            IF sRs.EOF THEN			
		        With Response
			        sRs.Close
			        Set sRs = Nothing
			        Dber.Dispose
			        Set Dber = Nothing
			        .Write "<script language=javascript>" & vbCrLf
			        .Write "alert('인증번호가 일치하지 않습니다.');" & vbCrLf
			        .Write "</script>" & vbCrLf
			        .END
		        END With            
	        END IF


	        sRs.Close
	        Set sRs = Nothing	
        End IF	        
			            
        '########   환전 테이블에 삽입   ##############               	
		'SQL = "INSERT INTO Info_Exchange (IE_ID, IE_NickName, IE_Amount, IE_SITE) VALUES( ?, ?, ?, ?)"
		
		SQL = "UP_INFO_EXCHANGE_CHK"
		reDim param(3)
		param(0) = Dber.MakeParam("@IE_ID",adVarWChar,adParamInput,20,IE_ID)
		param(1) = Dber.MakeParam("@IE_NickName",adVarWChar,adParamInput,20,IE_NickName)
		param(2) = Dber.MakeParam("@IE_Amount",adInteger,adParamInput,,IE_Amount)
		param(3) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		
		Dber.ExecSP SQL,param,Nothing
		
		'########   회원 캐쉬 차감   ##############               	
		'SQL = "UPDATE Info_User SET IU_Cash = IU_Cash - ? WHERE IU_ID = ? AND IU_SITE = ? "
		
		SQL = "UP_INFO_EXCHANGE_UPD"
		reDim param(2)
		param(0) = Dber.MakeParam("@IE_Amount",adInteger,adParamInput,,Int(IE_Amount))
		param(1) = Dber.MakeParam("@IE_ID",adVarWChar,adParamInput,20,IE_ID)
		param(2) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		
		Dber.ExecSP SQL,param,Nothing
		
		Dber.Dispose
		Set Dber = Nothing	
		%>

		<script type='text/javascript'>
			parent.location.href="exchange.asp";
			alert("머니환전 신청이 접수되었습니다.\n환전신청시 문의 사항이 있으시면 고객센터로 문의 바랍니다.");
		</script>	
	<%
	'########   머니이동    ##############               
	ELSEIF EMODE = "MONEY04" THEN

		IE_ID = Session("SD_ID")
		IE_NickName = Session("IU_NickName")
		IE_Amount = REPLACE(Trim(REQUEST.Form("IE_Amount")), ",", "")
		IU_CheckPhone = REQUEST.Form("IU_CheckPhone")
		outSite  = REQUEST.Form("outSite")
		inSite  = REQUEST.Form("inSite")

		SQL = "UP_INFO_CASH_SHOW"

		reDim param(1)
		param(0) = Dber.MakeParam("@IE_ID",adVarWChar,adParamInput,20,IE_ID)
		param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

		Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

		IU_CASH	= sRs(0)

		sRs.Close
		Set sRs = Nothing	    
		
		IF Cdbl(IE_Amount) < 10000 Then
			Dber.Dispose
			Set Dber = Nothing	
			With Response
				.write "<script type='text/javascript'>" & vbcrlf
				.write "alert('머니이동 신청금액은 10,000원 이상 입력해 주세요.\n확인후 다시 신청해주세요.');" & vbcrlf
				.write "</script>" & vbcrlf
				.End
			End With
		END IF
				
		IF Cdbl(IU_Cash) < Cdbl(IE_Amount) Then
			Dber.Dispose
			Set Dber = Nothing	
			With Response
				.write "<script type='text/javascript'>" & vbcrlf
				.write "alert('이동가능금액보다 이동신청금액이 많습니다.\n확인후 다시 신청해주세요.');" & vbcrlf
				.write "</script>" & vbcrlf
				.End
			End With
		END IF

		IF (IE_Amount mod 1000) <> 0 Then
			Dber.Dispose
			Set Dber = Nothing		
			With Response
				.write "<script type='text/javascript'>" & vbcrlf
				.write "alert('천원 단위로 가능합니다.');" & vbcrlf
				.write "</script>" & vbcrlf
				.End
			End With
		END IF
        
                       
			            
        '########   환전 테이블에 삽입   ##############               	
		'SQL = "INSERT INTO Info_Exchange (IE_ID, IE_NickName, IE_Amount, IE_SITE) VALUES( ?, ?, ?, ?)"
		
		SQL = "UP_INFO_TRANFER_CHK"
		reDim param(5)
		param(0) = Dber.MakeParam("@IE_ID",adVarWChar,adParamInput,20,IE_ID)
		param(1) = Dber.MakeParam("@IE_NickName",adVarWChar,adParamInput,20,IE_NickName)
		param(2) = Dber.MakeParam("@IE_Amount",adInteger,adParamInput,,IE_Amount)
		param(3) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		param(4) = Dber.MakeParam("@IT_INSITE",adVarWChar,adParamInput,20,outSite)
		param(5) = Dber.MakeParam("@IT_OUTSITE",adVarWChar,adParamInput,20,inSite)
		
		Dber.ExecSP SQL,param,Nothing
		
		'########   회원 캐쉬 차감   ##############               	
		'SQL = "UPDATE Info_User SET IU_Cash = IU_Cash - ? WHERE IU_ID = ? AND IU_SITE = ? "
		
		SQL = "UP_INFO_EXCHANGE_UPD"
		reDim param(2)
		param(0) = Dber.MakeParam("@IE_Amount",adInteger,adParamInput,,Int(IE_Amount))
		param(1) = Dber.MakeParam("@IE_ID",adVarWChar,adParamInput,20,IE_ID)
		param(2) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		
		Dber.ExecSP SQL,param,Nothing
		
		Dber.Dispose
		Set Dber = Nothing	
		%>

		<script type='text/javascript'>
			parent.location.href="changemove.asp";
			alert("머니이동 신청이 접수되었습니다.\n 이동신청시 문의 사항이 있으시면 고객센터로 문의 바랍니다.");
		</script>	
	<%
	ELSEIF EMODE = "POINT" THEN

        IE_ID		= Session("SD_ID")
		IE_NickName		= Trim(REQUEST.Form("IE_NickName"))
		IU_POINT		= Trim(REQUEST.Form("IU_POINT"))		
		IE_Amount	= REPLACE(Trim(REQUEST.Form("IE_Amount")), ",", "")
               
        '현재 포인트 금액보다 전환금액이 클 경우 체크       
        'SQL = "select isNull(IU_POINT,0) from dbo.INFO_USER with (nolock) where IU_ID = ?"

		SQL = "UP_INFO_POINT_LST"
		reDim param(0)
		param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
       
        Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
            MY_POINT = sRs(0)
        
		sRs.close
		Set sRs = Nothing 
        
        IF int(IU_POINT) <>  int(MY_POINT) Then
			With Response
				.write "<script type='text/javascript'>" & vbcrlf
				.write "alert('정상적인 접근바랍니다.');" & vbcrlf
				.write "</script>" & vbcrlf
				.End
			End With           
        End IF
                       
        '########   입금 금액 체크    ##############    
        IF Int(IE_Amount) >  Int(IU_POINT) Then
			With Response
				.write "<script type='text/javascript'>" & vbcrlf
				.write "alert('정상적인 접근바랍니다.');" & vbcrlf
				.write "</script>" & vbcrlf
				.End
			End With        
        End IF
        
		IF Int(IE_Amount) < 1000 THEN
			With Response
				.write "<script type='text/javascript'>" & vbcrlf
				.write "alert('1,000포인트 이상만 전환 가능합니다.');" & vbcrlf
				.write "</script>" & vbcrlf
				.End
			End With
		END IF

		'SQL = "SELECT IU_CASH FROM INFO_USER WHERE IU_ID = ? AND IU_SITE = ? "
		
		SQL = "UP_INFO_CASH_SHOW"
		reDim param(1)
		param(0) = Dber.MakeParam("@IE_ID",adVarWChar,adParamInput,20,IE_ID)
		param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

		Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

		IU_CASH	= sRs(0)

		sRs.Close
		Set sRs = Nothing

		
        '포인트 정보를 넣는다.
		SQL_SP = "UP_insertLOG_POINT"
		
		reDim param(3)
		param(0) = Dber.MakeParam("@LP_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@LP_TYPE",adInteger,adParamInput,20,2)
		param(2) = Dber.MakeParam("@LP_POINT",adInteger,adParamInput,20,-(IE_Amount))
		param(3) = Dber.MakeParam("@LP_COMMENTS",adVarWChar,adParamInput,50,"캐쉬전환")

		Dber.ExecSP SQL_SP,param,Nothing	 

		'########   회원 캐쉬 증감   ##############     
		IE_Amount = IE_Amount          	
		'SQL = "UPDATE Info_User SET IU_Cash = IU_Cash + ? WHERE IU_ID = ? AND IU_SITE = ? "
		
		SQL = "UP_INFO_CASH_UPD"
		reDim param(2)
		param(0) = Dber.MakeParam("@IU_Cash",adInteger,adParamInput,,Int(IE_Amount))
		param(1) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(2) = Dber.MakeParam("@IU_SITE",adVarWChar,adParamInput,20,JOBSITE)
		
		Dber.ExecSP SQL,param,Nothing
		
		
	    'Log_CashInOut 에 충전 기록
	   ' SQL = "Insert Into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, LC_BONUS) values( ?, ?, ?, '캐쉬전환', ? ,1) "
	    
		SQL = "UP_INFO_CASH_LOG_INS"
		reDim param(3)		
		param(0) = Dber.MakeParam("@LC_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@LC_Cash",adInteger,adParamInput,,Int(IE_Amount))
		param(2) = Dber.MakeParam("@LC_GCASH",adInteger,adParamInput,,Int(IU_Cash))
		param(3) = Dber.MakeParam("@LC_SITE",adVarWChar,adParamInput,20,JOBSITE)
		
		Dber.ExecSP SQL,param,Nothing	
        
        Dber.Dispose
		Set Dber = Nothing	
%>

		<script type='text/javascript'>
			parent.location.href="point.asp";
			alert("캐쉬 변환이 정상적으로 이루어졌습니다.\n앞으로도 많은 활동 부탁드립니다.");
		</script>
<%		
ELSEIF EMODE = "POINT1" THEN '바로 캐쉬 전환
        
        IE_ID		= Session("SD_ID")				        
		'SQL = "SELECT IU_CASH, IU_Point FROM INFO_USER WHERE IU_ID = ? AND IU_SITE = ? "
		
		SQL = "UP_INFO_CASH_LST"
		reDim param(1)
		param(0) = Dber.MakeParam("@IE_ID",adVarWChar,adParamInput,20,IE_ID)
		param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

		Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

		IU_CASH	    = sRs("IU_CASH")
		IU_POINT    = sRs("IU_Point")	 
			
		sRs.Close
		Set sRs = Nothing
		        
                       
        '########   입금 금액 체크    ##############    
         
		IF Int(IU_POINT) < 1000 THEN
			With Response
				%>		
						<script type='text/javascript'>
							parent.location.href="/";
							alert("1000포인트 이상만 전환이 가능합니다.");
						</script>
				<%  
				.End
			End With
		END IF

        '포인트 정보를 넣는다.
		SQL_SP = "UP_insertLOG_POINT"
		
		reDim param(3)
		param(0) = Dber.MakeParam("@LP_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@LP_TYPE",adInteger,adParamInput,20,2)
		param(2) = Dber.MakeParam("@LP_POINT",adInteger,adParamInput,20,-(IU_POINT))
		param(3) = Dber.MakeParam("@LP_COMMENTS",adVarWChar,adParamInput,50,"캐쉬전환")

		Dber.ExecSP SQL_SP,param,Nothing	
		

		'########   회원 캐쉬 증감   ##############     
		        	
		'SQL = "UPDATE Info_User SET IU_Cash = IU_Cash + ? WHERE IU_ID = ? AND IU_SITE = ? "
		
		SQL = "UP_INFO_CASH_UPD"
		reDim param(2)
		param(0) = Dber.MakeParam("@IU_Cash",adInteger,adParamInput,,Int(IU_POINT))
		param(1) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(2) = Dber.MakeParam("@IU_SITE",adVarWChar,adParamInput,20,JOBSITE)
		
		Dber.ExecSP SQL,param,Nothing
		
		
	    'Log_CashInOut 에 충전 기록
	    'SQL = "Insert Into Log_CashInOut( LC_ID, LC_Cash, LC_GCASH, LC_Contents, LC_SITE, LC_BONUS) values( ?, ?, ?, '캐쉬전환', ? ,1) "
	    	    
	    
		SQL = "UP_INFO_CASH_LOG_INS"

		IU_CASH = IU_CASH + IU_POINT
		
		reDim param(3)		
		param(0) = Dber.MakeParam("@LC_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@LC_Cash",adInteger,adParamInput,,Int(IU_POINT))
		param(2) = Dber.MakeParam("@LC_GCASH",adInteger,adParamInput,,Int(IU_Cash))
		param(3) = Dber.MakeParam("@LC_SITE",adVarWChar,adParamInput,20,JOBSITE)
		
		Dber.ExecSP SQL,param,Nothing	
        
        Dber.Dispose
		Set Dber = Nothing	
%>
		<script type='text/javascript'>
			parent.location.href="/";
			alert("포인트 전환이 완료 되었습니다.");
		</script>
<%
ELSEIF EMODE = "SEND_POINT" THEN

        IE_ID		= Session("SD_ID")
		IE_NickName		= Trim(REQUEST.Form("IE_NickName"))
		IU_POINT		= Trim(REQUEST.Form("IU_POINT"))		
		IE_Amount	= REPLACE(Trim(REQUEST.Form("IE_Amount")), ",", "")
        
        RECOM_NICKNAME		= Trim(REQUEST.Form("RECOM_NICKNAME"))
               
		'SQL = "SELECT IU_ID FROM INFO_USER WHERE IU_NICKNAME = ?  "
		
		SQL = "UP_INFO_NICKNAME_CHK1"
		reDim param(0)
		param(0) = Dber.MakeParam("@IE_ID",adVarWChar,adParamInput,20,RECOM_NICKNAME)

		Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
        IF sRs.Eof Then
			Dber.Dispose
			Set Dber = Nothing		
			With Response
				.write "<script type='text/javascript'>" & vbcrlf
				.write "alert('선물받을 회원 닉네임을 확인하세주시기 바랍니다.');" & vbcrlf
				.write "</script>" & vbcrlf
				.End
			End With
        Else
            RECOM_ID	= sRs(0)			
        End IF

		sRs.Close
		Set sRs = Nothing
		
		
		               
        '########   입금 금액 체크    ##############    
        IF Int(IE_Amount) >  Int(IU_POINT) Then
			With Response
				.write "<script type='text/javascript'>" & vbcrlf
				.write "alert('정상적인 접근바랍니다.');" & vbcrlf
				.write "</script>" & vbcrlf
				.End
			End With        
        End IF
        
		IF Int(IE_Amount) < 1000 THEN
			With Response
				%>		
						<script type='text/javascript'>
							parent.location.href="/";
							alert("1000포인트 이상만 전환이 가능합니다.");
						</script>
				<% 
			End With
		END IF

        IF (IE_Amount mod 1000) <> 0 Then
			Dber.Dispose
			Set Dber = Nothing		
			With Response
				.write "<script type='text/javascript'>" & vbcrlf
				.write "alert('천원 단위로 전환 가능합니다.');" & vbcrlf
				.write "</script>" & vbcrlf
				.End
			End With
		END IF

		'SQL = "SELECT IU_CASH FROM INFO_USER WHERE IU_ID = ? AND IU_SITE = ? "
		
		SQL = "UP_INFO_CASH_SHOW"
		reDim param(1)
		param(0) = Dber.MakeParam("@IE_ID",adVarWChar,adParamInput,20,IE_ID)
		param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

		Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

		IU_CASH	= sRs(0)

		sRs.Close
		Set sRs = Nothing

		
        '선물한 사람에게 포인트 차감.
		SQL_SP = "UP_insertLOG_POINT"
		
		reDim param(3)
		param(0) = Dber.MakeParam("@LP_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@LP_TYPE",adInteger,adParamInput,20,2)
		param(2) = Dber.MakeParam("@LP_POINT",adInteger,adParamInput,20,-(IE_Amount))
		param(3) = Dber.MakeParam("@LP_COMMENTS",adVarWChar,adParamInput,50, RECOM_NICKNAME & "에게 포인트 선물")

		Dber.ExecSP SQL_SP,param,Nothing	 

        '선물한 사람에게 포인트 차감.
		SQL_SP = "UP_insertLOG_POINT"
		
		reDim param(3)
		param(0) = Dber.MakeParam("@LP_ID",adVarWChar,adParamInput,20,RECOM_ID)
		param(1) = Dber.MakeParam("@LP_TYPE",adInteger,adParamInput,20,1)
		param(2) = Dber.MakeParam("@LP_POINT",adInteger,adParamInput,20,IE_Amount)
		param(3) = Dber.MakeParam("@LP_COMMENTS",adVarWChar,adParamInput,50, Session("IU_NickName") & "님의 포인트 선물")

		Dber.ExecSP SQL_SP,param,Nothing	 



        
        Dber.Dispose
		Set Dber = Nothing	
%>

		<script type='text/javascript'>
            alert("포인트 선물이 정상적으로 이루어졌습니다.\n앞으로도 많은 활동 부탁드립니다.");
			parent.location.href="point.asp";
		</script>
<%		
    ELSEIF EMODE = "charge_del" THEN		
    
        IC_IDX = REQUEST("IC_IDX")
        '########   충전내역삭제   ##############               	
		'SQL = "UPDATE INFO_CHARGE SET IC_Del = 1 WHERE IC_ID = ? AND IC_SITE = ? AND IC_IDX = ? "
		
		SQL = "UP_INFO_CHARGE_UPDDEL"
		reDim param(2)
		
		param(0) = Dber.MakeParam("@IC_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		param(2) = Dber.MakeParam("@IC_IDX",adInteger,adParamInput,,Int(IC_IDX))
		
		Dber.ExecSP SQL,param,Nothing
		
		Dber.Dispose
		Set Dber = Nothing	
		    
%>		<script type='text/javascript'>
			parent.location.href="charge.asp";
			alert("충전내역이 지워졌습니다.");
		</script>
<%    
    ELSEIF EMODE = "exc_del" THEN		
  			
        IE_IDX = REQUEST("IE_IDX")
        '########   환전내역삭제   ##############               	
		'SQL = "UPDATE INFO_EXCHANGE SET IE_Del = 1 WHERE IE_ID = ? AND IE_SITE = ?  AND IE_IDX = ? "
		
		SQL = "UP_INFO_EXCHANGE_UPDDEL"
		reDim param(2)
		
		param(0) = Dber.MakeParam("@IE_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		param(2) = Dber.MakeParam("@IE_IDX",adInteger,adParamInput,,Int(IE_IDX))
		
		
		Dber.ExecSP SQL,param,Nothing
		
		Dber.Dispose
		Set Dber = Nothing	
		    
%>		<script type='text/javascript'>
			parent.location.href="exchange.asp";
			alert("환전내역이 지워졌습니다.");
		</script>
<%    
    ELSEIF EMODE = "exc_Tdel" THEN		'머니이동내역
  
        IE_IDX = REQUEST("IE_IDX")
        '########   환전내역삭제   ##############               	
		'SQL = "UPDATE INFO_EXCHANGE SET IE_Del = 1 WHERE IE_ID = ? AND IE_SITE = ?  AND IE_IDX = ? "
		
		SQL = "UP_INFO_TRANFER_UPDDEL"
		reDim param(2)
		
		param(0) = Dber.MakeParam("@IE_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		param(2) = Dber.MakeParam("@IE_IDX",adInteger,adParamInput,,Int(IE_IDX))
		
		
		Dber.ExecSP SQL,param,Nothing
		
		Dber.Dispose
		Set Dber = Nothing	
		    
%>		<script type='text/javascript'>
			parent.location.href="changemovelist.asp";
			alert("이동내역이 지워졌습니다.");
		</script>
<%     
	END IF
%>
