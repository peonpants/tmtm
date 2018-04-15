
 <%
    '########  리스트를 위한 Where 절     ##############
    Set Dber = new clsDBHelper

    'SQL = "SELECT bc_idx FROM Board_Customer Where BC_ID= ? and BC_Status=1 and BC_Reply=1 and BC_Read=0 AND (BC_SITE = ? OR BC_SITE = 'All')"
	
	SQL = "UP_NOTICE_CHK"
    reDim param(1)
    param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,Session("SD_ID"))
    param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

    Set sRs = Dber.ExecSPReturnRS(SQL,param,nothing)

    If Not sRs.eof then
	    RpyCnt = sRs(0)
    End If 

    sRs.close
    Set sRs = Nothing

    If RpyCnt <> "0" And  RpyCnt <> "" Then
%>
<script>location.href='/support/Answer_Read.asp?BC_IDX=<%=RpyCnt%>'</script>
<%
    End If 
%>