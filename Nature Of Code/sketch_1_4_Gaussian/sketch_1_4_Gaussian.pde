import java.util.*;

Random rand ;

void setup()
{
  size(400,400);
  rand = new Random();
}


float sd = 30;
int numDots = 20;
float dotDim = 10;
void draw()
{
  if(mousePressed)
  {
    float meanX = mouseX;
    float meanY = mouseY;
    for(int i = 0 ; i < numDots;i++)
    {
       float rx = (float)rand.nextGaussian();
       float ry = (float)rand.nextGaussian();
       float x =  rx*sd + meanX;
       float y =  ry*sd + meanY;
       
       float ca =  (float)rand.nextGaussian();
       float alpha = ca*60 + 255/6;
       float cr =  (float)rand.nextGaussian();
       float cg =  (float)rand.nextGaussian();
       float cb =  (float)rand.nextGaussian();
       float clrRed =   cr*50+255/2;
       float clrGreen = cg*50+255/2;
       float clrBlue =  cb*50+255/2;
       noStroke();
       fill(clrRed,clrGreen,clrBlue,alpha);
       ellipse(x,y,dotDim,dotDim);
        
    }
  
  }
  if(keyPressed)
  {
    if(key == 'c')
    {
      clear();
    }
  }
    

}