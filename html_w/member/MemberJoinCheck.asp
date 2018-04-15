
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<%
    '---------------------------------------------------------
    '   @Title : 추천인 회원가입 체크
    '   @desc  : 아이디 및 닉네임 체크
    '---------------------------------------------------------
    '######## 리퀘스트를 받는다.  ##############
	RECOM_ID = Trim(REQUEST("RECOM_ID"))
	RECOM_CODE = Trim(REQUEST("RECOM_CODE"))
	

Set Dber = new clsDBHelper
	
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
	
	'######## 중복 아이디 검사한다 ##############
	IF cStr(SITE_OPEN) = "2" THEN

        
        
		'SQL = "SELECT IU_ID FROM Info_User WHERE IU_ID = ? and iu_status=1" 'AND IU_SITE = ?

		SQL = "SELECT IA_SITE FROM INFO_ADMIN WHERE IA_ID = ? and IA_STATUS=1 and ia_id <> 'admin'" 'AND IU_SITE = ?

		reDim param(0)
		param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,RECOM_ID)
		'param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
		
		
		IF sRs.EOF THEN			

			
			SQL = "SELECT IU_ID,IU_SITE FROM INFO_USER_CODE WHERE IU_CODE = ?"
			reDim param(0)
			'param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,RECOM_ID)
			param(0) = Dber.MakeParam("@IU_CODE",adVarWChar,adParamInput,20,RECOM_ID)

			Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
			
			IF sRs.EOF THEN	
%>

			<script type="text/javascript">
				alert("아이디 혹은 코드가 정확하지 않습니다.");
				parent.frm1.ChkID.value = 1;
				parent.frm1.IU_PW.focus();
			</script>
<%	
				response.End
			ELSE  
			RECOM_CODE = RECOM_ID
			RECOM_ID	= sRs(0)
			Session("JOBSITE") = sRs(1)
%>
			<script type="text/javascript">
				alert("추천인 및 코드가 확인되었습니다.");
				parent.location.href = "join.asp?RECOM_ID=<%= RECOM_ID %>&RECOM_CODE=<%= RECOM_CODE %>"
			</script>
<%	
				response.End
			END IF	

%>
		<script type="text/javascript">
			alert("추천인이 확인되었습니다.");
			parent.location.href = "join.asp?RECOM_ID=<%= RECOM_ID %>"
		</script>
		<!--<script type="text/javascript">
			alert("추천인이 정확하지 않습니다.");
			parent.frm1.ChkID.value = 1;
			parent.frm1.IU_PW.focus();
		</script>-->
<%				
	        response.End
	    ELSE  
			
			Session("JOBSITE")	= sRs(0)

%>
		<script type="text/javascript">
			alert("추천인이 확인되었습니다.");			
			parent.location.href = "join.asp?RECOM_ID=<%= RECOM_ID %>"
		</script>
<%	
	        response.End
	    END IF	
    
    ElseIF cStr(SITE_OPEN) = "3" THEN

        IF NOT dfSiteUtil.Pattern("ID", RECOM_ID) Then
%>

		<script type="text/javascript">
			alert("첫글자는 영자 그뒤엔 영어숫자 4이상 12자리 이하로 가입하셔야 합니다.");
			parent.frm1.IU_ID.value = "";
		</script>

<%	
	        response.End        
        End IF
        
		SQL = "SELECT IU_ID FROM INFO_USER_CODE WHERE IU_ID = ? AND IU_CODE = ?"
		reDim param(1)
		param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,RECOM_ID)
		param(1) = Dber.MakeParam("@IU_CODE",adVarWChar,adParamInput,20,RECOM_CODE)

		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
		
		IF sRs.EOF THEN	
%>

		<script type="text/javascript">
			alert("아이디 혹은 코드가 정확하지 않습니다.");
			parent.frm1.ChkID.value = 1;
			parent.frm1.IU_PW.focus();
		</script>
<%	
	        response.End
	    ELSE  
%>
		<script type="text/javascript">
			alert("추천인 및 코드가 확인되었습니다.");
			parent.location.href = "join.asp?RECOM_ID=<%= RECOM_ID %>&RECOM_CODE=<%= RECOM_CODE %>"
		</script>
<%	
	        response.End
	    END IF	
    
	END IF

	sRs.Close
	Set sRs = Nothing 
	
	Dber.Dispose
	Set Dber = Nothing 	
%>

