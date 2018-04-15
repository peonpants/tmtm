

<!doctype html>
<html xmlns:og="http://ogp.me/ns#" class="no-js">
<head>
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<script src="/js/bet365.js"></script>
<body>
    <div class="content">
		<div id='playerMuLopKAGyXcB'></div>
		<script type='text/javascript'> 
			jwplayer('playerMuLopKAGyXcB').setup({
				file: 'rtmp://vsports.bet365.com/live/L1_C146_S1_high',
				primary: 'flash',
				width: '872',
				height: '514',
				aspectratio: '16:9',
				skin: 'five',
				autostart: 'true',
				mute: false
			});
		</script>
    </div>
    <div style="text-align: center; height: 30px;">
        <a href="g.asp" class="active">Premiership</a>
        <a href="gg.asp" class="">Superleague</a>
        <a href="tv.asp" class="">World Cup</a>
    </div>

    <script src="/newjs/jquery.min.js" type="text/javascript"></script>
    <script src="/newjs/common.js?v=1.0.0.12" type="text/javascript"></script>
    <script type="text/javascript">
        //$(window).resize(function () { });
        $(document).ready(function () {
            if (typeof console === "undefined" || typeof console.log === "undefined") {
                console = {};
                console.log = function () { };
            }
            try {
                var width = $('body').parent().width();
                var height = $('body').parent().height();
                if (window.parent.$("iframe#bet365").length == 1) {
                    //$('#video-player').attr('width', "100%");
                    //$('#video-player').attr('height', window.parent.$("iframe#bet365").height());
                }
            }
            catch (e) { }

            if (!isPC()) {
                $('.content').html('<video x-webkit-airplay="deny" preload="auto" poster="http://" controls="controls" webkit-playsinline="" autoplay width="750" height="520" src="https://vmobile.bet365.com/C146_S1_o/smil:L1_C146_S1.smil/playlist.m3u8"></video>');
            }
        });
    </script>
</body>
</html>
