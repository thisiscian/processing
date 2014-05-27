int iteration=0;
int period=50;
int size=400;
int items=7;

class Work {
  float angle;
  int timeStart, time;
  String text;
  Work(String textIn, float angleIn, int timeIn) {
    text=textIn;
    angle=angleIn;
    timeStart=timeIn; 
  }
  void draw(int time) {
    textAlign(CENTER);
    textSize(50*cos(TWO_PI*(timeStart+time)/period)+70);
    fill(255*sin(PI+TWO_PI*(timeStart+time)/period)*sin(PI+TWO_PI*(timeStart+time)/period));
    float resize=size*sin(TWO_PI*(timeStart+time)/period)+size;
    text(
      text, 
      size/2+resize*cos(angle), 
      size/2+resize*sin(angle)
    );
  }
}

Work[] works = new Work[items];

void setup() {
  size(size, size);
  background(0,0,0);
  smooth(8);
  String[] texts={"work","sleep","worry","feed","rest","think","thirst"};
  for(int i=0; i<items; i++) {
    works[i] = new Work(texts[i],TWO_PI*i/items, period*i/items);
  }
}

void draw() {
  iteration++;
  if(iteration==period) {
    exit();
  }
  clear();
  background(0,0,0);
  for(int i=0; i<items; i++) {
    works[i].draw(iteration);
  }
  noStroke();
  for(int i=0; i<items;i++) {
    for(int j=0; j<items; j++) {
      fill(255*sin(random(PI)),0,0, 100);
      rect(1.0*i*size/items, 1.0*j*size/items, 1.0*size/items, 1.0*size/items, 10);
    }
  }
  saveFrame("output-###.png");
}

