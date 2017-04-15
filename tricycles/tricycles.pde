
//One point rotates around a center , another point (the ellipse rotate around the previous point)
float frequency = 0.2;
float centerX,centerY,cycleX,cycleY,circleX,circleY,x,y;
float radius = 150 ,radius2 = 50,radius3 = 25;
float angle  = 0   ,angle2  = 0,angle3  = 0;
// most inetersting changes are those two
float angleChange = 13; 
float angle2Change = 72;
float angle3Change = 1420;
float xShift = 0,yShift = 0;
// (1,8) is possibly the epicycle as Copernicus described it   
//other interesting values
//(1,10,100) , (1,5,10),(1,8,20),(13,72,1420),(100,10,1),(1000,1000,1)
void setup()
{
  size(1280,640,FX2D);
  surface.setSize(1280, 640);
  fill(255);
  centerX = width / 5;
  centerY = height / 2 ;
  cycleX = centerX + radius ;
  cycleY = centerY + radius ;
  circleX = cycleX + radius2 ;
  circleY = cycleY + radius2 ;
  x = circleX + radius2 ;
  y = circleY + radius2 ;
  xShift = x;
  yShift = y;
  
}

ArrayList<PVector> array = new   ArrayList<PVector>();//used to store points generated from the epicycles
ArrayList<PVector> array2 = new   ArrayList<PVector>();//used to store point related to drawing the wave

void draw()
{
  if(frameCount%3==0)
  {
    background(0);
    cycleX = centerX + cos(radians(angle*frequency))*radius;
    cycleY = centerY + sin(radians(angle*frequency))*radius;
    angle = angle + angleChange;
    
    circleX =  cycleX + cos(radians(angle2*frequency))*radius2;
    circleY =  cycleY + sin(radians(angle2*frequency))*radius2;
    angle2 = angle2 + angle2Change ;
    
    x =  circleX + cos(radians(angle3*frequency))*radius3;
    y =  circleY + sin(radians(angle3*frequency))*radius3;
    angle3 = angle3 + angle3Change ;
    
    xShift = xShift  + 1 ;
    yShift = y;
    if(xShift >= width)
    {
      xShift = width/6 + x;
      yShift = y;
      array2.clear();
    }
    array2.add(new PVector(xShift,yShift));
    array.add(new PVector(x,y));
    stroke(255);
    if(array.size() > 1)
      for(int i = 1 ; i < array.size();i++)
      {
        line(array.get(i-1).x,array.get(i-1).y,array.get(i).x,array.get(i).y);
      }
     stroke(0,255,0);
     if(array2.size() > 1)
      for(int i = 1 ; i < array2.size();i++)
      {
        line(array2.get(i-1).x,array2.get(i-1).y,array2.get(i).x,array2.get(i).y);
      }
    noFill();
    stroke(255,0,0);
    line(x,y,xShift,yShift);
    ellipse(cycleX,cycleY,radius,radius);
    ellipse(circleX,circleY,radius2,radius2);
    ellipse(x,y,radius3,radius3);
  }

}