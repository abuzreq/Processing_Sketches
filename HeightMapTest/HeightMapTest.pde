void setup()
{
  size(800,800);
  loadPixels();
  float t  = 1;
  noiseDetail(1,0.75);
  for(int i  = 0 ;i < pixels.length; i++)
  {
        float h =  noise(t,0.75)*(width/2) ;//- distanceToCenter(i%width,i/width);  //(noise(t)*255)*(distanceToCenter(i%width,i/width)/(width/2))
        pixels[i] = color(h);
        t +=0.05;
    
  }  

 for(int i  = 0 ;i < pixels.length; i++)
  {
 //   if(brightness(pixels[i]) < 100)
  //       pixels[i] = color(255,0,0,255);

  }
    updatePixels();
}

  float distanceToCenter(float x,float y)
  {
    return distance(x,y,width/2,height/2);
  }
  
  float distance(float x1,float y1,float x2,float y2)
  {
    return sqrt((x1-x2)*(x1-x2) +(y1-y2)*(y1-y2));
  }
void draw()
{
  loadPixels();
  float t  = 1;
  noiseDetail(1,0.75);
  for(int i  = 0 ;i < pixels.length; i++)
  {
        float h =  noise(t,0.75)*(width/2) ;//- distanceToCenter(i%width,i/width);  //(noise(t)*255)*(distanceToCenter(i%width,i/width)/(width/2))
        pixels[i] = color(h);
        t +=0.05;
    
  }  
    updatePixels();
}