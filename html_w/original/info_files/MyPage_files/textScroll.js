function scrolling(objId, sec1, sec2, speed, height) {
    this.objId = objId;
    this.sec1 = sec1;
    this.sec2 = sec2;
    this.speed = speed;
    this.height = height;
    this.h = 0;
    this.div = document.getElementById(this.objId);
    this.htmltxt = this.div.innerHTML;
    this.div.innerHTML = this.htmltxt + this.htmltxt;
    this.div.isover = false;
    this.div.onmouseover = function () { this.isover = true; }
    this.div.onmouseout = function () { this.isover = false; }
    var self = this;
    this.div.scrollTop = 0;
    window.setTimeout(function () { self.play() }, this.sec1);
}
scrolling.prototype = {
    play: function () {
        var self = this;
        if (!this.div.isover) {
            this.div.scrollTop += this.speed;
            if (this.div.scrollTop > this.div.scrollHeight / 2) {
                this.div.scrollTop = 0;
            } else {
                this.h += this.speed;
                if (this.h >= this.height) {
                    if (this.h > this.height || this.div.scrollTop % this.height != 0) {
                        this.div.scrollTop -= this.h % this.height;
                    }
                    this.h = 0;
                    window.setTimeout(function () { self.play() }, this.sec1);
                    return;
                }
            }
        }
        window.setTimeout(function () { self.play() }, this.sec2);
    },
    prev: function () {
        if (this.div.scrollTop == 0)
            this.div.scrollTop = this.div.scrollHeight / 2;
        this.div.scrollTop -= this.height;
    },
    next: function () {
        if (this.div.scrollTop == this.div.scrollHeight / 2)
            this.div.scrollTop = 0;
        this.div.scrollTop += this.height;
    }
}; 
