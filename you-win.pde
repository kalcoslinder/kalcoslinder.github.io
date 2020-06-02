void setup() {
		  size(400, 400);
		}
		stroke(255,255,255);
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
var shift = 0;
var speedLimit = 1;

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
var f = 30;
draw = function() {
    scale(2.445);
    background(0, 0, 0);
    if(!xs.every(isFull)){
        while(speed < speedLimit){
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
        //pushMatrix();
        if(shift < 80){
            for(var i = 0; i < ps.length; i++){
            if(ps[i].y < 0){
                    ps[i].y = 401;
                }
             ps[i].y+=1;
            
            }
            shift++;
        }
        else{
            shift = 0;
            ps.length = 0;
            xs.length = 0;
            for(var i = 0; i < 67; i++){
                xs.push(65);
            }
        }
        
        
    }
    for(var i = 0; i < ps.length; i++){
        if(ps[i].y >= xs[ps[i].x] && ps[i].s !== 0){
            ps[i].y = xs[ps[i].x] + 1;
            ps[i].s = 0;
            xs[ps[i].x]--;
        }
        ps[i].draw();
    }
    
};

mousePressed = function(){
    frameRate(500);
    speed = 2;
};

mouseReleased = function(){
    frameRate(30);
    speed = 0.1;
};
