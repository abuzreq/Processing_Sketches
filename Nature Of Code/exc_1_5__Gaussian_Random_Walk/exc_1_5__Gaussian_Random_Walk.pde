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
  void step()
  {
    
    int rx = (int)random(3)-1;
    int ry = (int)random(3)-1;
    float rd = (float)rand.nextGaussian();
    float  distance = rd + 3;
    px = x;
    py = y;
    x += rx*distance;
    y += ry*distance ;
      
  }
  void display()
  {
    stroke(0);
    point(x,y);
    line(px,py,x,y);
  }

}