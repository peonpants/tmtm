<!--
	function MM_swapImgRestore() { //v3.0
		var i,x,a=document.MM_sr;
		for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
	}
	function MM_preloadImages() { //v3.0
		var d=document;
		if(d.images){
			if(!d.MM_p) d.MM_p=new Array();
			var i,j=d.MM_p.length,a=MM_preloadImages.arguments;
			for(i=0; i<a.length; i++)
				if (a[i].indexOf("#")!=0){
					d.MM_p[j]=new Image;
				d.MM_p[j++].src=a[i];
			}
		}
	}

	function MM_findObj(n, d) { //v4.01
		var p,i,x;
		if(!d) d = document;
		if((p=n.indexOf("?"))>0&&parent.frames.length) {
			d=parent.frames[n.substring(p+1)].document;
			n=n.substring(0,p);
		}
		if(!(x=d[n])&&d.all) x=d.all[n];
		for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
			for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
			if(!x && d.getElementById) x=d.getElementById(n);
			return x;
	}

	function MM_swapImage() { //v3.0
		var i,j=0,x,a=MM_swapImage.arguments;
		document.MM_sr = new Array;
		for(i=0;i<(a.length-2);i+=3)
			if ((x=MM_findObj(a[i]))!=null){
				document.MM_sr[j++]=x;
			if(!x.oSrc) x.oSrc=x.src;
			x.src=a[i+2];
		}
	}
	function memo_popup() {
		window.open("/memo/memo_list.asp", "memo", "width=617, height=460, scrollbars=yes");
	}
	function doBlink() {
		var blink = document.getElementsByTagName("blink");
		for (var i=0; i<blink.length; i++) {
			blink[i].style.visibility = blink[i].style.visibility == "" ? "hidden" : ""; 
		}
	}
	function goMobilePage() {
		parent.location.href = "http://" + location.host.replace("www.", "m.");
	}
	/*
	$(document).ready(function() {
		$.getJSON("/include/top2.asp", function(rs) {
			if (rs["Flag"] == "True") {
				alert(rs["msg"])
				location.href = rs["url"];
			} else {
				
				$("#spnAdmin").html(rs["btnAdmin"]);
				if (rs["mb_nick"] != "") { // �α��� �ߴٸ�...
					$("#spnMemInfo").css("display","");
					$("#frm_info").css("display", "");

					$("#mb_nick").text(rs["mb_nick"]);
					$("#mb_point").text(rs["mb_point"]);
					$("#mb_grade_name").text(rs["mb_grade_name"]);
					$("#post_icon").attr("src", "/html/VEGA/images/" + rs["memo_image"] + ".g"+"if");

					if (parseInt(rs["mb_mileage"], 10) >= parseInt(rs["intMP"], 10)) {
						$("#point_info").addClass("PointChange").html("<font color='#BB5400'><b>����Ʈ��ȯ</b></font>: <span class='font_12_red'>" + rs["mb_mileage"] + "</span> ��")
						$("#point_info").click(function() {
							if (confirm("���� ���ϸ����� ����Ʈ�� ��ȯ�Ͻðڽ��ϱ� ?")) {
								location.href = "/include/point_change.asp";
							}
						}).css("cursor","pointer");
					} else {
						$("#point_info").html("��������Ʈ: <span class='font_12_red'>" + rs["mb_mileage"] + "</span>��");
					}

					if ($("#post_icon").length > 0) {
						if ($("#post_icon").attr("src").indexOf("post_yes") != -1) {
							setInterval("doBlink()",700); 
						}
					}
				} else { // �α��� ���ߴٸ�...
					$("#userid").focus().css("imeMode", "disabled");
					$("#frm_login").css("display","")
						.submit(function() {
							if (!$("#userid").checkField("���̵� �Է��ϼ��� !")) return false;
							if (!$("#passwd").checkField("���̵� �Է��ϼ��� !")) return false;

							$("#mode").val("act");
					});
				}
			}

			$("#hot_news").html(rs["arr_hot_news"].replace(/\vbCrLf/gi, "<br />"));
			
			var shopping = new js_rolling('hot_news');
			shopping.set_direction(1);
			shopping.move_gap = 2;	//�����̴� �ȼ�����
			shopping.time_dealy = 30; //�����̴� Ÿ�ӵ�����	
			shopping.time_dealy_pause = 3000;//�ϳ��� ����� ���� ������ �� ���ߴ� �ð�, 0 �̸� ���� ����
			shopping.start();
		});
		
		$("#live_data").click(function() {
			window.open("../live_data.asp", "live_data_popup", "width=1017, height=700, scrollbars=yes");
		}).css("cursor", "pointer");
	});
	*/
//-->