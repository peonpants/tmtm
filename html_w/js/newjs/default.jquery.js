


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
		if($(this).attr("class") == "rating off") {		// 승무패에 배당이 없을 경우 hover 클래스 제거
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
