


$(document).ready(function()
{	

	$(".timeline td.left").hover(function()
	{
		$(this).addClass("hover");
	}, function()
	{
		$(this).removeClass("hover");
	});

	$(".timeline td.right").hover(function()
	{
		$(this).addClass("hover");
	}, function()
	{
		$(this).removeClass("hover");
	});

	$(".timeline td.rating").hover(function()
	{
		if($(this).attr("class") == "rating off") {		// �¹��п� ����� ���� ��� hover Ŭ���� ����
			$(this).removeClass("over");
			$(this).removeClass("hover");
		}
		else
			$(this).addClass("hover");
	}, function()
	{
		$(this).removeClass("hover");
	});


});
