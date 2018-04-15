USE [BUS_NEW]
GO
/****** Object:  StoredProcedure [dbo].[UP_RetrieveInfo_GameByUser]    Script Date: 2018-03-15 오후 6:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[UP_RetrieveInfo_GameByUser]  
 @IG_TYPE INT  
, @IG_SITE VARCHAR(20) = NULL  
AS  
  
SET NOCOUNT ON ;  
  
IF @IG_TYPE = 0   
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime,   
 IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit,   
 IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT,  
 IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E')  AND IG_SP = 'N' AND (IG_EVENT = 'N' or IG_EVENT = '3' or IG_EVENT = '4' or IG_EVENT = '5' or IG_EVENT = '7') AND IG_Type = 0  
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)
  and rl_sports <> '실시간' and rl_sports <> 'E-SPORTS' and rl_sports <> '스타' AND rl_sports<>'이벤트'
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC  
END  
  
IF @IG_TYPE = 1  
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E')  AND IG_SP = 'N' AND (IG_EVENT = 'N' or IG_EVENT = '3' or IG_EVENT = '4'  or IG_EVENT = '5' or IG_EVENT = '7') AND IG_Type IN (1 ,2)
  and rl_sports <> '실시간' and rl_sports <> 'E-SPORTS' and rl_sports <> '스타2' AND rl_sports<>'이벤트'
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END  
  
  
IF @IG_TYPE = 2  
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E')  AND IG_SP = 'Y' AND (IG_EVENT = 'N' or IG_EVENT = '3' or IG_EVENT = '4'  or IG_EVENT = '5' or IG_EVENT = '7') AND IG_Type IN (0, 1 ,2)
  and rl_sports <> '실시간' and rl_sports <> 'E-SPORTS' and rl_sports <> '스타' AND rl_sports<>'이벤트'
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END  
  
  
IF @IG_TYPE = 3  
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E')  AND IG_SP = 'Y' AND (IG_EVENT = 'O' or ig_event='3' or IG_EVENT = '4'  or ig_event='5') AND IG_Type IN (0, 1 ,2)
  and rl_sports <> '실시간' and rl_sports <> 'E-SPORTS' and rl_sports <> '스타' AND rl_sports<>'이벤트'
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END  

IF @IG_TYPE = 4 
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E')  AND IG_SP = 'N' AND IG_EVENT = 'N' AND IG_Type IN (0, 1 ,2)
  and (rl_sports = '실시간' OR rl_sports = 'E-SPORTS' OR rl_sports = '스타')
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END  
  
IF @IG_TYPE = 5  
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E')  AND IG_SP = 'N' AND (IG_EVENT = 'N') AND IG_Type IN (0, 1 ,2)
  and rl_sports <> '실시간' and rl_sports <> 'E-SPORTS' and rl_sports <> '스타'
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END  


IF @IG_TYPE = 35 
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E')  AND IG_SP = 'N' AND (IG_EVENT = 'Y') and rl_sports = '실시간' and ig_starttime < dateadd(mi,30,getdate()) 
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END  

 
IF @IG_TYPE = 36 
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E')  AND IG_SP = 'N' AND (IG_EVENT = 'D') and rl_sports = '실시간' and ig_starttime < dateadd(mi, 30,getdate()) 
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END  
 
IF @IG_TYPE = 37 
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E')  AND (IG_EVENT = 'P') and rl_sports = '실시간' and ig_starttime < dateadd(mi, 30,getdate()) 
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END  
 
IF @IG_TYPE = 38 
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E')  AND IG_SP = 'N' AND (IG_EVENT = 'H') and rl_sports = '실시간' and ig_starttime < dateadd(mi, 30,getdate()) 
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END 

IF @IG_TYPE = 39 
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E')  AND IG_SP = 'N' AND (IG_EVENT = 'A') and rl_sports = '실시간' and ig_starttime < dateadd(mi, 30,getdate()) 
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END   


IF @IG_TYPE = 40 
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E')  AND IG_SP = 'N' AND (IG_EVENT = 'R') and rl_sports = '실시간' and ig_starttime < dateadd(mi, 30,getdate()) 
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END   


IF @IG_TYPE = 41 
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E') AND (IG_EVENT = 'B') and rl_sports = '실시간' and ig_starttime < dateadd(mi, 30,getdate()) 
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END   


IF @IG_TYPE = 42 
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E') AND (IG_EVENT = 'W') and rl_sports = '실시간' and ig_starttime < dateadd(mi, 30,getdate()) 
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END   

IF @IG_TYPE = 43 
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E') AND (IG_EVENT = 'L') and rl_sports = '실시간' and ig_starttime < dateadd(mi, 5,getdate()) 
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END   

IF @IG_TYPE = 44 
BEGIN  
 SELECT   
  IG_Idx, RL_Idx, RL_Sports, RL_League, RL_Image,IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Team1Benefit, IG_DrawBenefit, IG_Team2Benefit, IG_Status, IG_Type, IG_VSPoint, IG_Memo, IG_TEAM1BET_CNT  ,IG_TEAM2BET_CNT  ,IG_DRAWBET_CNT, I7_IDX,IG_CONTENT, IG_ANAL, IG_BROD  
 FROM   
  dbo.Info_Game WITH(NOLOCK)  
 WHERE   
  (IG_Status = 'S' OR IG_Status = 'E') AND (IG_EVENT = 'S') and rl_sports = '실시간' and ig_starttime < dateadd(mi, 5,getdate()) 
  AND (IG_SITE = 'ALL' OR IG_SITE = @IG_SITE)  
 ORDER BY   
  IG_STATUS desc,  IG_StartTime ASC, rl_league asc, IG_TEAM1 ASC, IG_TYPE ASC  
END   
