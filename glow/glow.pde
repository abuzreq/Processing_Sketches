void setup()
{
  size(500,500);
  points = new Vector2[width/2][height/10];//change the height here : increase to increase points vice versa
  boolean flag = true;
  for(int i = 0 ; i < points.length;i++)
  {
    for(int j = 0 ; j < points[i].length ; j++)
          points[i][j] =  new Vector2(round(random(0,width)),round(random(0,height)));
  
  }

}
Vector2[][] points ;
int angle = 1 ;
void draw()
{
  fill(255,50);
  rect(0,0,width,height);
  fill(0);
  for(int i = 0 ; i < points[angle].length; i++ )
  {
    
  //  line(points[angle][i].x,points[angle][i].y,points[angle-1][i].x,points[angle-1][i].y);
     ellipse(points[angle][i].x,points[angle][i].y,2,2);
  }
 

 // angle = (int)map(mouseX,0,width,1,points.length-1); map the angle to the mouse X
 if(frameCount%30==0)
   angle++;
angle %= points.length;
}

 class Vector2
 {
   int x, y;
   Vector2(int nx , int ny)
   {
     x = nx ;
     y = ny;
   }
   
   public String toString()
   {
     return " ["+ x +" , "+ y + " ]";
   }
 }
