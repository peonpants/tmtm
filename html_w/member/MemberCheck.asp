
<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->
<%
    '---------------------------------------------------------
    '   @Title : 회원 가입시 중복 체크 페이지
    '   @desc  : 아이디 및 닉네임 체크
    '---------------------------------------------------------
    '######## 리퀘스트를 받는다.  ##############
	IU_ID = Trim(REQUEST("IU_ID"))
	IU_NickName = Trim(REQUEST("IU_NickName"))
	
	Set Dber = new clsDBHelper
	
	'######## 중복 아이디 검사한다 ##############
	IF IU_ID <> "" THEN

        IF NOT dfSiteUtil.Pattern("ID", IU_ID) Then
%>

		<script type="text/javascript">
			alert("첫글자는 영자 그뒤엔 영어숫자 4이상 12자리 이하로 가입하셔야 합니다.");
			parent.frm1.IU_ID.value = "";
		</script>

<%	
	        response.End        
        End IF
        
		SQL = "SELECT IU_ID FROM Info_User WHERE IU_ID = ?" 'AND IU_SITE = ?
		reDim param(0)
		param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,IU_ID)
		'param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
		
		IF sRs.EOF THEN	
%>

		<script type="text/javascript">
			alert("사용가능한 아이디 입니다.");
			parent.frm1.ChkID.value = 1;
			parent.frm1.IU_PW.focus();
		</script>
<%	
	        response.End
	    ELSE  
%>

		<script type="text/javascript">
			alert("이미 사용중인 아이디 입니다.\다른 아이디로 다시 확인해주세요.");
			parent.frm1.IU_ID.value = "";
		</script>

<%	
	        response.End
	    END IF	
    '######## 중복 닉네임 검사한다 ##############
	ELSEIF IU_NickName <> "" THEN

    
        IF NOT dfSiteUtil.Pattern("NICKNAME", IU_NickName) Then
%>

		<script type="text/javascript">
			alert("닉네임은 한글/영어/숫자 조합 2~10자로 입력하셔야 합니다.");
			parent.frm1.IU_NickName.value = "";
		</script>

<%	
	        response.End        
        End IF
            
            
        SQL = "select BF_WRITER from CHECK_NICKNAME WHERE BF_WRITER = ? " 'AND IU_SITE = ?"
		reDim param(0)
		param(0) = Dber.MakeParam("@IU_NickName",adVarWChar,adParamInput,20,IU_NickName)
		'param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

  	    IF Not sRs.EOF THEN	
%>
		<script type="text/javascript">
			alert("이미 사용중인 닉네임 입니다.\다른 닉네임으로 다시 확인해주세요.");
			parent.frm1.IU_NickName.value = "";
		</script>

<%	
            response.End  	    
  	    End IF          
  	      
		SQL = "SELECT IU_NICKNAME FROM Info_User WHERE IU_NICKNAME = ? " 'AND IU_SITE = ?"
		reDim param(0)
		param(0) = Dber.MakeParam("@IU_NickName",adVarWChar,adParamInput,20,IU_NickName)
		'param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

		Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

  	    IF sRs.EOF THEN	
%>
		<script type="text/javascript">
			alert("사용가능한 닉네임 입니다.");
			parent.frm1.ChkNN.value = 1;
			parent.frm1.IU_Mobile2.focus();
		</script>
<%
            response.End	
        ELSE  
%>
		<script type="text/javascript">
			alert("이미 사용중인 닉네임 입니다.\다른 닉네임으로 다시 확인해주세요.");
			parent.frm1.IU_NickName.value = "";
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

