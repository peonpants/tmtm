function flash(id,w,h,s,wmode) {
  var str="", sID="";
  if (id.length > 0) { sID = " id='"+id+"' name='"+id+"'"; }
  str += "<object "+sID+" classid='clsid:D27CDB6E-AE6D-11cf-96B8";
  str += "-444553540000'";
  str += " codebase='http://download.macromedia.com/pub/shockwave/cabs";
  str += "/flash/swflash.cab#version=6,0,29,0'";
  str += " width='"+w+"' height='"+h+"'>";
  str += "<param name='movie' value='"+s+"'>";
  str += "<param name='quality' value='high'>";
  str += "<param name='wmode' value='"+wmode+"'>";
  str += "<embed "+sID+" src='"+s+"' quality='high' wmode='"+wmode+"'";
  str += " pluginspage='http://www.macromedia.com/go/getflashplayer'";
  str += " type='application/x-shockwave-flash'";
  str += " width='"+w+"' height='"+h+"'></embed>";
  str += "</object>";
  document.write(str);
}