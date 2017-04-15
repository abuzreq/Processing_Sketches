

void setup()
{
  size(400, 400);
  loadPixels();  
  float t = 0;
  for (int y = 0; y < height; y++) 
   {
      for (int x = 0; x < width; x++) 
      {
          int loc = x + y*width;
             float nx = x/width - 0.5, ny = y/height - 0.5;
              float n = 1 * noise(x, y)
                +  0.5 * noise( x, y)
                + 0.25 * noise(x, y);
                  pixels[loc] = color((int)(n*255));
                     
      }
   } 
 updatePixels(); 
 
 
 
 /*
   loadPixels();  
    for (int y = 1; y < height-1; y++) 
   {
    for (int x = 1; x < width-1; x++) 
    {
        int loc = x + y*width;
     
        
          pixels[loc]  = 255;
        
        
        //int v = getPixel(x,y);
        
             
  }
 }
   
   
  updatePixels(); */

}

 

int getPixel(int x, int y)
{
  return pixels[x+y*width];     
}

float distance_squared(float x, float y)
{
    float dx = 2 * x / width - 1;
   float dy = 2 * y / height - 1;
   // # at this point 0 <= dx <= 1 and 0 <= dy <= 1
    return dx*dx + dy*dy;
    
}