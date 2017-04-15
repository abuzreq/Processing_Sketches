
import miny.render.*;
import miny.types.*;
import java.util.*;
import processing.xml.XMLWriter;
import java.io.*;
Map map;

void setup()
{
  size(600, 600);
  //size(displayWidth, displayHeight); 
  map = new Map(this);
  map.nbPoints = 40;
  launchCreation(26004); // good seeds : 48047, 24973,26004
  // BUG with 17504 (for example)
}

void draw()
{
   map.draw();
}


public class TriangleVectorComparator implements Comparator<PVector>  {
    private PVector M; 
    public TriangleVectorComparator(PVector origin) {
        M = origin;
    }

    public int compare(PVector o1, PVector o2) {
        double angle1 = Math.atan2(o1.y - M.y, o1.x - M.x);
        double angle2 = Math.atan2(o2.y - M.y, o2.x - M.x);

        //For counter-clockwise, just reverse the signs of the return values
        if(angle1 < angle2) return 1;
        else if (angle2 < angle1) return -1;
        return 0;
    }

}
 ArrayList<PVector> coastPoints ;
void launchCreation(int seed)
{ 
   map.createMap(seed);
   map.fullCreation();
   exportXML("polygonVoronoi.xml");
     
 
   
   /*
   
   try
   {
     StringWriter sw = new StringWriter();

     
    coastPoints = new ArrayList<PVector>();
    PVector first = null;
     float x,y;
     int n  = 0;
     for(int i = 0 ; i < map.pointsList.size();i++)
     {
             if(map.pointsList.get(i).neighbours.size()<3)
             println(map.pointsList.get(i));
       if(map.pointsList.get(i).coast)
       {
   
          x = map.pointsList.get(i).pos.x;
          y = map.pointsList.get(i).pos.y;
          if(n == 0)
              first = new PVector(x,y);
          coastPoints.add(new PVector(x,y));       
           n++;
       }
     }  
     coastPoints.add(first);
     Collections.sort( coastPoints, new TriangleVectorComparator(new PVector(width/2,height/2)) );
     sw.write("<polygons numOfPolygons =\"1\">\n");
     sw.write("<polygon>\n");
     sw.write("<numOfVertices>"+n+"</numOfVertices>\n");
    for(int i = 0 ; i < coastPoints.size();i++)
    {
         x = coastPoints.get(i).x;
         y = coastPoints.get(i).y;
         sw.write("<x"+i+">"+x+"</x"+i+">\n");
         sw.write("<y"+i+">"+x+"</y"+i+">\n");   
    }
  
     sw.write("<numOfAdjacent>0</numOfAdjacent>\n");
     sw.write("</polygon>\n");  
     sw.write("\n</polygons>\n");
 
    PrintWriter  pw =  createWriter("polygonVoronoi.xml");
    pw.print(sw.toString());   
    pw.flush();
    pw.close();
   // println(sw.toString());
   }
   catch(Exception e)
   {
       e.printStackTrace();;
   }


   */
   
  //println(map.edgesList);
}

XMLElement element(String str)
{
    return new XMLElement(str);
}

/*

  ArrayList < Face > faces;
  ArrayList < Edge > edges;
  ArrayList < Point > neighbours;
  */




 LinkedList<Point>  toLinkedList(ArrayList<Map.Point> points)
{
  LinkedList<Point> newPoints =  new LinkedList<Point>();
  for(int i = 0;i < points.size();i++)
  {
    newPoints.add(new Point(points.get(i).pos.x,points.get(i).pos.y));
  }
  return newPoints;

}

  public void exportXML(String fileName) {
  
    StringWriter sw = new StringWriter();
    XmlWriter writer = new XmlWriter(sw);
  LinkedList<LinkedList<Point>> allCyclesList =  new  LinkedList<LinkedList<Point>>();
   for(int i  = 0 ; i < map.facesList.size();i++ )
    {
        if(!map.facesList.get(i).ocean)
        {
               LinkedList<Point> cyclePoints = toLinkedList(map.facesList.get(i).points);
                allCyclesList.add(cyclePoints);
        }
    
    }
    
  
  
    sw.write("<polygons numOfPolygons =\""+allCyclesList.size()+"\">\n\n");
    for (int i = 0; i < allCyclesList.size(); i++) {
      try {
        LinkedList<Point> cycle = allCyclesList.get(i);
        writer.element("polygon")
            .element("numOfVertices", cycle.size());
    
        for (int j = 0; j < cycle.size(); j++) {
        
          writer.element("x"+j, cycle.get(j).x*10+"");
          writer.element("y"+j, cycle.get(j).y*10+"");
        }
        int[] adjacencies =  new int[allCyclesList.size()];
        /*  for(int a = 0 ; a < adjacencies.length ; a++)
        {
          adjacencies[a] = -1 ;
        }*/
        int numOfAdjacent = 0 ;
        
        for(int j = 0 ; j < allCyclesList.size();j++)
        {
          if(!cycle.equals(allCyclesList.get(j)))
            if(isAdjacent(cycle, allCyclesList.get(j)))
            {
              adjacencies[j] = 1;
              numOfAdjacent++;
            }
        }    
        writer.element("numOfAdjacent",numOfAdjacent);
        for(int a = 0 ,b=0; a < adjacencies.length ; a++)
        {
          if(adjacencies[a]==1)
          {
            writer.element("adj"+b,a);
            b++;
          }
        }
        writer.pop();
      } catch (IOException e) {
        e.printStackTrace();
      }
      sw.write("\n");
    }
    
    sw.write("\n</polygons>");

       PrintWriter  pw =  createWriter(fileName);
        pw.print(sw.toString());   
        pw.flush();
        pw.close();
    
  }

void keyPressed()
{
  switch(keyCode)
  {
    // Create another map
    case ' ': 
      int seed = millis();
      println(seed);
      launchCreation(seed);
    break;
    
    case 'N':
      map.createNoisyEdges = !map.createNoisyEdges;
   
        for(Map.Edge e : map.edgesList) {
          e.noisy1 = null;
          e.noisy2 = null;
        }
      

    break;
    
    

  }
}

class Edge<Point> {

    Point first, second;

    public Edge(Point first, Point second) {
      this.first = first;
      this.second = second;
    }

    public void set(Point first, Point second) {
      this.first = first;
      this.second = second;
    }

    public Point getFirst() {
      return first;
    }

    public void setFirst(Point first) {
      this.first = first;
    }

    public Point getSecond() {
      return second;
    }

    public void setSecond(Point second) {
      this.second = second;
    }

  }

  class Point {
    protected float x, y;

    public Point(float x, float y) {
      this.x = x;
      this.y = y;
    }

    public Point set(float x, float y) {
      this.x = x;
      this.y = y;
      return this;
    }

    @Override
    public String toString() {
      return "(" + x + "," + y + ")";
    }

    @Override
    public boolean equals(Object other) {
      if (other != null && other instanceof Point) {
        Point p = (Point) other;
        return (x == p.x) && (y == p.y);
      } else
        return false;
    }

    @Override
    public int hashCode() {
      return (x + "" + y).hashCode();
    }
  }
  
  public boolean isAdjacent(LinkedList<Point> poly1 , LinkedList<Point> poly2 )
  {
    if(poly1 == null || poly2 == null)return false;
    if(poly1.size()<=2 ||poly2.size()<=2)return false;
    int  numOfVerticesInBoth = 0 ;
    for(int i = 0 ; i < poly1.size() ; i++ )
    {
      if(poly2.contains(poly1.get(i)))
        numOfVerticesInBoth++;    
    }
    return numOfVerticesInBoth>=2 ;
  }