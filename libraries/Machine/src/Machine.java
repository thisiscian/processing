package Machine;
import gifAnimation.*;
import processing.core.PApplet;
import processing.core.PConstants;

public class Machine {
  PApplet parent;
  String name="unnamed";
  public int width, height;
  public float period, progress=0, increment=1;
  GifMaker gif;

  public Machine(PApplet parent, String name, int width, int height, float period) {
    this.parent = parent;
    this.name=name;
    this.width=width;
    this.height=height; 
    this.period=period;
    this.gif=new GifMaker(this.parent, "output/"+this.name+".gif");
    this.parent.size(this.width,this.height);
    this.parent.frameRate(120);
    this.gif.setRepeat(0);
    this.gif.setTransparent(255,0,0);
    this.parent.registerMethod("post", this);
  }

  public void pre() {
    this.parent.println("hello!");
  }

  public void post() {
    this.parent.println("progress: " + this.progress + "/" + this.period);
    this.progress+=this.increment;
    this.gif.setDelay(1);
    this.gif.addFrame();	
    if(this.period<=this.progress) {
      this.parent.println("progress: " + this.progress + "/" + this.period);
      this.parent.println("finishing up gif");
      this.gif.finish();
      this.parent.exit();
    }
  }
  
  public float progress() {
    return this.progress/this.period;
  }

  public float progressAngle() {
    return (float) (2*Math.PI)*this.progress/this.period;
  }
  
}

