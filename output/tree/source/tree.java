import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gifAnimation.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class tree extends PApplet {


int width=200;
int height=200;
int period=50;
int iteration=0;
int col=0;
int bgCol=0;
int growVal=1;
GifMaker gifExport = new GifMaker(this, "output/tree.gif");

class cCoord {
	float x, y;
	cCoord (float X, float Y) {
		x=X;
		y=Y;
	}
  cCoord() {
    x=0;
    y=0;
  }
}

class BezierTwo {
  cCoord anchor, LCtl, RCtl;
  BezierTwo(float ax, float ay, float dist, float angleL, float angleR) {
    anchor=new cCoord();
    LCtl=new cCoord();
    RCtl=new cCoord();
    reset(ax,ay,dist,angleL,angleR);
  }
  BezierTwo() {
    anchor=new cCoord();
    LCtl=new cCoord();
    RCtl=new cCoord();
  }
  public void reset(float ax, float ay, float dist, float angleL, float angleR) {
    anchor.x=ax; anchor.y=ay;
    LCtl.x=ax+dist*cos(angleL); LCtl.y=ay+dist*sin(angleL);
    RCtl.x=ax+dist*cos(angleR); RCtl.y=ay+dist*sin(angleR);
  }
}

class Leaf {
  BezierTwo base=new BezierTwo(), tip=new BezierTwo();
  float baseRatio=0.2f, tipRatio=-0.4f;
  float baseAngle=PI/8, tipAngle=-PI/16;
  Leaf(float x, float y, float s, float r) {
    calculate(x,y,s,r); 
  }
  public void calculate(float x, float y, float s, float r) {
    base.reset(x,y, s*baseRatio, r-baseAngle, r+baseAngle); 
    tip.reset(x+s*cos(r),y+s*sin(r), s*tipRatio, r-tipAngle, r+tipAngle); 
  }
  public void draw() {
    noStroke();
    fill(109,179,63);
    beginShape();
      vertex(base.anchor.x, base.anchor.y);
      bezierVertex(
        base.LCtl.x, base.LCtl.y,
        tip.LCtl.x, tip.LCtl.y,
        tip.anchor.x, tip.anchor.y
      );
      bezierVertex(
        tip.RCtl.x, tip.RCtl.y,
        base.RCtl.x, base.RCtl.y,
        base.anchor.x,base.anchor.y
      );
    endShape(); 
  }
}

class Tree {
  float maxSize, maxWidth, size=0, width=0;
  float r,g,b,grav;
  cCoord base;
  Tree(float x, float y, float mS, float mW, float curvature, float R, float G, float B, float Grav) {
    base=new cCoord(x,y);
    r=R; g=G; b=B;
    grav=Grav;
    maxSize=mS;
    maxWidth=mW;
  }
  public void grow() {
    size+=growVal*maxSize/period;
    width+=growVal*maxWidth/period;
  }
  public void draw() {
    noFill();
    stroke(r,g,b);
    for(float i=-maxWidth/2; i<=maxWidth/2; i+=maxWidth/100) {
      beginShape();
        vertex(base.x+i*cos(grav), base.y+i*sin(grav));
        vertex(
          base.x+cos(grav)*(i+size*sin(2*(i/maxWidth)*PI))+sin(grav)*(size*cos(2*(i/maxWidth)*PI)),
          base.y+sin(grav)*(i+size*sin(2*(i/maxWidth)*PI))+cos(grav)*(size*cos(2*(i/maxWidth)*PI))
        );
      endShape();
    }
  }
}

public void setup() {
	size(width,height);
	background(bgCol);
	frameRate(120);
	gifExport.setRepeat(0);
	gifExport.setTransparent(255,0,0);
	smooth(8);
  strokeWeight(1);
}

Tree tree1 = new Tree(0,height/4, height/4, width/4, PI/8, 151, 151, 151, 0);
Tree tree2 = new Tree(-height/4,0, width/4, height/4, PI/8, 90, 90, 90, 3*PI/2);
Tree tree3 = new Tree(0,-height/4, height/4, width/4, PI/8, 151, 151, 151, 2*PI/2);
Tree tree4 = new Tree(width/4,0, width/4, height/4, PI/8, 90, 90, 90, 1*PI/2);

public void draw() {
	iteration++;
  clear();
  translate(width/2,height/2);
  rotate(PI*iteration/(1.25f*period));
  fill(100);
  rect(0-width/9,0-height/9,2*width/9,2*height/9,width/100); 
  triangle(
    0-width/36,0-4*height/17,
    0+width/36,0-4*height/17,
    0, 0-height/5
  );
  triangle(
    0-width/36,0+4*height/17,
    0+width/36,0+4*height/17,
    0, 0+height/5
  );
  triangle(
    0+4*width/17,0-height/36,
    0+4*width/17,0+height/36,
    0+width/5, 0
  );
  triangle(
    0-4*width/17,0-height/36,
    0-4*width/17,0+height/36,
    0-width/5, 0
  );
  tree1.grow(); tree1.draw();
  tree3.grow(); tree3.draw();
  tree2.grow(); tree2.draw();
  tree4.grow(); tree4.draw();
	gifExport.setDelay(1);
	gifExport.addFrame();	
  noStroke();
  if(iteration==period) {
   growVal*=-4; 
  }
	if(iteration>=1.25f*period) {
		gifExport.finish();
		exit();
	}
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "tree" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
