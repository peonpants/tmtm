// ����,���ڸ� ����
function ch(obj){
	var str = obj.src;               
	if(str.indexOf('_on.gif') < 0){         
	ss = str.substr(0, str.indexOf('.gif'))      
	obj.src = ss + "_on.gif";                         
	}else{                                      
	ss = str.substr(0, str.indexOf('_on.gif'))
	obj.src = ss + ".gif";
	}
}

function EnNumCheck(word)
{
	  var str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
	  for (i=0; i< word.length; i++)
	  {
		idcheck = word.charAt(i);
		for (j = 0 ;  j < str.length ; j++)
		{
		  if (idcheck == str.charAt(j)) break;
		  if (j+1 == str.length)
		  {
			return false;
		  }
		}
	  }
	  return true;
}

function NumCommaCheck(word)
{
	var str = ",1234567890";
	for (i=0; i< word.length; i++)
	  {
		idcheck = word.charAt(i);
		for (j = 0 ;  j < str.length ; j++)
		{
		  if (idcheck == str.charAt(j)) break;
		  if (j+1 == str.length)
		  {
			return false;
		  }
		}
	  }
	  return true;
}

function NumDash(word)
{
	var str = "-1234567890";
	for (i=0; i< word.length; i++)
	  {
		idcheck = word.charAt(i);
		for (j = 0 ;  j < str.length ; j++)
		{
		  if (idcheck == str.charAt(j)) break;
		  if (j+1 == str.length)
		  {
			return false;
		  }
		}
	  }
	  return true;
}

function NumCheck(word)
{
	var str = "1234567890";
	  for (i=0; i< word.length; i++) {
			idcheck = word.charAt(i);
			for (j = 0 ;  j < str.length ; j++)
			{
		  	if (idcheck == str.charAt(j)) break;
		  	if (j+1 == str.length)
		  	{
					return false;
		  	}
			}
	  }
	  return true;
}


//	��ȭ��ȣ üũ[���ڷθ� �����ǰ� 3 ~ 4���� ���̸� ������ ��]
function IsPhoneChek(strNumber)
{
	var regExpr = /^[0-9]{3,4}$/;
	
	if ( regExpr.test( strNumber ) )
		return true;
	else
		return false;
}


function keyCheck(){
  if(event.keyCode < 48 || event.keyCode > 57)// 0~9�� ASCII�ڵ��� �� ����
  {
   alert("���ڸ� ����Ҽ� �ֽ��ϴ�");
   event.returnValue= false ;//���ڰ� �ƴѰ�� �Է��� �ȵ�   
  }
}
