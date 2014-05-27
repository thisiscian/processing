import Machine.*;
import gifAnimation.*;

Machine machine;
int col=0;
int bgCol=0;
int growVal=1;

void setup() {
  println("setup phase is now");
	frameRate(120);
	smooth(8);
  strokeWeight(1);
  fill(255);
  background(0);
  machine=new Machine(this, "space", 200, 200, 50);
}

void draw() {
  translate(machine.width/2,machine.height/2);
  ellipse(randomGaussian()*machine.width/4, randomGaussian()*machine.height/4, machine.width/50, machine.height/50);
}
