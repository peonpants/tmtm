  

var booCartMove = true ; // īƮ ���� ���� ����

var slidemenu_X = 138; //��� ���� ��
var slidemenu_Y = 80; //�ϴ� ���� ��

var isDOM = (document.getElementById ? true : false);
var isIE4 = ((document.all && !isDOM) ? true : false);
var isNS4 = (document.layers ? true : false);
var isNS = navigator.appName == "Netscape";


function getRef(id)
{
    if (isDOM) return document.getElementById(id);
    if (isIE4) return document.all[id];
    if (isNS4) return document.layers[id];
}

function getSty(id) 
{
    x = getRef(id);
    return (isNS4 ? getRef(id) : getRef(id).style);
}

function moveRightEdge() 
{
    if(booCartMove) 
    {
        var yMenuFrom, yMenuTo, yOffset, timeoutNextCheck;
        
        if (isNS4) 
        {
            yMenuFrom = divMenu.top;
            yMenuTo = windows.pageYOffset + slidemenu_X; // ���� ��ġ
        } 
        else if (isDOM) 
        {
            yMenuFrom = parseInt (divMenu.style.top, 10);
            yMenuTo = (isNS ? window.pageYOffset : document.body.scrollTop) + slidemenu_X; // ���� ��ġ
            if (document.body.scrollTop < 130 )
            {
	            yMenuTo = (isNS ? window.pageYOffset : document.body.scrollTop) + slidemenu_X; // ���� ��ġ
            } 
            else
            {
	            yMenuTo = (isNS ? window.pageYOffset : document.body.scrollTop) + 0; // ���� ��ġ
            }
    }            
}
timeoutNextCheck = 5;

divMenu_H = document.getElementById('divMenu');
limit_H = (parseInt(document.body.scrollHeight)-slidemenu_Y)-parseInt(divMenu_H.offsetHeight);
divMenu_t = parseInt(divMenu.style.top) ;
//
strReturn = GetCookie('frm2');
if (strReturn == null || strReturn == 'false') {
	

if (yMenuFrom != yMenuTo) {
yOffset = Math.ceil(Math.abs(yMenuTo - yMenuFrom) / 20);
if (yMenuTo < yMenuFrom){
yOffset = -yOffset;
}
if (isNS4){
if(yOffset > 0){
if ( divMenu_t < limit_H) {
divMenu.top += yOffset;
}
}else{
divMenu.top += yOffset;
}

}else if (isDOM){
if(yOffset > 0){
if ( divMenu_t < limit_H) {
divMenu.style.top = parseInt (divMenu.style.top) + yOffset;
}
}else{
divMenu.style.top = parseInt (divMenu.style.top) + yOffset;
}
}
timeoutNextCheck = 5;
}

}

setTimeout ("moveRightEdge()", timeoutNextCheck);
}
