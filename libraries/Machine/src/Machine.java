package Machine;
import processing.core.*;

public class Machine {
  PApplet parent;

  public Machine(PApplet parent) {
    this.parent = parent;
    parent.registerMethod("dispose", this);
  }

  public void dispose() {
    this.parent.print("goodbye");
    // Anything in here will be called automatically when 
    // the parent sketch shuts down. For instance, this might
    // shut down a thread used by this library.
  }
}
