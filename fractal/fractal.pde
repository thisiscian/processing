import Machine.*;
import gifAnimation.*;

Machine machine;
int col=0;
int bgCol=0;
int sideLength=10;
int n=0, N=1;

class Four { 
	float a,b,c,d;
	Four() {
		a=-1;b=0;c=1;d=0;
	}
	Four(float A,float B, float C, float D) {
		a=A; b=B;c=C;d=D;
	}
}

ArrayList<Four> fractal;

float dist(Four f) {
	return sqrt(sq(f.a-f.c)+sq(f.b-f.d));
}

float ang(Four f) {
	float x=f.c-f.a;
	float y=f.d-f.b;
	float r=dist(f);
	if(r==0) { return 0; }
	if(y>=0) { return acos(x/r); } 
	else { return -acos(x/r); }
}

float ang(float a, float b, float c, float d) {
	Four f=new Four(a,b,c,d);
	return ang(f);
}


void fractallise() {
	int L=fractal.size();
	for(int i=0; i<L; i++) {
		Four l=fractal.get(0);
		float length=dist(l)/3;
		float angle=ang(l);
		Four A=new Four(l.a,l.b,l.a+length*cos(angle), l.b+length*sin(angle));
		Four B=new Four(l.a+length*cos(angle), l.b+length*sin(angle), l.a+length*(cos(angle-PI/3)+cos(angle)), l.b+length*(sin(angle-PI/3)+sin(angle)));
		Four C=new Four(l.a+length*(cos(angle-PI/3)+cos(angle)), l.b+length*(sin(angle-PI/3)+sin(angle)), l.c-length*cos(angle), l.d-length*sin(angle));
		Four D=new Four(l.c-length*cos(angle), l.d-length*sin(angle), l.c,l.d);
		fractal.remove(0);
		fractal.add(A);
		fractal.add(B);
		fractal.add(C);
		fractal.add(D);
	}
}

void setup() {
  println("setup phase is now");
	frameRate(60);
	smooth(8);
  strokeWeight(1);
	stroke(255);
  fill(255);
  background(0);
  machine=new Machine(this, "fractal2", 200, 200, 50);
	fractal = new ArrayList<Four>();
	Four firstLine= new Four(-100,0,100,0);
	Four secondLine= new Four(100,0,-100,0);
	Four thirdLine= new Four(0,-100,0,100);
	Four fourthLine= new Four(0,100,0,-100);
	fractal.add(firstLine);
	fractal.add(secondLine);
	fractal.add(thirdLine);
	fractal.add(fourthLine);
}

void draw() {
	n++;
	background(0,10);
  translate(machine.width/2,machine.height/2);
	rotate(-n*PI/(N+0.2*n));
	if(n%N==0) {
		fractallise();
		N+=n+1;
	}
	for(int i=0;i<fractal.size(); i++) {
		Four tmp = fractal.get(i);
		line(tmp.a,tmp.b,tmp.c,tmp.d);
	}
}
