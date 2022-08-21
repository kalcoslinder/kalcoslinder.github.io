void setup() {
		  size(400, 400);
		}
var camHeight = 165;
var camDist = 100;
var debugMenu = false;
var speedX,speedY,speedZ = 0;
var mousePos = [];
var launch = false;
var ballDist = 100;
var ballHeight = 20;
var speedYVel = 2;
var speed = 0.1;

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
            this.center.speedY *= -0.9;
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

//Create new objects
var radius = 20;
var ball = new Ball(0,56,142,radius,color(27, 27, 191));
var cursorHeight = 110;
var mBallx = 0;
var mBally = 0;
var mBallz = 0;
var mBall = new Ball(mBallx,mBally,mBallz,radius,color(255, 0, 0));
var hole = new Hole(22,0,211,100);

draw = function() {
    //Draws the background
    strokeWeight(2);
    background(58, 104, 252);
    fill(135, 181, 75);
    rect(-1,height/2,width+2,height/2+2);

    
    //Draws the point
    if(mousePressed){
        launch = true;
        mBallz = ballDist;
        mBally = ballHeight;
        mBallx = 0;
        mBall = new Ball(mBallx,mBally,mBallz,radius,color(255, 0, 0));
        
        //Create an array that holds the last _ positions of the mouse
        mousePos.push([mouseX,mouseY]);    
        if(mousePos.length > 10) {
            mousePos.splice(0, 1);    
	    print(mousePos);
        } 
    }
    else{
        //Set the initial velocities
        if(launch)
        {
            mBall.center.speedX = speedX;
            mBall.center.speedZ = speedZ;
            mBall.center.speedY = speedY;
            launch = false;
        }
    }
    mBall.updateBall();
    mBall.checkBall();
    mBall.drawBall();
};



void mouseReleased() {
    speedX = speed*(mousePos[mousePos.length-1][0] - mousePos[0][0]);
    speedY = speedYVel*speed*(-1*mousePos[mousePos.length-1][1] + mousePos[0][1]);
    speedZ = speed*(-1*mousePos[mousePos.length-1][1] + mousePos[0][1]);
    mousePos.length = 0;
       
}; 
