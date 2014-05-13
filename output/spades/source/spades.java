import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class spades extends PApplet {

int iteration=0;
int period=50;
int size=400;
int items=7;

public void setup() {
  size(size, size);
  background(50,0,0);
}

class Spade {
  public void draw(int t) {
    noFill();
    stroke(0);
    curve(
      200,100,
      200,100,
      250,200,
      -400,200);
  }
}

Spade spade = new Spade();

public void draw() {
  iteration++;
  if(iteration==period) {
    exit();
  }
  clear();
  background(50,0,0);
  spade.draw(iteration);
  saveFrame("output-###.png");
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "spades" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
