

function LoginFrmChk(frm) 
{	
    if ((frm.IU_ID.value == "") || (frm.IU_ID.value.length < 4))	
    {
        alert("회원님의 아이디를 입력해 주세요.");	
        frm.IU_ID.focus();
        return false;	
    }
	
    if ((frm.IU_PW.value == "") || (frm.IU_PW.value.length < 4))	
    {
        alert("회원님의 비밀번호를 입력해 주세요.");
        frm.IU_PW.focus();
        return false;	        
    }

    if(screen.width > 1024) 
    {
        frm.action = "http://111.68.3.2:8080/Login/Login_Proc.asp";
    }        
    else
    {
        frm.action = "/Login/Login_Proc.asp";
    }
}

function goJoin()
{
    if(screen.width > 1024) 
    {
        location.href = "http://111.68.3.2:8080/member/join.asp";
    }        
    else
    {
        location.href = "/member/join.asp";
    }
    
}