import java.util.Random;
ArrayList<Walker> walkers = new ArrayList<Walker>() ;
Random rand ;
void setup()
{
  background(0);
  size(1200,1200);
  rand = new Random();
}


//press p for perlin noise ,r for the usual random() , g for a gausian distibution,m for 50% random , %50 following the mouse
static int stepType = 0;
void draw()
{

  if(mousePressed)
  {
      createWalkers(stepType) ;
  }
  
  if(keyPressed)
  {
    if(key == '1')
    {
       stepType = 0;        
    }
    if(key == '2')
    {
         stepType = 1;
    }
    if(key == '3')
    {    
        stepType = 2;
    }
     if(key == '4')
    {    
        stepType = 3;
    }
  }
  
    loadPixels();
   for(int i = 0 ; i < walkers.size();i++)
    {  
      if(outOfBoundry(walkers.get(i)))
          walkers.remove(walkers.get(i));
          
      walkers.get(i).step(stepType);//or pStep or rSrep
      walkers.get(i).display();
    
    }     
    updatePixels();  
}
void createWalkers(int stepType)
{
  for(int i = 0 ; i < 10;i++)
      {
           walkers.add(new Walker((int)mouseX,(int)mouseY,stepType));  
      } 
}
boolean outOfBoundry(Walker walker)
{
    if(walker.x < 0 || walker.x > width || walker.y < 0 || walker.y > height)
    {
      return false;
    }
    else
    return false;

}
class Walker
{

  int x ,y ,px,py;
  int stepType;

  Walker()
  {
    x = width/2;
    y = height /2;
  
  }
  Walker(int nx , int ny,int chosenStepType)
  {
    x = nx ;
    y = ny ;
    stepType = chosenStepType;
  
  }
  float t = 10;
  
  void step(int stepType)
  {
    if(stepType == 0)
      pStep();
    else if(stepType == 1)
      rStep();
    else if(stepType == 2)
      gStep();
   else if(stepType == 3)
      mStep();
   
  }
  void pStep()
  {
    
    
     float stepsize = map(noise(t),0,1,0,20);
    t += 0.00001;
    float stepx = random(-stepsize,stepsize);
    float stepy = random(-stepsize,stepsize);
    px = x;
    py = y;
    x += stepx;
    y += stepy;
    x = constrain(x, 0, width-1);
    y = constrain(y, 0, height-1);
      
  }
  void gStep()
  {
     int rx = (int)random(3)-1;
    int ry = (int)random(3)-1;
    float rd = (float)rand.nextGaussian();
    float  distance = rd + 3;
    px = x;
    py = y;
    x = constrain(x+(int)(rx*distance),0,width-1);
    y = constrain(y+(int)(ry*distance),0,height-1);

  }
  void rStep()
  {
    x += (int)random(-2,2);
    y += (int)random(-2,2);
     x = constrain(x,0,width-1);
    y = constrain(y,0,height-1);
  }
  void mStep()
  {
    int rx = (int)random(3)-1;
    int ry = (int)random(3)-1;
    float choice = random(1);
    
    if(choice < 0.5)
     {
      x +=  rx;
      y +=  ry;
     }
     else
     {
        if(mouseX > x)
          x += 1;
        else if(mouseX <= x)
          x -= 1;
       
        if(mouseY > y)
          y += 1;
        else if(mouseY <= y)
          y -= 1;
     }
    x = constrain(x,0,width-1);
    y = constrain(y,0,height-1);
      
  }
  
  void display()
  {
   
    if(pixels[x+y*width] ==  color(0))
        pixels[x+y*width]  = color(255, 0, 0);
    else if (pixels[x+y*width] == color(255, 0, 0))
        pixels[x+y*width]  = color(255,255,0);
    else if (pixels[x+y*width] == color(255,255,0))
        pixels[x+y*width]  = color(0,0,255);
  }

}