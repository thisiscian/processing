package Machine;
import gifAnimation.*;
import processing.core.*;

public class Machine {
  PApplet parent;
  String name;
  int width, height;
  float period, progress=0, increment=1;
  GifMaker gifExport; = new GifMaker(this, "output/space.gif");

  public Machine(PApplet parent) {
    this.parent = parent;
    parent.registerMethod("machineSize", this);
    parent.registerMethod("machinePeriod", this);
    parent.registerMethod("machineName", this);
    parent.registerMethod("post", this);
    parent.registerMethod("pre", this);
  }

  public void machineSize(int width, int height) {
    this.width=width;
    this.height=height; 
  }
  
  public void machinePeriod(float period) {
    this.period=period;
  }

  public void machineName(String name) {
    this.name=name;
  }

  public void 

  public void pre() {
    if(progress==0) {
      this.parent.size(this.width,this.height);
      this.parent.frameRate(120);
      gifExport.setRepeat(0);
      gifExport.setTransparent(255,0,0);
    }
  }

  public void post() {
    progress+=increment;
    gifExport.setDelay(1);
    gifExport.addFrame();	
    if(period<=progress) {
      this.parent.exit();
    }
		gifExport.finish();
  }
}
