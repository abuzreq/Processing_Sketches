
PVector center ;
int[] radii = new int[]{20,40,60,80,100,120,140,160,180};
int numPoints =40;
void setup()
{
    size(400,400);
    center = new PVector(width/2,height/2);
   for(int i = 0 ; i <  numPoints;i++)
    {
        points.add(new Point(radii[(int)(noise(i)*radii.length)],i*((2*PI)/numPoints)));        
    }
  
}


ArrayList<Point> points  = new ArrayList<Point>();
float t = 0;
void draw()
{
 // clear();//TRY commenting this
   stroke(255);
   noFill();
  strokeWeight(4);
  if(frameCount%15==0)
 for(int i = 0 ; i <  points.size();i++)
  {
       int n = constrain((int)(noise(t)*radii.length)+(int)random(-2,2),0,radii.length);
       println(n);
       t += 0.01f;//TRY 1 ,0.01 ,0.1 ,0.001
       points.get(i).radius = radii[n];
  }
  //printing lines between points
  for(int i = 1 ; i <=  points.size();i++)
  {
        Point p1 = points.get(i-1);
        Point p2 = points.get(i%points.size());  
        stroke(map(p1.radius,radii[0],radii[radii.length-1],0.2,1)*255);
        line(p1.getX(),p1.getY(),p2.getX(),p2.getY());  //see Point.getX()      
  }
  //draw circles
    strokeWeight(0.2);
   ellipseMode(CENTER);
   for(int i = 0 ; i <  radii.length;i++)
    {
        ellipse(center.x,center.y,radii[i]*2,radii[i]*2);        
    }
  
  
  

}

class Point
{
  float angle ;
  int radius;
  Point(int radius, float angle)
  {
      this.angle = angle;
      this.radius = radius;
  }
  
  float getX()
  {
     return center.x +radius*cos(angle);
  }
  
    float getY()
  {
     return center.y +radius*sin(angle);
  }
 
}