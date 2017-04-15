float x1,x2,y1,y2;
float radius1 ,radius2;
//http://kishimotostudios.com/articles/circle_collision/
void setup()
{
  size(400,400);
  x1 = width/2;
  y1  = height/2;
  radius1 = 50;
  radius2 = 25;
  
}

void draw()
{
  clear();
  x2 = mouseX;
  y2 = mouseY;
  
  ellipse(x1,y1,radius1*2,radius1*2);
  ellipse(x2,y2,radius2*2,radius2*2);
  float distance =  abs(dist(x1,y1,x2,y2));
  if (radius1 + radius2  >= distance)
    println(" Collid ");
  
}