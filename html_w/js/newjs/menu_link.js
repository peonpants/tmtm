function menu_link(menuName)
{
    if(top.MainFrm == null)
    {
        location.href = "/" ;
    }
    
    if(menuName=="home")
    {
         location.href = "/" ;
    }
    else if(menuName=="m1") //proto
    {
        location.href="/game/BetGame.asp?game_type=smp"; 
    }
    else if(menuName=="m2") //hand 
    {
        location.href="/game/BetGame.asp?game_type=handicap"; 
    }
    else if(menuName=="m3")//sp
    {
        location.href="/game/BetGame.asp?game_type=special"; 
    }
    else if(menuName=="m4")//point
    {
        location.href="/game/BetResult.asp"; 
    }
    else if(menuName=="m5")//result
    {
        location.href="/guide/Role.asp"; 
    }
    else if(menuName=="m6")//role
    {
        location.href="/guide/Game.asp"; 
    }
    else if(menuName=="m7")//game info
    {
        location.href="/freeboard/Board_List.asp"; 
    }
    else if(menuName=="m8")//board
    {
        location.href="/support/Answer_List.asp"; 
    }
    else if(menuName=="m10")//livescore
    {
        location.href="/live/livescore.asp";
    }    
    else if(menuName=="m9")//board
    {
        location.href="/support/Answer_List.asp"; 
    }    
    else if(menuName=="top1")//�Ӵ�����
    { 
        location.href="/money/charge.asp"; 
    }
    else if(menuName=="top2")//�Ӵ�ȯ��
    { 
        location.href="/money/exchange.asp"; 
    }
    else if(menuName=="top3")//���Ǻ���
    { 
        location.href="/member/mybet.asp"; 
    }
    else if(menuName=="top4_1")//�α׾ƿ�
    { 
        location.href="/login/Logout_Proc.asp"; 
    }
    else if(menuName=="top4_2")//�α���
    { 
        location.href="/"; 
    }                
    else if(menuName=="top5")//��������
    { 
        location.href="/member/info.asp"; 
    }          
    else
    {
        alert("������ �غ��� �Դϴ�.");
    }
}    