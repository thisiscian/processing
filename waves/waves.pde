class Point {
  float x,y;
  Point(float xIn, float yIn) {
    x=xIn;
    y=yIn;
  }
}

class Wave {
  Point start, stop, controlStart, controlStop;
  int col;
  int t;
  Wave (Point startIn, Point stopIn, Point controlStartIn, Point controlStopIn, int tIn, int colIn) {
    start=startIn;
    stop=stopIn;
    controlStart=controlStartIn;
    controlStop=controlStopIn;
    t=tIn;
    col=colIn;
  }
  void update() {
    t++;
    controlStart.y=800*sin(PI/50*t)+200;
    controlStop.y=-800*sin(PI/50*t)+200;
  }
  void draw() {
    stroke(255);
    fill(col,col,155);
    beginShape();
    curveVertex(controlStart.x,controlStart.y);
    curveVertex(start.x,start.y);
    curveVertex(stop.x,stop.y);
    curveVertex(controlStop.x,controlStop.y);
    vertex(400,400);
    vertex(0,400);
    endShape();
  }
}

class Boat {
  Point pos;
  int t=-10;
  Boat (Point posIn) {
    pos=posIn;
  }
  void update() {
    t++;
  }
  void draw() {
    stroke(255);
    fill(255);
    arc(pos.x, pos.y, 30, 30, -PI/8+PI/8*sin(PI/50*t), PI+PI/8+PI/8*sin(PI/50*t), CHORD);
    line(pos.x,pos.y, 30*cos(-PI/2+PI/8*sin(PI/50*t))+pos.x, 30*sin(-PI/2+PI/8*sin(PI/50*t))+pos.y);
    triangle(
      30*cos(-0.95*PI/2+PI/8*sin(PI/50*t))+pos.x, 30*sin(-0.95*PI/2+PI/8*sin(PI/50*t))+pos.y,
      15*cos(-0.88*PI/2+PI/8*sin(PI/50*t))+pos.x, 15*sin(-0.88*PI/2+PI/8*sin(PI/50*t))+pos.y,
      20*cos(-PI/4+PI/8*sin(PI/50*t))+pos.x, 20*sin(-PI/4+PI/8*sin(PI/50*t))+pos.y
    );
    triangle(
      30*cos(-1.05*PI/2+PI/8*sin(PI/50*t))+pos.x, 30*sin(-1.05*PI/2+PI/8*sin(PI/50*t))+pos.y,
      15*cos(-1.12*PI/2+PI/8*sin(PI/50*t))+pos.x, 15*sin(-1.12*PI/2+PI/8*sin(PI/50*t))+pos.y,
      20*cos(-3*PI/4+PI/8*sin(PI/50*t))+pos.x, 20*sin(-3*PI/4+PI/8*sin(PI/50*t))+pos.y
    );
  }
}

class Cloud {
  Point[] c = new Point[1600]; 
  int[] s= new int[1600];
  int[] C= new int[1600];
  int[] t=new int[1600];
  int T=0;
  
  Cloud() {
    for(int i=0; i<1600; i++) {
      c[i]=new Point(i/4+randomGaussian()*10,randomGaussian()*10);
      s[i]=floor(randomGaussian()*15)+15;
        C[i]=47+i%6;
        t[i]=floor(random(100));
      }
    }
    void update() {
      T++;
    }
    void draw() {
      noStroke();
      for(int i=0;i<1600; i++) {
        fill(C[i],C[i],C[i]);
        arc(c[i].x,c[i].y+15*sin((t[i]+T)*PI/50),s[i],s[i],0*PI,2*PI);
    } 
  }
}

Cloud cloud = new Cloud();

Wave wave1 = new Wave(new Point(-100,185), new Point(500,185), new Point(0,185), new Point(400,185), -30, 80);
Wave wave2 = new Wave(new Point(-100,190), new Point(500,190), new Point(0,190), new Point(400,190), -15, 60);
Wave wave3 = new Wave(new Point(-100,200), new Point(500,200), new Point(0,200), new Point(400,200), 0, 40);
Wave wave4 = new Wave(new Point(-100,220), new Point(500,220), new Point(0,220), new Point(400,220), 15, 20);
Wave wave5 = new Wave(new Point(-100,240), new Point(500,240), new Point(0,240), new Point(400,240), 30, 0);

Boat boat=new Boat(new Point(200,200));

void setup() {
  size(400, 400);
  background(100,100,105);
  smooth();
}

int iteration=0;

void draw() {
  iteration++;
  if(iteration>100) {
    exit();
  }
  clear();
  background(60,60,65);
  wave1.update();
  wave2.update();
  wave3.update();
  wave4.update();
  wave5.update();
  cloud.update();
  boat.update();
  wave1.draw(); 
  wave2.draw(); 
  boat.draw();
  wave3.draw(); 
  wave4.draw(); 
  wave5.draw(); 
  cloud.draw();
  saveFrame("output-####.png");
}

