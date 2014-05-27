int iteration=0;
int period=50;
int size=400;
int items=7;

void setup() {
  size(size, size);
  background(50,0,0);
}

class Spade {
  void draw(int t) {
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

void draw() {
  iteration++;
  if(iteration==period) {
    exit();
  }
  clear();
  background(50,0,0);
  spade.draw(iteration);
  saveFrame("output-###.png");
}

