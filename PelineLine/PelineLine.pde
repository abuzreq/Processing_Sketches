  void drawRoughLine(float x1, float y1, float x2, float y2,float Pos, float Freq, float Amp, float Steps) 
  {
    float  step  = 1.0/Steps;
    float mag   = new PVector(x1,y1).dist(new PVector(x2,y2));
    float theta =  PVector.angleBetween(new PVector(x1,y1),new PVector(x2,y2));

    float xmag = Amp * sin(theta) * mag;
    float ymag = Amp * cos(theta) * mag;
    fill(255);
    beginShape(TRIANGLES);

    vertex(x1, y1);

    for (float a = step; a < Steps; a += step)
    {
      float n = noise(Pos);
      vertex(lerp(a,x1,x2) + n*xmag, lerp(a,y1,y2) + n*ymag);
      Pos += Freq;
    }
    vertex(x2, y2);
    endShape();
  }
  void setup()
  {
    size(400,400);
  
  }
  
  void draw()
  {
    stroke(255);
    drawRoughLine(0,0,width/2,height/2,0,10,15,100);
  
  }