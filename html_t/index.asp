<html>
<head>

<meta http-equiv=content-type content=text/html>
<title><%= SITE_TITLE %></title>
 <script>
  var this_url = document.location.href;
  var split_url =this_url.split("/");
//  alert(split_url[2]);
var url_detail = split_url[2].split(".");
//alert(url_detail.length);


//alert(final_url);
if (url_detail.length == 2) {
var final_url = "http://m."+split_url[2];

} else {

var final_url = "http://m."+url_detail[1]+"."+url_detail[2];
}

     if (navigator.userAgent.match(/iPad/) == null && navigator.userAgent.match(/iPhone|Mobile|UP.Browser|Android|BlackBerry|Windows CE|Nokia|webOS|Opera Mini|SonyEricsson|opera mobi|Windows Phone|IEMobile|POLARIS/) != null) { //����Ͽ� �ε��������� ����location.href = "";
     location.href = final_url;//�����

     } else {
  //   location.href = "SNP_open_F.asp";
	 } //�ͽ��÷η� �ε��������� ���� 

</script> 
</head>

<frameset rows="*,0" cols="1*" border=0>
<frame src="index2.asp" frameborder=0 scrolling=auto>
</frameset>

</body>
</html>