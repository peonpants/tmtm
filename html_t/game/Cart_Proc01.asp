<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->

<%

	Flag        = REQUEST("Flag")        
	ICT_ID		= Trim(REQUEST("ICT_ID"))
    IG_Idx		= Trim(REQUEST("IG_Idx"))
    ICT_BetNum	= Trim(REQUEST("ICT_BetNum"))
	Game_Type	= Trim(REQUEST("Game_Type"))	
	GMemo		= Trim(REQUEST("GMemo"))
    ICT_Idx		= Trim(REQUEST("ICT_Idx"))
    IG_Handicap = Trim(REQUEST("IG_Handicap"))
    tdID = request("tdID")
    gtype = 0
    if LCase(Game_Type)="power" or LCase(Game_Type)="live" or LCase(Game_Type)="dal" or LCase(Game_Type)="powers" or LCase(Game_Type)="dari" then gtype = 1
    
    Set Dber = new clsDBHelper
	IF BETTING_ALL Then
	    IF LCase(Game_Type)  <> "special" Then
	        Game_Type = "All"
        End IF	        
    End IF
    IF Flag = "add" THEN
	IF LCase(Game_Type)  <> "power" and LCase(Game_Type)  <> "live"  and LCase(Game_Type)  <> "high" and LCase(Game_Type)  <> "dal" and LCase(Game_Type)  <> "dice" and LCase(Game_Type)  <> "aladin" and LCase(Game_Type)  <> "virtuals" and LCase(Game_Type)  <> "dari" and LCase(Game_Type)  <> "mgm" and LCase(Game_Type)  <> "toms" and LCase(Game_Type)  <> "bacarat" and LCase(Game_Type)  <> "choice" and LCase(Game_Type)  <> "nine" and LCase(Game_Type)  <> "powers" and LCase(Game_Type)  <> "lotusoe" and LCase(Game_Type)  <> "lotusb"  Then


			IF GMemo = "" Then
			    WITH RESPONSE
				    .WRITE "<script>" & vbcrlf
				    .WRITE "parent.location.reload();" & vbcrlf
				    .WRITE "</script>"
				    .END
			    END WITH	        
	        End IF
	        GMemoArr =  split(GMemo,"/")
	        IF ubound(GMemoArr) <> 2 Then
			    WITH RESPONSE
				    .WRITE "<script>" & vbcrlf
				    .WRITE "parent.location.reload();" & vbcrlf
				    .WRITE "</script>"
				    .END
			    END WITH		        
	        End IF


		    SQL = "SELECT  ICT_Idx   FROM Info_Cart WHERE ICT_ID= ? AND ICT_GameMemo = ? AND ICT_GType = ? AND ICT_SITE = ? "

	        checkGMemo = GMemoArr(0) & "/" & GMemoArr(1)

            If ICT_BetNum = "0" Then  '무를 선택하였을 경우에는 오버언더 안되도록 처리
	            IF cStr(GMemoArr(2)) = "0" Then '승무패
	                checkGMemoOver = checkGMemo &"/1"  '순서가 중요(아랫것과위치가 바뀌면 안됨)
	                checkGMemo = checkGMemo &"/2"
        		    SQL = "SELECT  ICT_Idx   FROM Info_Cart WHERE ICT_ID= ? AND (ICT_GameMemo = '" & checkGMemoOver &  "' OR (ICT_GameMemo = ? AND ICT_BetNum=2)) AND ICT_GType = ? AND ICT_SITE = ? "
	            End IF
			Else
	            IF cStr(GMemoArr(2)) = "0" Then '승무패
	                checkGMemo = checkGMemo &"/1"
	            ElseIF cStr(GMemoArr(2))= "1" Then '핸디캡
	                checkGMemo = checkGMemo &"/0"
	            ElseIF (cStr(GMemoArr(2))= "2" AND ICT_BetNum = 2) Then '오버언더
	                checkGMemo = checkGMemo &"/0"
   		            SQL = "SELECT  ICT_Idx   FROM Info_Cart WHERE ICT_BETNUM = 0 AND ICT_ID= ? AND ICT_GameMemo = ? AND ICT_GType = ? AND ICT_SITE = ? "
	            End IF
	        End IF

    		
		    reDim param2(3)
		    
		    param2(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,ICT_ID)
		    param2(1) = Dber.MakeParam("@GMemo",adVarWChar,adParamInput,400,checkGMemo)
		    param2(2) = Dber.MakeParam("@Game_Type",adVarWChar,adParamInput,10,Game_Type)
		    param2(3) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		    		    
		    Set sRs2 = Dber.ExecSQLReturnRS(SQL,param2,nothing)
		    If Not sRs2.eof Then
			    WITH RESPONSE
				    .WRITE "<script>" & vbcrlf
					.WRITE "alert('동일 경기의 [승무패와핸디캡] 또는 [무/핸디캡과 언더] 조합배팅이 불가능합니다.2');" & vbcrlf
				    .WRITE "parent.location.reload();" & vbcrlf
				    .WRITE "</script>"
				    .END
			    END WITH			    
		    End If 
      
			SQL = "SELECT IG_TEAM1, IG_TEAM2, IG_TYPE, IG_STARTTIME, RL_SPORTS, RL_LEAGUE FROM Info_Game WHERE IG_Idx = ? AND IG_TYPE IN (0,1) AND IG_SP = 'N'"
			  

			reDim param(0)
			param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,IG_Idx)

			Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

			If Not sRs.eof Then
			tRL_SPORTS = sRs("RL_SPORTS")
			Else
			tIG_TEAM1 = ""
			tIG_TEAM2 = ""
			tIG_TYPE = ""
			tIG_STARTTIME = "2010-01-01"
			tRL_SPORTS = ""
			tRL_LEAGUE = ""
			End If 

			sRs.close
			Set sRs = Nothing

			IF (LCase(Game_Type) = "cross" or LCase(Game_Type) = "handicap" or LCase(Game_Type) = "smp"  ) Then


				SQL = "SELECT  ICT_Idx   FROM Info_Cart WHERE ICT_ID= ? AND ICT_GameMemo = ? AND ICT_GType = ? AND ICT_SITE = ? "

				checkGMemo = GMemoArr(0) & "/" & GMemoArr(1)

				If ICT_BetNum = "0" Then  '무를 선택하였을 경우에는 오버언더 안되도록 처리
					IF cStr(GMemoArr(2)) = "0" Then '승무패
						checkGMemoOver = checkGMemo &"/1"  '순서가 중요(아랫것과위치가 바뀌면 안됨)
						checkGMemo = checkGMemo &"/2"
						SQL = "SELECT  ICT_Idx   FROM Info_Cart WHERE ICT_ID= ? AND (ICT_GameMemo = '" & checkGMemoOver &  "' OR (ICT_GameMemo = ? AND ICT_BetNum=2)) AND ICT_GType = ? AND ICT_SITE = ? "
					End IF
				ElseIf ICT_BetNum = "1" Then  '무를 선택하였을 경우에는 오버언더 안되도록 처리
					IF cStr(GMemoArr(2)) = "0" Then '승무패
						checkGMemoOver = checkGMemo &"/1"  '순서가 중요(아랫것과위치가 바뀌면 안됨)
						checkGMemo = checkGMemo &"/2"
						SQL = "SELECT  ICT_Idx   FROM Info_Cart WHERE ICT_ID= ? AND (ICT_GameMemo = '" & checkGMemoOver &  "' OR (ICT_GameMemo = ? AND ICT_BetNum=1)) AND ICT_GType = ? AND ICT_SITE = ? "
					End IF
				ElseIf ICT_BetNum = "2" Then  '무를 선택하였을 경우에는 오버언더 안되도록 처리
					IF cStr(GMemoArr(2)) = "0" Then '승무패
						checkGMemoOver = checkGMemo &"/1"  '순서가 중요(아랫것과위치가 바뀌면 안됨)
						checkGMemo = checkGMemo &"/2"
						SQL = "SELECT  ICT_Idx   FROM Info_Cart WHERE ICT_ID= ? AND (ICT_GameMemo = '" & checkGMemoOver &  "' OR (ICT_GameMemo = ? AND ICT_BetNum=1)) AND ICT_GType = ? AND ICT_SITE = ? "
					End IF
				Else
					IF cStr(GMemoArr(2)) = "0" Then '승무패
						checkGMemo = checkGMemo &"/1"
					ElseIF cStr(GMemoArr(2))= "1" Then '핸디캡
						checkGMemo = checkGMemo &"/0"
					ElseIF (cStr(GMemoArr(2))= "2" AND ICT_BetNum = 2) Then '오버언더
						checkGMemo = checkGMemo &"/0"
						SQL = "SELECT  ICT_Idx   FROM Info_Cart WHERE ICT_BETNUM = 0 AND ICT_ID= ? AND ICT_GameMemo = ? AND ICT_GType = ? AND ICT_SITE = ? "
					End IF
				End IF
				
				reDim param2(3)
				
				param2(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,ICT_ID)
				param2(1) = Dber.MakeParam("@GMemo",adVarWChar,adParamInput,400,checkGMemo)
				param2(2) = Dber.MakeParam("@Game_Type",adVarWChar,adParamInput,10,Game_Type)
				param2(3) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
							
				Set sRs2 = Dber.ExecSQLReturnRS(SQL,param2,nothing)
				If Not sRs2.eof Then
					WITH RESPONSE
						.WRITE "<script>" & vbcrlf
						.WRITE "alert('동일 경기의 [승무패와핸디캡] 또는 [무/핸디캡과 언더] 또는 [승/오바] 조합배팅이 불가능합니다.2');" & vbcrlf
						.WRITE "parent.location.reload();" & vbcrlf
						.WRITE "</script>"
						.END
					END WITH			    
				End If    
				
				sRs2.close
				Set sRs2 = Nothing		


			end if
'''''''''''''''''''''핸디와 언옵조합 불가로직추가 0327''''''''''''''''''''''''''''''''''''
if LCase(Game_Type) = "cross" Or LCase(Game_Type) = "smp" Or LCase(Game_Type) = "handicap"  then
	SQL = "SELECT IG_TEAM1, IG_TEAM2, IG_TYPE, IG_STARTTIME, RL_SPORTS, RL_LEAGUE FROM Info_Game WHERE IG_Idx = ? AND IG_TYPE IN (1,2) AND IG_SP = 'N' and rl_sports='축구'"


	reDim param(0)
	param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,IG_Idx)

	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

	If Not sRs.eof Then
	tIG_TEAM1 = Trim(sRs("IG_TEAM1"))
	tIG_TEAM2 = Trim(sRs("IG_TEAM2"))
	tIG_TYPE = sRs("IG_TYPE")
	tIG_STARTTIME = dfSiteUtil.GetFullDate(sRs("IG_STARTTIME"))
	tRL_SPORTS = sRs("RL_SPORTS")
	tRL_LEAGUE = sRs("RL_LEAGUE")
	Else
	tIG_TEAM1 = ""
	tIG_TEAM2 = ""
	tIG_TYPE = ""
	tIG_STARTTIME = "2010-01-01"
	tRL_SPORTS = ""
	tRL_LEAGUE = ""
	End If 

	sRs.close
	Set sRs = Nothing    		


	'####### 타입에 따라 같은 팀명이 카트내에 존재한다면 팅기게 한다.
	IF cStr(tIG_TYPE) = "2" Then
		SQL = "SELECT IG_IDX FROM Info_Game WHERE IG_TEAM1 = ? AND IG_TEAM2 = ? AND IG_STARTTIME = ? AND RL_SPORTS = ? AND RL_LEAGUE = ? AND IG_TYPE  = 1 AND IG_SP = 'N' and rl_sports='축구'"


		reDim param(4)
		param(0) = Dber.MakeParam("@IG_TEAM1",adVarWChar,adParamInput,100,tIG_TEAM1)
		param(1) = Dber.MakeParam("@IG_TEAM2",adVarWChar,adParamInput,100,tIG_TEAM2)
		param(2) = Dber.MakeParam("@IG_STARTTIME",adVarWChar,adParamInput,100,tIG_STARTTIME)
		param(3) = Dber.MakeParam("@RL_SPORTS",adVarWChar,adParamInput,100,tRL_SPORTS)
		param(4) = Dber.MakeParam("@RL_LEAGUE",adVarWChar,adParamInput,100,tRL_LEAGUE)

		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

			If Not sRs.eof Then
			tIG_IDX = sRs("IG_IDX")			                		            
			End If         		

		sRs.close
		Set sRs = Nothing


			IF tIG_IDX <> "" Then

				SQL = "SELECT ICT_IDX FROM Info_Cart WHERE ICT_ID= ? AND ICT_GAMENUM=?"

				reDim param(1)
				param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
				param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,tIG_IDX)
				Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)			        

					If Not sRs.eof Then
					WITH RESPONSE
					.WRITE "<script>" & vbcrlf
					.WRITE "alert('동일경기는 핸디/오버 조합은불가능합니다.1');" & vbcrlf
					.WRITE "parent.location.reload();" & vbcrlf
					.WRITE "</script>"
					.END
					END WITH            			                    
				End IF 

				sRs.close
				Set sRs = Nothing
			End IF    	
	ElseIF cStr(tIG_TYPE) = "1" Then
		SQL = "SELECT IG_IDX FROM Info_Game WHERE IG_TEAM1 = ? AND IG_TEAM2 = ? AND IG_STARTTIME = ? AND RL_SPORTS = ? AND RL_LEAGUE = ? AND IG_TYPE  = 2  AND IG_SP = 'N' and rl_sports='축구'"

		reDim param(4)
		param(0) = Dber.MakeParam("@IG_TEAM1",adVarWChar,adParamInput,100,tIG_TEAM1)
		param(1) = Dber.MakeParam("@IG_TEAM2",adVarWChar,adParamInput,100,tIG_TEAM2)
		param(2) = Dber.MakeParam("@IG_STARTTIME",adVarWChar,adParamInput,100,tIG_STARTTIME)
		param(3) = Dber.MakeParam("@RL_SPORTS",adVarWChar,adParamInput,100,tRL_SPORTS)
		param(4) = Dber.MakeParam("@RL_LEAGUE",adVarWChar,adParamInput,100,tRL_LEAGUE)

		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

			If Not sRs.eof Then
			tIG_IDX = sRs("IG_IDX")			                		            
			End If         		

		sRs.close
		Set sRs = Nothing


			IF tIG_IDX <> "" Then
				SQL = "SELECT ICT_IDX FROM Info_Cart WHERE ICT_ID= ? AND ICT_GAMENUM=?"

				reDim param(1)
				param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
				param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,tIG_IDX)


				Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)			        

				If Not sRs.eof Then
					WITH RESPONSE
					.WRITE "<script>" & vbcrlf
					.WRITE "alert('동일경기는 핸디/오버 조합은불가능합니다.2');" & vbcrlf
					.WRITE "parent.location.reload();" & vbcrlf
					.WRITE "</script>"
					.END
					END WITH            			                    
				End IF 

				sRs.close
				Set sRs = Nothing
			End IF            
	End IF    

'''''''''''''''''''''핸디와언옵조합 불가끝''''''''''''''''''''''''''''''''''''''''''''''''
'''''''''''''''''''''승패와언옵조합 불가로직추가 0328''''''''''''''''''''''''''''''''''''
      SQL = "SELECT IG_TEAM1, IG_TEAM2, IG_TYPE, IG_STARTTIME, RL_SPORTS, RL_LEAGUE FROM Info_Game WHERE IG_Idx = ? AND IG_TYPE IN (0,2) AND IG_SP = 'N'"
          

      reDim param(0)
      param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,IG_Idx)

      Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

      If Not sRs.eof Then
        tIG_TEAM1 = Trim(sRs("IG_TEAM1"))
        tIG_TEAM2 = Trim(sRs("IG_TEAM2"))
        tIG_TYPE = sRs("IG_TYPE")
        tIG_STARTTIME = dfSiteUtil.GetFullDate(sRs("IG_STARTTIME"))
        tRL_SPORTS = sRs("RL_SPORTS")
        tRL_LEAGUE = sRs("RL_LEAGUE")
      Else
        tIG_TEAM1 = ""
        tIG_TEAM2 = ""
        tIG_TYPE = ""
        tIG_STARTTIME = "2010-01-01"
        tRL_SPORTS = ""
        tRL_LEAGUE = ""
      End If 

      sRs.close
      Set sRs = Nothing    		


'####### 타입에 따라 같은 팀명이 카트내에 존재한다면 팅기게 한다.
	IF cStr(tIG_TYPE) = "2" Then
		SQL = "SELECT IG_IDX FROM Info_Game WHERE IG_TEAM1 = ? AND IG_TEAM2 = ? AND IG_STARTTIME = ? AND RL_SPORTS = ? AND RL_LEAGUE = ? AND IG_TYPE  = 0 AND IG_SP = 'N'"


		reDim param(4)
		param(0) = Dber.MakeParam("@IG_TEAM1",adVarWChar,adParamInput,100,tIG_TEAM1)
		param(1) = Dber.MakeParam("@IG_TEAM2",adVarWChar,adParamInput,100,tIG_TEAM2)
		param(2) = Dber.MakeParam("@IG_STARTTIME",adVarWChar,adParamInput,100,tIG_STARTTIME)
		param(3) = Dber.MakeParam("@RL_SPORTS",adVarWChar,adParamInput,100,tRL_SPORTS)
		param(4) = Dber.MakeParam("@RL_LEAGUE",adVarWChar,adParamInput,100,tRL_LEAGUE)

		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
			
		If Not sRs.eof Then
		tIG_IDX = sRs("IG_IDX")			                		            
		End If         		

		sRs.close
		Set sRs = Nothing


		IF tIG_IDX <> "" Then

			SQL = "SELECT ICT_IDX FROM Info_Cart WHERE ICT_ID= ? AND ICT_GAMENUM=?"

			reDim param(1)
			param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
			param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,tIG_IDX)
			Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)			        

			If Not sRs.eof Then
			WITH RESPONSE
			.WRITE "<script>" & vbcrlf
			.WRITE "alert('동일경기는 승패/언더오버 조합은불가능합니다.1');" & vbcrlf
			.WRITE "parent.location.reload();" & vbcrlf
			.WRITE "</script>"
			.END
			END WITH            			                    
			End IF 

			sRs.close
			Set sRs = Nothing
		End IF    	
	ElseIF cStr(tIG_TYPE) = "0" Then
		SQL = "SELECT IG_IDX FROM Info_Game WHERE IG_TEAM1 = ? AND IG_TEAM2 = ? AND IG_STARTTIME = ? AND RL_SPORTS = ? AND RL_LEAGUE = ? AND IG_TYPE  = 2  AND IG_SP = 'N'"

		reDim param(4)
		param(0) = Dber.MakeParam("@IG_TEAM1",adVarWChar,adParamInput,100,tIG_TEAM1)
		param(1) = Dber.MakeParam("@IG_TEAM2",adVarWChar,adParamInput,100,tIG_TEAM2)
		param(2) = Dber.MakeParam("@IG_STARTTIME",adVarWChar,adParamInput,100,tIG_STARTTIME)
		param(3) = Dber.MakeParam("@RL_SPORTS",adVarWChar,adParamInput,100,tRL_SPORTS)
		param(4) = Dber.MakeParam("@RL_LEAGUE",adVarWChar,adParamInput,100,tRL_LEAGUE)

		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
			
		If Not sRs.eof Then
		tIG_IDX = sRs("IG_IDX")			                		            
		End If         		

		sRs.close
		Set sRs = Nothing


		IF tIG_IDX <> "" Then
			SQL = "SELECT ICT_IDX FROM Info_Cart WHERE ICT_ID= ? AND ICT_GAMENUM=?"

			reDim param(1)
			param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
			param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,tIG_IDX)


			Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)			        

			If Not sRs.eof Then
			WITH RESPONSE
			.WRITE "<script>" & vbcrlf
			.WRITE "alert('동일경기는 승패/언더오버 조합은불가능합니다.2');" & vbcrlf
			.WRITE "parent.location.reload();" & vbcrlf
			.WRITE "</script>"
			.END
			END WITH            			                    
			End IF 

			sRs.close
			Set sRs = Nothing
		End IF            
	End IF    

'''''''''''''''''''''''''''''''''''''''''''''''''''승무패와 핸디캡 동일경기 크로스 불가하게 추가됨''''''''''''''''''''''''''''''''''''''''
end if
end if '축구로직 끝
		SQL = "SELECT ICT_IDX, ICT_GAMENUM, ICT_BETNUM FROM Info_Cart WITH (NOLOCK) WHERE ICT_ID= ? AND ICT_GType = ? AND ICT_SITE = ? AND ict_betnum = ? AND ICT_GAMENUM = ? " 
        
		Dim param_select(4)
		param_select(0) = Dber.MakeParam("@ICT_ID", adVarWChar,adParamInput,20,Session("SD_ID"))
		param_select(1) = Dber.MakeParam("@Game_Type", adVarWChar,adParamInput,10,Game_Type)
		param_select(2) = Dber.MakeParam("@JOBSITE", adVarWChar,adParamInput,20,JOBSITE)
		param_select(3) = Dber.MakeParam("@ICT_BetNum",adInteger,adParamInput,,ICT_BetNum)
		param_select(4) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,IG_Idx)
			
		Set sRs = Dber.ExecSQLReturnRS(SQL,param_select,nothing)

		If Not sRs.eof Then
      Flag = "sub2"
		End If 
		
		sRs.close
		Set sRs = Nothing
    End IF		

	'########   장바구니 등록    ##############	    
	IF Flag = "add" THEN
	
    '######## 크로스 조합인 경우 핸디캡/승무패 동일 게임이 잇는지 체크한다.
    IF Game_Type = "All" Then

      SQL = "SELECT IG_TEAM1, IG_TEAM2, IG_TYPE, IG_STARTTIME, RL_SPORTS, RL_LEAGUE FROM Info_Game WHERE IG_Idx = ? AND IG_TYPE IN (0,1) AND IG_SP = 'N'"
          

      reDim param(0)
      param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,IG_Idx)

      Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

      If Not sRs.eof Then
        tIG_TEAM1 = Trim(sRs("IG_TEAM1"))
        tIG_TEAM2 = Trim(sRs("IG_TEAM2"))
        tIG_TYPE = sRs("IG_TYPE")
        tIG_STARTTIME = dfSiteUtil.GetFullDate(sRs("IG_STARTTIME"))
        tRL_SPORTS = sRs("RL_SPORTS")
        tRL_LEAGUE = sRs("RL_LEAGUE")
      Else
        tIG_TEAM1 = ""
        tIG_TEAM2 = ""
        tIG_TYPE = ""
        tIG_STARTTIME = "2010-01-01"
        tRL_SPORTS = ""
        tRL_LEAGUE = ""
      End If 

      sRs.close
      Set sRs = Nothing    		


    '####### 타입에 따라 같은 팀명이 카트내에 존재한다면 팅기게 한다.
    IF cStr(tIG_TYPE) = "0" Then
      SQL = "SELECT IG_IDX FROM Info_Game WHERE IG_TEAM1 = ? AND IG_TEAM2 = ? AND IG_STARTTIME = ? AND RL_SPORTS = ? AND RL_LEAGUE = ? AND IG_TYPE  = 1 AND IG_SP = 'N'"
        
        
        reDim param(4)
        param(0) = Dber.MakeParam("@IG_TEAM1",adVarWChar,adParamInput,100,tIG_TEAM1)
        param(1) = Dber.MakeParam("@IG_TEAM2",adVarWChar,adParamInput,100,tIG_TEAM2)
        param(2) = Dber.MakeParam("@IG_STARTTIME",adVarWChar,adParamInput,100,tIG_STARTTIME)
        param(3) = Dber.MakeParam("@RL_SPORTS",adVarWChar,adParamInput,100,tRL_SPORTS)
        param(4) = Dber.MakeParam("@RL_LEAGUE",adVarWChar,adParamInput,100,tRL_LEAGUE)
    		
        Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
        		        
        If Not sRs.eof Then
          tIG_IDX = sRs("IG_IDX")			                		            
        End If         		
        
        sRs.close
        Set sRs = Nothing
        
            
            IF tIG_IDX <> "" Then
            
              SQL = "SELECT ICT_IDX FROM Info_Cart WHERE ICT_ID= ? AND ICT_GAMENUM=?"
        		
              reDim param(1)
              param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
              param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,tIG_IDX)
              Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)			        
              
                If Not sRs.eof Then
                  WITH RESPONSE
                    .WRITE "<script>" & vbcrlf
                    .WRITE "alert('동일경기는 핸디/승무패 조합은불가능합니다.');" & vbcrlf
                    .WRITE "parent.location.reload();" & vbcrlf
                    .WRITE "</script>"
                    .END
                  END WITH            			                    
                End IF 
                
              sRs.close
              Set sRs = Nothing
            End IF    	
        ElseIF cStr(tIG_TYPE) = "1" Then
            SQL = "SELECT IG_IDX FROM Info_Game WHERE IG_TEAM1 = ? AND IG_TEAM2 = ? AND IG_STARTTIME = ? AND RL_SPORTS = ? AND RL_LEAGUE = ? AND IG_TYPE  = 0 AND IG_SP = 'N'"
      
        reDim param(4)
        param(0) = Dber.MakeParam("@IG_TEAM1",adVarWChar,adParamInput,100,tIG_TEAM1)
        param(1) = Dber.MakeParam("@IG_TEAM2",adVarWChar,adParamInput,100,tIG_TEAM2)
        param(2) = Dber.MakeParam("@IG_STARTTIME",adVarWChar,adParamInput,100,tIG_STARTTIME)
        param(3) = Dber.MakeParam("@RL_SPORTS",adVarWChar,adParamInput,100,tRL_SPORTS)
        param(4) = Dber.MakeParam("@RL_LEAGUE",adVarWChar,adParamInput,100,tRL_LEAGUE)
    		
        Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
        		        
        If Not sRs.eof Then
          tIG_IDX = sRs("IG_IDX")			                		            
        End If         		
        
        sRs.close
        Set sRs = Nothing
        
            
            IF tIG_IDX <> "" Then
              SQL = "SELECT ICT_IDX FROM Info_Cart WHERE ICT_ID= ? AND ICT_GAMENUM=?"
        	
              reDim param(1)
              param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
              param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,tIG_IDX)
              
              
              Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)			        
              
                If Not sRs.eof Then
              WITH RESPONSE
                .WRITE "<script>" & vbcrlf
                .WRITE "alert('동일경기는 핸디/승무패 조합은불가능합니다.');" & vbcrlf
                .WRITE "parent.location.reload();" & vbcrlf
                .WRITE "</script>"
                .END
              END WITH            			                    
                End IF 
                
              sRs.close
              Set sRs = Nothing
            End IF            
        End IF    
        
      '#### 요청에 의하여 승무패/오버언더 조합도 막음  
      SQL = "SELECT IG_TEAM1, IG_TEAM2, IG_TYPE, IG_STARTTIME, RL_SPORTS, RL_LEAGUE FROM Info_Game WHERE IG_Idx = ? AND IG_TYPE IN (0,2) AND IG_SP = 'N'"
          

      reDim param(0)
      param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,IG_Idx)

      Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

      If Not sRs.eof Then
        tIG_TEAM1 = Trim(sRs("IG_TEAM1"))
        tIG_TEAM2 = Trim(sRs("IG_TEAM2"))
        tIG_TYPE = sRs("IG_TYPE")
        tIG_STARTTIME = dfSiteUtil.GetFullDate(sRs("IG_STARTTIME"))
        tRL_SPORTS = sRs("RL_SPORTS")
        tRL_LEAGUE = sRs("RL_LEAGUE")
      Else
        tIG_TEAM1 = ""
        tIG_TEAM2 = ""
        tIG_TYPE = ""
        tIG_STARTTIME = "2010-01-01"
        tRL_SPORTS = ""
        tRL_LEAGUE = ""
      End If 

      sRs.close
      Set sRs = Nothing    		


    '####### 타입에 따라 같은 팀명이 카트내에 존재한다면 팅기게 한다.
    IF cStr(tIG_TYPE) = "0" Then
      SQL = "SELECT IG_IDX FROM Info_Game WHERE IG_TEAM1 = ? AND IG_TEAM2 = ? AND IG_STARTTIME = ? AND RL_SPORTS = ? AND RL_LEAGUE = ? AND IG_TYPE  = 2 AND IG_SP = 'N'"
        
        
        reDim param(4)
        param(0) = Dber.MakeParam("@IG_TEAM1",adVarWChar,adParamInput,100,tIG_TEAM1)
        param(1) = Dber.MakeParam("@IG_TEAM2",adVarWChar,adParamInput,100,tIG_TEAM2)
        param(2) = Dber.MakeParam("@IG_STARTTIME",adVarWChar,adParamInput,100,tIG_STARTTIME)
        param(3) = Dber.MakeParam("@RL_SPORTS",adVarWChar,adParamInput,100,tRL_SPORTS)
        param(4) = Dber.MakeParam("@RL_LEAGUE",adVarWChar,adParamInput,100,tRL_LEAGUE)
    		
        Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
        		        
        If Not sRs.eof Then
          tIG_IDX = sRs("IG_IDX")			                		            
        End If         		
        
        sRs.close
        Set sRs = Nothing
        
            
            IF tIG_IDX <> "" Then
            
              SQL = "SELECT ICT_IDX FROM Info_Cart WHERE ICT_ID= ? AND ICT_GAMENUM=?"
        		
              reDim param(1)
              param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
              param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,tIG_IDX)
              Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)			        
              
                If Not sRs.eof Then
                  WITH RESPONSE
                    .WRITE "<script>" & vbcrlf
                    .WRITE "alert('동일경기는 오버언더/승무패 조합은불가능합니다.');" & vbcrlf
                    .WRITE "parent.location.reload();" & vbcrlf
                    .WRITE "</script>"
                    .END
                  END WITH            			                    
                End IF 
                
              sRs.close
              Set sRs = Nothing
            End IF    	
        ElseIF cStr(tIG_TYPE) = "2" Then
            SQL = "SELECT IG_IDX FROM Info_Game WHERE IG_TEAM1 = ? AND IG_TEAM2 = ? AND IG_STARTTIME = ? AND RL_SPORTS = ? AND RL_LEAGUE = ? AND IG_TYPE  = 0 AND IG_SP = 'N'"
      
        reDim param(4)
        param(0) = Dber.MakeParam("@IG_TEAM1",adVarWChar,adParamInput,100,tIG_TEAM1)
        param(1) = Dber.MakeParam("@IG_TEAM2",adVarWChar,adParamInput,100,tIG_TEAM2)
        param(2) = Dber.MakeParam("@IG_STARTTIME",adVarWChar,adParamInput,100,tIG_STARTTIME)
        param(3) = Dber.MakeParam("@RL_SPORTS",adVarWChar,adParamInput,100,tRL_SPORTS)
        param(4) = Dber.MakeParam("@RL_LEAGUE",adVarWChar,adParamInput,100,tRL_LEAGUE)
    		
        Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
        		        
        If Not sRs.eof Then
          tIG_IDX = sRs("IG_IDX")			                		            
        End If         		
        
        sRs.close
        Set sRs = Nothing
        
            
            IF tIG_IDX <> "" Then
              SQL = "SELECT ICT_IDX FROM Info_Cart WHERE ICT_ID= ? AND ICT_GAMENUM=?"
        	
              reDim param(1)
              param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
              param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,tIG_IDX)
              
              
              Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)			        
              
                If Not sRs.eof Then
              WITH RESPONSE
                .WRITE "<script>" & vbcrlf
                .WRITE "alert('동일경기는 오버언더/승무패 조합은불가능합니다.');" & vbcrlf
                .WRITE "parent.location.reload();" & vbcrlf
                .WRITE "</script>"
                .END
              END WITH            			                    
                End IF 
                
              sRs.close
              Set sRs = Nothing
            End IF            
        End IF   
	  '#### 요청에 의하여 승무패/오버 조합 막음(15/03/16)  
      SQL = "SELECT IG_TEAM1, IG_TEAM2, IG_TYPE, IG_STARTTIME, RL_SPORTS, RL_LEAGUE FROM Info_Game WHERE IG_Idx = ? AND IG_TYPE IN (0,2) AND IG_SP = 'N'"
          

      reDim param(0)
      param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,IG_Idx)

      Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

      If Not sRs.eof Then
        tIG_TEAM1 = Trim(sRs("IG_TEAM1"))
        tIG_TEAM2 = Trim(sRs("IG_TEAM2"))
        tIG_TYPE = sRs("IG_TYPE")
        tIG_STARTTIME = dfSiteUtil.GetFullDate(sRs("IG_STARTTIME"))
        tRL_SPORTS = sRs("RL_SPORTS")
        tRL_LEAGUE = sRs("RL_LEAGUE")
      Else
        tIG_TEAM1 = ""
        tIG_TEAM2 = ""
        tIG_TYPE = ""
        tIG_STARTTIME = "2010-01-01"
        tRL_SPORTS = ""
        tRL_LEAGUE = ""
      End If 

      sRs.close
      Set sRs = Nothing    		


    '####### 타입에 따라 같은 팀명이 카트내에 존재한다면 팅기게 한다.
		IF cStr(tIG_TYPE) = "2" and ICT_BetNum = "1" Then
            SQL = "SELECT IG_IDX FROM Info_Game WHERE IG_TEAM1 = ? AND IG_TEAM2 = ? AND IG_STARTTIME = ? AND RL_SPORTS = ? AND RL_LEAGUE = ? AND IG_TYPE = 0 AND IG_SP = 'N'"
      
        reDim param(4)
        param(0) = Dber.MakeParam("@IG_TEAM1",adVarWChar,adParamInput,100,tIG_TEAM1)
        param(1) = Dber.MakeParam("@IG_TEAM2",adVarWChar,adParamInput,100,tIG_TEAM2)
        param(2) = Dber.MakeParam("@IG_STARTTIME",adVarWChar,adParamInput,100,tIG_STARTTIME)
        param(3) = Dber.MakeParam("@RL_SPORTS",adVarWChar,adParamInput,100,tRL_SPORTS)
        param(4) = Dber.MakeParam("@RL_LEAGUE",adVarWChar,adParamInput,100,tRL_LEAGUE)
    		
        Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
        		        
        If Not sRs.eof Then
          tIG_IDX = sRs("IG_IDX")			                		            
        End If         		
        
        sRs.close
        Set sRs = Nothing
        
            
            IF tIG_IDX <> "" Then
              SQL = "SELECT ICT_IDX FROM Info_Cart WHERE ICT_ID= ? AND ICT_GAMENUM=?"
        	
              reDim param(1)
              param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
              param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,tIG_IDX)
              
              
              Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)			        
              
                If Not sRs.eof Then
              WITH RESPONSE
                .WRITE "<script>" & vbcrlf
				.WRITE "alert('동일 경기의 [승무패와핸디캡] 또는 [무/핸디캡과 언더] 또는 [승/오버] 조합배팅이 불가능합니다.2');" & vbcrlf
                .WRITE "parent.location.reload();" & vbcrlf
                .WRITE "</script>"
                .END
              END WITH            			                    
                End IF 
                
              sRs.close
              Set sRs = Nothing
            End IF            
        End IF   
                            
    End IF     						
		'########   카트에 담을때 게임시작 시간 체크해서 게임이 시작됐으면 배팅마감(E)로 변경하고 Info_Cart의 해당게임을 모두 삭제한다.    ##############	    
		SQL = "SELECT IG_StartTime, IG_Status FROM Info_Game WITH (NOLOCK) WHERE IG_Idx = ?"

		reDim param(0)
		param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,IG_Idx)
		
		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

		If Not sRs.eof Then
			IG_StartTime = sRs("IG_StartTime")
			IG_Status = sRs("IG_Status")
			df = DATEDIFF("s",now(),Cdate(IG_StartTime))
		End If 
		
		sRs.close
		Set sRs = Nothing

		'// Cint(df)할경우 오버플로우...가능성...
		IF CDBL(df) < GAME_END_TEAM THEN
			

			SQL = "UP_INFO_Cart_DEL2 "

			reDim param(1)		
			param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,IG_Idx)
			param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)					
			Dber.ExecSP SQL,param,Nothing


			Dber.Dispose
			Set Dber = Nothing 
			

			WITH RESPONSE
				.WRITE "<script>" & vbcrlf
				.WRITE "parent.location.reload();" & vbcrlf
				.WRITE "</script>"
				.END
			END WITH
		END IF

		
		'카트에 담을 수 있는 게임수(10개)를 초과하였을 경우.
		

		SQL = "SELECT Count(ICT_Idx) as Cnt FROM Info_Cart WITH (NOLOCK) WHERE ICT_ID= ? AND ICT_GType = ? AND ICT_SITE = ?"
		
		reDim param(2)
		param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@Game_Type",adVarWChar,adParamInput,10,Game_Type)
		param(2) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

		If Not sRs.eof Then
			Cnt = sRs("Cnt")
		End If 

		sRs.close
		Set sRs = Nothing

		IF CDbl(Cnt) =>  BETTING_COUNT  Then
			Dber.Dispose
			Set Dber = Nothing 
			WITH RESPONSE
				.WRITE "<script>" & vbcrlf
				.WRITE "alert('카트 담을수 있는 게임은 최대 "&BETTING_COUNT&"개 입니다. 필요없는 게임을 삭제해 주세요.');" & vbcrlf
				.WRITE "parent.location.reload();" & vbcrlf
				.WRITE "</script>"
				.END
			END WITH
		END IF

		
		SQL = "SELECT ICT_IDX, ICT_GAMENUM, ICT_BETNUM FROM Info_Cart WITH (NOLOCK) WHERE ICT_ID= ? AND ICT_GType = ? AND ICT_SITE = ? AND ICT_GAMENUM=?"
		
		reDim param(3)
		param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		'param(1) = Dber.MakeParam("@GMemo",adVarWChar,adParamInput,100,GMemo)
		param(1) = Dber.MakeParam("@Game_Type",adVarWChar,adParamInput,10,Game_Type)
		param(2) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		param(3) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,IG_Idx)
		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

		If Not sRs.eof Then
			ICT_IDX = sRs(0)
			ICT_GAMENUM = sRs(1)
			ICT_BETNUMM	= sRs(2)
                        
            'update cart
			SQL = "UP_INFO_Cart_UPD"
			
			reDim param(3)
			param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,IG_Idx)
			param(1) = Dber.MakeParam("@GMemo",adVarWChar,adParamInput,400,GMemo)
			param(2) = Dber.MakeParam("@ICT_BetNum",adInteger,adParamInput,,ICT_BetNum)
			param(3) = Dber.MakeParam("@ICT_IDX",adInteger,adParamInput,,ICT_IDX)
			Dber.ExecSP SQL,param,Nothing
			Response.Write "<script>" 	
			Response.Write "parent.switchBtn('id0"&"_"&ICT_GAMENUM&"');"
			Response.Write "parent.switchBtn('id1"&"_"&ICT_GAMENUM&"');"
			Response.Write "parent.switchBtn('id2"&"_"&ICT_GAMENUM&"');"
			Response.Write "parent.document.getElementById('"&tdID&"').classList.add('CssSelect');"
			Response.Write "</script>"

		Else
		    '########   장바구니 등록    ##############
		    if (Game_Type ="live" or Game_Type ="power" or Game_Type ="powers" or Game_Type ="dari" or Game_Type ="dal")then
				SQL = "UP_INFO_Cart_DEL4"
					reDim param(2)
					param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
					param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
					param(2) = Dber.MakeParam("@Game_Type",adVarWChar,adParamInput,10,Game_Type)
					Dber.ExecSP SQL,param,Nothing
			end if
			
			SQL = "UP_INFO_Cart_INS"
			reDim param(5)
			param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
			param(1) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,IG_Idx)
			param(2) = Dber.MakeParam("@GMemo",adVarWChar,adParamInput,400,GMemo)
			param(3) = Dber.MakeParam("@ICT_BetNum",adInteger,adParamInput,,ICT_BetNum)
			param(4) = Dber.MakeParam("@Game_Type",adVarWChar,adParamInput,10,Game_Type)
			param(5) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
			Dber.ExecSP SQL,param,Nothing

			Response.Write "<script>" 	
			Response.Write "parent.document.getElementById('"&tdID&"').classList.add('CssSelect');"
			Response.Write "</script>"
			
		END IF

		sRs.close
		Set sRs = Nothing
		
		
    '########   한 게임 삭제    ##############
	ELSEIF Flag = "sub" THEN
		SQL = "UP_INFO_Cart_DEL3"
		reDim param(2)
				
		param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@ICT_Idx",adInteger,adParamInput,,ICT_Idx)
		param(2) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		Dber.ExecSP SQL,param,Nothing
		
		
	
	ELSEIF Flag = "sub2" THEN
	
		SQL = " SELECT A.ICT_IDX, A.ICT_GAMENUM, A.ICT_BETNUM, B.IG_TEAM1, B.IG_TEAM2, B.IG_TEAM1BENEFIT, B.IG_DRAWBENEFIT, B.IG_TEAM2BENEFIT, B.IG_Handicap  "
		SQL = SQL & " FROM INFO_CART A WITH (NOLOCK), INFO_GAME B WITH (NOLOCK)"
		SQL = SQL & "WHERE A.ICT_GAMENUM = B.IG_IDX AND A.ICT_ID = ? AND A.ICT_GTYPE = ? AND A.ICT_SITE = ? AND ICT_GAMENUM = ? AND ICT_BETNUM = ? "
		
		Dim param_sub2(4)
		param_sub2(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param_sub2(1) = Dber.MakeParam("@Game_Type",adVarWChar,adParamInput,10,Game_Type)
		param_sub2(2) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		param_sub2(3) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,IG_Idx)
		param_sub2(4) = Dber.MakeParam("@ICT_BetNum",adInteger,adParamInput,,ICT_BetNum)
		
			
		Set sRs = Dber.ExecSQLReturnRS(SQL,param_sub2,nothing)
        
		ict_idx22 = sRs("ict_idx")


		sRs.close
		Set sRs = Nothing
	
		SQL = "UP_INFO_Cart_DEL3"
		reDim param(2)
		param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@ICT_Idx",adInteger,adParamInput,,ict_idx22)
		param(2) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
		
		Dber.ExecSP SQL,param,Nothing

		'20141010 삭제 후 view단 버튼 이미지 변경
		Response.Write "<script>" 	
		Response.Write "parent.switchBtn('"&tdID&"');" 	
		Response.Write "</script>"
		
		
	'########   모든 게임 삭제    ##############
	ELSEIF Flag = "subAll" Then
		SQL = "UP_INFO_Cart_DEL4"
		reDim param(2)
		param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
		param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
        param(2) = Dber.MakeParam("@Game_Type",adVarWChar,adParamInput,10,Game_Type)
        
		Dber.ExecSP SQL,param,Nothing
		Dber.Dispose
		Set Dber = Nothing 
		WITH RESPONSE
			.WRITE "<script>" & vbcrlf
			.WRITE "parent.location.reload();" & vbcrlf
			.WRITE "</script>"
			.END
		END WITH
	END If

	returnVal = ""
	returnVal2 = ""

	SQL = "SELECT a.ict_idx AS ict_idx, a.ict_gamenum AS ict_gamenum, b.ig_starttime AS ig_starttime , b.IG_status as IG_status FROM info_cart a WITH (NOLOCK), info_game b WITH (NOLOCK) WHERE a.ict_gamenum = b.ig_idx and a.ict_id = ? and a.ict_site = ? and a.ict_gtype = ?"
	
	reDim param(2)
	param(0) = Dber.MakeParam("@ICT_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
    param(2) = Dber.MakeParam("@Game_Type",adVarWChar,adParamInput,10,Game_Type)
    
	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

	If Not sRs.eof Then
		Do Until sRs.eof
			k2_ict_idx = sRs("ict_idx")
			k2_ict_gamenum = sRs("ict_gamenum")
			k2_ig_starttime = sRs("ig_starttime")
			k2_ig_status = sRs("ig_status")

			dfk2 = datediff("s",now(),Cdate(k2_ig_starttime))

			IF CDBL(dfk2) < GAME_END_TEAM Or k2_ig_status = "E"  Then
				SQL = "UP_INFO_Cart_DEL5"		
				
				reDim param(4)
				param(0) = Dber.MakeParam("@k2_ict_gamenum",adInteger,adParamInput,,k2_ict_gamenum)
				param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)
				param(2) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
				param(3) = Dber.MakeParam("@k2_ict_idx",adInteger,adParamInput,,k2_ict_idx)
				param(4) = Dber.MakeParam("@ict_gtype",adVarWChar,adParamInput,10,Game_Type)
				
				Dber.ExecSP SQL,param,Nothing
				
				delnum = 1
			END If
		sRs.MoveNext
		Loop
	End If 

	sRs.close
	Set sRs = Nothing
		
	If delnum > 0 Then
		Dber.Dispose
		Set Dber = Nothing 

		WITH RESPONSE
			.WRITE "<script>" & vbcrlf
			.WRITE "alert('배팅시간을 초과한 게임을 삭제하였습니다.');" & vbcrlf
			.WRITE "parent.location.reload();" & vbcrlf
			.WRITE "</script>"
			.END
		END WITH
	End If 

	SQL = "SELECT * FROM Set_Betting WITH (NOLOCK) Where SB_SITE = ?"
	
	reDim param(0)
	param(0) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

	If Not sRs.eof Then
		SB_BETTINGMIN	= SESSION("SB_BETTINGMIN")
		SB_BETTINGMAX01 = Session("SB_BETTINGMAX") ' sRs("SB_BETTINGMAX01")
		SB_BENEFITMAX01 = Session("SB_BENEFITMAX")
	End If 
	
		SB_BETTINGMIN	= SESSION("SB_BETTINGMIN")
		SB_BETTINGMAX01 = Session("SB_BETTINGMAX") ' sRs("SB_BETTINGMAX01")
		SB_BENEFITMAX01 = Session("SB_BENEFITMAX")
				
	sRs.close
	Set sRs = Nothing

	
	SQL = "SELECT A.ICT_Idx, A.ICT_GameNum, A.ICT_BetNum, B.IG_Team1, B.IG_Team2, B.IG_Team1Benefit, B.IG_DrawBenefit, B.IG_Team2Benefit, B.IG_Handicap "
	SQL = SQL & " FROM Info_Cart A WITH (NOLOCK), Info_Game B WITH (NOLOCK)"
	SQL = SQL & " WHERE A.ICT_GameNum = B.IG_Idx and A.ICT_ID = ? AND A.ICT_GTYPE = ? AND A.ICT_SITE = ?"

	i_cnt = 0		
	i_cnt2 = 0 
	
			
	reDim param(2)
	param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
	param(1) = Dber.MakeParam("@Game_Type",adVarWChar,adParamInput,10,Game_Type)
	param(2) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

	Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
	
	DIM myID 
	myID = Session("SD_ID")

	If Not sRs.eof Then

		TotalBenefitRate = 1
		TotalBenefit = 0
		DO UNTIL sRs.EOF
		i_cnt = i_cnt + 1
		i_cnt2 = 1 
		ICT_Idx = sRs("ICT_Idx")
		ICT_GameNum = sRs("ICT_GameNum")
		
		Team1 = sRs("IG_Team1")
		Team2 = sRs("IG_Team2")
		BetNum = CDbl(sRs("ICT_BetNum"))

		IF BetNum = 1 THEN
			Benefit = sRs("IG_Team1Benefit")
			Choice = "<font color='black'>[승]</font>"
			teamClass1 = "menubar_1_1_1"
			teamClass2 = "menubar_default"
		ELSEIF BetNum = 0 THEN
			Benefit = sRs("IG_DrawBenefit")
			Choice = "<font color='black'>[무]</font>"
			teamClass1 = "menubar_default"
			teamClass2 = "menubar_default"					
		ELSEIF BetNum = 2 THEN
			Benefit = sRs("IG_Team2Benefit")
			Choice = "<font color='black'>[패]</font>"
			teamClass1 = "menubar_default"
			teamClass2 = "menubar_1_1_1"					
		END IF		
				
			returnVal = returnVal &  "<table width='100%' height='52' border='0' cellpadding='0' cellspacing='0' background='' align='center'>"
			returnVal = returnVal &  "<input type='hidden' name='IG_Idx' value='" + CStr(ICT_GameNum) + "'>"
			returnVal = returnVal &  "<input type='hidden' name='IB_Num' id='BN_"+ CStr(ICT_GameNum) +"' value='"+ CStr(BetNum) +"'>"
			returnVal = returnVal &  "<input type='hidden' name='IB_Benefit' value='"+ cstr(Benefit) +"'>"
			returnVal = returnVal &  "<input type='hidden' name='IG_Handicap' value='"+ IG_Handicap +"'>"	
			returnVal = returnVal &  "<input type='hidden' id='ICT_"+ CStr(ICT_GameNum) +"' value=''>"
			returnVal = returnVal &  "<tr><td rowspan='3' style='font-size: 12px;'><input type='radio' id='ISAR' name='ISAR' style='Display:None;' value='"+ CStr(ICT_GameNum) +"'></td><td height='21' valign='bottom'>"
			returnVal = returnVal &  "<table width='100%' height='13' border='0' align='left' cellpadding='0' cellspacing='0'>"
			returnVal = returnVal &  "<tr><td width='10'></td>"
			if CStr(BetNum)="1" then
			returnVal = returnVal &  "<td style='font-size: 12px;color: #444;'>"+ team1 +" &nbsp;VS</td>"
				returnVal3 = team1
			else
			returnVal = returnVal &  "<td style='font-size: 12px;color: #ff5400;'>"+ team1 +" &nbsp;VS</td>"
			end if
			returnVal = returnVal &  "<td width='18' ><input id='valuevalue' type='hidden' value='"&ICT_Idx&"'/><input id='valuevalue2' type='hidden' value='"&BetNum&"'/><a href=javascript:subCart('"&Session("SD_ID")&"','"&ICT_Idx&"','"&ICT_GameNum&"','"&BetNum&"','id"&BetNum&"_"&ICT_GameNum&"');><img src='/images/cart/bet_del.png' width='11' height='11' border='0'/></a></td>"
			returnVal = returnVal &  "</tr></table></td></tr><tr><td height='6'></td></tr><tr><td valign='top'>"
			returnVal = returnVal &  "<table width='100%' height='13' border='0' align='left' cellpadding='0' cellspacing='0'>"
			returnVal = returnVal &  "<tr><td width='10'></td>"
			if CStr(BetNum)="2" then
			returnVal = returnVal &  "<td width='75%' style='font-size: 12px;color: rgb(254, 239, 0);'>"+ team2 +"</td>"
				returnVal3 = team2
			else
			returnVal = returnVal &  "<td width='75%' style='font-size: 12px;color: #ff5400;'>"+ team2 +"</td>"
			End if
			if CStr(BetNum)="0" then
				team0 = Replace(team1, "소","중")
				returnVal = returnVal &  "<span style='color:#ff0 !important;'>"+ team0 +"</span>"
				returnVal3 = team0
			End if

			returnVal = returnVal &  "<td style='font-size: 12px;color: black;'>"+ choice +"&nbsp;"+ cstr(Benefit) +"</td>"
			returnVal = returnVal &  "</tr></table></td></tr>"
			returnVal = returnVal &  "<tr width='170'><td colspan='2' height='1' bgcolor='#2D2D2D'></tr>"
			returnVal = returnVal &  "</table>"

			
			returnVal2 = returnVal2 & "	"
	        TotalBenefitRate = Cdbl(TotalBenefitRate) * Cdbl(Benefit)
		
	    sRs.MoveNext
	Loop
	response.write returnVal
	response.write returnVal2

	End If 
	
	sRs.close
	Set sRs = Nothing
	Dber.Dispose
	Set Dber = Nothing 
    
    response.Flush()

	%>
	
<script type="text/javascript">

    if(parent.document.getElementById("cartTable") == null)
    {
        parent.location.href = "/" ;
    }
    else
    {
        parent.document.getElementById("cartTable").innerHTML = "<%=returnVal%>";
        
        parent.document.getElementById("TotalBenefitRate").value = "<%=TotalBenefitRate%>";
        parent.document.getElementById("foreCastDividendPercent").innerHTML = "<%=numdel(TotalBenefitRate)%>";
        parent.document.getElementById("SB_BETTINGMIN").value = "<%=SESSION("SB_BETTINGMIN")%>";

        var Gmemo2 = "<%=returnVal3%>";
		Gmemo2 = Gmemo2.replace(/<font([^>]+)?>/i, '');
		Gmemo2 = Gmemo2.replace('</font>', '');
		if ("<%=gtype%>"==1) {
        	parent.document.getElementById("cartTable_game").innerHTML = "<%=returnVal3%>";
			$('.betInfoClass', parent.document).val(Gmemo2);
        }
        parent.foreCastDividendPriceCalc();
    }
	
</script>
