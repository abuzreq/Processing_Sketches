PShape shape ;
ArrayList<Point> points = new ArrayList<Point>();
void setup() {
  size(640,360,P2D);
}

void draw() {
    background(0);

  if(mousePressed)
  {
    points.add(new Point(mouseX, mouseY));
  }
  if(key =='d')
    {
      shape = createShape();
      shape.beginShape();
      for(int i = 0 ; i < points.size();i++)
          shape.vertex(points.get(i).x,points.get(i).y);
      shape.endShape();
    }
    else if (key == 'p')
    {
      points.clear();
      background(0);
    }
    if(shape != null)
    shape(shape);
    

}


class Point
{
  int x , y;
  Point(int nx , int ny )
  {
  x = nx ; 
  y= ny ;
  }


}
