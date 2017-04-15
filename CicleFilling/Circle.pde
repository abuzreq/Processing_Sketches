class Circle
{
    PVector center ;
    float radius;
    int stepsize = 2;
    
    public Circle(float x , float y , float r)
    {
        center = new PVector(x,y);
        radius = r;
    }
    public Circle(PVector v , float r)
    {
        center = v;
        radius = r;
    }
    void grow()
    {
        float newRadius = radius + stepsize;
        Circle newCircle = new Circle(center,newRadius);
        for(int i = 0 ; i < circles.size();i++)
        {
          if(!circles.get(i).equals(this))  
          {
            if(newCircle.isColliding(circles.get(i)))
            {
               n++;
               return;
            }
          }
          else
               continue;

        }
        radius = newRadius;
    }
    

    
      public boolean isColliding(Circle circle)
        {
            float distanceX = center.x - circle.center.x;
            float distanceY = center.y - circle.center.y;
            float radiusSum = circle.radius + radius;
            return distanceX * distanceX + distanceY * distanceY <= radiusSum * radiusSum;
        }
    void display()
    {
      ellipse(center.x,center.y,radius,radius);
    }
    boolean equals(Circle c)
    {
      return (this.center.x == c.center.x) && (center.y == c.center.y);
    }
     
}