void setup(){
size(400,400);
}
var fight = function(Stickman1,Stickman2){};
//Mouse Controls 
//Involves interacting with every on-screen feature including doors and interactives
//Implement Zoom
//**VARIABLES**//
var Zoom = false;
var scopeZoom = 1;


//**VARIABLES**//
{
var bobX = 0;
var ground = 363;
var timeStep = 0;
var time = 0; //time for running animations
var s = 4; //Defines length of animation frames
var run = true;
var lrun = false;
var grav = 0.3;
var acc = 0;
var vel = 0;
var jump = -4;
var money = 100;
var disp = 0;
var r,g,b = 0;
var r1,g1,b1 = 0;
var t = 12; //time for day/night cycles
var m = "";
var clock = 0;
var screen = 2;
var shop = "closed";
var state = "menu";
var textEntry = false;
var click = false;
var textMsg = [];
var textRegister;
var format = "default";
var amt = 0;
var tr = 0;
var confirm = false;
var cloudPosX1 = 50;
var cloudPosX2 = 235;
var cloudSpeed = 0.06;
var runLeft = false;
var runRight = false;
var transparency = 0;
var mouseDown = true;
}

//**DRAW CUSTOM ARTWORK**//
{
var drawBackground = function(){
    //Sky
    t+=0.001;
    fill(0, 32, 69); // Early Morning
    fill(217, 76, 0); // Purple Sunset
    fill(212, 132, 12); // Orange Sunrise
    fill(0, 0, 0); // Night 2
    if(t >= 24)
    {
        t = 0;
    }
    if(t > 5 && t < 5.5) //Nighttime to Early Morning
    {
        /*if(t>19 && t < 19.2) { fill(215,215,0,lerp(t,5*(t-19)); }
        */
        r = lerp(0,0,2*(t-5));
        g = lerp(0,32,2*(t-5));
        b = lerp(0,69,2*(t-5));
        r1 = r;
        g1 = g;
        b1 = b;
    }
    if(t > 5.5 && t < 6.5) //Early Morning to Midday
    {
        r = lerp(r1,145,(t-5.5));
        g = lerp(g1,191,(t-5.5)); 
        b = lerp(b1,255,(t-5.5));
    }
    if(t > 6.5 && t < 18.5) //Midday
    {
        r = 145;
        g = 191;
        b = 255;
    }
    if(t > 18.5 && t < 19) //Midday to Sunset
    {
        //217, 76, 0
        fill(52, 12, 59);
        r = lerp(145,52,(t-18.5));
        g = lerp(191,12,(t-18.5));
        b = lerp(255,59,(t-18.5));
        r1 = r;
        g1 = g;
        b1 = b;
    }
    if(t > 19 && t < 20) //Sunset to Nighttime
    {
        r = lerp(r1,0,(t-19));
        g = lerp(g1,0,(t-19));
        b = lerp(b1,0,(t-19));
    }
    if(t > 20 || (t > 1 && t < 5)) //Nighttime
    {
        r = 0;
        g = 0;
        b = 0;
    }
    //Draw background
    background(r,g,b);
    stroke(0, 0, 0);
    strokeWeight(2);
    
};
var drawClock = function(){
    //Draw Clock
    fill(0, 0, 0);
    textSize(18);
    m = "am";
    if (t >= 12){
        m = "pm";
    }
    if(t < 1){
        clock = t+12;
    }
    if(t < 13 && t >= 1){
        clock = t;
    }
    if(t>=13){
        clock = t-12;
    }
    fill(151, 171, 252,180);
    noStroke();
    fill(255, 255, 255);
    stroke(0, 0, 0);
    text(floor(clock) + ":" + nfc((clock - floor(clock))*60,2,-1) + " " + m,320,395);
    fill(0, 0, 0);
    ellipse(355,335,70,70);
    fill(255, 255, 255);
    textSize(10);
    text("1",366,314);
    text("2",376,324);
    text("3",382,338);
    text("4",376,351);
    text("5",366,364);
    text("6",352,367);
    text("7",340,362);
    text("8",329,353);
    text("9",323,339);
    text("10",325,325);
    text("11",335,315);
    text("12",348,310);
    stroke(255, 255, 255);
    point(355,335);
    line(355,335,cos((clock-3)*360/12)*12+355,sin((clock-3)*360/12)*12+335);
    line(355,335,cos((clock - floor(clock)-0.25)*360)*20+355,sin((clock - floor(clock)-0.25)*360)*20+335);
};
var drawStreetlight = function(){
    strokeWeight(2);
    stroke(255, 255, 255,tr+100);
    fill(255, 255, 255,tr+100);
    ellipse(200+110,100,10,10); //Streetlight bulb
    stroke(0, 0, 0);
    fill(0, 0, 0);
    arc(200+110,100,10,10,187*PI/180,354*PI/180);
    fill(247,255,0,tr*110);
    noStroke();
    if(t > 7+12 || t < 6)
    {
    beginShape(); //Streetlight light
        vertex(204+110, 100);
        vertex(196+110, 100);
        vertex(175+110, 161);
        vertex(225+110, 161);
    endShape();
    }
    stroke(0, 0, 0);
    line(200+110,107,200+110,160);
};
var drawBank = function(){
    strokeWeight(2);
        //Bushes
        fill(11, 214, 0);
        stroke(0, 0, 0);
        rect(203-80,200-46,40,7,6);
        noStroke();
        ellipse(213-80,198-46,15,15);
        ellipse(226-80,194-46,15,15);
        rect(226-90,194-45,20,9);
        
        stroke(0, 0, 0);
        arc(213-80,198-46,15,15,162,316);
        arc(226-80,194-46,15,15,203,365);
        //Draw main build
        strokeWeight(2);
        stroke(0,0,0);
        fill(89, 89, 89);
        rect(25+125,-35,100,197);
        
        //Top Windows
        fill(0, 174, 255);
        strokeWeight(1);
        for(var i = 0; i < 7; i ++){
            for(var j = 0; j < 16; j++){
                rect(151+14*i,-34+8*j,12,7);
            }
        }
        //Inside
        strokeWeight(2);
        fill(228, 237, 55);
        rect(95+76,12+94+10,58,40);
        //Door
        fill(255, 255, 255);
        rect(95+76,12+94+10,57,40);
        fill(0, 174, 255);
        rect(99+76,12+94+14,27,40);
        rect(70+116+14,12+98+10,24,40);
        
        fill(255, 255, 255);
        rect(91+103,12+94+29,5,10);
        rect(91+96+12,12+94+29,5,10);
        
        //Steps
        fill(99, 99, 99);
        rect(20+125,157,110,6);
        rect(170,157,60,6);
        strokeWeight(1);
        line(171,160,229,160);
        //Money Sign
        strokeWeight(2);
        fill(255, 255, 255);
        rect(171,98,58,19);
        rect(174,101,52,16);
        fill(0, 0, 0);
        textSize(16);
        text("BANK",177,115);
};
var drawSupermarket = function(){
        //Draw main buildings
        strokeWeight(2);
        stroke(0,0,0);
        //Side buildings
        fill(242, 228, 191);
        rect(25+125-25,106,150,57);
        //Bottom Step
        fill(138, 138, 138);
        rect(20+125-25,157,160,6);
        //Top Roof
        fill(61, 36, 9);
        rect(20+125-25,81,160,27);
        
        
        for(var i = 0; i < 20; i++){
            line(120+8*i,83,120+8*i,106);
        }
        //Sign
        fill(255, 242, 0);
        strokeWeight(4);
        rect(160,88,80,21);
        strokeWeight(2);
        fill(255, 0, 0);
        textSize(18);
        textFont(createFont("sans-serif Bold"));
        text("LIQUOR",165,104);
        textFont(createFont("sans-serif"));
        //Bottom Windows
        fill(0, 174, 255);
        rect(35+95,12+94+10,50,30);
        line(36+95,38+94+10,53+125,38+94+10);
        rect(95+125,12+94+10,50,30);
        line(96+125,38+94+10,114+155,38+94+10);
        
        //Inside
        fill(228, 237, 55);
        rect(95+91,12+94+10,28,40);
        //Door
        fill(97, 97, 97);
        rect(95+91,12+94+10,5,40);
        rect(95+99+14,12+94+10,5,40);
        
        fill(255, 255, 255);
        rect(91+95,12+94+29,5,10);
        
        rect(91+96+21,12+94+29,5,10);
        
        

};
var drawApartment = function(){
    
//Draw main buildings
        strokeWeight(3);
        stroke(0,0,0);
        fill(128, 44, 23);
        //Main building
        rect(25+125,-10,100,172);
        strokeWeight(1);
        stroke(0,0,0,100);
        for(var i = 0; i < 33; i++){
            line(154 + 3*i,-10,154+3*i,163);
        }
        strokeWeight(3);
        for(var i = 0; i < 43; i++){
            line(152,4*i-8,248,4*i-8);
        }
        stroke(0, 0, 0);
        //Windows
        fill(140, 140, 140);
        strokeWeight(2);
        for(var i = 0; i < 6; i ++){
            for(var j = 0; j < 5; j++){
                rect(157+15*i,20*j,7,15);    
            }
            
        }
        //Railings
        stroke(0, 0, 0);
        for(var i = -1; i < 3 ; i++){
            strokeWeight(3);
            line(160,40+20*i,190,40+20*i);
            strokeWeight(2);
            line(160,20+20*i,190,40+20*i);
        }
        //Steps
        strokeWeight(2);
        fill(166, 166, 166);
        rect(180,157,40,6);
        strokeWeight(1);
        line(181,160,219,160);
        
        //Awning
        fill(39, 79, 2);
        rect(150,117-10,100,10);
        stroke(255,255,255);
        strokeWeight(2);
        for(var i = 0; i < 20; i++){
            line(152+5*i,119-10,152+5*i,125-10);
        }
        stroke(0, 0, 0);
        fill(39,79,2);
        for(var i = 0; i < 10; i++){
            arc(155+i*10,128-10,10,10,0,PI);
        }
        //Call box
        fill(97, 97, 97);
        rect(170+52,140,7,10);
        point(173+52,143);
        point(173+52,146);
};
var drawMailbox = function(mailbox){
    fill(0,62,176);
    rect(mailbox.pos.x,mailbox.pos.y,mailbox.width,mailbox.height-4);
    line(mailbox.pos.x,mailbox.pos.y+8,mailbox.pos.x-1+mailbox.width,mailbox.pos.y+8);
    rect(mailbox.pos.x,mailbox.pos.y+mailbox.height-4,4,4);
    rect(mailbox.pos.x+mailbox.width-4,mailbox.pos.y+mailbox.height-4,4,4);
    fill(255,255,255);
    rect(mailbox.pos.x+3,mailbox.pos.y+11,6,4);
    fill(0,0,0);
    rect(mailbox.pos.x,mailbox.pos.y+8-mailbox.timer.curTime/mailbox.timer.maxTime*6,mailbox.width,mailbox.timer.curTime/mailbox.timer.maxTime*6);
};
}

//**FUNCTION AND OBJECT DECLARATIONS**//
{

//**ART**//
var lineDraw = function(arr1,arr2){
    strokeWeight(2);
    line(arr1[0],arr1[1],arr2[0],arr2[1]);
};var drawSkyline = function(){
    
    stroke(143, 143, 143,100);
    rectMode(CORNERS);
    fill(90, 97, 125);
    rect(0,149,87,363);
    fill(81, 89, 120);
    rect(101,92,158,363);
    fill(117, 127, 173);
    rect(176,88,223,363);
    fill(70, 74, 92);
    rect(132,70,187,363);
    fill(59, 62, 77);
    rect(27,126,118,363);
    fill(106, 114, 150);
    rect(246,53,297,363);
    fill(70, 75, 99);
    rect(191,113,269,363);
    fill(94, 98, 125);
    rect(316,105,399,363);
    
    fill(61, 63, 77);
    rect(206,174,332,363);
    
    rectMode(CORNER);
    //WINDOWS
    noStroke();
    fill(109, 141, 150,100);
    
    
    for(var i = 0; i < 5; i++){
        for(var j = 0; j < 5; j++){
            rect(222+20*i,187+20*j,10,10);
        }
    }

};
var drawCloud = function(x,y){
    fill(255, 255, 255);
    noStroke();
    ellipse(x+16,y,25,25);
    ellipse(x+1,y+5,15,16);
    ellipse(x+32,y+5,14,15);
    rect(x,y+7,35,6,5);
};
var drawStar = function(x,y,t1,f){
    if( t > 18.5 + t1 || t < 5.5)
    {
        stroke(255,255,255,255*(0.5 + abs(sin((t+t1)*f))/2));
        if( t > 18.5 + t1 && t < 18.6 + t1)
        {
            stroke(255,255,255,(t-(18.5+t1))*10*255);
        }
        point(x,y);
    }
};
var drawBush = function(){
    //Bushes
        fill(21, 176, 10);
        stroke(0, 0, 0);
        strokeWeight(2);
        rect(203-80,200-46,40,7,6);
        noStroke();
        ellipse(213-80,198-46,15,15);
        ellipse(226-80,194-46,15,15);
        ellipse(240-80,203-46,9,7);
        ellipse(236-80,199-46,11,11);
        rect(213-80,200-50,30,7,6);
        rect(2-90,190-45,18,9);
        stroke(0, 0, 0);
        strokeWeight(2);
        arc(213-80,198-46,15,15,162,316);
        arc(226-80,194-46,15,15,203,365);   
        arc(240-80,203-46,10,10,288,410);
        arc(236-80,199-46,11,11,210,350);
};
var bank = {
    pos:
    {
        x: 93,
        y: 363,
    },
    width: 120,
    height: 200,
    draw: function()
    {
        //Draw main build
        strokeWeight(2);
        stroke(0,0,0);
        fill(89, 89, 89);
        rectMode(CORNERS);
        rect(this.pos.x,this.pos.y - this.height,this.pos.x+this.width,this.pos.y);
        rectMode(CORNER);
    }
};
var drawBanker = function(x,y){
    //Head
    strokeWeight(3);
    fill(255, 255, 255);
    ellipse(x,y,50,50);
    line(x,y+25,x,y+30);
    line(x,y+28,x-11,y+59);
    line(x,y+25,x+11,y+59);
    line(x,y+33,x,y+59);
    
};
var simulateClouds = function(){
    if(t > 5.5 && t < 13.5) 
    { 
        cloudPosX1 = -60 + (t-5.5)*60; 
    }
    else { 
        cloudPosX1 = -60; 
    }
    if(t > 8.5 && t < 16.5) { 
        cloudPosX2 = -60 + (t-8.5)*60; 
    }
    else {
        cloudPosX2 = -60;
    }
    drawCloud(cloudPosX1,35);
    drawCloud(cloudPosX2,70);
};



var aptKey = true;

}

//**STICKMEN**//
//A stickman is a moldable position of (stick) arms legs, body and head. It can only run so far.
{
var stickman = function(){
this.posX = 20;
this.pos = 150; //Change to 0 for a fun drop-in!
this.height = 0;
this.frame = "";
this.head = [this.posX+14,this.pos-15];
this.neck = [this.posX+12,this.pos-9];
this.torso = [this.posX+11,this.pos-7];
this.waist = [this.posX+8,this.pos-1];
this.rknee = [this.posX+7,this.pos+5];
this.lknee = [this.posX+12,this.pos+5];
this.rfoot = [this.posX,this.pos+8];
this.lfoot = [this.posX+13,this.pos+10];
this.lhand = [this.posX+14,this.pos-2];
this.rhand = [this.posX+4,this.pos-3];

this.recordPos();
};
stickman.prototype.draw = function() {
this.com = (this.head[0]+this.neck[0]+this.torso[0]+this.waist[0]+this.rknee[0]+this.lknee[0]+this.rfoot[0]+this.lfoot[0]+this.lhand[0]+this.rhand[0])/10;
stroke(0, 0, 0);
fill(255, 255, 255);
lineDraw(this.neck,this.torso);
lineDraw(this.waist,this.torso);
lineDraw(this.lknee,this.waist);
lineDraw(this.rknee,this.waist);
lineDraw(this.lfoot,this.lknee);
lineDraw(this.rfoot,this.rknee);
lineDraw(this.neck,this.lhand);
lineDraw(this.neck,this.rhand);
ellipse(this.head[0],this.head[1],10,10);

};
stickman.prototype.recordPos = function() {
    this.com = (this.head[0]+this.neck[0]+this.torso[0]+this.waist[0]+this.rknee[0]+this.lknee[0]+this.rfoot[0]+this.lfoot[0]+this.lhand[0]+this.rhand[0])/10;
    this.oldHead = this.head;
    this.oldNeck = this.neck;
    this.oldTorso = this.torso;
    this.oldWaist = this.waist;
    this.oldRknee = this.rknee;
    this.oldLknee = this.lknee;
    this.oldRfoot = this.rfoot;
    this.oldLfoot = this.lfoot;
    this.oldRhand = this.rhand;
    this.oldLhand = this.lhand;
    
};
//run the functions to draw the frames
stickman.prototype.run1 = function() {
this.frame = "run1";
this.head = [this.posX-3,this.pos-14];
this.neck = [this.posX-6,this.pos-8];
this.torso = [this.posX-8,this.pos-5];
this.waist = [this.posX-10,this.pos];
this.rknee = [this.posX-5,this.pos+5];
this.lknee = [this.posX-15,this.pos+5];
this.rfoot = [this.posX-2,this.pos+12];
this.lfoot = [this.posX-20,this.pos+2];
this.lhand = [this.posX-16,this.pos-6];
this.rhand = [this.posX,this.pos-2];
};
stickman.prototype.run2 = function() {
this.frame = "run2";
this.head = [this.posX-3+4*timeStep,this.pos-14];
this.neck = [this.posX-6+5*timeStep,this.pos-8];
this.torso = [this.posX-8+5*timeStep,this.pos-5];
this.waist = [this.posX-10+5*timeStep,this.pos+1*timeStep];
this.rknee = [this.posX-5+5*timeStep,this.pos+5+2*timeStep];
this.lknee = [this.posX-15+7*timeStep,this.pos+5+1*timeStep];
this.rfoot = [this.posX-2,this.pos+12];
this.lfoot = [this.posX-20+6*timeStep,this.pos+2+5*timeStep];
this.lhand = [this.posX-16+6*timeStep,this.pos-6+3*timeStep];
this.rhand = [this.posX+1*timeStep,this.pos-2+2*timeStep];
};
stickman.prototype.run3 = function() {
this.frame = "run3";
this.head = [this.posX+1+3*timeStep,this.pos-14+1*timeStep];
this.neck = [this.posX-1+3*timeStep,this.pos-8-2*timeStep];
this.torso = [this.posX-3+3*timeStep,this.pos-5-2*timeStep];
this.waist = [this.posX-5+4*timeStep,this.pos+1-2*timeStep];
this.rknee = [this.posX+1*timeStep,this.pos+7-1*timeStep];
this.lknee = [this.posX-8+9*timeStep,this.pos+6-2*timeStep];
this.rfoot = [this.posX-2,this.pos+12];
this.lfoot = [this.posX-14+8*timeStep,this.pos+7];
this.lhand = [this.posX-10+12*timeStep,this.pos-3+1*timeStep];
this.rhand = [this.posX+1-4*timeStep,this.pos-1*timeStep];
};
stickman.prototype.run4 = function() {
this.frame = "run4";
this.head = [this.posX+4+5*timeStep,this.pos-12-3*timeStep];
this.neck = [this.posX+2+4*timeStep,this.pos-10+1*timeStep];
this.torso = [this.posX+5*timeStep,this.pos-7];
this.waist = [this.posX-1+3*timeStep,this.pos-1];
this.rknee = [this.posX+1+2*timeStep,this.pos+6-1*timeStep];
this.lknee = [this.posX+1+5*timeStep,this.pos+4+1*timeStep];
this.rfoot = [this.posX-2,this.pos+12];
this.lfoot = [this.posX-6+8*timeStep,this.pos+7+1*timeStep];
this.lhand = [this.posX+2+4*timeStep,this.pos-2];
this.rhand = [this.posX-3+3*timeStep,this.pos-1-1*timeStep];
};
stickman.prototype.run5 = function() {
this.frame = "run5";
this.head = [this.posX+9+3*timeStep,this.pos-15];
this.neck = [this.posX+6+3*timeStep,this.pos-9];
this.torso = [this.posX+5+3*timeStep,this.pos-7];
this.waist = [this.posX+2+3*timeStep,this.pos-1];
this.rknee = [this.posX+3+1*timeStep,this.pos+5];
this.lknee = [this.posX+6+4*timeStep,this.pos+5-2*timeStep];
this.rfoot = [this.posX-2,this.pos+12];
this.lfoot = [this.posX+2+6*timeStep,this.pos+8];
this.lhand = [this.posX+6+4*timeStep,this.pos-2];
this.rhand = [this.posX+2*timeStep,this.pos-2];
};
stickman.prototype.run6 = function() {
this.frame = "run6";
this.head = [this.posX+12+2*timeStep,this.pos-15];
this.neck = [this.posX+9+3*timeStep,this.pos-9];
this.torso = [this.posX+8+3*timeStep,this.pos-7];
this.waist = [this.posX+5+3*timeStep,this.pos-1];
this.rknee = [this.posX+4+3*timeStep,this.pos+5];
this.lknee = [this.posX+10+2*timeStep,this.pos+3+2*timeStep];
this.rfoot = [this.posX-2+2*timeStep,this.pos+12-4*timeStep];
this.lfoot = [this.posX+8+5*timeStep,this.pos+8+2*timeStep];
this.lhand = [this.posX+10+4*timeStep,this.pos-2];
this.rhand = [this.posX+2+2*timeStep,this.pos-2-1*timeStep];
};
stickman.prototype.run7 = function() {
this.frame = "run7";
this.head = [this.posX + 14 + 1*timeStep,this.pos-15];
this.neck = [this.posX + 13,this.pos-9];
this.torso = [this.posX + 11,this.pos-7];
this.waist = [this.posX + 8 + 2*timeStep,this.pos-1];
this.rknee = [this.posX + 7,this.pos+5];
this.lknee = [this.posX + 12 + 2*timeStep,this.pos+5];
this.rfoot = [this.posX,this.pos+8-3*timeStep];
this.lfoot = [this.posX + 13 + 3*timeStep,this.pos+10];
this.lhand = [14+this.posX + 4*timeStep,this.pos-2];
this.rhand = [4+this.posX - 1*timeStep,this.pos-3-2*timeStep];
};
stickman.prototype.lrun1 = function() {
this.frame = "lrun1";
this.head = [this.posX+3,this.pos-14];
this.neck = [this.posX+6,this.pos-8];
this.torso = [this.posX+8,this.pos-5];
this.waist = [this.posX+10,this.pos];
this.rknee = [this.posX+5,this.pos+5];
this.lknee = [this.posX+15,this.pos+5];
this.rfoot = [this.posX+2,this.pos+12];
this.lfoot = [this.posX+20,this.pos+2];
this.lhand = [this.posX+16,this.pos-6];
this.rhand = [this.posX,this.pos-2];
};
stickman.prototype.lrun2 = function() {
this.frame = "lrun2";
this.head = [this.posX+3-4*timeStep,this.pos-14];
this.neck = [this.posX+6-5*timeStep,this.pos-8];
this.torso = [this.posX+8-5*timeStep,this.pos-5];
this.waist = [this.posX+10-5*timeStep,this.pos+1*timeStep];
this.rknee = [this.posX+5-5*timeStep,this.pos+5+2*timeStep];
this.lknee = [this.posX+15-7*timeStep,this.pos+5+1*timeStep];
this.rfoot = [this.posX+2,this.pos+12];
this.lfoot = [this.posX+20-6*timeStep,this.pos+2+5*timeStep];
this.lhand = [this.posX+16-6*timeStep,this.pos-6+3*timeStep];
this.rhand = [this.posX-1*timeStep,this.pos-2+2*timeStep];
};
stickman.prototype.lrun3 = function() {
this.frame = "lrun3";
this.head = [this.posX-1-3*timeStep,this.pos-14+1*timeStep];
this.neck = [this.posX+1-3*timeStep,this.pos-8-2*timeStep];
this.torso = [this.posX+3-3*timeStep,this.pos-5-2*timeStep];
this.waist = [this.posX+5-4*timeStep,this.pos+1-2*timeStep];
this.rknee = [this.posX-1*timeStep,this.pos+7-1*timeStep];
this.lknee = [this.posX+8-9*timeStep,this.pos+6-2*timeStep];
this.rfoot = [this.posX+2,this.pos+12];
this.lfoot = [this.posX+14-8*timeStep,this.pos+7];
this.lhand = [this.posX+10-12*timeStep,this.pos-3+1*timeStep];
this.rhand = [this.posX-1+4*timeStep,this.pos-1*timeStep];
};
stickman.prototype.lrun4 = function() {
this.frame = "lrun4";
this.head = [this.posX-4-5*timeStep,this.pos-12-3*timeStep];
this.neck = [this.posX-2-4*timeStep,this.pos-10+1*timeStep];
this.torso = [this.posX-5*timeStep,this.pos-7];
this.waist = [this.posX+1-3*timeStep,this.pos-1];
this.rknee = [this.posX-1-2*timeStep,this.pos+6-1*timeStep];
this.lknee = [this.posX-1-5*timeStep,this.pos+4+1*timeStep];
this.rfoot = [this.posX+2,this.pos+12];
this.lfoot = [this.posX+6-8*timeStep,this.pos+7+1*timeStep];
this.lhand = [this.posX-2-4*timeStep,this.pos-2];
this.rhand = [this.posX+3-3*timeStep,this.pos-1-1*timeStep];
};
stickman.prototype.lrun5 = function() {
this.frame = "lrun5";
this.head = [this.posX-9-3*timeStep,this.pos-15];
this.neck = [this.posX-6-3*timeStep,this.pos-9];
this.torso = [this.posX-5-3*timeStep,this.pos-7];
this.waist = [this.posX-2-3*timeStep,this.pos-1];
this.rknee = [this.posX-3-1*timeStep,this.pos+5];
this.lknee = [this.posX-6-4*timeStep,this.pos+5-2*timeStep];
this.rfoot = [this.posX+2,this.pos+12];
this.lfoot = [this.posX-2-6*timeStep,this.pos+8];
this.lhand = [this.posX-6-4*timeStep,this.pos-2];
this.rhand = [this.posX-2*timeStep,this.pos-2];
};
stickman.prototype.lrun6 = function() {
this.frame = "lrun6";
this.head = [this.posX-12-2*timeStep,this.pos-15];
this.neck = [this.posX-9-3*timeStep,this.pos-9];
this.torso = [this.posX-8-3*timeStep,this.pos-7];
this.waist = [this.posX-5-3*timeStep,this.pos-1];
this.rknee = [this.posX-4-3*timeStep,this.pos+5];
this.lknee = [this.posX-10-2*timeStep,this.pos+3+2*timeStep];
this.rfoot = [this.posX+2-2*timeStep,this.pos+12-4*timeStep];
this.lfoot = [this.posX-8-5*timeStep,this.pos+8+2*timeStep];
this.lhand = [this.posX-10-4*timeStep,this.pos-2];
this.rhand = [this.posX-2-2*timeStep,this.pos-2-1*timeStep];
};
stickman.prototype.lrun7 = function() {
this.frame = "lrun7";
this.head = [this.posX - 14 - 1*timeStep,this.pos-15];
this.neck = [this.posX - 13,this.pos-9];
this.torso = [this.posX - 11,this.pos-7];
this.waist = [this.posX - 8 - 2*timeStep,this.pos-1];
this.rknee = [this.posX - 7,this.pos+5];
this.lknee = [this.posX - 12 - 2*timeStep,this.pos+5];
this.rfoot = [this.posX,this.pos+8-3*timeStep];
this.lfoot = [this.posX - 13 - 3*timeStep,this.pos+10];
this.lhand = [-14+this.posX - 4*timeStep,this.pos-2];
this.rhand = [-4+this.posX + 1*timeStep,this.pos-3-2*timeStep];
};
stickman.prototype.idle1 = function() {
//lerp takes the value in slot one, transforms it to value in slot two
this.head[0] = lerp(this.oldHead[0],this.com,timeStep);
this.neck[0] = lerp(this.oldNeck[0],this.com,timeStep);
this.torso[0] = lerp(this.oldTorso[0],this.com,timeStep);
this.waist[0] = lerp(this.oldWaist[0],this.com,timeStep);

this.head[1] = lerp(this.oldHead[1],this.pos-13, timeStep);
this.neck[1] = lerp(this.oldNeck[1],this.pos-7, timeStep);
this.torso[1] = lerp(this.oldTorso[1],this.pos-5, timeStep);
this.waist[1] = lerp(this.oldWaist[1],this.pos+1, timeStep);
this.rknee[1] = lerp(this.oldRknee[1],this.pos+7, timeStep);
this.lknee[1] = lerp(this.oldLknee[1],this.pos+7, timeStep);
this.rfoot[1] = lerp(this.oldRfoot[1],this.pos+12, timeStep);
this.lfoot[1] = lerp(this.oldLfoot[1],this.pos+12, timeStep);
this.lhand[1] = lerp(this.oldLhand[1],this.pos+1, timeStep);
this.rhand[1] = lerp(this.oldRhand[1],this.pos+2, timeStep);

if(this.frame === "run1" || this.frame === "run2" || this.frame === "run3"){
//Switch the chirality for these frames
this.rknee[0] = lerp(this.oldRknee[0],this.com+3,timeStep);
this.lknee[0] = lerp(this.oldLknee[0],this.com-3,timeStep);
this.rfoot[0] = lerp(this.oldRfoot[0],this.com+5,timeStep);
this.lfoot[0] = lerp(this.oldLfoot[0],this.com-5,timeStep);
this.lhand[0] = lerp(this.oldLhand[0],this.com-4,timeStep);
this.rhand[0] = lerp(this.oldRhand[0],this.com+4,timeStep);
}
else{
this.rknee[0] = lerp(this.oldRknee[0],this.com-3,timeStep);
this.lknee[0] = lerp(this.oldLknee[0],this.com+3,timeStep);
this.rfoot[0] = lerp(this.oldRfoot[0],this.com-5,timeStep);
this.lfoot[0] = lerp(this.oldLfoot[0],this.com+5,timeStep);
this.lhand[0] = lerp(this.oldLhand[0],this.com+4,timeStep);
this.rhand[0] = lerp(this.oldRhand[0],this.com-4,timeStep);
}
};
stickman.prototype.idle2 = function() { //For when running begins
this.head[0] = lerp(this.com,this.posX+1+3,timeStep);
this.neck[0] = lerp(this.com,this.posX-1+3,timeStep);
this.torso[0] = lerp(this.com,this.posX-3+3,timeStep);
this.waist[0] = lerp(this.com,this.posX-5+4,timeStep);
this.head[1] = lerp(this.pos-13,this.pos-14+1, timeStep);
this.neck[1] = lerp(this.pos-7,this.pos-8-2, timeStep);
this.torso[1] = lerp(this.pos-5,this.pos-5-2, timeStep);
this.waist[1] = lerp(this.pos+1,this.pos+1-2, timeStep);

this.rknee[0] = lerp(this.com-3,this.posX-8+9,timeStep);
this.lknee[0] = lerp(this.com+3,this.posX+1,timeStep);
this.rfoot[0] = lerp(this.com-5,this.posX-14+8,timeStep);
this.lfoot[0] = lerp(this.com+5,this.posX-2,timeStep);
this.lhand[0] = lerp(this.com+4,this.posX-10+12,timeStep);
this.rhand[0] = lerp(this.com-4,this.posX+1-4,timeStep);
this.rknee[1] = lerp(this.pos+7,this.pos+6-2, timeStep);
this.lknee[1] = lerp(this.pos+7,this.pos+7-1, timeStep);
this.rfoot[1] = lerp(this.pos+12,this.pos+7, timeStep);
this.lfoot[1] = lerp(this.pos+12,this.pos+12, timeStep);
this.lhand[1] = lerp(this.pos+1,this.pos-3+1, timeStep);
this.rhand[1] = lerp(this.pos+2,this.pos-1, timeStep);

};
stickman.prototype.lidle1 = function() {
//lerp takes the value in slot one, transforms it to value in slot two
this.head[0] = lerp(this.oldHead[0],this.com,timeStep);
this.neck[0] = lerp(this.oldNeck[0],this.com,timeStep);
this.torso[0] = lerp(this.oldTorso[0],this.com,timeStep);
this.waist[0] = lerp(this.oldWaist[0],this.com,timeStep);

this.head[1] = lerp(this.oldHead[1],this.pos-13, timeStep);
this.neck[1] = lerp(this.oldNeck[1],this.pos-7, timeStep);
this.torso[1] = lerp(this.oldTorso[1],this.pos-5, timeStep);
this.waist[1] = lerp(this.oldWaist[1],this.pos+1, timeStep);
this.rknee[1] = lerp(this.oldRknee[1],this.pos+7, timeStep);
this.lknee[1] = lerp(this.oldLknee[1],this.pos+7, timeStep);
this.rfoot[1] = lerp(this.oldRfoot[1],this.pos+12, timeStep);
this.lfoot[1] = lerp(this.oldLfoot[1],this.pos+12, timeStep);
this.lhand[1] = lerp(this.oldLhand[1],this.pos+1, timeStep);
this.rhand[1] = lerp(this.oldRhand[1],this.pos+2, timeStep);

if(this.frame === "lrun1" || this.frame === "lrun2" || this.frame === "lrun3"){
//Switch the chirality for these frames
this.rknee[0] = lerp(this.oldRknee[0],this.com-3,timeStep);
this.lknee[0] = lerp(this.oldLknee[0],this.com+3,timeStep);
this.rfoot[0] = lerp(this.oldRfoot[0],this.com-5,timeStep);
this.lfoot[0] = lerp(this.oldLfoot[0],this.com+5,timeStep);
this.lhand[0] = lerp(this.oldLhand[0],this.com+4,timeStep);
this.rhand[0] = lerp(this.oldRhand[0],this.com-4,timeStep);
}
else{
this.rknee[0] = lerp(this.oldRknee[0],this.com+3,timeStep);
this.lknee[0] = lerp(this.oldLknee[0],this.com-3,timeStep);
this.rfoot[0] = lerp(this.oldRfoot[0],this.com+5,timeStep);
this.lfoot[0] = lerp(this.oldLfoot[0],this.com-5,timeStep);
this.lhand[0] = lerp(this.oldLhand[0],this.com-4,timeStep);
this.rhand[0] = lerp(this.oldRhand[0],this.com+4,timeStep);
}
};
stickman.prototype.lidle2 = function() { //For when running begins
this.head[0] = lerp(this.com,this.posX-1-3,timeStep);
this.neck[0] = lerp(this.com,this.posX+1-3,timeStep);
this.torso[0] = lerp(this.com,this.posX+3-3,timeStep);
this.waist[0] = lerp(this.com,this.posX+1,timeStep);
this.head[1] = lerp(this.pos-13,this.pos-13, timeStep);
this.neck[1] = lerp(this.pos-7,this.pos-10, timeStep);
this.torso[1] = lerp(this.pos-5,this.pos-7, timeStep);
this.waist[1] = lerp(this.pos+1,this.pos-1, timeStep);

this.rknee[0] = lerp(this.com-3,this.posX-1,timeStep);
this.lknee[0] = lerp(this.com+3,this.posX-1,timeStep);
this.rfoot[0] = lerp(this.com-5,this.posX+6,timeStep);
this.lfoot[0] = lerp(this.com+5,this.posX+2,timeStep);
this.lhand[0] = lerp(this.com+4,this.posX-2,timeStep);
this.rhand[0] = lerp(this.com-4,this.posX+3,timeStep);
this.rknee[1] = lerp(this.pos+7,this.pos+6-2, timeStep);
this.lknee[1] = lerp(this.pos+7,this.pos+7-1, timeStep);
this.rfoot[1] = lerp(this.pos+12,this.pos+7, timeStep);
this.lfoot[1] = lerp(this.pos+12,this.pos+12, timeStep);
this.lhand[1] = lerp(this.pos+1,this.pos-3+1, timeStep);
this.rhand[1] = lerp(this.pos+2,this.pos-1, timeStep);

};
    var bob = new stickman();
    var hobo = new stickman();

}

//**TIMER**//
//A timer is a class that holds a number corresponding to the maximum time, which it counts up or down based on functions
{
var timer = function(maxTime){
    this.maxTime = maxTime;
    this.curTime = 0;
};
timer.prototype.increaseTime = function(){
    if(this.curTime < this.maxTime){
        this.curTime++;
    }
};
timer.prototype.decreaseTime = function(){
    if(this.curTime > 0){
        this.curTime--;
    }
};
}

//**INTERACTIONS**//
//The goal of the interaction class is to hold a coded series of text that displays text based information and can macro other functions
{

var interaction = function(messages,options){
    this.x = 20;
    this.y = 40;
    this.state = 0;
    this.width = 360;
    this.height = 95;
    this.t = 1;
    this.messages = ["Hey, some mail!"];
    this.message = 1;
    this.options = [["Dear Mr. Pinkerton, thank you \nfor your recent move-in!\nHere is your key."]];                  
    this.states = [0,0];
    this.timer = new timer(5);
    this.lock = true;
};
interaction.prototype.draw = function(){
    if(this.state !== 0){
        this.timer.increaseTime();
        if(!keyPressed){
            this.lock = false;
        }
    }
    if(this.state === 0){
       this.timer.decreaseTime();
    }
    this.t = this.timer.curTime/this.timer.maxTime;
    if(this.t === 0){
        this.lock = true;
        
    }
    if(this.state === 0 && this.t === 0){
        this.message = 1;
    }
    if(this.t !== 0){
        transparency = this.t;
        pushMatrix();
        translate(0,-(this.t)*10);
        //Draw face
        strokeWeight(2);
        fill(255,255,255,100*this.t);
        rect(this.x,this.y,95,95);
        translate(0,this.y-20);
        drawBanker(67,55);
        translate(0,20-this.y);
        //Draw box
        fill(171, 171, 171,100*this.t);
        rect(this.x+95,this.y,this.width-95,this.height);
        //Draw message
        fill(255, 255, 255, 255*this.t);
        textSize(20);
        textFont(createFont("Arial"));
        text(this.messages[this.message-1],this.x + 105,this.y + 25);
        //Draw options
        textSize(17);
        text(this.options[this.message -1][0],this.x + 105,this.y + 50);
        text(this.options[this.message -1][1],this.x + 105,this.y + 85);
        popMatrix();
        //Change state to 0 if closed - MUST GO LAST
        
    }
};
}

//**DOORS**//
//The goal of the doors class is to hold a position and image for a interactable object
{
var door = function(){
    this.timer = new timer(5);
    this.color = color(74, 35, 7);
    this.interaction = new interaction();
    this.width = 25;
    this.height = 35;
    this.pos = {
        x: 150,
        y: ground-this.height
    };
    this.show = true;
    this.messages = [];
    this.options = [];
    this.hold = true;
};
door.prototype.draw = function() {
    //Draw door
    if(this.show){
        strokeWeight(2);
        fill(0,0,0);
        rect(this.pos.x,this.pos.y,this.width,this.height);
        fill(this.color);
        rect(this.pos.x,this.pos.y,this.width-this.timer.curTime,this.height);
        strokeWeight(3);
        //Draw doorknob
        point(this.pos.x + this.width*3/4-this.timer.curTime*2/3,this.pos.y+this.height/2);
    }
        strokeWeight(2);
        //Exclamation Point
        fill(255, 255, 255,this.timer.curTime*255/5);
        stroke(0,0,0,this.timer.curTime*255/5);
        strokeWeight(2);
        rect(this.pos.x+this.width/2-2,this.pos.y-6-this.timer.curTime,4,4);
        rect(this.pos.x+this.width/2-2,this.pos.y-16-this.timer.curTime,4,10);
        stroke(0, 0, 0);
    
    //Activate with proximity to Bob
    if(bobX > this.pos.x && bobX < this.pos.x + this.width)
    {
        //Press down to enter interaction state 1
        if(this.interaction.state !== 0){
            shop = "open";
        }
        if(this.interaction.state === 0){
            shop = "closed";
            if(mousePressed && this.hold === false && mouseX>this.pos.x-5&&mouseX<this.pos.x+5+this.width&&mouseY>this.pos.y-15&&mouseY<this.pos.y+this.height+10){
                this.interaction.state = 1;
                this.hold = true;
            }
        }
        if(this.interaction.state === 1 && !mousePressed){
               this.interaction.state = 2;
        }
        if(this.interaction.state === 2){
            if((mousePressed && this.hold === false)){
                this.hold = true;
                if(this.interaction.message < this.interaction.options.length){
                    this.interaction.message ++;
                }
                else{
                this.interaction.state = 0;
                }
            }
        }
        if(!mousePressed){
            this.hold = false;
        }
        //Change timer for Exclamation point
        if(this.interaction.state === 0)
        {
            this.timer.increaseTime();
        }
        
    }
        
    //If far away then decrease timers and set interaction state to 0
    else{
        this.timer.decreaseTime();
        this.interaction.state = 0;
    }
    if(this.interaction.state !== 0){
        
    }
};
}
    var mailbox = new door();
    mailbox.show = false;
    mailbox.pos.x = 23;
    
    mailbox.width = 12;
    mailbox.height = 23;
    mailbox.pos.y = ground - mailbox.height;
    mailbox.interaction.messages = ["Let's see what we got.","Oh it's a key"];
    mailbox.interaction.options = [[],[]];
    var aptDoor = new door();
    aptDoor.pos.x = 100;
    aptDoor.pos.y = 326;
    aptDoor.width = 20;
    aptDoor.height = 30;
    aptDoor.color = color(74, 35, 7);
    var hoboDoor = new door();
    hoboDoor.pos.x = 205;
    hoboDoor.width = 30;
    hoboDoor.height = 30;
    hoboDoor.show = false;
    
    hoboDoor.interaction.messages=["Want to know something?","Ah, nevermind."];
    hoboDoor.interaction.options=[[],[]];
    
    var liquorDoor = new door();
    liquorDoor.pos.x = 266;
    liquorDoor.pos.y -= 12;
    liquorDoor.height += 6;
    liquorDoor.width += 4;
    liquorDoor.show = false;


//**DRAW**//
cursor(ARROW);
draw = function() {
    //**DRAW ENVIRONMENT**//
    {
    pushMatrix();
    drawBackground();
    //CLOUDS
    simulateClouds();
    //STARS
    drawStar(100,10,0,1000);
    drawStar(100,10,0.1,900);
    drawStar(50,160,0.2,1000);
    drawStar(50,160,0.3,900);
    drawStar(350,40,0.4,1000);
    drawStar(350,40,0.5,900);
    drawStar(20,100,0.6,1000);
    drawStar(300,20,0.7,900);
    drawStar(55,7,0.8,1000);
    drawStar(240,100,0.9,900);
    drawStar(48,51,1,1000);
    drawStar(307,78,1.1,900);
    drawStar(140,55,1.2,1000);
    drawStar(207,12,1.3,900);
    drawStar(390,88,1.4,1000);
    //Skyline
    drawSkyline();
    //Sidewalk
    strokeWeight(1);
    fill(179, 179, 179);
    rect(-1,363,401,36);
    //Ground line
    strokeWeight(2);
    stroke(0,0,0);
    line(-10,ground,410,ground);
    }
    //**ITEMS**//
    if(aptKey){
        pushMatrix();
        translate(0,30);
        fill(238, 255, 0);
        beginShape();
        vertex(25,355);
        vertex(25,360);
        vertex(15,360);
        vertex(15,345);
        vertex(25,345);
        vertex(25,350);
        vertex(50,350);
        vertex(50,360);
        vertex(45,360);
        vertex(45,355);
        vertex(43,355);
        vertex(43,360);
        vertex(39,360);
        vertex(39,355);
        vertex(25,355);
        endShape();
        line(20,350,20,355);
        popMatrix();
    }
    //**FIRST SCREEN WITH APT AND LIQUOR STORE
    if(screen === 2)
    {   
        //Apartment
        pushMatrix();
        translate(-90,200);
        drawApartment();
        popMatrix();
        drawMailbox(mailbox);
        //"Supermarket" and hobo
        pushMatrix();
        translate(80,200);
        drawSupermarket();
        hobo.head = [140,141];
        hobo.neck = [hobo.head[0],hobo.head[1]+5];
        hobo.torso = [hobo.neck[0],hobo.neck[1]+5];
        hobo.waist = [hobo.neck[0],hobo.neck[1]+10];
        hobo.rknee = [hobo.waist[0]+5,hobo.waist[1]+-2];
        hobo.lknee = [hobo.waist[0]-5,hobo.waist[1]-5];
        hobo.rfoot = [hobo.rknee[0]+2,hobo.rknee[1]+5];
        hobo.lfoot = [hobo.lknee[0]-2,hobo.lknee[1]+5];
        hobo.lhand = [hobo.torso[0]-7,hobo.torso[1]];
        hobo.rhand = [hobo.torso[0]+7,hobo.torso[1]+2];
        hobo.draw();
        
        popMatrix();
        //draw doors
        aptDoor.draw();
        hoboDoor.draw();
        liquorDoor.draw();
        mailbox.draw();
        //draw mailbox
        
        
        //Draw bob
        pushMatrix();
        translate(0,200);
        bob.draw();
        bobX = bob.waist[0];
        popMatrix();
        
        
        //draw interactions
        fill(0,0,0,transparency*140);
        noStroke();
        rect(0,0,400,600);
        stroke(0,0,0);
        mailbox.interaction.draw();
        hoboDoor.interaction.draw();
        liquorDoor.interaction.draw();
        aptDoor.interaction.draw();
        
        
    }
    //**SECOND SCREEN WITH SCHOOL AND GARDEN
    if(screen === 3)
    {
        //BANK
        bank.pos.x = 100;
        bank.width = 180;
        bank.draw();
        //Bank Door
        mailbox.pos.x = 180;
        mailbox.draw();
        
        pushMatrix();
        translate(-243,203);
        drawStreetlight();
        popMatrix();
        pushMatrix();
        translate(0,203);
        drawStreetlight();
        popMatrix();
    }
    //**UPDATE BOB**//
    {
    if(run)
    {   
        //Increase time
        time++;
        if(time >= 7*s){
            bob.posX+=21; //??????
            time = 0;
        }
        if(bob.posX > 400){
            bob.posX = 0;
            screen ++;
        }
        if(time < 7*s){
            timeStep = time/(7*s);
            bob.run7();
        }
        if(time < 6*s){
            timeStep = time/(6*s);
            bob.run6();
        }
        if(time < 5*s){
            timeStep = time/(5*s);
            bob.run5();
        }
        if(time < 4*s){
            timeStep = time/(4*s);
        bob.run4();
        }
        if(time < 3*s){
            timeStep = time/(3*s);
        bob.run3();
        }
        if(time < 2*s){
        timeStep = time/(2*s);     
        bob.run2();
        }
        if(time < 1*s){
        timeStep = time/(1*s);    
        bob.run1();
        }
    }
    if(lrun)
    {   
        //Increase time
        time++;
        if(time >= 7*s){
            bob.posX-=21; //??????
            time = 0;
        }
        if(bob.posX < 0){
            bob.posX = 400;
            screen --;
        }
        if(time < 7*s){
            timeStep = time/(7*s);
            bob.lrun7();
        }
        if(time < 6*s){
            timeStep = time/(6*s);
            bob.lrun6();
        }
        if(time < 5*s){
            timeStep = time/(5*s);
            bob.lrun5();
        }
        if(time < 4*s){
            timeStep = time/(4*s);
        bob.lrun4();
        }
        if(time < 3*s){
            timeStep = time/(3*s);
        bob.lrun3();
        }
        if(time < 2*s){
        timeStep = time/(2*s);     
        bob.lrun2();
        }
        if(time < 1*s){
        timeStep = time/(1*s);    
        bob.lrun1();
        }
    }
    //Set bob to idle animation
    if(!keyPressed && lrun === false && (!mousePressed||mouseX<bobX+5)){
        if(run === true){ //This runs just once
            run = false;
            time = 0; //Set time to 0 to count frames
            bob.recordPos();
            bob.state = "stop";
        }
        if(time < 8*s){ //Repeats (4) times 
            time++;
            timeStep = time/(8*s);
            bob.idle1();
        }
    }
    if(!keyPressed && run === false && (!mousePressed||mouseX>bobX-5)){
        if(lrun === true){ //This runs just once
            lrun = false;
            time = 0; //Set time to 0 to count frames
            bob.recordPos();
            bob.state = "stop";
        }
        if(time < 8*s){ //Repeats (4) times 
            time++;
            timeStep = time/(8*s);
            bob.lidle1();
        }
        
    }
    //Start running again when right is pressed
    if((keyCode === RIGHT && run === false && shop === "closed" && keyPressed)||(mouseX>bobX+5 && mousePressed && mouseDown && run === false && shop === "closed")){ 
        mouseDown = true;
        lrun = false;
        if(bob.state === "stop")
        {
            bob.state = "start";
            bob.posX = bob.com + 7;
            time = 0;
        }
        if(time < 2*s)
        {
            time++;
            timeStep = time/(2*s);
            bob.idle2();
        }
        else
        { //If stop frames are complete, reset time for animation 2
            time = 2*s;
            run = true;
        }
    }
    if((keyCode === LEFT && lrun === false && shop === "closed" && keyPressed)||(mouseX<bobX-5 && mousePressed && mouseDown && lrun === false && shop === "closed")){ 
        run = false;
        if(bob.state === "stop")
        {
            
            bob.state = "start";
            bob.posX = bob.com - 7;
            time = 0;
        }
        if(time < 2*s)
        {
            time++;
            timeStep = time/(2*s);
            bob.lidle2();
        }
        else
        { //If stop frames are complete, reset time for animation 2
            time = 2*s;
            lrun = true;
        }
    }
    }   
    //**CLICK AND CONFIRM**//
    {
    
    
    //Set click to false at the end of each frame
    click = false;
    //Set confirm to false at the end of each frame
    confirm = false;
    }
    
    fill(0, 0, 0);
    noStroke();
    
        text("mailbox.interaction.state: "+mailbox.interaction.state,5,415);
        text("mailbox.interaction.message: "+mailbox.interaction.message,5,435);
        text("mailbox.hold: " + mailbox.hold,5,455);
        text("shop: "+shop,5,475);
};

//**MOUSE CLICKED**//
void mouseClicked(){
    click = true;
};

void mouseReleased(){
    mouseDown = true;
};

//**KEY TYPED**//
void keyTyped(){
    if(format === "default"){
        textMsg.push(key);  
    }
    if(format === "usd"){
        if(key >= 48 && key <= 57){
            textMsg.unshift(key-48);
        }
        if(key <= 8 && textMsg.length >= 1){
            textMsg.splice(0,1);
        }
        amt = 0;
        for(var i = 0; i < textMsg.length; i++){
            amt += pow(10,i)*textMsg[i];   
        }
    }
    if(Math.floor(key) === 10){
        confirm = true;    
    }
};

