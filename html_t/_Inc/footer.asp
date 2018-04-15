	</div>
<div id="footer">
  <div class="footer_inner">
    <span class="fl_r">COPYRIGHT <%=site_NAME%> ALL RIGHTS RESERVED.</span>
  </div>
</div>
</body>
</html>
<% IF Session("SD_ID") <> "" Then %>
<script>
	$(".isLoginFalse").removeClass('isLoginFalse');
</script>
<% End If %>
<iframe name="HiddenFrm" src="/Blank.html" frameborder="0" width="0" height="0" frameborder="0" style="display: none;"></iframe>
<iframe name="ProcFrm" src="/Blank.html" frameborder="0" width="0" height="0" frameborder="0" style="display: none;"></iframe>