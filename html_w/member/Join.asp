<!-- #include file="../../_Common/Lib/DBHelper.asp" -->
<!-- #include file="../../_Common/Lib/Request.class.asp" -->
<!-- #include file="../../_Common/Api/sql_injection.asp" -->
<!-- #include file="../../_Conf/Common.Conf.asp" -->
<!-- #include file="../../_Lib/SiteUtil.Class.asp" -->

<%
Response.CharSet="utf-8"

  IF SITE_IMAGE_URL = "" Then
     SITE_IMAGE_URL = SITE_IMAGE_URL
  End IF

  IF Session("SD_ID") <> "" Then
    %>
    <script type="text/javascript">
       alert("자동 로그아웃 됩니다.");
       location.href = "/login/logout_proc.asp"
    </script>
    <%
    response.End
 End IF

 RECOM_ID = Trim(REQUEST("RECOM_ID"))
 RECOM_CODE = Trim(REQUEST("RECOM_CODE"))
 sms_phone    = Trim(REQUEST("sms_phone"))
 Set Dber = new clsDBHelper  



 SQL = "UP_GetSET_SITE_OPEN"

 Set sRs = Dber.ExecSPReturnRS(SQL,nothing,nothing)
 SITE_OPEN = sRs("SITE_OPEN")

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
 IF cStr(SITE_OPEN) = "2" OR cStr(SITE_OPEN) = "3" Then  
    IF NOT dfSiteUtil.Pattern("RECOM_ID", RECOM_ID) Then
      %>
      <script type="text/javascript">
         alert("추천인 아이디를 확인해주세요");
         history.back();
      </script>
      <%  
      response.End            
   END IF
End IF    

IF cStr(SITE_OPEN) = "2" Then  

    reDim param(0)
    param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,RECOM_ID)
    'param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

    Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)
    
    IF sRs.EOF THEN 

            SQL = "SELECT IU_ID FROM Info_User WHERE IU_ID = ? and iu_status=1" 

            reDim param1(0)
            param1(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,RECOM_ID)

            Set sRss = Dber.ExecSQLReturnRS(SQL,param1,nothing)

            IF sRss.EOF THEN

%>
<script type="text/javascript">
 alert("추천인이 정확하지 않습니다.");
 parent.frm1.ChkID.value = 1;
 parent.frm1.IU_PW.focus();
</script>
<%              
              response.End    
           END IF

        End IF    
     ElseIF cStr(SITE_OPEN) = "3" THEN

     SQL = "SELECT IU_ID FROM INFO_USER_CODE WHERE IU_ID = ? AND IU_CODE = ?  "
     reDim param(1)
     param(0) = Dber.MakeParam("@IU_ID",adVarWChar,adParamInput,20,RECOM_ID)
     param(1) = Dber.MakeParam("@IU_CODE",adVarWChar,adParamInput,20,RECOM_CODE)

     Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

     IF sRs.EOF THEN 
      %>
      <script type="text/javascript">
        alert("아이디 혹은 코드가 정확하지 않습니다.");
        history.back();
     </script>
     <%  
     response.End    
  End IF          

arrSms_phone = Split(sms_phone,"-")
End IF

'######## 차단된 아이피    ##############
CI_IP2 = REQUEST("REMOTE_ADDR")        
If InStr(CI_IP2,"220.74.") Or InStr(CI_IP2,"220.75.") Or InStr(CI_IP2,"220.91.") Then
 %>
 <script>
    alert("회원가입이 차단된 대역입니다.");
    history.back(-1);
 </script>
 <%
 response.end
End if 

IF MEMBER_JOIN_IP Then                                                                
    '######## 사용 불가 아이피 체크 ##############
    IF Request.ServerVariables("REMOTE_ADDR") <> "125.187.40.135" Then  
     SQL = "SELECT CI_IP FROM Check_IP WHERE CI_IP= ? AND CI_SITE = ?"

     reDim param(1)
     param(0) = Dber.MakeParam("@CI_IP",adVarWChar,adParamInput,20,CI_IP2)
     param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

     Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

     IF NOT sRs.EOF THEN
      With Response
       sRs.Close
       Set sRs = Nothing
       Dber.Dispose
       Set Dber = Nothing 
       .Write "<script language=javascript>" & vbCrLf
       .Write "alert('회원가입이 불가능한 IP입니다.\n이미 다른분이 가입한 ip입니다.');history.back(-1);" & vbCrLf
       .Write "</script>" & vbCrLf
       .END
    END With
 END IF

 sRs.Close
 Set sRs = Nothing


 SQL = "SELECT IU_ID FROM INFO_USER WHERE IU_IP= ? AND IU_SITE = ?"

 reDim param(1)
 param(0) = Dber.MakeParam("@CI_IP",adVarWChar,adParamInput,20,CI_IP2)
 param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

 Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

 IF NOT sRs.EOF THEN
   With Response
    sRs.Close
    Set sRs = Nothing
    Dber.Dispose
    Set Dber = Nothing 
    .Write "<script language=javascript>" & vbCrLf
    .Write "alert('회원가입이 불가능한 IP입니다.\n이미 다른분이 가입한 ip입니다.');" & vbCrLf
    .Write "</script>" & vbCrLf
    .END
 END With
END IF

sRs.Close
Set sRs = Nothing    

END If

End IF
%>

<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <TITLE><%= SITE_TITLE %></TITLE>
   <meta name="keywords" content="<%= SITE_DESC %>">
   <meta name="Description" content="<%= SITE_DESC %>">
   <meta name="robots" content="noindex,nofollow">
   <meta NAME="ROBOTS" CONTENT="NONE"> 
   <meta NAME="GOOGLEBOT" CONTENT="NOARCHIVE"> 

   <LINK href="/css/join2.css" rel="stylesheet" type="text/css">
   <STYLE type="text/css">
   html {
     font-size: 12px;
     padding-top: 100px;
  }
  body {
     color: #ddd;
     background: #000;
  }
  h2 {
     padding: 10px 0 10px 15px;
     color: #FC0;
     font-weight: bold;
     background-color: black;
     margin: 21px;
  }
  table {
     width: 800px;
     margin: 0 auto;
     border: 1px solid #111;
  }
  td.text01 {
     font-weight: bold;
     background-color: #282828;
     border-top: #3E3E3E solid 1px;
     border-left: #3E3E3E solid 1px;
     color: #AAA;
     width: 104px;
     font-size: 12px;
     padding-left: 12px;
  }
  td.text02 {
     padding: 5px;
     line-height: 28px;
     background-color: #333;
     border-top: #484848 solid 1px;
     border-left: #484848 solid 1px;
  }
</STYLE> 
<script language="javascript" src="/_777/scripts/common/script.js"></script>
<script language="javascript" src="/_777/scripts/flash.js"></script>
<script language="javascript" src="/_777/scripts/bbs/script.js"></script>
<script language="javascript" src="/_777/scripts/customer/script.js"></script>
<script language="javascript" src="/_777/scripts/game/script.js"></script>

<script language="javascript" src="/member/js/flash.js"></script>
<script language="javascript" src="/member/js/menu_link.js"></script>
<script language="javascript" src="/member/js/func.js"></script>
<script language="javascript" src="/member/js/scroll.js"></script>
<script language="javascript" src="/member/js/ajax.js" ></script>
<script language="javascript" src="/member/js/function.js" ></script>
<script language="javascript" src="/member/js/prototype.js"></script>
<script language="javascript" src="/member/js/jquery-1.8.3.min.js"></script>

<script type="text/javascript">
 var codeRandom = Math.floor(Math.random()*100000).toLocaleString('en-US', {minimumIntegerDigits: 6, useGrouping:false})
 function FrmChk1() {
  var frm = document.frm1;
        
        if (frm.ChkID.value != 1) {
         alert(" 아이디 중복체크를 해주세요.");
         frm.IU_ID.focus();
         return false;
      }

        // 아이디 체크 [오픈 체크시에도 씀] 
        if ((frm.IU_ID.value.length == 0) || (frm.IU_ID.value.length < 4) || (frm.IU_ID.value.length > 12)) {
         alert(" 사용하실 아이디를 정확히 넣어주세요.\n아이디는 4~12까지만 입력이 가능합니다.");
         frm.IU_ID.focus();
         return false;
      }
      else if (EnNumCheck(frm.IU_ID.value) == false) {
         alert(" 아이디는 공백없이 영어와 숫자로만 입력이 가능합니다.");
         frm.IU_ID.focus();
         return false;
      }

        // 비밀번호 체크
        if ((frm.IU_PW.value.length == 0) || (frm.IU_PW.value.length < 4) || (frm.IU_PW.value.length > 12)) {
         alert(" 사용하실 비밀번호를 정확히 넣어주세요.\n비밀번호는 4~12자 까지만 입력이 가능합니다.");
         frm.IU_PW.select();
         frm.IU_PW.focus();
         return false;
      }

      if (EnNumCheck(frm.IU_PW.value) == false) {
         alert(" 비밀번호는 공백없이 영어와 숫자로만 입력이 가능합니다.");
         frm.IU_PW.focus();
         return false;
      }
      else if (frm.IU_PW.value != frm.IU_PW1.value) {
         alert(" 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
         frm.IU_PW1.value = "";
         frm.IU_PW1.focus();
         return false;
      }

        // nickname
        if ((frm.IU_NickName.value.length == 0) || (frm.IU_NickName.value.length < 3) || (frm.IU_NickName.value.length > 10)) {
         alert(" 닉네임을 정확히 넣어주세요.\n닉네임은 3~10까지만 입력이 가능합니다.");
         frm.IU_NickName.focus();
         return false;
      }

        if (frm.ChkNN.value != 1) {
         alert(" 닉네임 중복체크를 해주세요.");
         frm.IU_NickName.focus();
         return false;
      }
      if (IsPhoneChek(frm.IU_Mobile2.value) == false) {
       alert("휴대폰번호를 정확히 입력해주세요.");
       frm.IU_Mobile2.value = "";
       frm.IU_Mobile2.focus();
       return false;
      }
      if (IsPhoneChek(frm.IU_Mobile3.value) == false) {
         alert("휴대폰번호를 정확히 입력해주세요.");
         frm.IU_Mobile3.value = "";
         frm.IU_Mobile3.focus();
         return false;
      }

      if (frm.IU_BankName.value == "") {
         alert("은행명을 정확하게 입력해주세요.");
         frm.IU_BankName.focus();
         return false;
      }

      if ((frm.IU_BankNum.value == "") || (frm.IU_BankNum.value.length < 10)) {
         alert("계좌번호를 정확하게 입력해주세요.");
         frm.IU_BankNum.focus();
         return false;
      }

      if (NumDash(frm.IU_BankNum.value) == false) {
         alert("계좌번호는 숫자와 '-' 만을 사용해서 입력해주세요.");
         frm.IU_BankNum.value = "";
         frm.IU_BankNum.focus();
         return false;
      }

      if ((frm.IU_BankOwner.value == "") || (frm.IU_BankOwner.value.length < 2)) {
         alert("예금주를  정확하게 입력해주세요.");
         frm.IU_BankOwner.focus();
         return false;
      }

      
        if(frm.IU_ID.value == frm.IU_ID.RECOM_ID)
        {
         alert("추천인과 자신의 아이디가 같을 수 없습니다.");
         frm.RECOM_ID.value = "";
         return false;            
      }
      frm.action = "member_Proc.asp";
      return true;
   }
   
   function idDblChk() {
     var frm = document.frm1;
     if (frm.IU_ID.value == "") {
      alert("중복체크하실 아이디를 적어주세요.");
      frm.IU_ID.focus();
      return false;
   }
   else if ((frm.IU_ID.value.length == 0) || (frm.IU_ID.value.length < 2) || (frm.IU_ID.value.length > 12)) {
      alert(" 사용하실 아이디를 정확히 넣어주세요.\n아이디는 2~12까지만 입력이 가능합니다.");
      frm.IU_ID.focus();
      return false;
   }
   else if (EnNumCheck(frm.IU_ID.value) == false) {
      alert(" 아이디는 공백없이 영어와 숫자로만 입력이 가능합니다.");
      frm.IU_ID.focus();
      return false;
   }
   else {
      ProcFrm.location.href = "/member/memberCheck.asp?IU_ID=" + frm.IU_ID.value;
   }
}

function nnDblChk() {
  var frm = document.frm1;

  if (frm.IU_NickName.value == "") {
   alert("중복체크하실 닉네임을 적어주세요.");
   frm.IU_NickName.focus();
   return false;
}
else if ((frm.IU_NickName.value.length == 0) || (frm.IU_NickName.value.length < 1) || (frm.IU_NickName.value.length > 10)) {
   alert(" 사용하실 닉네임을 정확히 넣어주세요.\n아이디는 3~10까지만 입력이 가능합니다.");
   frm.IU_NickName.focus();
   return false;
}        
else {
   ProcFrm.location.href = "/member/memberCheck.asp?IU_NickName=" + frm.IU_NickName.value;
}
}

function clickemail() {
  var frm = document.frm1;

  frm1.Email3.readOnly = true;
  frm1.Email3.value = frm1.Email2[frm1.Email2.selectedIndex].value;
  if (frm1.Email2[0].selected) {
   frm1.Email3.readOnly = false;
  }
}
</script>

<%

IF SITE_IMAGE_URL = "" Then
 SITE_IMAGE_URL = SITE_IMAGE_URL
End IF

IF Session("IU_Level") <> 9 Then
   %>
   <script language="javascript" type="text/javascript" src="/member/js/Base.js"></script>
</head>

<%
Else
%>
</head>
<body topmargin="0" topmargin="0" style="overflow-x:hidden"> 
   <%
End IF
%>    

<% 

'######## 차단된 아이피    ##############
CI_IP2 = REQUEST("REMOTE_ADDR")        
If InStr(CI_IP2,"220.74.") Or InStr(CI_IP2,"220.75.") Or InStr(CI_IP2,"220.91.") Then
 %>
 <script>
    alert("회원가입이 차단된 대역입니다. \n zooo@hotmail.com으로 문의주세요.");
    history.back(-1);
 </script>
 <%
 response.end
End if 


'######## 사용 불가 아이피 체크 ##############
Set Dber = new clsDBHelper          
IF Request.ServerVariables("REMOTE_ADDR") <> "119.193.6.112" Then  
 SQL = "SELECT CI_IP FROM Check_IP WHERE CI_IP= ? AND CI_SITE = ?"

 reDim param(1)
 param(0) = Dber.MakeParam("@CI_IP",adVarWChar,adParamInput,20,CI_IP2)
 param(1) = Dber.MakeParam("@JOBSITE",adVarWChar,adParamInput,20,JOBSITE)

 Set sRs = Dber.ExecSQLReturnRS(SQL,param,nothing)

 IF NOT sRs.EOF THEN
  With Response
   sRs.Close
   Set sRs = Nothing
   Dber.Dispose
   Set Dber = Nothing 
   .Write "<script language=javascript>" & vbCrLf
   .Write "alert('회원가입이 불가능한 IP입니다.\n이미 다른분이 가입한 ip입니다.');history.back(-1);" & vbCrLf
   .Write "</script>" & vbCrLf
   .END
END With
END IF

sRs.Close
Set sRs = Nothing
END If

%>

<iframe name="pChk" id="pChk" width="0" height="0"></iframe>
<form name="frm1" method="post"  onsubmit="return FrmChk1();" target="ProcFrm">
   <input type="hidden" name="EMODE" value="MEMADD">
   <input type="hidden" name="ChkID" value="0">
   <input type="hidden" name="ChkNN" value="0">
   <input type="hidden" name="PChkNum" value="0">
   <input type="hidden" name="RECOM_CODE" value="<%=RECOM_CODE%>">
   <input type="hidden" name="Email1" value="11111@gmail.com">
   <DIV id="sub-area">
      <DIV style="margin: 0px auto; width: 840px; border-top-color: rgb(65, 65, 65); border-left-color: rgb(65, 65, 65); border-top-width: 1px; border-left-width: 1px; border-top-style: solid; border-left-style: solid; background-color: rgb(32, 32, 32);">
         <H2>■ 회원가입</H2>
         <TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
           <TBODY>
              <TR>
                <TD align="left" class="text01" rowspan="2">
                  <P><STRONG>아이디</STRONG></P></TD>
                  <TD height="30" align="left" class="text02"><INPUT name="IU_ID" class="bg_input" id="textfield" style="background: rgb(68, 68, 68); padding: 4px; border: 1px solid rgb(85, 85, 85); border-image: none; width: 200px; color: rgb(242, 242, 242); font-size: 12px; -ms-ime-mode: disabled;" type="text" size="25"> 
                     <SPAN id="msg_mb_id" style="color: rgb(255, 255, 0);"><img src="../images/sub/join_btn2.gif" width="63" height="21" align="texttop" onClick="idDblChk();" style="cursor:pointer">영문소문자, 숫자, _ 만 
                     입력하세요.</SPAN>              </TD></TR>
                     <TR>
                      <TD height="30" align="left" class="text02"><SPAN style="color: rgb(187, 187, 187); font-size: 11px;">- 
                      영문 소문자, 숫자만 입력 가능하며 최소 3자 이상 입력하세요.</SPAN></TD></TR>
                      <TR>
                         <TD align="left" class="text01">
                           <P><STRONG>패스워드</STRONG></P></TD>
                           <TD height="30" align="left" class="text02"><INPUT name="IU_PW" class="bg_input" id="textfield" style="background: rgb(68, 68, 68); padding: 4px; border: 1px solid rgb(85, 85, 85); border-image: none; width: 200px; color: rgb(242, 242, 242); font-size: 12px;" type="password" size="25"></TD></TR>
                           <TR>
                            <TD align="left" class="text01">
                              <P><STRONG>패스워드확인</STRONG></P></TD>
                              <TD height="30" align="left" class="text02"><INPUT name="IU_PW1" class="bg_input" id="textfield" style="background: rgb(68, 68, 68); padding: 4px; border: 1px solid rgb(85, 85, 85); border-image: none; width: 200px; color: rgb(242, 242, 242); font-size: 12px;" type="password" size="25"></TD></TR>
                              <TR>
                               <TD align="left" class="text01">
                                 <P><STRONG>이름</STRONG></P></TD>
                                 <TD height="30" align="left" class="text02"><INPUT name="IU_BankOwner" class="bg_input" id="textfield" style="background: rgb(68, 68, 68); padding: 4px; border: 1px solid rgb(85, 85, 85); border-image: none; width: 200px; color: rgb(242, 242, 242); font-size: 12px;" type="text" size="25"> 
                                    <SPAN style="color: rgb(187, 187, 187); font-size: 11px;"><BR>- 실명이 아닌 경우에 
                                    환전시 불이익을 받을 수 있습니다.(공백없이 한글만 입력 가능)</SPAN>                 </TD></TR>
                                    <TR>
                                     <TD align="left" class="text01">
                                       <P><STRONG>거래은행</STRONG></P></TD>
                                       <TD height="30" align="left" class="text02"><select name="IU_BankName" size="1" >
                                    <option value="">선택</option>
                                    <option value="국민은행">국민은행</option>
                                    <option value="광주은행">광주은행</option>
                                    <option value="경남은행">경남은행</option>
                                    <option value="기업은행">기업은행</option>
                                    <option value="농협">농협</option>
                                    <option value="대구은행">대구은행</option>
                                    <option value="도이치은행">도이치은행</option>
                                    <option value="부산은행">부산은행</option>
                                    <option value="상호저축은행">상호저축은행</option>
                                    <option value="새마을금고">새마을금고</option>
                                    <option value="수협">수협</option>
                                    <option value="신한은행">신한은행</option>
                                    <option value="외환은행">외환은행</option>
                                    <option value="우리은행">우리은행</option>
                                    <option value="우체국">우체국</option>
                                    <option value="전북은행">전북은행</option>
                                    <option value="제주은행">제주은행</option>
                                    <option value="하나은행">하나은행</option>
                                    <option value="한국씨티은행">한국씨티은행</option>
                                    <option value="HSBC은행">HSBC은행</option>
                                    <option value="SC제일은행">SC제일은행</option>
                                    <option value="신협">신협</option>
                                    <option value="케이뱅크">케이뱅크</option>
                                    <option value="카카오뱅크">카카오뱅크</option>
                                    </select>                   계좌번호
                                     <INPUT name="IU_BankNum" class="bg_input" id="textfield" style="background: rgb(68, 68, 68); padding: 4px; border: 1px solid rgb(85, 85, 85); border-image: none; width: 200px; color: rgb(242, 242, 242); font-size: 12px;" type="text" size="25"> 
                                     <SPAN style="color: rgb(187, 187, 187); font-size: 11px;"><BR>- 본인 명의의 
                                     계좌번호를 입력하세요. 이름과 예금주가 다르면 환전되지 않습니다. 수정을 원하시면 관리자에게 문의하세요.</SPAN></TD></TR>
                                     <TR>
                                        <TD align="left" class="text01">
                                          <P><STRONG>닉네임</STRONG></P></TD>
                                          <TD height="30" align="left" class="text02"><INPUT name="IU_NickName" class="bg_input" id="textfield" style="background: rgb(68, 68, 68); padding: 4px; border: 1px solid rgb(85, 85, 85); border-image: none; width: 200px; color: rgb(242, 242, 242); font-size: 12px;" type="text" size="25">
                                             <img src="../images/sub/join_btn2.gif" width="63" height="21" align="middle" onClick="nnDblChk();" style="cursor:pointer">&nbsp;&nbsp; <SPAN id="msg_mb_nick"></SPAN>                    <BR><SPAN style="color: rgb(187, 187, 187); font-size: 11px;">- 
                                             공백없이 한글, 영문, 숫자만 입력가능합니다.(3자이상)</SPAN>                 </TD></TR>
                                             <TR>
                                              <TD align="left" class="text01" rowspan="1">
                                                <P><STRONG>핸드폰번호</STRONG></P></TD>
                                                <TD height="30" align="left" class="text02"><SPAN style="color: rgb(187, 187, 187); font-size: 11px;">- 
                                                수정시에는 관리자에게 요청하세요.</SPAN> 
                                                <% IF cStr(SITE_OPEN) = "5" Then %>
                                                <select name="IU_Mobile1" size="1" >
                                                   <option value="010" <% IF cStr(arrSms_phone(0)) = "010" Then %>selected<% End IF %>>010</option>
                                                   <option value="011" <% IF cStr(arrSms_phone(0)) = "011" Then %>selected<% End IF %>>011</option>
                                                   <option value="016" <% IF cStr(arrSms_phone(0)) = "016" Then %>selected<% End IF %>>016</option>
                                                   <option value="017" <% IF cStr(arrSms_phone(0)) = "017" Then %>selected<% End IF %>>017</option>
                                                   <option value="018" <% IF cStr(arrSms_phone(0)) = "018" Then %>selected<% End IF %>>018</option>
                                                   <option value="019" <% IF cStr(arrSms_phone(0)) = "019" Then %>selected<% End IF %>>019</option>
                                                </select>

                                                - <input type="text" name="IU_Mobile2"  class="INPUT" maxlength="4" value="<%= arrSms_phone(1) %>">
                                                - <input type="text" name="IU_Mobile3"  class="INPUT" maxlength="4" value="<%= arrSms_phone(2) %>">
                                                <% Else %>
                                                <select name="IU_Mobile1" size="1" >
                                                   <option value="010" >010</option>
                                                   <option value="011" >011</option>
                                                   <option value="016" >016</option>
                                                   <option value="017" >017</option>
                                                   <option value="018" >018</option>
                                                   <option value="019" >019</option>
                                                </select> 
                                                - <input type="text" name="IU_Mobile2"  class="INPUT" maxlength="4" size="8">
                                                - <input type="text" name="IU_Mobile3"  class="INPUT" maxlength="4" size="8">                      
                                                <% End IF %>
                                                <SPAN style="color: rgb(187, 187, 187); font-size: 11px;"><br>-긴급 
                                                공지사항 전달 시 휴대폰으로 전송되오니 연락가능한 본인 휴대폰번호를 기재해 주세요.</SPAN>              </TD></TR>
                                                      <TR>
                                                       <TD align="left" class="text01"><STRONG>추천인 아이디</STRONG></TD>
                                                       <TD height="30" align="left" 
                                                       class="text02"><B><input name="RECOM_ID" type="text" class="INPUT" id="textfield" size="30" maxlength="20"  <% IF RECOM_ID <> "" Then %>readonly<% End IF %> value="<%= RECOM_ID %>"></B></TD></TR></TBODY></TABLE>
                                                       <DIV style="padding: 20px 0px; width: 100%; text-align: center;"><SPAN id="btnSubmit"><INPUT type="image" src="/member/btn_join.png"></SPAN>
                                                       </DIV></DIV></DIV></FORM></BODY></HTML>
                                                       <iframe name="HiddenFrm" src="/Blank.html" frame width="0" height="0" ></iframe>
                                                       <iframe name="ProcFrm" src="/Blank.html" frame width="0" height="0" ></iframe>
                                                    </body>
                                                    </html>
