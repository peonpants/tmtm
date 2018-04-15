
function getObject(objectId) { 	
	if(document.getElementById && document.getElementById[objectId]) { 
		return document.getElementById[objectId]; 
	} 
	else if (document.all && document.all[objectId]) { 
		return document.all[objectId]; 
	} 
	else if (document.layers && document.layers[objectId]) { 
		return document.layers[objectId]; 
	}
	else if(document.getElementById && document.getElementById(objectId)) { 
		return document.getElementById(objectId); 
	}
	else 
	{ 
		return false; 
	} 
} 
function Slider(objid,top,min) 
{
    this._obj = getObject(objid);
	this._top = top;
	if(!min) this._min=0;
	else this._min = min;
	this._pt = top;//document.body.scrollTop + 
	this._movenow = false;
	this._stop = 0;
}
Slider.prototype.set = function()
{
	if(document.body.scrollTop<=this._min)
	{
		this._pt = 0;
		//alert("111");
	}
	else
	{
		this._pt = document.body.scrollTop - this._min + this._top;// - 114;
		//alert("222");
	}
	
	if(!this._movenow) this.move();
}
Slider.prototype.move = function()
{
	if(!this._obj)return;
	if(this._stop==1) return;
	
	this._movenow=true;
	var myt=parseInt(this._obj.style.height);
	var gap = this._pt - myt;
	gap = parseInt(gap/4);

	if(gap>0)
	{
	
		myt+=gap;
		if(myt<=0) myt = 0;
		this._obj.style.height=myt;
		//this._obj.height=myt;
		setTimeout("move();",10);
	}
	else if(gap<0)
	{

		myt+=gap;
		if(myt<=0) myt = 0;
		this._obj.style.height=myt;
		//this._obj.height=myt;
		setTimeout("move();",10);
	}
	else
	{
		this._movenow=false;	
	}	
}

Slider.prototype.stop = function()
{
	if(this._stop==1)	{
		this._stop=0;	

	}else if(this._stop==0)	{
		this._stop=1;	

	}
}

Slider.prototype.isStop = function() {
    return this._stop;
}

	var bs;
	var obj = getObject("bet_slip_space");
	if (obj)	bs = new Slider("bet_slip_space", 0,130);
 
function move() {
	if (bs) bs.move();
}

function LocationChange() {
	if (bs) {
		bs.stop();

		var obj = getObject("imgBetlipPin");
		if (obj) {
			if (bs.isStop() == 1)	obj.src = "/images/cross/fixed_cart_on.png";
			else	obj.src = "/images/cross/fixed_cart_off.png";
		}
		BetslipSlide();
	}
}
 
function BetslipSlide() {
	if (bs) bs.set();
}
window.onscroll = BetslipSlide;
window.onresize = BetslipSlide;
//-->