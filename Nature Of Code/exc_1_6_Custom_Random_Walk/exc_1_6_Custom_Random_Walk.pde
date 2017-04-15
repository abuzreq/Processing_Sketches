import java.util.*;

Random rand ;
Walker walker ;
int[] randomCounts;
void setup()
{
  size(500,500);
  rand = new Random();
  walker = new Walker();
  randomCounts = new int[100];

}


void draw()
{
  
  walker.step();
  walker.display();
  int index = int((int)(montecarlo()*100));
   randomCounts[index] += 3;
  
  stroke(0);
  fill(175);
  int w = width/randomCounts.length;
  for (int x = 0; x < randomCounts.length; x++)
  {
    rect(x*w,height-randomCounts[x],w-1,randomCounts[x]);
  }
  
  if(keyPressed)
  {
    if(key == 'c')
    {
      clear();
    }
  }
    

}

 float montecarlo()
  {
    while(true)
    {
      float r1 = random(1);
      //here you are basicly choosing the function that will define your probability , a PDF
      //float probability = r1*r1;//squared
      float probability = r1;//linear

      float r2 = random(1);
      
      if(r2 < probability)
      {
        return r1;
      }
    }
  
  }


class Walker
{
 
  int x ,y ,px,py;
  Walker()
  {
    x = width/2;
    y = height /2;
  
  }
  void  step()
  {
    float stepsize = montecarlo()*40;
    
    float stepx = random(-stepsize,stepsize);
    float stepy = random(-stepsize,stepsize);
    px = x;
    py = y;
    x += stepx;
    y += stepy;
    x = constrain(x, 0, width-1);
    y = constrain(y, 0, height-1);
  }
  void display()
  {
    stroke(0);
    point(x,y);
    line(px,py,x,y);
  }


}