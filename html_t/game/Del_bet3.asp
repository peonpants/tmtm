<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<!-- #include file="../../_Common/Api/Login_Check.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<%
    '---------------------------------------------------------
    '   @Title :  배팅 내역 삭제 처리 페이지
    '   @desc  : 
    '   @commnet : 
    '---------------------------------------------------------
%>
<%
		Set Dber = new clsDBHelper
		IB_IDX		= Trim(REQUEST("IB_IDX"))
    
		PAGE	= REQUEST("PAGE")
		Search	= REQUEST("Search")
		Find	= REQUEST("Find")
		b1 = REQUEST("b1")
		bType	= REQUEST("bType")
		
        
		URL = "/member/MyBet.asp?Page="&Page&"&Search="&Search&"&Find="&Find&""
	    
           
        '#### 배팅내역에서 삭제함( 사용자 페이지에서 보이지 않게 함	        
            SQL = "UP_INFO_Betting_DEL_All"
			reDim param(0)
			param(0) = Dber.MakeParam("@IB_ID",adVarWChar,adParamInput,20,SESSION("SD_ID"))
			Dber.ExecSP SQL,param,Nothing
			
			Dber.Dispose
		    Set Dber = Nothing 

    		
		    WITH RESPONSE
			    .WRITE "<script language='javascript'>" & VbCrLf
			    .WRITE "alert('해당 배팅 내역이 삭제되었습니다.\n진행중인 배팅은 삭제되지 않습니다.');" & VbCrLf
			    .WRITE "location.href='"&URL&"'" & VbCrLf
			    .WRITE "</script>" & VbCrLf
			    .END
		    END WITH
				
    

%>