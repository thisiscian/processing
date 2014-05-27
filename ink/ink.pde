import gifAnimation.*;
int width=100;
int period=100;
int iteration=0;
int col=0;
GifMaker gifExport = new GifMaker(this, "output/ink.gif");

class CartesianCoord {
	float x, y;
	CartesianCoord (float X, float Y) {
		x=X;
		y=Y;
	}
}

class InkPath {
	CartesianCoord[] coords=new CartesianCoord[2];
	float distance;
	float direction;
	InkPath(CartesianCoord a, float dis, float dir) {
		distance=dis;
		direction=dir;
		coords[0]=new CartesianCoord(a.x,a.y);
		coords[1]=new CartesianCoord(a.x+dis*cos(dir),a.y+dis*sin(dir));
	}
	void grow() {
		float bend=random(TWO_PI/50)-TWO_PI/36;
		float dist=sqrt(sq(coords[1].x)+sq(coords[1].y));
		if(coords[1].x < 0 && dist > distance/2) {
			coords[1].x=0;
		}
		if(coords[1].y < 0 && dist > distance/2) {
			coords[1].y=0;
		}
		if(coords[1].x >= width && dist > distance/2) {
			coords[1].x=width-1;
		}
		if(coords[1].y >= width && dist > distance/2) {
			coords[1].y=width-1;
		}

		float xOut=coords[1].x+distance*cos(direction+bend/2);
		float yOut=coords[1].y+distance*sin(direction+bend/2);
		while(xOut >= width || xOut < 0 || yOut >= width || yOut < 0) {
			bend=random(TWO_PI);
			xOut=coords[1].x+distance*cos(direction+bend/2);
			yOut=coords[1].y+distance*sin(direction+bend/2);
		}
		coords[0].x=coords[1].x;
		coords[0].y=coords[1].y;
		coords[1].x+=distance*cos(direction);
		coords[1].y+=distance*sin(direction);
		direction+=bend/2;
	}
	void draw() {
		beginShape();
		vertex(coords[0].x, coords[0].y);
		vertex(coords[1].x, coords[1].y);
		endShape();
	}
}

class InkStain {
	ArrayList<InkPath> paths;
	CartesianCoord start;
	float area, distance;
	int colour;
	InkStain(CartesianCoord s, float a, float d, float dir, int col) {
		paths=new ArrayList<InkPath>();
		area=a;	
		start=s;
		distance=d;
		colour=col;
		paths.add(new InkPath(s, distance, dir));
	}	
	void grow() {
		for(int i=0; i<paths.size(); i++) {
			paths.get(i).grow();
		}
	}
	void draw() {
		stroke(colour);
		for(int i=0; i<paths.size(); i++) {
			paths.get(i).draw();
		}
	}
}

void setup() {
	size(width,width);
	background(255-col);
	frameRate(12);
	gifExport.setRepeat(0);
	gifExport.setTransparent(128,0,128);
	gifExport.setQuality(3);
	smooth(0);
	stroke(col);
}

float di=15;

InkStain stain1=new InkStain(new CartesianCoord(0,0), TWO_PI*100*100, di, PI/4, col);
InkStain stain2=new InkStain(new CartesianCoord(width-1,0), TWO_PI*100*100, di, 3*PI/4, col);
InkStain stain3=new InkStain(new CartesianCoord(0,width-1), TWO_PI*100*100, di, 5*PI/4, col);
InkStain stain4=new InkStain(new CartesianCoord(width-1,width-1), TWO_PI*100*100, di, 7*PI/4, col);

void draw() {
	iteration++;
	stain1.draw();
	stain2.draw();
	stain3.draw();
	stain4.draw();
	stain1.grow();
	stain2.grow();
	stain3.grow();
	stain4.grow();
	gifExport.setDelay(1);
	gifExport.addFrame();	
	float w=width*iteration/period;
	strokeWeight(random(w));	
	if(iteration>=period) {
		gifExport.finish();
		exit();
	}
}
