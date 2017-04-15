
void setup()
{
  size(600,400);
 
}


float t  = 0 ,xoff,yoff;
void draw()
{
  loadPixels();
   xoff = 0;
  for (int x = 0; x < width; x++) 
  {
    yoff = 0;
    for (int y = 0; y < height; y++) 
    {
      float bright = map(noise(xoff,yoff,t),0,1,0,255);
      pixels[x+y*width] = color(bright);
      yoff +=0.01;
    }
    xoff +=0.01;
  }
 
  updatePixels();
  t+=0.01;
  
}