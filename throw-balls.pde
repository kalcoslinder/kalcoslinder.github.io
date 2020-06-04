void setup() {
		  size(400, 400);
		}
var camHeight = 165;
var camDist = 100;
var radius = 20;
var mBallHeight = radius + 107;
var debugMenu = false;
var speedX,speedZ;
var speedY = 0;
var mousePos = [];
var speedMultiplier = 0.1;
var bounceMultiplier = 1;
var launch = false;
var HitBoxZ = 1000;
var HitBoxR = 10;
var HitBoxFill = color(0,0,0);
var randColor = color(random(0,2)*255,random(0,2)*255,random(0,2)*255);
var Balls = [];
 
var keyPressed = function() {
    if(keyCode === 32)
    {
        if(debugMenu === true){
            debugMenu = false;
        }
        else{
            debugMenu = true; 
        }
    }
};

var Point = function(Wx,Wy,Wz)
{
    this.Wx = Wx;
    this.Wy = Wy;
    this.Wz = Wz;
    this.Sx = 0;
    this.Sy = 0;
    this.ShadowY = 0;
    this.height = 0;
    this.speedX = 0;
    this.speedY = 0;
    this.speedZ = 0;
};

Point.prototype.updatePoint = function()
{
    //Update the point's position according to its speed
    this.Wx += this.speedX;
    this.Wy += this.speedY;
    this.Wz += this.speedZ;
    
    /*Change the world coordinates to camera coordinates by shifting y pos
    Dilate the camera coordinates by the z distance and focus length
    Normalize the screen coordinates
    Put the normalized coordinates in view (raster space)*/
    this.Sx = ((this.Wx/this.Wz*camDist) + width/2);
    this.Sy = height/2-((this.Wy-camHeight)/this.Wz*camDist);
    this.ShadowY = (1-(((-camHeight/this.Wz*camDist) + height/2)/height))*height;
};

Point.prototype.drawPoint = function()
{
    stroke(0, 0, 0);
    strokeWeight(5);
    point(this.Sx,this.Sy);
    stroke(255, 0, 0);
    point(this.Sx,this.ShadowY);
    stroke(0, 0, 0);
    strokeWeight(2);
};

var drawPoint = function(Wx,Wy,Wz)
{
    stroke(0, 0, 0);
    strokeWeight(2);
    var Sx = ((Wx/Wz*camDist) + width/2);
    var Sy = height/2-((Wy-camHeight)/Wz*camDist);
    point(Sx,Sy);
};

var Ball = function(x,y,z,r,color) {
    this.tossed = false;
    this.center = new Point(x,r+y,z);
    this.Wr = r;
    this.Sr = 0;
    this.height = 1;
    this.scale = 1;
    this.color = color;
    this.accelerationY = -1;
    this.bounce = 0;
};

Ball.prototype.updateBall = function() {
    this.center.speedY += this.accelerationY;
    
    this.center.updatePoint();
    this.Sr = this.Wr*camDist/this.center.Wz;
    this.height = this.center.Wy-this.Wr;
    this.scale = 0.9/(this.height/300+1);
    
};

Ball.prototype.checkBall = function() {
    if(this.bounce < 10){
        if(this.height < 0){
            this.center.Wy = this.Wr;
            this.center.speedY *= -bounceMultiplier;
            this.bounce++;
        }
        else{
            this.bounce = 0;
        }
    }
    else{
        this.center.Wy = this.Wr;
        this.center.speedY = 0;
        this.accelerationY = 0;
    }
    if(this.center.Wz > 10000){
        this.center.Wz = 10000;
        this.center.speedX = 0;
        this.center.speedY = 0;
        this.center.speedZ = 0;
    }
};

Ball.prototype.drawBall = function() {
    //Draw Shadow
    strokeWeight(2);
    fill(0, 0, 0);
    ellipse(this.center.Sx,this.center.ShadowY,2*this.Sr*this.scale,this.Sr*this.scale);
    stroke(0, 0, 0);
    
    //Draw Ball
    strokeWeight(3);
    fill(this.color);
    ellipse(this.center.Sx,this.center.Sy,this.Sr*2,this.Sr*2);
};

var Hole = function(Wx,Wy,Wz,Wr){
    this.Wx = Wx;
    this.Wy = Wy;
    this.Wz = Wz;
    this.Wr = Wr;
    this.Sr = Wr/Wz*camDist;
    this.center = new Point(Wx,Wy,Wz);
    this.center.updatePoint();
};

Hole.prototype.drawHole = function(){
    fill(0, 0, 0);
    ellipse(this.center.Sx,this.center.Sy,this.Sr*2,this.Sr);
};

var Goal = function(Wx,Wy,Wz,Wr){
    this.Wx = Wx;
    this.Wy = Wy;
    this.Wz = Wz;
    this.Wr = Wr;
    this.Sr = Wr/Wz*camDist;
    this.center = new Point(Wx,Wy,Wz);
    this.center.updatePoint();
};

Goal.prototype.drawGoal = function(){
    stroke(0, 0, 0);
    fill(255, 255, 255);
    rect(this.center.Sx,this.center.Sy,this.Sr*2,this.Sr);
};

/*****************************************************************HIT BOX*/
//HitBox
var HitBoxCenter = new Point(0,160,HitBoxZ);
var drawHitBox = function(){
    HitBoxCenter.updatePoint();
    HitBoxCenter.drawPoint();
    fill(HitBoxFill);
    ellipse(HitBoxCenter.Sx,HitBoxCenter.Sy,HitBoxR*2,HitBoxR*2);
    
};
var checkHitBox = function(x,y,z)
{
    if(z < HitBoxZ +20 && z > HitBoxZ - 20 && sq(x - HitBoxCenter.Sx) + sq(y - HitBoxCenter.Sy) < sq(HitBoxR))
    {
    HitBoxFill = color(255, 0, 0,255);
        return true;
    }
    else
    {
        HitBoxFill = color(0, 0, 0, 0);
        return false;
    }
};

//Create new objects
var mBallx = 0;
var mBally = 0;
var mBallz = 0;
Balls.push(new Ball(mBallx,mBally,mBallz,radius,randColor));
var hole = new Hole(22,0,211,100);
var goal = new Goal(22,0,211,100);

/***************************************************************DRAW FUNCTION*/
draw = function() {
    //Draws the background
    strokeWeight(2);
    background(58, 104, 252);
    fill(135, 181, 75);
    rect(-1,200,402,202);
    
    //Draws the hole
    //hole.drawHole();
    
    
    
    
    //Draws hit box
    Balls.forEach(function(element){
        if( checkHitBox(element.center.Sx,element.center.Sy,element.center.Wz) ) {
            element.center.speedZ *= -1; 
        }
    
    });
    
    
    
    //Draws the mouse ball
    if(mouseIsPressed){
        launch = true;
    
        mBallz = 2*camDist*(mBallHeight - camHeight)/(height-2*mouseY);
        mBally = mBallHeight - radius;
        mBallx = (mouseX-width/2)*mBallz/camDist;
        
        Balls[Balls.length-1]=new Ball(mBallx,mBally,mBallz,radius,randColor);
        //Create an array that holds the last _ positions of the mouse
        mousePos.push([mouseX,mouseY]);    
        if(mousePos.length > 10) {
            mousePos.splice(0, 1);    
        } 
    }
    //When mouse is released sets the speed of the ball
    else{
         //Set the initial velocities
        if(launch)
        {
           
            Balls[Balls.length-1].center.speedX = speedX;
            Balls[Balls.length-1].center.speedZ = speedZ;
            Balls[Balls.length-1].center.speedY = speedY;
            
            launch = false;
        }
        
    }
    
    Balls.forEach(function(element){
        element.updateBall();
        element.checkBall();
        element.drawBall();
    });
};







void mouseReleased() {
    speedX = speedMultiplier*(mousePos[mousePos.length-1][0] - mousePos[0][0]);
    speedZ = speedMultiplier*(-1*mousePos[mousePos.length-1][1] + mousePos[0][1]);
    var Wzi = camHeight*camDist/(mousePos[0][1]-height/2);
    var Wzf = camHeight*camDist/(mousePos[mousePos.length-1][1]-height/2);
    speedZ = speedMultiplier*(Wzf - Wzi);
    var Wxi = (mousePos[0][0]-width/2)*Wzi/camDist;
    var Wxf = (mousePos[mousePos.length-1][0]-width/2)*Wzf/camDist;
    speedX = speedMultiplier*(Wxf - Wxi);
    mousePos.length = 0;
      
}; 

void mouseOut() {
    mousePos.length = 0; 
}; 

void mousePressed() {
    randColor = color(random(0,2)*255,random(0,2)*255,random(0,2)*255);
   
    mousePos.length = 0;
    Balls.push(new Ball(mBallx,mBally,mBallz,radius,randColor));
};
