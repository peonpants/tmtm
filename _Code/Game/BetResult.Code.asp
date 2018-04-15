<%@ Codepage=949  Language="VBScript"%>
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->

 <%
    '########   페이징 관련 셋팅    ##############
	SETSIZE = 10
	PGSIZE = 30

    PAGE            = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("PAGE")), 1, 1, 999999) 
    sType            = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("sType")), 0, 1, 6)     
    sType1            = dfSiteUtil.F_initNumericParam(Trim(dfRequest.Value("sType1")), 1, 1, 4)     
    
	IF PAGE = "" THEN
		PAGE = 1
		STARTPAGE = 1
	ELSE
		PAGE = CINT(PAGE) 
		STARTPAGE = INT(PAGE/SETSIZE)

		IF STARTPAGE = (PAGE/SETSIZE) THEN
			STARTPAGE = PAGE-SETSIZE + 1
		ELSE
			STARTPAGE = INT(PAGE/SETSIZE) * SETSIZE + 1
		END IF
	END IF
	
    '########  리스트를 위한 Where 절     ##############
	Set Dber = new clsDBHelper
		
	SQLR = " Info_Game Where (IG_Status = 'F' OR IG_Status = 'C') AND (IG_SITE = '"& JOBSITE &"' OR IG_SITE = 'All') "


    IF sType <> 0 Then
        SELECT CASE sType
        CASE 1         
            SQLR = SQLR & " AND RL_SPORTS = '축구' "
        CASE 2
            SQLR = SQLR & " AND RL_SPORTS = '야구' "
        CASE 3
            SQLR = SQLR & " AND RL_SPORTS = '농구' "
        CASE 4
            SQLR = SQLR & " AND RL_SPORTS = '배구' "
        CASE 5
            SQLR = SQLR & " AND RL_SPORTS = '스타크래프트' "
        CASE 6
            SQLR = SQLR & " AND RL_SPORTS IN ('아이스하키', '피겨스케이팅','격투기')"                                                
        END SELECT
    End IF
    
    IF sType1 <> 0 Then
        SELECT CASE sType1
        CASE 1         
            SQLR = SQLR & " AND IG_TYPE = 0 AND IG_SP = 'N' AND IG_EVENT = 'N' AND RL_SPORTS <> '실시간'"
        CASE 2
            SQLR = SQLR & " AND IG_TYPE IN (1,2) AND IG_SP = 'N' AND IG_EVENT = 'N' AND RL_SPORTS <> '실시간'"
        CASE 3
            SQLR = SQLR & " AND IG_SP = 'Y' AND IG_EVENT = 'N' AND RL_SPORTS <> '실시간'"
        CASE 4
            SQLR = SQLR & " AND RL_SPORTS = '실시간'"
		END SELECT    
    End IF
    
	SQL = "SELECT COUNT(*) AS TN FROM "& SQLR &""


	Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)
	
	TOMEM = CDbl(sRs(0))
	sRs.close
	Set sRs = Nothing


	SQL = "SELECT COUNT(*) AS TN From "& SQLR &""

	Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)
	TN = CDbl(sRs("TN"))
	sRs.close
	Set sRs = Nothing


	PGCOUNT = INT(TN/PGSIZE)
	IF PGCOUNT * PGSIZE <> TN THEN 
		PGCOUNT = PGCOUNT+1
	END If

    '########   경기 마감 리스트 출력   ##############
    SQL =  "SELECT TOP " & PGSIZE & " IG_Idx, RL_League, RL_Image, CONVERT(VARCHAR, IG_StartTime, 111) + ' ' + CONVERT(VARCHAR(8), IG_StartTime, 114) AS IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Score1, IG_Score2, IG_Result, IG_Type, RL_Sports, IG_Status, IG_Memo, IG_SP, IG_Draw FROM "& SQLR &" AND IG_Idx NOT IN (SELECT TOP " & ((PAGE - 1) * PGSIZE)   & " IG_Idx  FROM "& SQLR &" ORDER BY IG_STARTTIME DESC, rl_league DESC, IG_TEAM1 DESC)  ORDER BY IG_STARTTIME DESC, rl_league DESC, IG_TEAM1 DESC"

    'response.Write SQL
	Set sRs = Dber.ExecSQLReturnRS(SQL,nothing,nothing)

	IF NOT sRs.EOF THEN
		NEXTPAGE = CINT(PAGE) + 1
		PREVPAGE = CINT(PAGE) - 1
		NN = TN - (PAGE-1) * PGSIZE
	ELSE
		TN = 0
		PGCOUNT = 0
	END IF
	

%>


