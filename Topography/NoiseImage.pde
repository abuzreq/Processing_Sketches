import miny.render.BB.*;

public class NoiseImage extends Drawable
{
  miny.render.BB.AABB bb;
  int seed, low, high;
  public NoiseImage(int seed, int low, int high) { 
    this.seed = seed;
    this.low = low; this.high = high;
    bb = new miny.render.BB.AABB(0, 0, width-1, height-1);
    randomSeed(seed);  // Will not work in a multithreaded renderer !
  }
  
  public BoundingBox getBoundingBox() { return bb; } 
  
  public color getColor(float x, float y) {
    return color(random(low, high));
  }
}

