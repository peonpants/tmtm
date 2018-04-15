jQuery.fn.checkField = function(str) {
	if ($(this).val().match(/\S/) == null) {
		alert(str);
		$(this).focus();
		return false;
	} else {
		return true;
	}
};