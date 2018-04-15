
<%
Response.CodePage = 65001
Response.CharSet = "UTF-8"
Class SiteUtil
	Private Sub Class_initialize ()
	End Sub	
	
	Private Sub Class_terminate ()
	End Sub

    public function makePassword(nLenMin, nLenMax)

        Dim idx, nEnd, nStat, resultStr

        nEnd = makeRand(nLenMin, nLenMax)
        resultStr = ""

        for idx=1 to nEnd
            nStat = makeRand(2,2)
            select case nStat
                case 0 : resultStr = resultStr & Chr(makeRand(Asc("a"),Asc("z")))
                case 1 : resultStr = resultStr & Chr(makeRand(Asc("A"),Asc("Z")))                            
                case 2 : resultStr = resultStr & Chr(makeRand(Asc("0"),Asc("9")))
            end select
        next

        makePassword = resultStr

    end function
    '-------------------------------------------------------------
    'nMin ~ nMax 범위 내에서 임의 숫자를 산출한다.
    '-------------------------------------------------------------
    public function makeRand(nMin, nMax)

        Randomize

        makeRand = Int((nMax - nMin + 1) * Rnd + nMin)

    end function 
    	
	'-------------------------------------------
	' Text Check Code
	'-------------------------------------------

	Public Function IsEmptyStr(ByVal pStr)
		Dim fFlag
	
		If IsNull(pStr) or pStr = "" Then 
			fFlag = true
		Else
			fFlag = false
		End If

		IsEmptyStr = fFlag
 
	End Function


	'-------------------------------------------
	' Numeric Check Code
	'-------------------------------------------

	Public Function ExistIsNumeric(ByVal pNum)

		If IsNumeric(pNum) Then 
			IsTrue = True
		Else
			IsTrue = False
		End If

		ExistIsNumeric	= IsTrue
 
	End Function


	Public Function Pattern(pPattern, pStr)
	  Dim fObjReg, fRegPatte
	  Dim fRegPatten

	  Set fObjReg = new RegExp
	  
	  Select Case UCase(pPattern)
		Case "NUM"
		  fRegPatten	= "^[0-9]+$"											' 숫자만
		Case "PHONE"
			fRegPatten	= "^[0-9]{2,4}-[0-9]{3,4}-[0-9]{4}$"				    ' 전화번호 형식 : 033-1234-5678
		Case "MOBILE"  
            fRegPatten = "^01[016789]{1}(\-)?[0-9]{3,4}(\-)?[0-9]{4}$"          ' 핸드폰 형식 : 010-123-1234			
		Case "MAIL"
		  fRegPatten	= "^[_a-zA-Z0-9-]+@[._a-zA-Z0-9-]+\.[a-zA-Z]+$" '		' 메일
		Case "DOMAIN"
		  fRegPatten	= "^[.a-zA-Z0-9-]+.[a-zA-Z]+$"							' 영자 숫자와 . 다음도 영자
		Case "ENGNUM"
		  fRegPatten	= "^[a-zA-Z0-9]+$"										' 영자와 숫자만
		Case "ENG"
		  fRegPatten	= "^[a-zA-Z]+$"											' 영자만
		Case "HOST"
		  fRegPatten	= "^[a-zA-Z-]+$"										' 영자 와 '-'
		Case "HANGUL"
		  fRegPatten	= "[가-힣]"												' 한글인지
		Case "HANGULENG"
		  fRegPatten	= "[가-힣a-zA-Z]"										' 한글영어
		Case "HANGULENGNUM"
		  fRegPatten	= "[가-힣a-zA-Z0-9]"									' 한글영어숫자
		Case "HANGULONLY"
		  fRegPatten	= "^[가-힣]*$"											' 한글만
		Case "NICKNAME"
		  fRegPatten	= "[가-힣a-zA-Z0-9]{2,10}$"									' 한글영어숫자		  
		Case "ID"
		  fRegPatten	= "[a-zA-Z0-9_-]{2,12}$"					' 첫글자는 영자 그뒤엔 영어숫자 2이상 12자리 이하
		Case "RECOM_ID"
		  fRegPatten	= "[가-힣a-zA-Z0-9]{2,10}$"									' 한글영어숫자		  
		Case "DATE"
		  fRegPatten	= "^[0-9]{4}-[0-9]{2}-[0-9]{2}$"						' 형식 : 2002-08-15
		Case "STATESTR"
		  fRegPatten	= "Y|N"													'Y또는N
		Case "STATENUM"
		  fRegPatten	= "^0|1$"												'0or1 상태값
		Case "ANSWERNUM"
		  fRegPatten	= "^0|1|2|3$"											'답변 상태값
        Case "NAME"            
		    fRegPatten = "^[가-힣]{2,6}$"                                       '한글 이름(2~6자로 간주한다.)
        Case "MOONEY"            
		    fRegPatten = "^[0-9]{6}$"                                       ' 숫자만
	  End Select


	  fObjReg.Pattern		= fRegPatten
	  fObjReg.IgnoreCase	= True	
	  fObjReg.Global		= True
	  Pattern			= fObjReg.Test(pStr&"" )

	End Function
	
	
	'-------------------------------------------
	' 문자열의 길이를 가지고 온다..
	' 문자열변수가 비었을 경우 길이로 0을 반환 한다.
	'-------------------------------------------

	Public Function LenStr(ByVal pStr)

		
		If  IsNull(pStr) or pStr = "" Then 
			LenStr = 0
		Else
			LenStr = Len(pStr)
		End If
 
	End Function

	
	
	'
	' 문자열의 Byte수를 가져온다... 한글및 기타 문자  2Byte 취급 
	'

	Function LenByte(ByVal pStr)

		Dim i, fChar, fLen
		
		fLen = 0 

		If  IsNull(pStr) or pStr = "" Then 
			LenByte = 0
		Else
			
			For i = 1 To Len(pStr)
				fChar = Mid(pStr, i, 1)	' 한 글자씩 끊어 온다

				If Asc(fChar) < 0 Then	' asc 값이 0보다 작으면 한글, 한문 혹은 한글 특수문자.
					fLen = fLen + 2
				Else
					fLen = fLen + 1
				End If
			Next
			
			LenByte = fLen
			
		End If 
		
		
	End Function


	'
	' 문자열의 Byte수를 가져온다... 한글및 기타 문자  2Byte 취급 
	'

	Function LenCheck(ByVal pStr, ByVal pMaxSize)

		Dim i, fChar, fLen
		Dim isTrue
		
		fLen = 0 

		If  IsNull(pStr) or pStr = "" Then 
			LenByte = 0
		Else
			
			For i = 1 To Len(pStr)
				fChar = Mid(pStr, i, 1)	' 한 글자씩 끊어 온다

				If Asc(fChar) < 0 Then	' asc 값이 0보다 작으면 한글, 한문 혹은 한글 특수문자.
					fLen = fLen + 2
				Else
					fLen = fLen + 1
				End If
			Next
			
			'LenByte = fLen
			
		End If 

		If Not IsNumeric(pMaxSize) Then
			isTrue = False
		End If

		If fLen > pMaxSize Then
			isTrue	= False
		End If

		LenCheck	= isTrue
		
	End Function

	'-------------------------------------------
	' ReplaceFrom
	'-------------------------------------------
	Public Function ReplaceFrom(ByVal pStr)


		pStr		= Replace(pStr,"<","&lt;")
		pStr		= Replace(pStr,">","&gt;")

		ReplaceFrom	=  pStr
 
	End Function

	'-------------------------------------------
	' ReplaceTo
	'-------------------------------------------
	Public Function ReplaceTo(ByVal pStr)


		pStr		= Replace(pStr,"&lt;","<")
		pStr		= Replace(pStr,"&gt;",">")

		ReplaceTo	=  pStr
 
	End Function


    ' 정해진 길이를 초과할경우 정해진 길이 만큼 문자열을 잘라서 반환
    ' param :	int		pMaxLen	: 최대 허용 길이
    '			string	pName	: 문자열
    Public Function GetShortString(pName, pMaxLen, pMark)
    	
	    IF Len(pName) > pMaxLen Then
		    GetShortString = Left(pName, pMaxLen-1) & pMark
	    Else
		    GetShortString = pName
	    End IF

    End Function
    
    
    ' 정해진 길이를 초과할경우 정해진 길이 만큼 문자열을 잘라서 반환(Byte단위)
    ' param :	int		pMaxLen	: 최대 허용 길이(Byte 단위)
    '			string	pName	: 문자열
    Public Function GetShortStringByte(pName, pMaxLen, pMark)
    	
	    Dim fNI, fByte, fRet, fLit
	    Dim fMaxLen

        If LenByte(pName) > pMaxLen Then
	        for fNI = 0 to Len (pName) - 1
		        fLit	= mid (pName, fNI + 1, 1)
		        fRet	= fRet & fLit
		        fByte	= fByte + 1
    		    
		        if Asc (fLit) < 0 then	fByte = fByte + 1

		        if fByte >= pMaxLen-2 then
			        if fByte > pMaxLen AND Asc (fLit) < 0 then
				        fRet = mid (fRet, 1, Len (fRet) - 1)
			        end if
    			    
			        fRet = fRet & pMark
			        exit for
		        end if
	        next
	        
    	    GetShortStringByte = fRet	    
        Else
            GetShortStringByte = pName
        End If
	    

    End Function    



    '----------------------------------------------------------------------
    'Desc      : String -> DEC
    'Parameter
    '@pstr     : String
    'return    : String
    '----------------------------------------------------------------------
    Public Function GetStrToDec(ByVal pstr)
        Dim fTmp
        fTmp = pstr 
        IF pstr <> "" Then   
          fTmp = replace(fTmp, chr(32), "&nbsp;")
          fTmp = replace(fTmp, """", "&#34;")
          fTmp = replace(fTmp, "%", "&#37;")
          fTmp = replace(fTmp, "'", "&#39;")
          'fTmp = replace(fTmp, "<", "&#60;")
          'fTmp = replace(fTmp, ">", "&#62;")
          fTmp = replace(fTmp, "<", "&lt;")
          fTmp = replace(fTmp, ">", "&gt;")
          fTmp = replace(fTmp, "(", "&#40;")
          fTmp = replace(fTmp, ")", "&#41;")
        End IF
        GetStrToDec = fTmp
    End Function
    
    '----------------------------------------------------------------------
    'Desc      : DEC -> String 
    'Parameter
    '@pstr     : String
    'return    : String
    '----------------------------------------------------------------------
    Public Function GetDecToStr(ByVal pstr)
        Dim fTmp
        fTmp = pstr 
        IF pstr <> "" Then   
          fTmp = replace(fTmp, "&nbsp;", chr(32))
          fTmp = replace(fTmp, "&#34;", """")
          fTmp = replace(fTmp, "&#37", "%")
          fTmp = replace(fTmp, "&#39;", "'")
          'fTmp = replace(fTmp, "&#60;", "<")
          'fTmp = replace(fTmp, "&#62;", ">")
          fTmp = replace(fTmp, "&lt;", "<")
          fTmp = replace(fTmp, "&gt;", ">")
          fTmp = replace(fTmp, "&#40;", "(")
          fTmp = replace(fTmp, "&#41;", ")")
        End IF
        GetDecToStr = fTmp
    End Function
    
    
    '----------------------------------------------------------------------
    'Desc      : nl2br
    'Parameter
    '@pstr     : String
    'return    : String
    '----------------------------------------------------------------------
    Public Function Getnl2br(ByVal pstr)
        Dim fTmp
        fTmp = pstr 
        IF pstr <> "" Then   
          fTmp = replace(fTmp, chr(13)&chr(10), "<br>")
        End IF
        Getnl2br = fTmp
    End Function
    
    '----------------------------------------------------------------------
    'Desc      : nl2nbsp
    'Parameter
    '@pstr     : String
    'return    : String
    '----------------------------------------------------------------------
    Public Function Getnl2nbsp(ByVal pstr)
        Dim fTmp
        fTmp = pstr 
        IF pstr <> "" Then   
          fTmp = replace(fTmp, chr(13)&chr(10), "&nbsp;")
        End IF
        F_nl2nbsp = fTmp
    End Function    

	Public Function F_initNumericParam(strParam, nDefault, nMinVal, nMaxVal)

		Dim nRtnVal
		If not IsNumeric(strParam) Then
		        nRtnVal = nDefault
		Else
		        nRtnVal = Int(strParam)
		        If nRtnVal < nMinVal Then nRtnVal = nDefault
		        If nRtnVal > nMaxVal Then nRtnVal = nDefault
		End If

		F_initNumericParam = nRtnVal

	End Function    


    function SQL_Injection_T( get_String )

       get_String = REPLACE( get_String, "'", "''" )
       'get_String = REPLACE( get_String, ";", "" )
       get_String = REPLACE( get_String, "--", "" )
       get_String = REPLACE( get_String, "select", "", 1, -1, 1 )
       get_String = REPLACE( get_String, "insert", "", 1, -1, 1 )
       get_String = REPLACE( get_String, "update", "", 1, -1, 1 )
       get_String = REPLACE( get_String, "delete", "", 1, -1, 1 )
       get_String = REPLACE( get_String, "drop", "", 1, -1, 1 )
       get_String = REPLACE( get_String, "union", "", 1, -1, 1 )
       get_String = REPLACE( get_String, "and", "", 1, -1, 1 )
       get_String = REPLACE( get_String, "or", "", 1, -1, 1 )
       get_String = REPLACE( get_String, "1=1", "", 1, -1, 1 )

       get_String = REPLACE( get_String, "sp_", "", 1, -1, 1 )
       get_String = REPLACE( get_String, "xp_", "", 1, -1, 1 )
       get_String = REPLACE( get_String, "@variable", "", 1, -1, 1 )
       get_String = REPLACE( get_String, "@@variable", "", 1, -1, 1 )
       get_String = REPLACE( get_String, "exec", "", 1, -1, 1 )
       get_String = REPLACE( get_String, "sysobject", "", 1, -1, 1 )

       SQL_Injection_T = get_String

    end Function
    
	Public Function GetFullDate(dt)
        
        Dim rtnVal
        				
        rtnVal = right("000" & year(dt)  , 4) & "-" & _		    
        right("0" & month(dt) , 2) & "-" & _
        right("0" & day(dt) , 2) & " " & _
        right("0" & hour(dt), 2) & ":" & _
        right("0" & minute(dt), 2)			

        GetFullDate = rtnVal
	
	End Function 
	
    Public Function GetBetDate(dt)
        
        Dim rtnVal
        				
        rtnVal = right("0" & month(dt) , 2) & "/" & _
        right("0" & day(dt) , 2) & " " & _
        right("0" & hour(dt), 2) & ":" & _
        right("0" & minute(dt), 2)			

        GetBetDate = rtnVal
	
	End Function 	    
	
    Public Function GetShotDate(dt)
        
        Dim rtnVal
        				
        rtnVal = right("0" & month(dt) , 2) & "/" & _
        right("0" & day(dt) , 2) 	

        GetShotDate = rtnVal
	
	End Function 	    
				
    Public Function GetShotDate1(dt)
        
        Dim rtnVal
        				
        rtnVal = right("000" & year(dt)  , 4)  & _		    
        right("0" & month(dt) , 2)  & _
        right("0" & day(dt) , 2)	

        GetShotDate1 = rtnVal
	
	End Function 	
					
	Public Function GetGamePercent(totalCnt, cnt)
        
        Dim rtnVal
        				
        rtnVal = Round((cnt/totalCnt) * 100 ,0)
        
        GetGamePercent = rtnVal
	
	End Function      
	
                   
    Function RemoveHTML( strText )
	    Dim RegEx

	    Set RegEx = New RegExp

	    RegEx.Pattern = "<[^>]*>"
	    RegEx.Global = True

	    RemoveHTML = RegEx.Replace(strText, "")
    End Function

                   
    Public Function GetBetInfo(IB_IDX)                       
    
        Set DberTemp = new clsDBHelper
        SQL = "SELECT IB_IDX, IB_TYPE, IG_IDX, IB_NUM, IB_BENEFIT, IB_AMOUNT, IB_STATUS, IB_REGDATE FROM Info_Betting WHERE IB_IDX IN (" & IB_IDX & ")  "
        
        Dim txttotalIBD_RESULT(9)
            txttotalIBD_RESULT(0) = "실패"
            txttotalIBD_RESULT(1) = "적중"
            txttotalIBD_RESULT(2) = "한배처리"
            txttotalIBD_RESULT(3) = "한배처리"
            txttotalIBD_RESULT(9) = "<font style=font-size:11px>진행중"
             
        
        Set sRs = DberTemp.ExecSQLReturnRS(SQL,nothing,nothing)
                        
        strGameInfo = ""
        IF NOT sRs.EOF THEN
        Do Until sRs.Eof       
        
        IB_IDX1             = 0 
        BenefitAmount       = 1
        BenefitAmountA      = 1
		BenefitAmountf      = 1
        TotalBenefit        = 1
		TotalBenefitF        = 1
        TotalBenefitA       = 1
		TotalBenefitB       = 1

        totalIBD_RESULT     = 5 '0  : 실패, 1  : 성공, 2 : 취소, 3 : 적중특례 , 5 : 진행중 , 9 : 진행중
                
            IB_IDX		= sRs(0)
            IB_TYPE		= sRs(1)
            IG_IDX		= sRs(2)
            IB_NUM		= sRs(3)
            IB_BENEFIT	= sRs(4)
            IB_AMOUNT	= sRs(5)
            IB_STATUS	= sRs(6)
            IB_REGDATE	= sRs(7)
            
            strGameInfo = strGameInfo & "<div id='betting_list'><table class='bettingtable01'><caption class='hidden'>스페셜</caption><colgroup><col width='9%'><col width='14%'><col width='28%'><col width='6%'><col width='28%'><col width='8%'><col width='6%'></colgroup><tbody><tr><th scope='col' style='font-size: 11px;'>경기일시</th><th scope='col' style='font-size: 11px;'>리그</th><th scope='col' style='font-size: 11px;'>[승]홈팀</th><th scope='col' style='font-size: 11px;'>무/기</th><th scope='col' style='font-size: 11px;'>[패]원정팀</th><th scope='col' style='font-size: 11px;'>결과</th><th scope='col' style='font-size: 11px;'>정보</th></tr></tbody></table><table class='bettingtable01'><colgroup><col width='9%'><col width='14%'><col width='29%'><col width='6%'><col width='29%'><col width='8%'><col width='6%'></colgroup>"
            

           SQL =  "UP_RetrieveINFO_BETTING_DETAILByPreview"

            reDim param(0)
            param(0) = DberTemp.MakeParam("@IB_Idx",adInteger,adParamInput, ,IB_Idx)
        			
            Set sRs2 = DberTemp.ExecSPReturnRS(SQL,param,nothing)
            
            
            IF NOT sRs2.Eof Then
            	        
                Do Until sRs2.Eof              
                    IG_IDX		= sRs2("IG_IDX")                    
	                RL_League		= sRs2("RL_League")
	                RL_IMAGE		= sRs2("RL_IMAGE")	        
					RL_Image		= "<img align='absmiddle' src='" & dfSiteUtil.GetLeagueImage(RL_Image) & "' width='26' />"
 	                IG_Team1		= sRs2("IG_Team1")
	                IG_Team2		= sRs2("IG_Team2")
	                IG_Status		= sRs2("IG_Status")
	                IG_Result		= sRs2("IG_Result")
	                IG_StartTime	= sRs2("IG_StartTime")
	                IG_Team1Benefit = sRs2("IG_Team1Benefit")
	                IG_DrawBenefit	= sRs2("IG_DrawBenefit")
	                IG_Team2Benefit	= sRs2("IG_Team2Benefit")
	                IG_Score1		= sRs2("IG_Score1")
	                IG_Score2		= sRs2("IG_Score2")
	                IG_Type			= sRs2("IG_Type")
	                IG_Handicap		= sRs2("IG_Handicap")
	                IG_Draw		    = sRs2("IG_Draw")
	                IBD_NUM         = sRs2("IBD_NUM")
	                IBD_RESULT      = sRs2("IBD_RESULT")
	                IBD_RESULT_BENEFIT = sRs2("IBD_RESULT_BENEFIT")
	                IBD_BENEFIT = sRs2("IBD_BENEFIT")
                
                    IG_Result = Trim(IG_Result)
                    
                    IF boolBET_CANCEL2 AND IG_StartTime > now() Then
                        boolBET_CANCEL2 = False
                    End IF     
                                
                    IF (IG_Status = "E") OR (IG_Status = "S") Then
                        IG_Result = 3
                    End IF
                            

	                IF IG_Type <> "0" THEN 
		                IG_DrawBenefit = IG_Handicap
	                END IF

                    IF boolBET_CANCEL2 AND IG_StartTime > now() Then
                        boolBET_CANCEL2 = False
                    End IF   
                    
                    IF IG_Type = "1" Then
                        txtIG_Type  = "핸디캡"   
                        IG_DRAWBENEFIT =  IG_HANDICAP
                    ElseIF IG_Type = "2" Then
                        txtIG_Type  = "오버/언더"  
                        IG_DRAWBENEFIT =  IG_HANDICAP  
                    Else
                        txtIG_Type  = "승무패"    
                    End IF
                    
                    IF IBD_NUM = "1" Then
                        choice  = "승"    
                    ElseIF IBD_NUM = "0" Then
                        choice  = "무"    
                    ElseIF IBD_NUM = "2" Then
                        choice  = "패"    
                    End IF
                    
'response.Write IBD_RESULT
                    IF IBD_RESULT = "0" Then    
                        txtIBD_RESULT = "실패"
            ElseIF IBD_RESULT = "1" Then
                 txtIBD_RESULT = "<font color='F5C60C'><b>적중</b></font>"
            ElseIF IBD_RESULT = "2" Then
                txtIBD_RESULT = "<font color='F35000'><b>취소</b></font>"
            ElseIF IBD_RESULT = "3" Then
                txtIBD_RESULT = "<font color='F35000'><b>적특</b></font>"
            Else
                txtIBD_RESULT = "<font color=chartreuse>진행</font>"
            End IF
                    
                    IF IBD_RESULT_BENEFIT = 1 Then
                        'txtIBD_RESULT = "<font color='B50D0D'>1배처리</font>"
                        IG_Result = 4            
                    End IF                    
                    
                    SCORE = IG_SCORE1 & " : " & IG_SCORE2
                    
                    '#### 진행 중인지 체크한다.
                    IF IBD_RESULT = 9  Then
                       totalIBD_RESULT = 9 
                       IBD_RESULT_BENEFIT = IBD_BENEFIT
                    End IF        
                    
                        
                    TotalBenefit = Cdbl(TotalBenefit) * Cdbl(IBD_RESULT_BENEFIT)
					TotalBenefitF = Cdbl(TotalBenefitF) * Cdbl(IBD_BENEFIT)
                    TotalBenefitA = Cdbl(TotalBenefitA) * Cdbl(IBD_BENEFIT) 
					TotalBenefitB = Cdbl(TotalBenefitB) * Cdbl(IBD_RESULT_BENEFIT) 
                                          
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    strGameInfo = strGameInfo & "<tbody><tr><td colspan='7' style='padding: 4px 0;'></td></tr><tr class='betting-active'><td class='bt_stime'><span class='tleft-title01' tyle='font-family:tahoma'>"
                    strGameInfo = strGameInfo & dfSiteUtil.GetBetDate(IG_StartTime)
                    strGameInfo = strGameInfo & "</span></td><td class='league'>"
                    strGameInfo = strGameInfo & RL_Image
                    strGameInfo = strGameInfo & "<strong>"
                    strGameInfo = strGameInfo & RL_League
                    strGameInfo = strGameInfo & "</strong></td><td><a class='tleft-btn"
					If IBD_NUM="1" Then
					strGameInfo = strGameInfo & " tleft-btn03"
					End if
					strGameInfo = strGameInfo & "' bgcolor='#707018'><span class='team-l'><font color='#00ff00'>"
                    strGameInfo = strGameInfo & IG_Team1
                    strGameInfo = strGameInfo & "</font></span><span class='point-r'>"
                    strGameInfo = strGameInfo & IG_Team1Benefit
                    strGameInfo = strGameInfo & "</span></a></td><td style='text-align: center;'><a class='tcenter-btn "
					If IBD_NUM="0" Then
					strGameInfo = strGameInfo & " tleft-btn03"
					End if
					strGameInfo = strGameInfo & "' bgcolor=''>"
                    strGameInfo = strGameInfo & dfSiteUtil.getDrawValue(IG_TYPE, sRs2("IG_DrawBenefit") ,sRs2("IG_Handicap"))
                    strGameInfo = strGameInfo & "</a></td><td><a class='tright-btn"
					If IBD_NUM="2" Then
					strGameInfo = strGameInfo & " tright-btn03"
					End if
					strGameInfo = strGameInfo & "' bgcolor=''><span class='point-l'>"
                    strGameInfo = strGameInfo & IG_Team2Benefit
                    strGameInfo = strGameInfo & "</span><span class='team-r'><font color='#00ccf4'>&lt;&lt;&lt;&lt;"
                    strGameInfo = strGameInfo & IG_Team2
                    strGameInfo = strGameInfo & "</font></span></a></td><td nowrap=''><span style='display:block;padding:2px;text-align: center;color:#fff;font-weight:bold;font-size:12px'>"
                    strGameInfo = strGameInfo & SCORE
                    strGameInfo = strGameInfo & "</span></td><td style='text-align:center;font-size:12px'><span class='guess'><font color='#ff8a00'><b>"
                    strGameInfo = strGameInfo & txtIBD_RESULT
                    strGameInfo = strGameInfo & "</b></font></span></td></tr>"

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    sRs2.MoveNext
                Loop    	    
                	                                        
            End IF
	        BenefitAmount = Cdbl(IB_Amount)  * CDbl(dfSiteUtil.numdel2(TotalBenefit*100))/100        
			BenefitAmountf = Cdbl(IB_Amount)  * CDbl(dfSiteUtil.numdel2(TotalBenefitf*100))/100        
'	        BenefitAmountA = Cdbl(IB_Amount)  * CDbl(dfSiteUtil.numdel2(TotalBenefitA*100))/100     
	        BenefitAmountA = Cdbl(IB_Amount)  * CDbl(dfSiteUtil.numdel2(TotalBenefit*100))/100     
            BenefitAmount = dfSiteUtil.numdel2(BenefitAmount)
            BenefitAmountA = dfSiteUtil.numdel2(BenefitAmountA)	 
			BenefitAmountf = dfSiteUtil.numdel2(BenefitAmountf)	
            IF Cdbl(TotalBenefit) = 1 Then
                totalIBD_RESULT = 2
                resultBgColor1 = "noSelected"
            ElseIF Cdbl(TotalBenefit) = 0 Then                
                totalIBD_RESULT = 0
                resultBgColor1 = "failGame"
            Else                    
                IF Cdbl(totalIBD_RESULT) = 9 Then               
                    totalIBD_RESULT = 9 
                    resultBgColor1 = "noSelected"
                Else
                    totalIBD_RESULT = 1 
                    resultBgColor1 = "Selected"
                End IF                    
            End IF


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''					
                    strGameInfo = strGameInfo & "<tr><td colspan='7' style='padding: 4px 0;'></td></tr><tr><td colspan='4' style='padding: 4px 4px 4px 14px;background: #999999;border-top: 1px solid #111;border-bottom: 1px solid #111;font-family:tahoma'>배당율 : <span style='font-size:12px;color:#FBD504;'>"				
                    strGameInfo = strGameInfo & FORMATNUMBER(TotalBenefitF,2)				
                    strGameInfo = strGameInfo & "</span>/ 배팅금액 : <span style='font-size:12px;color:#FBD504;'>"				
                    strGameInfo = strGameInfo & FORMATNUMBER(IB_Amount,0)				
                    strGameInfo = strGameInfo & "</span> 원/ 예상적중금액 : <span style='font-size:12px;color:#FBD504;'>"				
                    strGameInfo = strGameInfo & FORMATNUMBER(BenefitAmountA,0)			
                    strGameInfo = strGameInfo & "</span> 원</td><td colspan='4' style='text-align: right;padding: 4px 12px 4px 2px;background: #999999;border-top: 1px solid #111;border-bottom: 1px solid #111;font-family:tahoma'>(<font color='#ff8a00'><b>"				
                    strGameInfo = strGameInfo & txttotalIBD_RESULT(totalIBD_RESULT)				
                    strGameInfo = strGameInfo & "</b></font><font color='red'><b></b></font>)&nbsp;<span>베팅날짜 : <span>"
                    strGameInfo = strGameInfo & dfSiteUtil.GetFullDate(IB_REGDATE)
                    strGameInfo = strGameInfo & "</span> </span> </td></tr></tbody></table></div>"
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            sRs.MoveNext
        Loop
        End IF   
        GetBetInfo =   strGameInfo          
    End Function 		
    
    Public Function GetGameLink(RL_Sports, RL_League, IG_StartTime,  IG_Team1, IG_Team2, I7_IDX)
        Dim strGameDataURL 
        Dim IG_Team1ShotName, IG_Team2ShotName, IG_TeamShotName, categoryName, dateName
        
        IF I7_IDX <> "" And RL_Sports = "축구" Then
            strGameDataURL= "<a href='http://data2.7m.cn/analyse/kr/" & I7_IDX & ".shtml' target='_blank'>분석</a>"
        Else
            dateName =  GetShotDate1(IG_StartTime)
            categoryName = GetCategoryName(RL_League)

            IF categoryName = "mlb" Or categoryName = "kbo" Then
                IG_Team1ShotName = GetGameShotName(IG_Team1)
                IG_Team2ShotName = GetGameShotName(IG_Team2)
                IG_TeamShotName = IG_Team2ShotName & IG_Team1ShotName
                strGameDataURL = "<a href='http://news.naver.com/sports/index.nhn?category=" & categoryName & "&ctg=live&game_id=" & dateName & IG_TeamShotName &  "0' target='_blank'>분석</a>"
            ElseIF I7_IDX <> "" And (categoryName = "nba" OR categoryName = "kbl" OR categoryName = "wkbl") Then                
                strGameDataURL= "<a href='http://bdata2.7m.cn/analyse/kr/" & I7_IDX & ".shtml' target='_blank'>분석</a>"
            ElseIF categoryName = "npb" Then
                strGameDataURL= "<a href='http://kr.sports.yahoo.com/npb/?idx=schedule' target='_blank'>분석</a>"
            End IF
        End IF            
        
        GetGameLink = strGameDataURL
    End Function	
    
    Public Function GetCategoryName(leagueName)
        IF Left(leagueName,3) = "MLB" OR leagueName = "미국 MLB" Then
            GetCategoryName = "mlb"
        ElseIF Left(leagueName,3) = "KBO" OR leagueName = "한국 KBO" Then
            GetCategoryName = "kbo"
        ElseIF Left(leagueName,3) = "NBA" Then
            GetCategoryName = "nba"            
        ElseIF Left(leagueName,3) = "KBL" Then
            GetCategoryName = "kbl"                    
        ElseIF Left(leagueName,4) = "wkbl" OR Left(leagueName,4) = "WKBL" Then
            GetCategoryName = "wkbl"                                
        ElseIF Left(leagueName,3) = "NPB" OR leagueName = "일본 NPB" Then
            GetCategoryName = "npb"            
        End IF
        
    End Function
    
    Public Function GetGameShotName(teamName)
        Dim shotGameName
	    IF teamName = "애틀랜타" Then 
            shotGameName = "AT"
        ElseIF teamName = "피츠버그"  Then 
            shotGameName = "PI"
        ElseIF teamName = "볼티모어" Then 
            shotGameName = "BA"
        ElseIF teamName = "뉴욕Y"Then 
            shotGameName = "NY"
        ElseIF teamName = "시카고W"  Then 
            shotGameName = "CW"
        ElseIF teamName = "디트로이트" Then 
            shotGameName = "DE"
        ElseIF teamName = "플로리다" Then 
            shotGameName = "FL"
        ElseIF teamName = "필라델피아"  Then 
            shotGameName = "PH"
        ElseIF teamName = "뉴욕M"  Then 
            shotGameName = "NM"
        ElseIF teamName = "워싱턴" Then 
            shotGameName = "MO"
        ElseIF teamName = "텍사스" Then 
            shotGameName = "TE"
        ElseIF teamName = "토론토"  Then 
            shotGameName = "TO"
        ElseIF teamName = "탬파베이"  Then 
            shotGameName = "TB"
        ElseIF teamName = "보스턴" Then 
            shotGameName = "BO"
        ElseIF teamName = "휴스턴"  Then 
            shotGameName = "HO"
        ElseIF teamName = "시카고C"  Then                 
            shotGameName = "CC"
        ElseIF teamName = "캔자스시티"  Then 
            shotGameName = "KC"
        ElseIF teamName = "미네소타" Then 
            shotGameName = "MN"
        ElseIF teamName = "세인트루이스" Then 
            shotGameName = "SL"
        ElseIF teamName = "밀워키" Then 
            shotGameName = "MI"
        ElseIF teamName = "신시내티" Then 
            shotGameName = "CI"
        ElseIF teamName = "콜로라도" Then 
            shotGameName = "CO"
        ElseIF teamName = "샌프란시스코" Then 
            shotGameName = "SF"
        ElseIF teamName = "애리조나" Then 
            shotGameName = "AZ"
        ElseIF teamName = "클리블랜드" Then 
            shotGameName = "CL"
        ElseIF teamName = "LA에인절스" OR teamName = "LA 에인절스" Then 
            shotGameName = "AN"
        ElseIF teamName = "LA다저스" OR teamName = "LA 다저스" Then 
            shotGameName = "LA"
        ElseIF teamName = "샌디에이고" Then 
            shotGameName = "SD"
        ElseIF teamName = "시애틀" Then 
            shotGameName = "SE"
        ElseIF teamName = "오클랜드" Then 
            shotGameName = "OA"
        ElseIF teamName = "롯데" Then 
            shotGameName = "LT"
        ElseIF teamName = "한화" Then 
            shotGameName = "HH"
        ElseIF teamName = "KIA" OR teamName = "기아"  Then 
            shotGameName = "HT"
        ElseIF teamName = "LG" Then 
            shotGameName = "LG"
        ElseIF teamName = "두산" Then 
            shotGameName = "OB"
        ElseIF teamName = "넥센" Then 
            shotGameName = "WO"
        ElseIF teamName = "SK" Then 
            shotGameName = "SK"
        ElseIF teamName = "삼성" Then 
            shotGameName = "SS"
        End IF        
        GetGameShotName = shotGameName
    End Function 
  
    Public Function getDrawValue(IG_TYPE, IG_DrawBenefit ,IG_Handicap)
	    SELECT CASE cStr(IG_TYPE) 
	    CASE "0" '승무패
            IF Cdbl(IG_DrawBenefit) < 1 THEN	'// 농구경기등....무승부가 없는경기...(무의 배당율이 0일때...)
                team2Input = "<font color='red'>VS</font>"
            ELSE
                team2Input = FORMATNUMBER(IG_DrawBenefit,2)
            END IF			        
	    CASE "1" '핸디캡
            IF IG_Handicap = "0" Then
                team2Input = "<font color='red'>VS</font>"
            Else
	            IF IG_Handicap < 0 THEN 
                    team2Input =  IG_Handicap 
                ELSE
'                    team2Input = "+" & IG_Handicap 
                    team2Input = IG_Handicap 
                END IF
            End IF
	    CASE "2" '오버언더
            IF IG_Handicap < 0 THEN 
                team2Input = IG_Handicap
            ELSE
'                team2Input = "+" & IG_Handicap 
                team2Input = IG_Handicap 
            END IF	    	        
	    END SELECT
	    getDrawValue =  team2Input
			        
    End Function 
    

	Public Function numdel2(var)
		If InStr(var,".") Then
			a = Split(var,".")(0)
			var = a 
		Else
			var = var 
		End If 

		numdel2 = var
	End Function 
	    
	Public Function numdel(var)
		If InStr(var,".") Then
			a = Split(var,".")(0)
			If Len(Left(Split(var,".")(1),2)) > 1 Then
				b = Left(Split(var,".")(1),2)
			ElseIf Len(Left(Split(var,".")(1),2)) > 0 Then 
				b = Left(Split(var,".")(1),2) & "0"
			Else 
				b = "00"
			End If 
			var = a & "." & b
		Else
			var = var & ".00"
		End If 

		numdel = var
	End Function 
	'리그추가로 추가됨(soso150302)
    Function GetLeagueImage(pRL_Image)
            Dim rtnValue
            IF inStr(pRL_Image,"http") = 0  Then 
                rtnValue  = "http://league." & SITE_URL & "/" & pRL_Image 
            Else
                rtnValue  = pRL_Image 
            End IF    
            GetLeagueImage = rtnValue
    End Function	
End Class


Dim dfSiteUtil 
Set dfSiteUtil = new SiteUtil
%>