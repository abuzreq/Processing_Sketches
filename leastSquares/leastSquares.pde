
//see PatrickJMT , least squares
void setup()
{
   size(400,400);
}
//data points
int[] xs = {1,2,3,4,5,6,7,8};
int[] ys = {1,3,2,6,1,7,4,8};
float scale = 20 ; //to scale the graph
float x1,y1=0.8*scale,x2=9*scale,y2=7.5*scale;
boolean otherPoint = false ,justPressed  = false;
void draw()
{
  scale(1, -1);
  translate(0, -height);
  background(255);
  stroke(0);
  strokeWeight(4);
 for(int i = 0 ; i < xs.length ;i++)
  {
    point(xs[i]*scale,ys[i]*scale);
  }
  strokeWeight(8);
  stroke(75);
  point(x1,y1);//first point of the best-fit line
  point(x2,y2);//second point of the best-fit line
   strokeWeight(2);
  line(x1,y1,x2,y2);
  
  
  float slope = (y2-y1)/(x2-x1);//slope of best fit line
 
  float D = 0;
  for(int i = 0 ; i < xs.length;i++)
  {
    /*
    y = slope(x-x1) + y1 , use this equation to find the vertical distance by 
    fixing the x in this equation and in the point and comparing the y of the point on the line and y of the point
    
      |        * y1   : y1 comes by applying the x of the point to the equation of the line
      |        |
      |        | d    :  vertical distance
      |        |
      |        * y2   : y2 is in the pair that have x in our data points
      #------------
    
    */
    float onLineY  = slope*(xs[i]-x1)+y1;
    D += (onLineY - ys[i]) * (onLineY - ys[i]) ;
   /* 
   the squaring of the vertical distances(above) is just to get rid of the signs (also compariosn of the > , < is valid after squaring why ? see below )
   from Math.stackExchange:
    The general principle (LEARN THIS! You can later apply it to more difficult functions) is that if you apply an increasing function to both side of an inequality, you keep the original order. OTOH if you apply a decreasing function to both sides of an inequality the order is reversed.

    So if you know that xx and yy are both ≥0≥0 , then the inequality x>yx>y is true if and only if the inequality x2>y2x2>y2 is true.

    OTOH if you know that xx and yy both ≤0≤0, then the inequality x>yx>y is true if and only if the inequality x2<y2x2<y2 is true.
    */
  }
  textSize(18);
  fill(0);
  scale(1,-1);
  translate(0,-height);
  text("D = " +D,250,50 );
 



  //Control the points of thew best-fit line , press CONTROL to change between which points to manipulate, Click on screen and the mouse x,y will be given to the point
  if(mousePressed && !otherPoint)
  {
    x1 = mouseX;
    y1 = height-mouseY;
  }
  else if(mousePressed && otherPoint)
  {
    x2 = mouseX;
    y2 = height-mouseY;
  }
  if(keyPressed )
    if(key == CODED)
    {
      if( keyCode == CONTROL && !justPressed)
      {
        justPressed = true;//to prevent multiple presses quickly after each other
        otherPoint = !otherPoint;
        println(otherPoint);
      }
    }
  
    if(frameCount%30==0)
        justPressed = false;
    
    
}