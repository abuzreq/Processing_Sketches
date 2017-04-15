// Particles, by Daniel Shiffman.
//My Addition to this is the trace behind particles
ParticleSystem ps;
PImage sprite;  

void setup() {
  size(1024, 768, P2D);
  orientation(LANDSCAPE);
  sprite = loadImage("sprite.png");
  ps = new ParticleSystem(1000);

  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
} 

void draw () {
  //I disabled this
  //background(0);
  //and added the following 3 lines
  fill(100,20,120,15);
  rect(0,0,width,height);
  fill(255);
  ps.update();
  ps.display();
  
  ps.setEmitter(mouseX,mouseY);
  
  fill(255);
  textSize(16);
  text("Frame rate: " + int(frameRate), 10, 20);
  
}


