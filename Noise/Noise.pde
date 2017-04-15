//Noise
//http://devmag.org.za/2009/04/25/perlin-noise/
/*float xoff = 0.0;
void draw() {
  background(204);
  xoff = xoff + .01;
  float n = noise(xoff) * width;
  line(n, 0, n, height);
}
*/

/*float noiseScale=0.02;

void draw() {
  background(0);
  for (int x=0; x < width; x++) {
    float noiseVal = noise((mouseX+x)*noiseScale, 
                            mouseY*noiseScale);
    stroke(noiseVal*255);
    line(x, mouseY+noiseVal*80, x, height);
  }
}*/


/*
PShape s ;
ArrayList<PVector> list = new ArrayList<PVector>();
void setup(){
size(480,480,P2D);
s = createShape();
s.beginShape();
 s.fill(127);
    s.stroke(0);
    s.strokeWeight(2);
for(float i = 0 ; i < TWO_PI ;i += 0.1)
  {
    PVector v = PVector.fromAngle(i);
    v.mult(100);
    
    s.vertex(v.x,v.y);
  }
 s.endShape(CLOSE);
}
void draw(){
  background(255);
  
for (int i = 0; i < s.getVertexCount(); i++) {
  PVector v = s.getVertex(i);
  v.x += random(-1,1);
  v.y += random(-1,1);
  s.setVertex(i,v.x,v.y);
}

translate(width/2, height/2);
  shape(s);
}*/
