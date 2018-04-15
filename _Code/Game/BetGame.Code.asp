<%
Response.CodePage = 65001
Response.CharSet = "UTF-8"
response.buffer = true
%>
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->

<%
	Set Dber = new clsDBHelper
	SQL = "UP_GetInfo_GameByStatusForUser " 
	
    reDim param(0)
    param(0) = Dber.MakeParam("@IG_Status",adVarWChar,adParamInput,1,"S")
			    		
	Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

	INPC = sRs.RecordCount
		
	IF NOT sRs.EOF Then
		FOR RE = 1 TO INPC
			IF sRs.EOF THEN
			EXIT FOR
			END If
			
			IG_IDX = sRs("IG_IDX")
			IG_StartTime = sRs("IG_StartTime")
			IG_Status = sRs("IG_Status")
			
			df = DATEDIFF("s",now(),Cdate(IG_StartTime))			
											   
			IF CDBL(df) < GAME_END_TEAM THEN
			    '########   게임 정보 배팅 마감으로 업데이트   ##############
    			'########   해당 게임 장바구니 비우기   ##############
			    
			    SQL = "UP_UpdateInfo_GameByEndGame" 
			    reDim param(0)
			    param(0) = Dber.MakeParam("@IG_Idx",adInteger,adParamInput,,IG_IDX)
			    Dber.ExecSP SQL,param,Nothing    			

			End If 	
			sRs.MoveNext
		next
	End If 

	sRs.close
	Set sRs = Nothing
	Dber.Dispose
	Set Dber = Nothing 

%>
<%  
    
    '########   리퀘스트 받기   ##############
	Sel_Sports	= Trim(REQUEST("Sel_Sports"))
	Sel_League	= Trim(REQUEST("Sel_League"))
	
	IG_Type		= REQUEST("IG_Type")
	Game_Type	= REQUEST("Game_Type")
    
   '// 기본 승무패...
	IF LCase(Game_Type)  = "" THEN Game_Type = "smp"
	IF NOT (LCase(Game_Type)  = "smp" OR LCase(Game_Type)  = "handicap" OR LCase(Game_Type)  = "special" OR LCase(Game_Type)  = "goal") THEN Game_Type = "smp"

%>



