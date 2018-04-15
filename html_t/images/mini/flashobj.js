function FlashObject(path, width, height)
{
	var m_movie = path;
	var m_width = width;
	var m_height = height;

	this.wmode = "transparent";
	this.id = "";
	this.quality = "high"
	this.menu = "false"
	
	this.Render = function()
	{
		var html;
		
		html = "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0' width='" + m_width + "' height='" + m_height + "'";
		if (this.id != "")
			html += " id='" + this.id + "'";
		html += ">";
		html += "<param name='movie' value='" + m_movie + "'>";
		html += "<param name='menu' value='" + this.menu + "'>";
		html += "<param name='quality' value='" + this.quality + "'>";
		if (this.wmode != "")
			html += "<param name='wmode' value='" + this.wmode + "'>";
		html += "<embed src='" + this.movie + "' quality='" + this.quality + "' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='"+m_width+"' height='"+m_height+"'></embed>";
		html += "</object>";
		document.write(html);
	}
}



function objCall(strpath,strwid,strhei){
var fla = new FlashObject(strpath, strwid, strhei); 
fla.Render(); 
}