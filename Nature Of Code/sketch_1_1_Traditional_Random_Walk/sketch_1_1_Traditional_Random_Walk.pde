
Walker walker ;

void setup()
{
  size(400,400);
  walker = new Walker();

}




void draw()
{
  walker.step();
  walker.display();

}
class Walker
{
  int x ,y;
  Walker()
  {
    x = width/2;
    y = height /2;
  
  }
  void step()
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
      
  }
  void display()
  {
    stroke(0);
    point(x,y);
  }

}