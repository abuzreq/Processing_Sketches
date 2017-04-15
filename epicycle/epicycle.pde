
//One point rotates around a center , another point (the ellipse rotate around the previous point)

float centerX,centerY,cycleX,cycleY,x,y;
float radius = 250 ,radius2 = 50;
float angle  = 0   ,angle2  = 0 ;
// most inetersting changes are those two
float angleChange = 666; 
float angle2Change = 50;
// (1,8) is possibly the epicycle as Copernicus described it   
//other interesting values
//(10,100) , (100,1000),(1000,10000),(1000,1000),(666,50)
void setup()
{
  size(640,640,FX2D);
  surface.setSize(640, 640);
  fill(255);
  centerX = width/2;
  centerY = height / 2 ;
  cycleX = centerX + radius ;
  cycleY = centerY + radius ;
  x = cycleX + radius2 ;
  x = cycleY + radius2 ;
}

ArrayList<PVector> array = new   ArrayList<PVector>();
void draw()
{
  if(frameCount%30==0)
  {
  background(0);
  cycleX = centerX + cos(radians(angle))*radius;
  cycleY = centerY + sin(radians(angle))*radius;
  angle = angle + angleChange;
  
  x =  cycleX + cos(radians(angle2))*radius2;
  y =  cycleY + sin(radians(angle2))*radius2;
  angle2 = angle2 + angle2Change ;
  
  array.add(new PVector(x,y));
  stroke(255);
  if(array.size() > 1)
    for(int i = 1 ; i < array.size();i++)
    {
      line(array.get(i-1).x,array.get(i-1).y,array.get(i).x,array.get(i).y);
    }
  fill(255,0,0);
  ellipse(x,y,25,25);
  }


}