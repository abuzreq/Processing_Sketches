class Road
{
   color[] colors = new color[]{color(255,0,0),color(0,255,0),color(0,0,255)};
  int type;
  City c1 ,c2;
  Road(City city1,City city2,int t)
  {
     c1 = city1;
     c2 = city2;
     this.type = t;
     
     tmpLines = new ArrayList<Line>();
     float x = c1.x,y = c1.y;
     for(int i = 0;i < numSmallLines ;i++)
     {
       float Dx = ((1.0)/numSmallLines)*(c2.x-c1.x);
       float Dy = ((1.0)/numSmallLines)*(c2.y-c1.y);

          if(i%2 == 0)
          {
              tmpLines.add(new Line(x,y,x+Dx,y+Dy));
          }
         x = x + Dx;
         y = y + Dy;
     }
  }
  int numSmallLines = 15;
  ArrayList<Line> tmpLines;
  void draw()
  {
    
     if(type == 0)
     {}
     else if (type == 1)
     {
         stroke(200);
         for(int i = 0 ; i < tmpLines.size();i++)
         {
            Line line =  tmpLines.get(i);    
              //stroke(colors[(int)map(type,1,4,0,colors.length)]);
              line(line.a.x,line.a.y,line.b.x,line.b.y);         
         }
     }
     else if(type == 2)
     {
          stroke(200);
          line(c1.x,c1.y,c2.x,c2.y);   
     }
     else if(type == 3)
     {
          stroke(0);
          line(c1.x,c1.y,c2.x,c2.y);   
     }
  }
  
  class Line
  {
   PVector a, b;
   Line(PVector aa,PVector bb)
   {
         a = aa;
         b = bb;  
   }
   Line(float ax,float ay,float bx,float by)
   {
        a = new PVector();
        b = new PVector();
         a.x = ax;
         a.y = ay;
         b.x = bx;
         b.y = by;
        
   }
   public String toString()
   {
       return "{ "+a+" , "+b+"}";
   }
  }
  

}