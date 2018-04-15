<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->

<%
    '---------------------------------------------------------
    '   @Title : 회원 관련 처리 페이지
    '   @desc  : 회원 가입 및 회원 수정
    '---------------------------------------------------------
	Set Dber = new clsDBHelper

	
	'######## 모드별 처리 ##############	
	IF REQUEST("EMODE") = "MEMADD" THEN

            '######## 회원 가입 처리  ##############	
            
            RECOM_ID        = Trim(REQUEST("RECOM_ID"))
            RECOM_CODE      = Trim(REQUEST("RECOM_CODE"))
			IU_ID           = Trim(REQUEST("IU_ID"))
			IU_PW           = Trim(REQUEST("IU_PW"))
			IU_BankName     = Trim(REQUEST("IU_BankName"))
			IU_BankNum      = Trim(REQUEST("IU_BankNum"))
			IU_BankOwner    = Trim(REQUEST("IU_BankOwner"))			
			IU_NickName     = Trim(REQUEST("IU_NickName"))
			IU_CODE         = Trim(REQUEST("IU_CODE"))
			IU_Mobile1      = REQUEST("IU_Mobile1")
			IU_Mobile2      = REQUEST("IU_Mobile2")
			IU_Mobile3      = REQUEST("IU_Mobile3")
			IU_SITE         = REQUEST("IU_SITE")
			SMSYN           = REQUEST("SMSYN")
			IU_Email        = REQUEST("Email1")
			CI_IP           = REQUEST("REMOTE_ADDR")
			IU_CheckPhone   = REQUEST("IU_CheckPhone")
			IU_MOONEY_PW   = REQUEST("IU_MOONEY_PW")

'######## 싸이트 상태에 따른 추천 정보 체크
SQL = "UP_GetSET_SITE_OPEN"
		
	Set sRs = Dber.ExecSPReturnRS(SQL,nothing,nothing)
	SITE_OPEN = "2"
	
SET sRs = Nothing

IF cStr(SITE_OPEN) = "4" Then
%>
    <script type="text/javascript">
    alert("페이지에 접근할 수 없습니다.");
    location.href = "/"
    </script>
<%
    response.end
End IF

IF cStr(SITE_OPEN) = "3" THEN
    
	SQL = "SELECT IU_ID FROM INFO_USER_CODE WHERE IU_ID = ? AND IU_CODE = ?"
	reDim param(1)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,RECOM_ID)
	param(1) = Dber.MakeParam("@IU_CODE",adVarWChar,adParamInput,20,RECOM_CODE)

	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
	
	IF sRs.EOF THEN	
%>
	<script type="text/javascript">
		alert("아이디 혹은 코드가 정확하지 않습니다.");		
	</script>
<%	
        response.End	
    End IF			
ElseIF cStr(SITE_OPEN) = "5" THEN

	IF LEN(IU_Mobile2) < 3 OR LEN(IU_Mobile3) < 4 THEN
		sms_phone = "0000-0000-0000"
	ELSE
		sms_phone = IU_Mobile1&"-"&IU_Mobile2&"-"&IU_Mobile3
	END IF
	'response.Write sms_phone & "|||" & RECOM_CODE
	
	SQL = "SELECT sms_phone FROM dbo.sms WHERE sms_phone = ? AND sms_code = ?"
	reDim param(1)
	param(0) = Dber.MakeParam("@sms_phone",adVarWChar,adParamInput,20,sms_phone)
	param(1) = Dber.MakeParam("@sms_code",adVarWChar,adParamInput,20,RECOM_CODE)

	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
	
	IF sRs.EOF THEN	
%>

		<script type="text/javascript">
			alert("핸드폰 혹은 코드가 정확하지 않습니다.");
			history.back();
		</script>
<%	
        response.End	
	End IF
	arrSms_phone = Split(sms_phone,"-")
End IF

            '######## 아이디 체크 #######################
            IF NOT dfSiteUtil.Pattern("ID", IU_ID) Then
%>
		    <script type="text/javascript">
			    alert("첫글자는 영자 그뒤엔 영어숫자 4이상 12자리 이하로 가입하셔야 합니다.");
		    </script>
<%	
	            response.End        
            End IF
            
            '######## 닉네임 체크 #######################
            IF NOT dfSiteUtil.Pattern("NICKNAME", IU_NickName) Then
%>
		    <script type="text/javascript">
			    alert("닉네임은 한글/영어/숫자 조합 3~10자로 입력하셔야 합니다.");
			    
		    </script>
<%	
	            response.End        
            End IF
                        
            '######## 환전 비밀번호     ################
            IF NOT dfSiteUtil.Pattern("NUM",IU_MOONEY_PW) AND Len(IU_MOONEY_PW) = 6 Then
%>
		    <script type="text/javascript">
			    alert("환전 비밀번호는 숫자 6자로 입력하셔야 합니다.");
		    </script>
<%	
	            response.End                    
            End IF
                                       
            '######## 사용 불가 아이디 체크  ##############				
    	    If InStr(iu_nickname,"관리자") > 0 Or InStr(iu_nickname,"운영자") > 0 Or InStr(iu_nickname,"영자") > 0 Or InStr(iu_nickname,"리자") > 0 Or InStr(iu_nickname,"관리") > 0 Or InStr(iu_nickname,"운영") > 0 Or InStr(iu_nickname,"주인") > 0 Or InStr(iu_nickname,"책임") > 0 Then
%>
            <script type="text/javascript">
                alert('관리자 / 운영자 / 리자 / 영자 가 포함된 닉네임은 사용하실 수 없습니다.'); 
                
            </script>
<%
					response.end
			End if 
			
			If SMSYN <> "" Then 
				SMSYN = "1"
			Else
				SMSYN = "0"
			End If 

			IF LEN(IU_Mobile2) < 3 OR LEN(IU_Mobile3) < 4 THEN
				IU_Mobile = null
			ELSE
				IU_Mobile = IU_Mobile1&"-"&IU_Mobile2&"-"&IU_Mobile3
			END IF
            
            
            '######## 핸드폰 체크 #######################
            IF NOT dfSiteUtil.Pattern("MOBILE", IU_Mobile) Then
%>
		    <script type="text/javascript">
			    alert("정확한 핸드폰 번호를 입력하세요");
			    
		    </script>
<%	
	            response.End        
            End IF
                                                 
            '######## 사용 불가 아이피 체크 ##############
            
			IF Request.ServerVariables("REMOTE_ADDR") <> "125.187.40.131"  THEN 				
                
                IF IP_USE Then			    			    
                    SQL = "dbo.UP_GetINFO_USERByJoinIP"
        			
			        reDim param(1)
			        param(0) = Dber.MakeParam("@CI_IP",adVarWChar,adParamInput,20,CI_IP)
			        param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

			        Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
                    
			        IF NOT sRs.EOF THEN
				        With Response
					        sRs.Close
					        Set sRs = Nothing
					        Dber.Dispose
					        Set Dber = Nothing 
					        .Write "<script language=javascript>" & vbCrLf
					        .Write "alert('회원가입이 불가능한 IP입니다.\n이미 다른분이 가입한 ip입니다.1');" & vbCrLf
					        .Write "</script>" & vbCrLf
					        .END
				        END With
			        END IF

			        sRs.Close
			        Set sRs = Nothing    
    			    			    
			        SQL = "dbo.UP_GetCheck_IPByJoinIP"
        			
			        reDim param(1)
			        param(0) = Dber.MakeParam("@CI_IP",adVarWChar,adParamInput,20,CI_IP)
			        param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

			        Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
                    
			        IF NOT sRs.EOF THEN
				        With Response
					        sRs.Close
					        Set sRs = Nothing
					        Dber.Dispose
					        Set Dber = Nothing 
					        .Write "<script language=javascript>" & vbCrLf
					        .Write "alert('회원가입이 불가능한 IP입니다.\n이미 다른분이 가입한 ip입니다.2');" & vbCrLf
					        .Write "</script>" & vbCrLf
					        .END
				        END With
			        END IF

			        sRs.Close
			        Set sRs = Nothing                			    
                'End IF
                '########  핸드폰 인증번호 체크 ##############
                
                'IF SMS_USE AND cStr(SITE_OPEN) <> "5" THEN
			        SQL = "dbo.UP_GetINFO_PHONEByJoinPHONE"
        			
			        reDim param(1)
			        param(0) = Dber.MakeParam("@IU_Mobile",adVarWChar,adParamInput,100,IU_Mobile)
			        param(1) = Dber.MakeParam("@IU_CheckPhone",adVarWChar,adParamInput,100,IU_CheckPhone)

			        Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

			        IF sRs.EOF THEN			
				        With Response
					        sRs.Close
					        Set sRs = Nothing
					        Dber.Dispose
					        Set Dber = Nothing
					        .Write "<script language=javascript>" & vbCrLf
					        .Write "alert('인증번호가 일치하지 않습니다.');history.back(-1);" & vbCrLf
					        .Write "</script>" & vbCrLf
					        .END
				        END With            
			        END IF

			        sRs.Close
			        Set sRs = Nothing	
                End IF			        
			    			    
			End IF
			
 
            '######## 계좌번호 체크 #######################
            IF NOT dfSiteUtil.Pattern("NUM", IU_BankNum) Then
%>
		    <script type="text/javascript">
			    alert("계좌 번호는 숫자만 입력 가능합니다.");			    
		    </script>
<%	
	            response.End        
            End IF
                
            '######## 예금주 체크 #######################
            IF NOT dfSiteUtil.Pattern("HANGULONLY", IU_BankOwner) Then
%>
		    <script type="text/javascript">
			    alert("예금주는 한글만 입력 가능합니다.");			    
		    </script>
<%	
	            response.End        
            End IF

            
            '######## 추천인 코드 중 총판연동 계정이 있는지 체크 ##############
            IF Trim(IU_SITE) <> "" Then
                SQL = "SELECT IA_SITE FROM INFO_ADMIN WHERE IA_ID = ?  "
                reDim param(0)
                param(0) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,Session("JOBSITE"))
                Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
                IF NOT sRs.EOF THEN
                    Session("JOBSITE")	= IU_SITE
                    JOBSITE = IU_SITE                    
                End IF
			    sRs.Close
			    Set sRs = Nothing		                
            End IF                
			
			'추천인 존재하면 회원가입 후 추천인 카운트 올림				
			If RECOM_ID <> "" Then
				SQL = "dbo.UP_InsertInfo_UserByJoin"
				
				reDim param(13)
				param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,IU_ID)
				param(1) = Dber.MakeParam("@IU_PW",adVarWChar,adParamInput,50,IU_PW)
				param(2) = Dber.MakeParam("@IU_NickName",adVarWChar,adParamInput,20,IU_NickName)
				param(3) = Dber.MakeParam("@IU_BankName",adVarWChar,adParamInput,20,IU_BankName)
				param(4) = Dber.MakeParam("@IU_BankNum",adVarWChar,adParamInput,20,IU_BankNum)
				param(5) = Dber.MakeParam("@IU_BankOwner",adVarWChar,adParamInput,20,IU_BankOwner)
				param(6) = Dber.MakeParam("@IU_Mobile",adVarWChar,adParamInput,20,IU_Mobile)
				param(7) = Dber.MakeParam("@IU_Email",adVarWChar,adParamInput,50,"11111@naver.com")
				param(8) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
				param(9) = Dber.MakeParam("@SMSYN",adInteger,adParamInput, ,SMSYN)
				param(10) = Dber.MakeParam("@IU_CODES",adVarWChar,adParamInput,20,RECOM_CODE)
				param(11) = Dber.MakeParam("@IU_IP",adVarWChar,adParamInput,20,CI_IP)
				param(12) = Dber.MakeParam("@RECOM_ID",adVarWChar,adParamInput,20,"")
				param(13) = Dber.MakeParam("@IUGTYPE",adInteger,adParamInput, ,1)	
				'param(13) = Dber.MakeParam("@IU_MOONEY_PW",adVarWChar,adParamInput,20,IU_MOONEY_PW)
				
				Dber.ExecSP SQL,param,Nothing

                IF POINT_USE AND POINT_MEMBER_RECOM > 0 Then				
                    '추천인에게 포인트 정보를 넣는다.
			        SQL_SP = "UP_insertLOG_POINT"
        			
			        reDim param(3)
			        param(0) = Dber.MakeParam("@LP_ID",adVarWChar,adParamInput,20,RECOM_ID)
			        param(1) = Dber.MakeParam("@LP_TYPE",adInteger,adParamInput,20,1)
			        param(2) = Dber.MakeParam("@LP_POINT",adInteger,adParamInput,20,POINT_MEMBER_RECOM)
			        param(3) = Dber.MakeParam("@LP_COMMENTS",adVarWChar,adParamInput,50,"추천포인트")

			        Dber.ExecSP SQL_SP,param,Nothing
			        				        
                End IF    

                    SQL_SP = "UP_DeleteIU_CODE"
	                reDim param(0)
	                'param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,RECOM_ID)
	                param(0) = Dber.MakeParam("@IU_CODE",adVarWChar,adParamInput,20,RECOM_CODE)
                    response.write RECOM_ID & "--" & RECOM_CODE
	                Dber.ExecSP SQL_SP,param,Nothing                      
			Else

				SQL = "dbo.UP_InsertInfo_UserByJoin"
				
				reDim param(13)
				param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,IU_ID)
				param(1) = Dber.MakeParam("@IU_PW",adVarWChar,adParamInput,50,IU_PW)
				param(2) = Dber.MakeParam("@IU_NickName",adVarWChar,adParamInput,20,IU_NickName)
				param(3) = Dber.MakeParam("@IU_BankName",adVarWChar,adParamInput,20,IU_BankName)
				param(4) = Dber.MakeParam("@IU_BankNum",adVarWChar,adParamInput,20,IU_BankNum)
				param(5) = Dber.MakeParam("@IU_BankOwner",adVarWChar,adParamInput,20,IU_BankOwner)
				param(6) = Dber.MakeParam("@IU_Mobile",adVarWChar,adParamInput,20,IU_Mobile)
				param(7) = Dber.MakeParam("@IU_Email",adVarWChar,adParamInput,50,"11111@naver.com")
				param(8) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
				param(9) = Dber.MakeParam("@SMSYN",adInteger,adParamInput, ,SMSYN)
				param(10) = Dber.MakeParam("@IU_CODES",adVarWChar,adParamInput,20,RECOM_CODE)
				param(11) = Dber.MakeParam("@IU_IP",adVarWChar,adParamInput,20,CI_IP)
				param(12) = Dber.MakeParam("@RECOM_ID",adVarWChar,adParamInput,20,"")
				param(13) = Dber.MakeParam("@IUGTYPE",adInteger,adParamInput, ,1)	
				'param(13) = Dber.MakeParam("@IU_MOONEY_PW",adVarWChar,adParamInput,20,IU_MOONEY_PW)
				Dber.ExecSP SQL,param,Nothing					
			END If

                '추천 코드 지움							
                    SQL_SP = "UP_DeleteIU_CODE"
	                reDim param(0)
	                'param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,RECOM_ID)
	                param(0) = Dber.MakeParam("@IU_CODE",adVarWChar,adParamInput,20,RECOM_CODE)
                    response.write RECOM_ID & "--" & RECOM_CODE
	                Dber.ExecSP SQL_SP,param,Nothing

%>
			<script type="text/javascript">
				alert("회원가입이 정상적으로 이루어졌습니다.");
				top.location.href = '/';
			</script>	
<%		

	'######## 회원가입이 아닌 회원정보 수정시	 ##############
	ELSEIF REQUEST.Form("EMODE") = "MEMMOD" THEN

			IU_PW = Trim(Request.Form("IU_PW"))
			    
            '######## 기존 비밀번호와 신규 비밀번호 체크	 ##############
			SQL = "SELECT IU_PW FROM Info_User WHERE IU_ID= ? AND IU_SITE = ?"

			reDim param(1)
			param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
			param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

			Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

			OLD_PW = sRs("IU_PW")
            
			sRs.Close
			Set sRs=Nothing
			            
			If OLD_PW = IU_PW Then
				Dber.Dispose
				Set Dber = Nothing
				With Response
					.Write "<script language=javascript>" & vbCrLf
					.Write "alert('비밀번호는 이전과 틀려야 합니다.');" & vbCrLf
					.Write "</script>" & vbCrLf
					.END
				END With				
			End If 
               
		                
            '######## 회원 정보 업데이트	 ##############
			SQL = "dbo.UP_UpdateINFO_USERByUser1 "

			reDim param(2)
			param(0) = Dber.MakeParam("@IU_PW",adVarWChar,adParamInput,50,IU_PW)
			param(1) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
			param(2) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

			Dber.ExecSP SQL,param,Nothing

			Dber.Dispose
			Set Dber = Nothing	
%>
			<script type="text/javascript">
				alert("회원정보 수정이 정상적으로 이루어졌습니다.");
				parent.location.href="/";
			</script>	
<%

	END IF	
%>