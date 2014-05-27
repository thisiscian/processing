import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import Machine.*; 
import gifAnimation.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class reptiles extends PApplet {




float H=sqrt(3)/2;

Machine machine;
int col=0;
int bgCol=0;
int sideLength=10;
PShape one, two, three, four;
String oneStr[]={"hey","okay"};

public void drawShape(String[] array, float x, float y, float angle) {
	translate(x,y);
	rotate(angle);
	float pos[]={0,0};
	beginShape();
	vertex(pos[0],pos[1]);
		for(int i=0; i<array.length; i++) {
			if(array[i]=="ur") {
				pos[0]+=sideLength/2; pos[1]+=sideLength*sqrt(3)/2;
			} else if (array[i] == "r") {
				pos[0]+=sideLength;
			} else if (array[i] == "dr") {
				pos[0]+=sideLength/2; pos[1]-=sideLength*sqrt(3)/2;
			} else if (array[i] == "ul") {
				pos[0]-=sideLength/2; pos[1]+=sideLength*sqrt(3)/2;
			} else if (array[i] == "l") {
				pos[0]-=sideLength;
			} else if (array[i] == "dl") {
				pos[0]-=sideLength/2; pos[1]-=sideLength*sqrt(3)/2;
			}
			vertex(pos[0],pos[1]);	
		}
	endShape(CLOSE);
	rotate(-angle);
	translate(-x, -y);
}

//PShape one = makeShape(oneStr);

public void setup() {
  println("setup phase is now");
	frameRate(120);
	smooth(8);
  strokeWeight(1);
  fill(255);
  background(0);
  machine=new Machine(this, "space", 200, 200, 50);
}

public void draw() {
  translate(machine.width/2,machine.height/2);
	drawShape(oneStr,0,0,0);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "reptiles" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
