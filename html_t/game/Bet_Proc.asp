
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->


<%
    IG_Idx		= Trim(REQUEST("IG_Idx"))
	IB_Num		= Trim(REQUEST("IB_Num"))
	IB_Benefit	= Trim(REQUEST("IB_Benefit"))
	IB_Amount	= REPLACE(Trim(REQUEST("BetAmount")),",", "")
	TotalBenefit	= REPLACE(Trim(REQUEST("TotalBenefit")),",", "")
	TotalBenefitRate = Trim(REQUEST("TotalBenefitRate"))
	ig_handicap = Trim(REQUEST("ig_handicap"))


	II_Type = Request("Itemuse")
	II_SA_IDX = REQUEST("ISAR")

	Game_Type	= Trim(REQUEST("Game_Type"))
	Game_Type1	= Trim(REQUEST("Game_Type")) ' 조합 배팅 추가로 인하여 추가 됨
	TotalCnt	= REQUEST("IG_Idx").Count
	IF LCase(Game_Type) = "smp"  or LCase(Game_Type) = "handicap" or LCase(Game_Type) = "special" or LCase(Game_Type) = "cross" Or  LCase(Game_Type) = "real" then
		LC_YN = "N"
	Else
		If LCase(Game_Type) = "live" Then
			LC_YN = "Y"
		ElseIf LCase(Game_Type) = "dari" Then
			LC_YN = "R"
		ElseIf LCase(Game_Type) = "dal" Then
			LC_YN = "D"
		ElseIf LCase(Game_Type) = "aladin" Then
			LC_YN = "A"
		ElseIf LCase(Game_Type) = "high" Then
			LC_YN = "H"
		ElseIf LCase(Game_Type) = "power" Then
			LC_YN = "P"
		ElseIf LCase(Game_Type) = "powers" then
			LC_YN = "W"
		ElseIf LCase(Game_Type) = "mgm" Then
			LC_YN = "M"
		ElseIf LCase(Game_Type) = "bacarat" Then
			LC_YN = "C"
		ElseIf LCase(Game_Type) = "lotusoe" Then
			LC_YN = "L"
		ElseIf LCase(Game_Type) = "lotusb" Then
			LC_YN = "S"
		ElseIf LCase(Game_Type) = "virtuals" Then
			LC_YN = "B"
		ElseIf LCase(Game_Type) = "1dari" Then
			LC_YN = "T"
		ElseIf LCase(Game_Type) = "2dari" Then
			LC_YN = "V"
		ElseIf LCase(Game_Type) = "3dari" Then
			LC_YN = "Q"
		ElseIf LCase(Game_Type) = "5dari" Then
			LC_YN = "J"
		ElseIf LCase(Game_Type) = "kino" Then
			LC_YN = "F"
		ElseIf LCase(Game_Type) = "banggu" Then
			LC_YN = "G"
		ElseIf LCase(Game_Type) = "dice" Then
			LC_YN = "I"
		ElseIf LCase(Game_Type) = "choice" Then
			LC_YN = "X"
		ElseIf LCase(Game_Type) = "9game" Then
			LC_YN = "K"
		End if
	end If
	
	
	Set Dber = new clsDBHelper

	'보너스배당체크
	If USER_BETGAME_CHK ="Y" Then

		arrIG_Idx = SPLIT(IG_Idx, ",")
		
		
		FOR fi=0 to Cint(TotalCnt) - 1
		
			SQL = "UP_SELECT_CHK_BET"
			
			reDim param(1)
			param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,arrIG_Idx(fi))
			param(1) = Dber.MakeParam("@TotalCnt",adInteger,adParamInput,,TotalCnt)
			
			Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
			
			ismsg = sRs(0)
			enumber = sRs(1)
			errEvent = sRs(2)
			
			sRs.close
			Set sRs = Nothing		
			
			If enumber <> "1000" Then			
				With Response
				.Write "<script>" & vbcrlf
				.Write "alert('"&ismsg&"');" & vbcrlf				
				.Write "history.back();" & vbcrlf
				.Write "</script>"
				.end
				End With	
				response.end	
			End if					
			
			If erri = 1 And errEvent = "1" Then
				With Response
				.Write "<script>" & vbcrlf
				.Write "alert('보너스배당은 1폴더이상 배팅할 수 없습니다.');" & vbcrlf				
				.Write "history.back();" & vbcrlf
				.Write "</script>"
				.end
				End With	
				response.end
			
			End if

			If errEvent = "1" Then					
				erri = 1				
			End if

		NEXT
	'response.Write TotalBenefitRate			
	End If

	'########## 경기수 체크
	IF TotalCnt < 1 Then
			With Response
				.Write "<script>" & vbcrlf
				.Write "alert('경기를 선택해주세요.');" & vbcrlf				
				.Write "history.back();" & vbcrlf
				.Write "</script>"
				.end
			End With	
			response.end	
	End IF

'######## 5% 아이템적용시 예외
	IF II_Type = "IP5" and TotalCnt < 3 Then
			With Response
				.Write "<script>" & vbcrlf
				.Write "alert('플러스배당 아이템은 3조합이상에 사용가능합니다.');" & vbcrlf				
				.Write "history.back();" & vbcrlf
				.Write "</script>"
				.end
			End With	
			response.end	
	End IF

'######## 10% 아이템적용시 예외
	IF II_Type = "IP10" and TotalCnt < 3 Then
			With Response
				.Write "<script>" & vbcrlf
				.Write "alert('플러스배당 아이템은 3조합이상에 사용가능합니다.');" & vbcrlf				
				.Write "history.back();" & vbcrlf
				.Write "</script>"
				.end
			End With	
			response.end	
	End IF


'######## 적중특례 아이템적용시 예외
	IF II_Type = "ISA" and TotalCnt < 5 Then
			With Response
				.Write "<script>" & vbcrlf
				.Write "alert('적중특례 아이템은 5조합이상에 사용가능합니다.');" & vbcrlf				
				.Write "history.back();" & vbcrlf
				.Write "</script>"
				.end
			End With	
			response.end	
	End IF

	IF II_Type = "ISA" and II_SA_IDX = "" Then
			With Response
				.Write "<script>" & vbcrlf
				.Write "alert('적중특례아이템을 적용시킬 특정경기를 선택하지 않으셨습니다.');" & vbcrlf				
				.Write "history.back();" & vbcrlf
				.Write "</script>"
				.end
			End With	
			response.end	
	End IF

	 '########   배팅 금액 확인    ##############	

    
    
    IF TotalBenefit < 0 OR TotalBenefit= "" Then
		With Response
			.Write "<script>" & vbcrlf
			.Write "alert('정상적인 접근 바랍니다.');" & vbcrlf
			.Write "history.back();" & vbcrlf
			.Write "</script>"
			.end
		End With	
		response.end    
    End IF

    IF TotalBenefitRate > 50 Then
		With Response
			.Write "<script>" & vbcrlf
			.Write "alert('최대 베팅배당은 50배당입니다. 다시 베팅해주세요.');" & vbcrlf
			.Write "history.back();" & vbcrlf
			.Write "</script>"
			.end
		End With	
		response.end    
    End If

    IF Cdbl(IB_Amount) < Cdbl(Session("SB_BETTINGMIN"))  Then
		With Response
			.Write "<script>" & vbcrlf
			.Write "alert('최저 배팅금액보다 작습니다.');" & vbcrlf
			.Write "history.back();" & vbcrlf
			.Write "</script>"
			.end
		End With	
		response.end  
    End If
	IF LCase(Game_Type) = "live" or LCase(Game_Type) = "power" or LCase(Game_Type) = "powers" or LCase(Game_Type) = "dari" or LCase(Game_Type) = "aladin" or LCase(Game_Type) = "mgm" or LCase(Game_Type) = "virtuals" THEN    	    

	else
		IF Cdbl(TotalBenefit) > Cdbl(Session("SB_BENEFITMAX"))  Then
			With Response
				.Write "<script>" & vbcrlf
				.Write "alert('배당금이 초과되었습니다.');" & vbcrlf
				.Write "history.back();" & vbcrlf
				.Write "</script>"
				.end
			End With	
			response.end  
		End If
	END IF    

    '########   멀티 게임인지 싱글 게임인지 체크    ##############	
	IF TotalCnt = 1 THEN
		IB_Type = "S"
	ELSE
		IB_Type = "M"
	END IF

    '########   장바구니 정보 불러옴   ##############	
	

	wrongnum = 0
	SQL = "SELECT isNull(COUNT(ict_gamenum),0) AS cnt FROM INFO_CART WHERE ict_id = ? AND ict_site = ? GROUP BY ict_gamenum,ict_id,ict_site "

	reDim param(1)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

	If Not sRs.eof Then
		wrongnum = CDbl(sRs("cnt"))
	End If 
	sRs.Close
	Set sRs = Nothing

	If wrongnum > 1 Then
	    '########   장바구니 정보 삭제 ##############	
		SQL = "UP_INFO_Cart_DEL6"
		reDim param(1)
		param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		
		Dber.ExecSP SQL,param,Nothing

		With Response
			.Write "<script>" & vbcrlf
			.Write "alert('비정상적 접근');" & vbcrlf
			.Write "history.back();" & vbcrlf
			.Write "</script>"
			.END
		End With
		response.end
	End If 	


	'// 사용자 Cash를 가져와 배팅가능여부 체크...
	SQL = "SELECT IU_CASH FROM INFO_USER WHERE IU_ID = ? AND IU_SITE = ? "
	
	reDim param(1)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

	If Not sRs.eof Then
		IU_CASH = sRs(0)
	End If 
	
	sRs.close
	Set sRs = Nothing
	
    '########   보유 머니 체크 ##############	
	IF Cdbl(IU_Cash) < Cdbl(IB_Amount) THEN
		With Response
			.Write "<script>" & vbcrlf
			.Write "alert('보유금액이 모자랍니다. 확인후 다시 베팅해주세요.');" & vbcrlf
			.WRITE "history.back();" & vbcrlf
			.Write "</script>"
			.END
		End With
	END IF
	
	
	'########  관리자에서 설정한 한도 체크 ##############	
	SQL = "SELECT * FROM Set_Betting Where SB_SITE = ?"
	
	reDim param(0)
	param(0) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

	'IF LCase(Game_Type)  = "smp" THEN
	'	SB_GameBenefitMax = Session("SB_BENEFITMAX")
	'ELSE
	'	SB_GameBenefitMax = sRs("SB_BENEFITMAX02")
	'END IF
	SB_GameBenefitMax = Session("SB_BENEFITMAX")

	sRs.close
	Set sRs = Nothing
	

	IF LCase(Game_Type) = "live" or LCase(Game_Type) = "power" or LCase(Game_Type) = "powers" or LCase(Game_Type) = "dal" or LCase(Game_Type) = "lotusb" or LCase(Game_Type) = "dice" or LCase(Game_Type) = "virtuals" or LCase(Game_Type) = "dari" THEN
			
		SQL = "select top 1 seq,scnt,pcnt,hcnt,lcnt,acnt,dcnt,rcnt,vcnt,regdate from info_betting_max with(nolock)  order by seq desc "

		
		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

		If Not sRs.eof Then
			scnt = sRs(1)
			pcnt = sRs(2)
			hcnt = sRs(3)
			lcnt = sRs(4)
			acnt = sRs(5)
			dcnt = sRs(6)
			rcnt = sRs(7)
			vcnt = sRs(8)
		else
			scnt = 1
			pcnt = 1
			hcnt = 1
			lcnt = 1
			acnt = 1
			dcnt = 1
			rcnt = 1
			vcnt = 1
		End If 
		
		sRs.close
		Set sRs = Nothing
		

		IF LCase(Game_Type) = "live" THEN
			Bcnt = scnt
		ELSEIF LCase(Game_Type) = "power" THEN
			Bcnt = pcnt
		ELSEIF LCase(Game_Type) = "powers" THEN
			Bcnt = hcnt
		ELSEIF LCase(Game_Type) = "dal" THEN
			Bcnt = lcnt
		ELSEIF LCase(Game_Type) = "lotusb" THEN
			Bcnt = acnt
		ELSEIF LCase(Game_Type) = "dice" THEN
			Bcnt = dcnt
		ELSEIF LCase(Game_Type) = "dari" THEN
			Bcnt = rcnt
		ELSEIF LCase(Game_Type) = "virtuals" THEN
			Bcnt = vcnt
		END IF

		
		IF IB_Type = "S" Then
			SQL = "select ii_idx from info_game with(nolock) where ig_idx = " & IG_Idx & " "
			
			Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

			If Not sRs.eof Then
				ii_idx = sRs(0)		
			End If 
			
			sRs.close
			Set sRs = Nothing
			
			
			SQL = "select count(ii_idx) as cntii from info_betting_cnt with(nolock) where ii_idx = " & ii_idx & " and iu_id =  '" & Session("SD_ID") & "' and ig_type =  '" & LCase(Game_Type) & "' "
			
			Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

			If Not sRs.eof Then
				cntii = sRs(0)		
			End If 
			
			sRs.close
			Set sRs = Nothing

			IF cntii >= Bcnt THEN
				With Response
					.Write "<script>" & vbcrlf
					.Write "alert('라이브경기는 "& Bcnt &" 폴더이하 배팅만 가능합니다');" & vbcrlf				
					.Write "history.back();" & vbcrlf
					.Write "</script>"
					.end
				End With
				response.end
			End IF
		Else
			

			arr1_IG_Idx = SPLIT(IG_Idx, ",")
			FOR fi=0 TO Cint(TotalCnt) - 1	

				SQL = "select ii_idx from info_game with(nolock) where ig_idx = " & arr1_IG_Idx(fi) & " "

				Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

				If Not sRs.eof Then
					ii_idx = sRs(0)		
				End If 

				sRs.close
				Set sRs = Nothing


				SQL = "select count(ii_idx) as cntii from info_betting_cnt with(nolock) where ii_idx = " & ii_idx & " and iu_id =  '" & Session("SD_ID") & "' and ig_type =  '" & LCase(Game_Type) & "' "

				Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

				If Not sRs.eof Then
					cntii = sRs(0)		
				End If 

				sRs.close
				Set sRs = Nothing
				

				SQL = "select top 1 count(ii_idx) as cntii,ii_idx from info_game with(nolock) where ig_idx in (" & IG_Idx & ") group by ii_idx order by count(ii_idx) desc "


				Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

				If Not sRs.eof Then
					cntii1 = sRs(0)		
				End If 

				sRs.close
				Set sRs = Nothing
					
				IF (cntii1+cntii) > Bcnt THEN
					With Response
						.Write "<script>" & vbcrlf
						.Write "alert('라이브경기는 "& Bcnt &" 폴더이하 배팅만 가능합니다');" & vbcrlf				
						.Write "history.back();" & vbcrlf
						.Write "</script>"
						.end
					End With	
					response.end
				End IF


			Next  
			

		End IF

	End IF

	'//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	'////////////////////////////////////////////// 단식일 경우......... //////////////////////////////////////////////
	'//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	IF IB_Type = "S" Then
	
		'########   게임 정보 불러옴 ##############
		SQL = "SELECT IG_StartTime,IG_Team1Betting,IG_DrawBetting,IG_Team2Betting,IG_Team1Benefit,IG_DrawBenefit,IG_Team2Benefit,IG_Status, IG_LIMIT,IG_TEAM1, IG_TEAM2,IG_Handicap FROM Info_Game WHERE IG_Idx= ?"
	
		reDim param(0)
		param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput, ,IG_Idx)

		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

		IG_StartTime	= sRs("IG_StartTime")
		IG_Status		= sRs("IG_Status")
		IG_LIMIT		= sRs("IG_LIMIT")
		IG_TEAM1		= sRs("IG_TEAM1")
		IG_TEAM2		= sRs("IG_TEAM2")
		IG_Team1Betting = sRs("IG_Team1Betting")
		IG_DrawBetting	= sRs("IG_DrawBetting")
		IG_Team2Betting	= sRs("IG_Team2Betting")
		IG_Team1Benefit	= sRs("IG_Team1Benefit")
		IG_DrawBenefit	= sRs("IG_DrawBenefit")
		IG_Team2Benefit	= sRs("IG_Team2Benefit")
		IG_HandicapDB	= sRs("IG_Handicap")
		sRs.Close
		Set sRs = Nothing
		If IsNull(IG_LIMIT)  Then IG_LIMIT = 0
	    
	        df = datediff("s",now(),Cdate(IG_StartTime))
            
            '########   배팅 종료 게임 체크 ##############
            
		    IF CDBL(df) < GAME_END_TEAM OR IG_Status = "E" Then
			
			    SQL = "UP_INFO_Cart_DEL7"

		        reDim param(0)
		        param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput, ,IG_Idx)
        		
			    Dber.ExecSP SQL,param,Nothing
			
			    Dber.Dispose
			    Set Dber = Nothing 
				
			    WITH RESPONSE
				    .WRITE "<script>" & vbcrlf
				    .WRITE "alert('베팅시간을 초과한 게임을 삭제하였습니다. 게임을 다시 선택후 베팅해주세요.');" & vbcrlf
				    .WRITE "history.back();" & vbcrlf
				    .WRITE "</script>"
				    .END
			    END WITH
		    END IF

            '######## 변동 배당값 체크
            IF IB_Num = 1 Then
                tempBenefit = IG_Team1Benefit 
            ElseIF IB_Num = 0 Then
                tempBenefit = IG_DrawBenefit 
            ElseIF IB_Num = 2 Then
                tempBenefit = IG_Team2Benefit 
            End IF
            
            IF FormatNumber(IB_Benefit,2) <> FormatNumber(tempBenefit,2) Then
                WITH RESPONSE
				    .WRITE "<script>" & vbcrlf
				    .WRITE "alert('선택하신 게임("&IG_TEAM1&"-"&IG_TEAM2&")에 배당이 변경되었습니다. 다시한번 배당을 확인하신뒤 베팅해 주시기 바랍니다.');" & vbcrlf
				    .WRITE "history.back();" & vbcrlf
				    .WRITE "</script>"
				    .END
			    END WITH            
            End IF
			'########   실시간 베팅금액 상한 ##############
			IF LCase(Game_Type) = "smp"  or LCase(Game_Type) = "handicap" or LCase(Game_Type) = "special" or LCase(Game_Type) = "cross" Then
                WITH RESPONSE
				    .WRITE "<script>" & vbcrlf
				    .WRITE "alert('스포츠는 단폴더 베팅이 불가합니다');" & vbcrlf
				    .WRITE "history.back();" & vbcrlf
				    .WRITE "</script>"
				    .END
			    END WITH 
			End if
			IF LCase(Game_Type) = "smp"  or LCase(Game_Type) = "handicap" or LCase(Game_Type) = "special" or LCase(Game_Type) = "cross" Or LCase(Game_Type) = "dal" Or LCase(Game_Type) = "power" Then
			Else
				If Session("IU_Level") = 1 then
				lvbet = 1300000
				elseIf Session("IU_Level") = 2 then
				lvbet = 1800000
				elseIf Session("IU_Level") >= 3 then
				lvbet = 2300000
				End if

				SQL_c = "select ii_idx as iiidx from info_game where ig_idx = '" & ig_idx & "'"

				reDim param(0)
				param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput, ,IG_Idx)
				
				Set sRs_c = Dber.ExecSQLReturnRS(SQL_c,param,nothing) 

					iiidx = sRs_c("iiidx")
					SQL_d = "select ig_idx as igidx1 from info_game where ii_idx = '" & iiidx & "' and ig_event='" & LC_YN & "'"

					reDim param(0)
					param(0) = Dber.MakeParam("@iiidx",adInteger,adParamInput, ,iiidx)
					
					Set sRs_d = Dber.ExecSQLReturnRS(SQL_d,param,nothing) 

					INPC = sRs_d.RecordCount

					If Not sRs_d.eof Then
						For RE = 1 TO INPC

							IF sRs_d.EOF THEN
								EXIT FOR
							END IF
							igidx1 = sRs_d("igidx1")

							If igidx2 = "" Then
								igidx2 = igidx1
							else
								igidx2 = igidx1 & "," & igidx2
							End If

						sRs_d.MoveNext
						NEXT
					End If
					
					sRs_d.Close
					Set sRs_d = Nothing 
					igidx2 = "'" & Replace(igidx2, ",", "','") & "'"

					SQL_e = "select sum(ib_amount) as ibamount from info_betting where ig_idx in (" & igidx2 & ") and ib_id = '" & Session("SD_ID") & "'"
					
					Set sRs = Dber.ExecSQLReturnRS(SQL_e,param,nothing)

					ibamount = sRs("ibamount")
					totibamount = ibamount + ib_amount

					If totibamount > lvbet Then
						WITH RESPONSE
							.WRITE "<script>" & vbcrlf
							.WRITE "alert('실시간 보험베팅의 상한금액 " & lvbet & "원을 초과할수없습니다');" & vbcrlf
							.WRITE "history.back();" & vbcrlf
							.WRITE "</script>"
							.END
						END WITH   
					End If

				sRs_c.Close
				Set sRs_c = Nothing  
			End if
			If LCase(Game_Type) = "dal" And ib_amount > 500000 Then
				WITH RESPONSE
					.WRITE "<script>" & vbcrlf
					.WRITE "alert('달팽이는 베팅금액 50만원을 초과할수없습니다');" & vbcrlf
					.WRITE "history.back();" & vbcrlf
					.WRITE "</script>"
					.END
				END WITH   
			End If

			If LCase(Game_Type) = "power" And ib_amount > 500000 And Session("IU_Level") < 3 Then
				WITH RESPONSE
					.WRITE "<script>" & vbcrlf
					.WRITE "alert('파워볼은 베팅금액 50만원을 초과할수없습니다');" & vbcrlf
					.WRITE "history.back();" & vbcrlf
					.WRITE "</script>"
					.END
				END WITH   
			End If

			If (LCase(Game_Type) = "live" Or LCase(Game_Type) = "powers" Or LCase(Game_Type) = "dari") And ib_amount > 1000000 And Session("IU_Level") = 1 Then
				WITH RESPONSE
					.WRITE "<script>" & vbcrlf
					.WRITE "alert('회원님의 레벨에서 실시간 단폴더는 100만원까지 베팅이 가능합니다');" & vbcrlf
					.WRITE "history.back();" & vbcrlf
					.WRITE "</script>"
					.END
				END WITH   
			End If
			If (LCase(Game_Type) = "live" Or LCase(Game_Type) = "powers" Or LCase(Game_Type) = "dari") And ib_amount > 1500000 And Session("IU_Level") = 2 Then
				WITH RESPONSE
					.WRITE "<script>" & vbcrlf
					.WRITE "alert('회원님의 레벨에서 실시간 단폴더는 150만원까지 베팅이 가능합니다');" & vbcrlf
					.WRITE "history.back();" & vbcrlf
					.WRITE "</script>"
					.END
				END WITH   
			End If
			If (LCase(Game_Type) = "live" Or LCase(Game_Type) = "powers" Or LCase(Game_Type) = "dari") And ib_amount > 2000000 And Session("IU_Level") = 3 Then
				WITH RESPONSE
					.WRITE "<script>" & vbcrlf
					.WRITE "alert('회원님의 레벨에서 실시간 단폴더는 200만원까지 베팅이 가능합니다');" & vbcrlf
					.WRITE "history.back();" & vbcrlf
					.WRITE "</script>"
					.END
				END WITH   
			End If

			If (LCase(Game_Type) = "live" Or LCase(Game_Type) = "powers" Or LCase(Game_Type) = "dari") And TotalBenefitRate > 2 And ib_amount > 300000 Then
				WITH RESPONSE
					.WRITE "<script>" & vbcrlf
					.WRITE "alert('조합베팅은 30만원을 초과할수없습니다');" & vbcrlf
					.WRITE "history.back();" & vbcrlf
					.WRITE "</script>"
					.END
				END WITH   
			End If
            '######## 동일 게임 배팅 제한   
			IF LCase(Game_Type) = "live" or LCase(Game_Type) = "power" or LCase(Game_Type) = "powers" or LCase(Game_Type) = "dal" or LCase(Game_Type) = "dari"  or LCase(Game_Type) = "virtuals" THEN
				betCheckCnt = 1		   
				IF betCheckCnt > 0 Then 
					SQL_b = "select count(IB_ID) from info_betting where ib_id = ? and ib_site <> 'None' And Ib_status = 0 and IB_IDX IN ( select IB_IDX from info_betting_detail where ig_idx = ?   )"
				
					reDim param(1)
					param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
					param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput, ,IG_Idx)

					Set sRs_b = Dber.ExecSQLReturnRS(SQL_b,param,nothing)            
					
					If Not sRs_b.eof Then
						myBetCount = sRs_b(0)
					Else
						myBetCount = 0 	        
					End If 
								
					sRs_b.Close
					Set sRs_b = Nothing            
					
					IF myBetCount >= betCheckCnt Then
						WITH RESPONSE
							.WRITE "<script>" & vbcrlf
							.WRITE "alert('동일경기의 중복베팅은 불가합니다');" & vbcrlf
							.WRITE "history.back();" & vbcrlf
							.WRITE "</script>"
							.END
						END WITH            
					End IF
				End If
			IF LCase(Game_Type) = "live" or LCase(Game_Type) = "powers" or LCase(Game_Type) = "dari" THEN
			'########   조합 단폴베팅 검수 ##############	
				SQL = "select top 1 * from INFO_BETTING_LIVECHECK where iu_id = '" & Session("SD_ID") & "' and ii_idx = " & iiidx & " and IG_EVENT = '" & LC_YN & "' order by regdate desc"
				
				Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
				
				If Not sRs.eof then
				iiiidx = sRs("ii_idx")
				ig_team = sRs("ig_team")
				cig_event = sRs("ig_event") 
				
				If ib_num = 1 then
					cig_team = Split(Split(ig_team1, ">")(1), "<")(0) 
					cig_team = Replace(Replace(Replace(Replace(Replace(cig_team, "[", ""), "]", ""), "오버", ""), "언더", ""), "출발점 ", "")
					cig_team = Replace(replace(Replace(Replace(Replace(cig_team, "수", ""), "개", ""), "출", ""), "줄4", "4줄"), "줄3", "3줄")
					cig_team = Replace(cig_team, "줄", "")
				elseif ib_num = 2 Then
					cig_team = Split(Split(ig_team2, ">")(1), "<")(0) 
					cig_team = Replace(Replace(Replace(Replace(Replace(cig_team, "[", ""), "]", ""), "오버", ""), "언더", ""), "출발점 ", "")
					cig_team = Replace(replace(Replace(Replace(Replace(cig_team, "수", ""), "개", ""), "출", ""), "줄4", "4줄"), "줄3", "3줄")
					cig_team = Replace(cig_team, "줄", "")				
				End if

'Response.Write "<script>alert('현재베팅: " & cig_team & "');</script>" 
'Response.Write "<script>alert('이전베팅: " & ig_team & "');</script>" 
'Response.Write "<script>alert('현재타입: " & cig_event & "');</script>" 
'Response.Write "<script>alert('이전타입: " & LC_YN & "');</script>" 
					If ig_team = "좌3" And cig_event = LC_YN And (cig_team = "4" Or cig_team = "우" Or cig_team = "홀") Then
						WITH RESPONSE
							.WRITE "<script>alert('보험베팅은 베팅이 불가합니다');history.back();</script>"
							.END
						END With
					ELSEIf ig_team = "우3" And cig_event = LC_YN And (cig_team = "4" Or cig_team = "좌" Or cig_team = "짝") Then
						WITH RESPONSE
							.WRITE "<script>alert('보험베팅은 베팅이 불가합니다');history.back();</script>"
							.END
						END With
					ELSEIf ig_team = "좌4" And cig_event = LC_YN And (cig_team = "3" Or cig_team = "우" Or cig_team = "짝") Then
						WITH RESPONSE
							.WRITE "<script>alert('보험베팅은 베팅이 불가합니다');history.back();</script>"
							.END
						END With
					ELSEIf ig_team = "우4" And cig_event = LC_YN And (cig_team = "3" Or cig_team = "좌" Or cig_team = "홀") Then
						WITH RESPONSE
							.WRITE "<script>alert('보험베팅은 베팅이 불가합니다');history.back();</script>"
							.END
						END With
					End If

					If (ig_team = "3" Or ig_team = "좌" Or ig_team = "홀") And cig_team = "우4" And cig_event = LC_YN Then
						WITH RESPONSE
							.WRITE "<script>alert('보험베팅은 베팅이 불가합니다');history.back();</script>"
							.END
						END With
					elseIf (ig_team = "3" Or ig_team = "우" Or ig_team = "짝") And cig_team = "좌4" And cig_event = LC_YN Then
						WITH RESPONSE
							.WRITE "<script>alert('보험베팅은 베팅이 불가합니다');history.back();</script>"
							.END
						END With
					elseIf (ig_team = "4" Or ig_team = "좌" Or ig_team = "짝") And cig_team = "우3" And cig_event = LC_YN Then
						WITH RESPONSE
							.WRITE "<script>alert('보험베팅은 베팅이 불가합니다');history.back();</script>"
							.END
						END With
					elseIf (ig_team = "4" Or ig_team = "우" Or ig_team = "홀") And cig_team = "좌3" And cig_event = LC_YN Then
						WITH RESPONSE
							.WRITE "<script>alert('보험베팅은 베팅이 불가합니다');history.back();</script>"
							.END
						END With
					elseIf (ig_team = "좌3" Or ig_team = "우3" Or ig_team = "좌4" Or ig_team = "우4") And (cig_team = "좌3" Or cig_team = "우3" Or cig_team = "좌4" Or cig_team = "우4") And cig_event = LC_YN Then
						WITH RESPONSE
							.WRITE "<script>alert('보험베팅은 베팅이 불가합니다');history.back();</script>"
							.END
						END With
					End if
				End If

				If Session("IU_Level") = 1 then
				lvbet1 = 1000000
				elseIf Session("IU_Level") = 2 then
				lvbet1 = 1500000
				elseIf Session("IU_Level") >= 3 then
				lvbet1 = 2000000
				End If

				If (ig_team = "3" Or ig_team = "좌" Or ig_team = "홀" Or ig_team = "4" Or ig_team = "우" Or ig_team = "짝") And (cig_team = "4" Or cig_team = "우" Or cig_team = "짝" Or cig_team = "3" Or cig_team = "좌" Or cig_team = "홀") And totibamount > lvbet1 then
					WITH RESPONSE
						.WRITE "<script>alert('회원님의 레벨에서 단폴더 2회베팅 금액은 " & FormatNumber(lvbet1,0) & "원을 초과할수없습니다.');history.back();</script>"
						.END
					END With
				End if
				sRs.Close
				Set sRs = Nothing  
			End if
			End if
            '########   배당 금액 및 배당율 셋팅 ##############
            
	        Team1Amount = CDBL(IG_Team1Betting)	* 100 * CDBL(IG_Team1Benefit) * 100 / 10000
	        DrawAmount	= CDBL(IG_DrawBetting)	* 100 * CDBL(IG_DrawBenefit) * 100 /10000
	        Team2Amount	= CDBL(IG_Team2Betting)	* 100 * CDBL(IG_Team2Benefit) * 100 /10000
			'########   기준값 변경 체크 로직   ########

	        IF IB_Num = 1 THEN
		        SelAmount	= CDBL(CDBL(IG_Team1Betting)	+ CDBL(IB_Amount))		* 100 * CDBL(IG_Team1Benefit)* 100 /10000
		        LeftAmount	= CDBL(IG_DrawBetting)			* 100 * CDBL(IG_DrawBenefit) * 100 / 10000	+ CDBL(IG_Team2Betting)* 100 	* CDBL(IG_Team2Benefit)* 100 /10000
	        ELSEIF IB_Num = 0 THEN
		        SelAmount	= CDBL(CDBL(IG_DrawBetting)		+ CDBL(IB_Amount))		* 100 * CDBL(IG_DrawBenefit)* 100 /10000
		        LeftAmount	= CDBL(IG_Team1Betting)			* 100 * CDBL(IG_Team1Benefit) * 100 / 10000+ CDBL(IG_Team2Betting)	* 100 * CDBL(IG_Team2Benefit) * 100  /10000
	        ELSEIF IB_Num = 2 THEN
		        SelAmount	= CDBL(CDBL(IG_Team2Betting)	+ CDBL(IB_Amount))		* 100 * CDBL(IG_Team2Benefit)* 100 /10000
		        LeftAmount	= CDBL(IG_Team1Betting)			* 100 * CDBL(IG_Team1Benefit) * 100 /10000+ CDBL(IG_DrawBetting)	* 100 * CDBL(IG_DrawBenefit) * 100 /10000
	        END IF
    		
	        CompareMoney	= CDBL(SelAmount)			- CDBL(LeftAmount)
	        SubMoney		= CDBL(IG_LIMIT)	- CDBL(CompareMoney)


	        '// 한게임 적중상한가를 넘으면...
	        IF CDBL(SubMoney) < 0 And CDbl(IG_LIMIT) > 0 THEN
		        Dber.Dispose
		        Set Dber = Nothing 
    			
		        WITH RESPONSE
			        .WRITE "<script>" & vbcrlf
			        .WRITE "alert('선택하신 게임 "&IG_TEAM1 & " : " & IG_TEAM2 &" 에 대한 적중율 상한가가 초과되어 배팅이 제한되었습니다. 확인후 다시 배팅해주세요.');" & vbcrlf
			        .WRITE "history.back();" & vbcrlf
			        .WRITE "</script>"
			        .END
		        END WITH
	        END If

	        '// 배팅금액을 Info_Game의 해당팀에 Add...
	        IF Session("IU_Level") <> 9 Then
	          
				SQL = "UP_INFO_Game_UPD"
				reDim param(2)
				param(0) = Dber.MakeParam("@IB_Amount",adInteger,adParamInput, ,CDBL(IB_Amount))
				param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput, ,IG_Idx)
				param(2) = Dber.MakeParam("@IB_Num",adInteger,adParamInput, ,CDbl(IB_Num))
				Dber.ExecSP SQL,param,Nothing
        			
	          
	        End IF

	'//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	'////////////////////////////////////////////// 복식일 경우......... //////////////////////////////////////////////
	'//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	ELSE
		arr_IG_Idx = SPLIT(IG_Idx, ",")
		arrLen = UBOUND(arr_IG_Idx)
		arr_IG_Handicap = SPLIT(IG_Handicap, ",")	
		
		
		arr_IB_Num = SPLIT(IB_Num, ",")
		arrIB_Benefit= SPLIT(IB_Benefit, ",")

		Dim arr_Calc_Amount()
		Redim arr_Calc_Amount(TotalCnt)
		FOR fi=0 to Cint(TotalCnt) - 1
            
            '########   해당 경기 정보 불러옴 ##############		
            
			SQL = "SELECT IG_StartTime, IG_Team1Betting, IG_DrawBetting, IG_Team2Betting, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_LIMIT,IG_TEAM1, IG_TEAM2, IG_HANDICAP FROM Info_Game WHERE IG_Idx = ?"
	

			reDim param(0)
			param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput, ,arr_IG_Idx(fi))

			Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

			IG_StartTime	= sRs("IG_StartTime")
			IG_Status		= sRs("IG_Status")
			IG_LIMIT		= sRs("IG_LIMIT")
			IG_TEAM1		= sRs("IG_TEAM1")
			IG_TEAM2		= sRs("IG_TEAM2")
			
			If IsNull(IG_LIMIT)  Then IG_LIMIT = 0                                
            
			df = datediff("s",now(),Cdate(IG_StartTime))

            '########   배팅 종료 경기 체크 ##############		
			IF CDBL(df) < GAME_END_TEAM OR IG_Status = "E" Then
			
				SQL = "UP_INFO_Cart_DEL7"
				
			    reDim param(0)
			    param(0) = Dber.MakeParam("@ICT_GAMENUM",adInteger,adParamInput, ,arr_IG_Idx(fi))
			    
				Dber.ExecSP SQL,param,Nothing
			    
				Dber.Dispose
				Set Dber = Nothing 
				'response.Write "DELETE FROM INFO_CART WHERE ICT_GAMENUM =" & arr_IG_Idx(fi)
				WITH RESPONSE
					.WRITE "<script>" & vbcrlf
					.WRITE "alert('배팅시간을 초과한 게임을 삭제하였습니다. 게임을 다시 선택후 배팅해주세요.');" & vbcrlf
					.Write "history.back();" & vbcrlf
					.WRITE "</script>"
					.END
				END WITH
			END IF

			IG_Team1Betting = sRs("IG_Team1Betting")
			IG_DrawBetting	= sRs("IG_DrawBetting")
			IG_Team2Betting	= sRs("IG_Team2Betting")
			IG_Team1Benefit	= sRs("IG_Team1Benefit")
			IG_DrawBenefit	= sRs("IG_DrawBenefit")
			IG_Team2Benefit	= sRs("IG_Team2Benefit")
			IG_HANDICAPDB	= sRs("IG_HANDICAP")
			sRs.Close
			Set sRs = Nothing

            '######## 변동 배당값 체크
            IF CDbl(arr_IB_Num(fi)) = 1 Then
                tempBenefit = IG_Team1Benefit 
            ElseIF CDbl(arr_IB_Num(fi)) = 0 Then
                tempBenefit = IG_DrawBenefit 
            ElseIF CDbl(arr_IB_Num(fi)) = 2 Then
                tempBenefit = IG_Team2Benefit 
            End IF

            IF FormatNumber(arrIB_Benefit(fi),2) <> FormatNumber(tempBenefit,2) Then
                WITH RESPONSE
				    .WRITE "<script>" & vbcrlf
				    .WRITE "alert('선택하신 게임("&IG_TEAM1&"-"&IG_TEAM2&")에 배당이 변경되었습니다. 다시한번 배당을 확인하신뒤 베팅해 주시기 바랍니다.');" & vbcrlf
				    .WRITE "history.back();" & vbcrlf
				    .WRITE "</script>"
				    .END
			    END WITH            
            End If
			'기준값 변경 체크 로직(멀티) 2012.03.14 고라파덕'
			'response.write CDbl(arr_IG_Handicap(fi))&"/"&CDbl(IG_HandicapDB)
			'If Not CDbl(arr_ig_handicap(fi)) = CDbl(IG_HandicapDB) Then
			'	WITH RESPONSE
			'		.WRITE "<script>" & vbcrlf
			'		.WRITE "alert('기준값이 변경된 게임이 존재합니다. 게임을 다시 선택후 베팅해주세요.2');" & vbcrlf
			'		.WRITE "history.back();" & vbcrlf
			'		.WRITE "</script>"
			'		.END
			'	END WITH
			'End If

			'########   배팅금액 및 배당율 셋팅 ##############		
			Team1Amount = CDBL(IG_Team1Betting)	* 100 * CDBL(IG_Team1Benefit) * 100 /10000
			DrawAmount	= CDBL(IG_DrawBetting)	* 100 * CDBL(IG_DrawBenefit) * 100 /10000
			Team2Amount	= CDBL(IG_Team2Betting)	* 100 * CDBL(IG_Team2Benefit) * 100 /10000

			IF CDbl(arr_IB_Num(fi)) = 1 THEN
				SelAmount			= CDBL(CDBL(IG_Team1Betting)	+ CDBL(IB_Amount))		* 100 * CDBL(IG_Team1Benefit) * 100 /10000
				LeftAmount			= CDBL(IG_DrawBetting)			* 100 * CDBL(IG_DrawBenefit)	* 100 /10000+ CDBL(IG_Team2Betting)	* 100 * CDBL(IG_Team2Benefit)* 100 /10000
				arr_Calc_Amount(fi)	= CDBL(IB_Amount)				* 100 * CDBL(IG_Team1Benefit) * 100 / 10000/ 10
			ELSEIF CDbl(arr_IB_Num(fi)) = 0 THEN
				SelAmount			= CDBL(CDBL(IG_DrawBetting)		+ CDBL(IB_Amount))		* 100 * CDBL(IG_DrawBenefit) * 100 / 10000
				LeftAmount			= CDBL(IG_Team1Betting)			* 100 * CDBL(IG_Team1Benefit) * 100 / 10000+ CDBL(IG_Team2Betting)	* 100 * CDBL(IG_Team2Benefit) * 100 / 10000
				arr_Calc_Amount(fi)	= CDBL(IB_Amount)				* 100 * CDBL(IG_DrawBenefit)	* 100  / 10000/ 10
			ELSEIF CDbl(arr_IB_Num(fi)) = 2 THEN
				SelAmount			= CDBL(CDBL(IG_Team2Betting)	+ CDBL(IB_Amount))		* 100 * CDBL(IG_Team2Benefit)* 100 / 10000
				LeftAmount			= CDBL(IG_Team1Betting)			* 100 * CDBL(IG_Team1Benefit) * 100 / 10000+ CDBL(IG_DrawBetting)	* 100 * CDBL(IG_DrawBenefit) * 100 / 10000
				arr_Calc_Amount(fi)	= CDBL(IB_Amount)			* 100 	* CDBL(IG_Team2Benefit) * 100 / 10000 / 10
			END IF
			
			CompareMoney	= CDBL(SelAmount)			- CDBL(LeftAmount)
			SubMoney		= CDBL(IG_LIMIT)	- CDBL(CompareMoney)					

			'// 한게임 적중상한가를 넘으면...
			IF Cdbl(SubMoney) < 0 And CDbl(IG_LIMIT) > 0 THEN
				Dber.Dispose
				Set Dber = Nothing 

			WITH RESPONSE
				.WRITE "<script>" & vbcrlf
				.WRITE "alert('선택하신 게임 "&IG_TEAM1 & " : " & IG_TEAM2 &" 에 대한 적중율 상한가가 초과되어 배팅이 제한되었습니다. 확인후 다시 베팅해주세요.');" & vbcrlf
				.WRITE "history.back();" & vbcrlf
				.WRITE "</script>"
				.END
			END WITH
			END If

		NEXT			


		IF LCase(Game_Type) = "live" or LCase(Game_Type) = "power" or LCase(Game_Type) = "high" or LCase(Game_Type) = "dal" or LCase(Game_Type) = "dice" or LCase(Game_Type) = "aladin" or LCase(Game_Type) = "virtuals" or LCase(Game_Type) = "dari" or LCase(Game_Type) = "mgm" THEN
			IF TotalCnt > 1 THEN
				With Response
					.Write "<script>" & vbcrlf
					.Write "alert('라이브경기는 단폴더 배팅만 가능합니다');" & vbcrlf				
					.Write "history.back();" & vbcrlf
				.Write "</script>"
					.end
				End With	
				response.end
			End IF
		End IF

		'// 적중상한가를 모든 게임이 초과하지 않았으면...
		'// 배팅금액을 Info_Game의 해당팀에 Add...
		IF Session("IU_Level") <> 9 Then
		    FOR fi=0 TO Cint(TotalCnt) - 1
				
				SQL = "UP_INFO_Game_UPD"
				reDim param(2)
				param(0) = Dber.MakeParam("@IB_Amount",adInteger,adParamInput, ,CDBL(IB_Amount))
				param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput, ,arr_IG_Idx(fi))
				param(2) = Dber.MakeParam("@IB_Num",adInteger,adParamInput, ,arr_IB_Num(fi))
				Dber.ExecSP SQL,param,Nothing

			    
		    NEXT
		END IF
	END IF
	
	
	'//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	'///////////////////////////////////////////// 단식복식 모두 해당.... /////////////////////////////////////////////
	'//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	

	SQL = "SELECT IU_NICKNAME FROM INFO_USER WHERE IU_ID = ? AND IU_SITE = ? "
	
	reDim param(1)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

	If Not sRs.eof Then
	    IB_NICKNAME = sRs(0)
	End If 
	
	sRs.close
	Set sRs = Nothing

    '########   배팅내용을 Info_Betting_LIVECHECK에 저장(12/09) ##############	
	IF LCase(Game_Type) = "live" or LCase(Game_Type) = "powers" or LCase(Game_Type) = "dari" THEN
		IF IB_Num = 1 Then
		ig_team = IG_TEAM1
		ElseIf IB_Num = 2 Then
		ig_team = IG_TEAM2
		Else
		ig_team = "무"
		End If

		ig_team = Split(Split(ig_team, ">")(1), "<")(0) 
		ig_team = Replace(Replace(Replace(Replace(Replace(ig_team, "[", ""), "]", ""), "오버", ""), "언더", ""), "출발점 ", "")
		ig_team = Replace(replace(Replace(Replace(Replace(ig_team, "수", ""), "개", ""), "출", ""), "줄4", "4줄"), "줄3", "3줄")
		ig_team = Replace(ig_team, "줄", "")

		SQL = "UP_InsertInfo_BettingByUser_LIVECHECK"
		reDim param(7)

		param(0) = Dber.MakeParam("@IB_Num",adVarWChar,adParamInput,50,IB_Num)
		param(1) = Dber.MakeParam("@IB_Amount",adInteger,adParamInput,,IB_Amount)
		param(2) = Dber.MakeParam("@IG_Idx",adVarWChar,adParamInput,200,IG_Idx)
		param(3) = Dber.MakeParam("@ig_team",adVarWChar,adParamInput,100,ig_team)
		param(4) = Dber.MakeParam("@ig_teambenefit",adInteger,adParamInput,,TotalBenefitRate)
		param(5) = Dber.MakeParam("@ig_event",adWChar,adParamInput,1,LC_YN)
		param(6) = Dber.MakeParam("@iiidx",adInteger,adParamInput, ,iiidx)
		param(7) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))

		Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

		sRs.close
		Set sRs = Nothing
	End If
	
	'########   총판의 레벨과 그룹을 가져온다(17.9.17) ##############
	SQL = "select top 1 * from info_admin where ia_site = ? "

	reDim param(0)
	param(0) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

	Set RS2 = Dber.ExecSQLReturnRS(SQL,param,nothing)
	
	If Not rs2.eof then
	IB_LEVEL = RS2("IA_LEVEL")
	IB_GROUP = RS2("IA_GROUP")
	IB_GROUP1 = RS2("IA_GROUP1")
	IB_GROUP2 = RS2("IA_GROUP2")
	IB_GROUP3 = RS2("IA_GROUP3")
	IB_GROUP4 = RS2("IA_GROUP4")
	Else
	IB_LEVEL = 1
	IB_GROUP = 1
	IB_GROUP1 = 0
	IB_GROUP2 = 0
	IB_GROUP3 = 0
	IB_GROUP4 = 0
	End if
	RS2.close
	Set RS2 = Nothing
    '########   배팅내용을 Info_Betting 테이블에 저장 ##############		
	SQL = "UP_InsertInfo_BettingByUser_SUBNEW"
	
	reDim param(15)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@IB_NICKNAME",adVarWChar,adParamInput,20,IB_NICKNAME)
	param(2) = Dber.MakeParam("@IB_Type",adVarWChar,adParamInput,1,IB_Type)
	param(3) = Dber.MakeParam("@IG_Idx",adVarWChar,adParamInput,200,IG_Idx)
	param(4) = Dber.MakeParam("@IB_Num",adVarWChar,adParamInput,50,IB_Num)
	param(5) = Dber.MakeParam("@IB_Benefit",adVarWChar,adParamInput,100,IB_Benefit)
	param(6) = Dber.MakeParam("@IB_Amount",adInteger,adParamInput,,IB_Amount)
	param(7) = Dber.MakeParam("@TotalBenefitRate",adInteger,adParamInput,,TotalBenefitRate)
	param(8) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
	param(9) = Dber.MakeParam("@TotalCnt",adVarWChar,adParamInput,20,TotalCnt)
	param(10) = Dber.MakeParam("@IB_LEVEL",adInteger,adParamInput,,IB_LEVEL)
	param(11) = Dber.MakeParam("@IB_GROUP",adInteger,adParamInput,,IB_GROUP)
	param(12) = Dber.MakeParam("@IB_GROUP1",adInteger,adParamInput,,IB_GROUP1)
	param(13) = Dber.MakeParam("@IB_GROUP2",adInteger,adParamInput,,IB_GROUP2)
	param(14) = Dber.MakeParam("@IB_GROUP3",adInteger,adParamInput,,IB_GROUP3)
	param(15) = Dber.MakeParam("@IB_GROUP4",adInteger,adParamInput,,IB_GROUP4)

	Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)
	
	IB_IDX = sRs(0)
	
	sRs.close
	Set sRs = Nothing



'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    '########   배팅내용을 Info_Betting_Detail 테이블에 저장 ##############
	IF IB_Type = "S" And (LCase(Game_Type) = "smp"  or LCase(Game_Type) = "handicap" or LCase(Game_Type) = "special" or LCase(Game_Type) = "cross") Then

	    SQL = "UP_InsertInfo_Betting_DetailByUser_NEW"
	    	    
		reDim param(2)
		param(0) = Dber.MakeParam("@IB_IDX",adInteger,adParamInput, ,IB_IDX)
		param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput, ,IG_Idx)
		param(2) = Dber.MakeParam("@IBD_Num",adInteger,adParamInput, ,IB_Num)

		Dber.ExecSp SQL,param,Nothing	



		SQL = "UP_InsertInfo_BettingByCnt"
	    	    
		reDim param(3)
		param(0) = Dber.MakeParam("@IB_IDX",adInteger,adParamInput, ,IB_IDX)
		param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput, ,IG_Idx)
		param(2) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,12,Session("SD_ID"))
		param(3) = Dber.MakeParam("@IG_TYPE",adVarWChar,adParamInput,20,LCase(Game_Type))
		
		
		Dber.ExecSp SQL,param,Nothing
		


    ElseIF IB_Type = "S" And LCase(Game_Type) <> "smp"  AND LCase(Game_Type) <> "handicap" AND LCase(Game_Type) <> "special" AND LCase(Game_Type) <> "cross" Then

	    SQL = "UP_InsertInfo_Betting_DetailByUser"
	    	    
		reDim param(2)
		param(0) = Dber.MakeParam("@IB_IDX",adInteger,adParamInput, ,IB_IDX)
		param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput, ,IG_Idx)
		param(2) = Dber.MakeParam("@IBD_Num",adInteger,adParamInput, ,IB_Num)

		Dber.ExecSp SQL,param,Nothing	



		SQL = "UP_InsertInfo_BettingByCnt"
	    	    
		reDim param(3)
		param(0) = Dber.MakeParam("@IB_IDX",adInteger,adParamInput, ,IB_IDX)
		param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput, ,IG_Idx)
		param(2) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,12,Session("SD_ID"))
		param(3) = Dber.MakeParam("@IG_TYPE",adVarWChar,adParamInput,20,LCase(Game_Type))
		
		
		Dber.ExecSp SQL,param,Nothing
	else
		FOR fi=0 TO Cint(TotalCnt) - 1
	        SQL = "UP_InsertInfo_Betting_DetailByUser"
    	    	    
		    reDim param(2)
		    param(0) = Dber.MakeParam("@IB_IDX",adInteger,adParamInput, ,IB_IDX)
		    param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput, ,arr_IG_Idx(fi))
            param(2) = Dber.MakeParam("@IBD_Num",adInteger,adParamInput, ,arr_IB_Num(fi))
		    Dber.ExecSp SQL,param,Nothing	
			

			SQL = "UP_InsertInfo_BettingByCnt"	    	    
			reDim param(3)
			param(0) = Dber.MakeParam("@IB_IDX",adInteger,adParamInput, ,IB_IDX)
			param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput, ,arr_IG_Idx(fi))
			param(2) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,12,Session("SD_ID"))
			param(3) = Dber.MakeParam("@IG_TYPE",adVarWChar,adParamInput,20,LCase(Game_Type))
			
			Dber.ExecSp SQL,param,Nothing
		Next        
    End IF	    
        	

	'########   보유캐쉬 차감 ##############		
	Amount1 = "-"&IB_Amount

	SQL = "UP_INFO_CASH_UPD1"
	reDim param(2)
	param(0) = Dber.MakeParam("@IB_Amount",adInteger,adParamInput, ,IB_Amount)
	param(1) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(2) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
	Dber.ExecSp SQL,param,Nothing
				
	SQL = "SELECT IU_Cash FROM INFO_USER WHERE IU_ID = ? AND IU_SITE = ?"
	
	reDim param(1)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
	
	CIU_Cash	= sRs(0)
	
	sRs.close
	Set sRs = Nothing
		
	'########   차감내역을 Log_CashInOut에 입력 ##############		

	SQL = "SELECT IU_CODES FROM INFO_USER WHERE IU_ID = ?"
	
	reDim param(0)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

	IU_CODES = sRs(0)
	
	sRs.close
	Set sRs = Nothing
	

	SQL = "UP_LOG_CASHINOUT_INS"
	reDim param(7)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@Amount1",adInteger,adParamInput, ,Amount1)
	param(2) = Dber.MakeParam("@CIU_Cash",adInteger,adParamInput, ,CIU_Cash)
	param(3) = Dber.MakeParam("@LC_Contents",adVarWChar,adParamInput,20,"배팅차감")
	param(4) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
	param(5) = Dber.MakeParam("@LC_COMMENTS",adVarWChar,adParamInput,20,"일반")
	param(6) = Dber.MakeParam("@LC_liveyn",adWChar,adParamInput,1,LC_YN)
	param(7) = Dber.MakeParam("@IB_IDX",adInteger,adParamInput, ,IB_IDX)
	Dber.ExecSp SQL,param,Nothing	

	'########   배팅한 게임에 대한 장바구니 내용을 삭제 ##############		
	'FOR fi = 1 TO TotalCnt 
		'IG_Idx = Trim(REQUEST("IG_Idx")(fi))
		SQL = "UP_INFO_Cart_DEL6"
		reDim param(1)
		param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		'param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput, ,IG_Idx)
		'param(2) = Dber.MakeParam("@Game_Type",adVarWChar,adParamInput,20,Game_Type)
		param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		Dber.ExecSp SQL,param,Nothing

	'NEXT
	
   
        
		
	Dber.Dispose
	Set Dber = Nothing 
%>
<script type="text/javascript">

    alert("배팅이 정상적으로 이루어졌습니다. 배팅내용은 마이배팅페이지에서 확인하실 수 있습니다.");
    parent.location.href = "/game/BetGame.asp?Game_Type=<%=Game_Type1%>";        

</script>