void setup() {
		  size(400, 400);
		}
		stroke(255,255,255);
var x = 0;
var y = 0;
var xs = [];
frameRate(30);
var speed = 0.1;
var c = "rand";
var sf = 6;
var pN;
var ps = [];
for(var i = 0; i < 67; i++){
    xs.push(67-2);
}
var p = function(){
    this.x = parseInt(random(0,67),10);
    this.y = 0;
    this.s = parseInt(random(speed,100*speed),10)/10;
    if(this.s < 0.1){
        this.s = 0.1;
    }
    if(c === "dirt"){
    this.c = color(random(65,95),random(10,50),random(0,20));
    }
    if(c === "rand"){
    this.c = color(random(0,255),random(0,255),random(0,255));
    }
    if(c === "red"){
        this.c = color(255, 0, 0);
    }
    if(c === "white"){
        this.c = color(255,255,255);
    }
};
p.prototype.draw = function() {
    stroke(this.c);
    point(this.x,this.y);
    this.y+=this.s;
    
};
var isFull = function(val){
    if(val < -2){
    
    return true;    
    }
};
draw = function() {
    //scale(2.445);
    scale(6);
    background(0, 0, 0);
    
    for(var i = 0; i < ps.length; i++){
        if(ps[i].y >= xs[ps[i].x] && ps[i].s !== 0){
            ps[i].y = xs[ps[i].x] + 1;
            ps[i].s = 0;
            xs[ps[i].x]--;
        }
        ps[i].draw();
    }
    if(!xs.every(isFull)){
        while(speed < 12){
        pN = new p();
        if(xs[pN.x] >= -2){
            ps.push(pN);
        }
        fill(255, 255, 255);
        speed++;
        }
        speed = 0;
        textSize(1.7);
        //text("Cl i ck to speed up",0,2);
    }
    //Draw YOU WIN
    else{
        translate(0,7);
        stroke(0, 0, 0);
        stroke(random(0,255),random(0,255),random(0,255));
        for(var i =0; i < 5; i ++){
        point(20,15+i);
        point(26,15+i);
        point(23,21+i);
        }
        point(21,21);
        point(21,19);
        point(25,21);
        point(25,19);
        point(21,20);
        point(25,20);
        point(22,21);
        point(24,21);
        
        point(34,16);
        point(35,17);
        point(33,15);
        point(32,16);
        point(31,17);
        for(var i = 0; i < 7; i++){
            point(30,17+i);
            point(36,17+i);
        }
        point(31,16);
        point(35,16);
        point(32,15);
        point(34,15);
        point(31,24);
        point(35,24);
        point(32,25);
        point(34,25);
        point(31,23);
        point(32,24);
        point(33,25);
        point(34,24);
        point(35,23);
        for(var i=0;i<10;i++){
        point(40,15+i);
        point(46,15+i);
        }
        point(41,24);
        point(42,25);
        point(43,25);
        point(44,25);
        point(45,24);
        point(41,25);
        point(45,25);
        point(20,29);
        for(var i = 0; i < 5; i++){
            point(20,29+i);
            point(21,34+i);
            point(25,34+i);
            point(26,29+i);
        }
        point(20,34);
        point(26,34);
        point(22,39);
        point(23,38);
        point(24,39);
        point(23,37);
        point(22,38);
        point(24,38);
        for(var i = 0; i < 7;i++){
        point(30+i,29);
        point(30+i,39);
        }
        for(var i = 0; i < 10;i++){
        point(33,29+i);    
        }
        for(var i = 0; i < 11; i++){
        point(40,29+i);
        point(46,29+i);
        }
        point(41,30);
        point(41,31);
        point(42,31);
        point(42,32);
        point(42,33);
        point(43,33);
        point(43,34);
        point(43,35);
        point(44,37);
        point(44,35);
        point(44,36);
        point(45,37);
        point(45,38);
        translate(0,-7);
    }
    
};
void mousePressed(){
    frameRate(500);
    speed = 2;
}
void mouseReleased(){
    frameRate(30);
    speed = 0.1;
}