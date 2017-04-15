import java.util.*;


Vector<PVector>  points = new Vector<PVector>();
Voronoi v ;
void setup()
{
  float x,y;
  for(int i = 0 ; i < 100;i++)
  {
  
    
    x = constrain(random(width),0,width);
    y = constrain(random(height),0,height);

    points.add(new PVector(x,y));
  }
  size(800,800);
  v = new Voronoi();
  v.computeVoronoi(points);
  v.processSite();
//  v.pointsLookup
}

void draw()
{
  stroke(255);
  fill(255);
  for(int i  = 1 ;i < v.sites.size();i++)
  {
    
   Voronoi.Site ps =  (Voronoi.Site)v.sites.get(i-1);
   Voronoi.Site s =  (Voronoi.Site)v.sites.get(i);
   LinkedList<PVector> list = ps.points;
    Iterator<PVector> it = list.iterator();
    PVector previous = it.next();
    while(it.hasNext())
    {
        PVector current = it.next();
        line(previous.x,previous.y,current.x,current.y);
        previous = current;
    }
  
  }
}