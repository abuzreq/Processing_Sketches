import java.util.Random;
Walker walker ;
Random rand ;
void setup()
{
  size(400,400);
  walker = new Walker();
  rand = new Random();
}




void draw()
{
  walker.step();
  walker.display();

  if(keyPressed)
  {
    if(key == 'r')
    {
      background(255);   
      walker.x = width/2;
      walker.y = height/2;
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
  float t = 10;
  void step()
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
  void display()
  {
    stroke(0);
    point(x,y);
    line(px,py,x,y);
  }

}