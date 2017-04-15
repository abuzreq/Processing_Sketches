import java.util.*;


LinkedList<Voronoi.Point> points = new LinkedList<Voronoi.Point>();//the initial points 
Voronoi v ;
ArrayList<Edge> edges = new ArrayList<Edge>();//the edges of teh voronoi polygons
int Num_Initial_Points = 100;
ArrayList<VertexEdgesPair> vertexEdgesPairs;
Set<PVector> vertices;//points where the polygons meet
ArrayList<Polygon> polygons = new ArrayList<Polygon>();
void setup()
{
  size(800,800);
  v = new Voronoi();
    
  points = preparePoints(Num_Initial_Points);
  v.runFortune(points);
  edges = turnToPVectorEdge(v.output);   
  vertices = getAllVertices(edges);
  vertexEdgesPairs = convertToVertexEdgesPair(vertices);
  
  //fills the vertexEdgesPairs with the right edges added to the right vertex
  fillPairs(vertexEdgesPairs,edges);
  polygons = createPolygons(vertexEdgesPairs);
  
  
}



ArrayList<Polygon> createPolygons(ArrayList<VertexEdgesPair> pairs)
{

  
  
  
  

    return null;
}

void fillPairs(ArrayList<VertexEdgesPair> pairs,ArrayList<Edge> edgesArray)
{
   for(int i = 0; i < edgesArray.size();i++)
  {
    pairs.get(pairs.indexOf(edgesArray.get(i).start)).add(edgesArray.get(i));
    pairs.get(pairs.indexOf(edgesArray.get(i).end)).add(edgesArray.get(i));
  }
  
}

  Set<PVector> getAllVertices(ArrayList<Edge> edges)
  {
    Set<PVector> vertices  = new LinkedHashSet<PVector>();
    for(int i = 0; i < edges.size();i++)
    {
         vertices.add(edges.get(i).start);
         vertices.add(edges.get(i).end);
    }  
    return vertices;
  }
  
  ArrayList<VertexEdgesPair> convertToVertexEdgesPair(Set<PVector> vertices)
  {
    ArrayList<VertexEdgesPair> pairs  = new   ArrayList<VertexEdgesPair>();
    Iterator<PVector> it = vertices.iterator();
    while(it.hasNext())
    {
         pairs.add(new VertexEdgesPair(it.next()));
    }  
    return pairs;
  }
  
void draw()
{
  clear();
  for(int i = 0 ; i < points.size();i++)
  {
      stroke(255);      
      point((float)points.get(i).x,(float)points.get(i).y);
  }
  for(int i = 0 ; i < edges.size();i++)
  {
      Edge edge = edges.get(i);
      stroke(255);      
      line(edge.start.x,  edge.start.y,  edge.end.x,  edge.end.y);
  }
  
}


//ArrayList<PVector> 



class VertexEdgesPair
{
  Set<Edge> edges ;
  PVector vertex ;
  VertexEdgesPair(PVector point)
  {
    vertex = point;
    edges = new LinkedHashSet<Edge>();
  }
  void add(Edge edge)
  {
  edges.add(edge);
  }
  
  boolean equals(VertexEdgesPair other)
  {
    return other.vertex.equals(this.vertex);
  }
  
  
}
class Edge
{
  PVector start,end;
  Edge(PVector s,PVector e)
  {
    start = s;
    end = e; 
  }

}

class Polygon
{
  PVector center;
  ArrayList<Edge> edges ;
  ArrayList<PVector> vertices;
  color polyColor;
  
  Polygon(PVector c,ArrayList<Edge> es,boolean relax)
  {
    center = c;
    edges = es;
    vertices = prepareVetices();
    if(relax)
      center = calculateCentroid(vertices);
  }
  
  ArrayList<PVector> prepareVetices()
  {
     ArrayList<PVector> vertices = new ArrayList<PVector>();
     for(int i = 1 ; i < edges.size();i++)
     {
         Edge e = edges.get(i);
         vertices.add(e.start);
         vertices.add(e.end);
     }
     return vertices;
    
    
  }
   PVector calculateCentroid(ArrayList<PVector> points) 
  {
    float x = 0;
    float y = 0;
    int pointCount = points.size();
    for (int i = 0;i < pointCount - 1;i++){
        PVector point = points.get(i);
        x += point.x;
        y += point.y;
    }

    x = x/pointCount;
    y = y/pointCount;
    return new PVector(x, y);
}



}
LinkedList<Voronoi.Point> preparePoints(int numPoints)
{
  Voronoi voro = new Voronoi();
  LinkedList<Voronoi.Point>  points = new LinkedList<Voronoi.Point>();
  float x,y;
  for(int i = 0 ; i < numPoints;i++)
  {
    x = random(width);
    y = random(height);
    
    Voronoi.Point p = voro.createPoint(x,y);
   
    points.add(p);
  }
  return points;
}

  ArrayList<PVector> turnToPVector(LinkedList<Voronoi.Point> pts)
  {
    ArrayList<PVector> points = new ArrayList<PVector>();
     Iterator<Voronoi.Point> it = pts.iterator();
    while(it.hasNext())
    {
      Voronoi.Point p = it.next();
      points.add(new PVector((float)p.x,(float)p.y));
    }
    return points;  
  }
   PVector turnToPVector(Voronoi.Point point)
  {
      return new PVector((float)point.x,(float)point.y);
  }
  
   ArrayList<Edge> turnToPVectorEdge(LinkedList<Voronoi.Edge> edges)
  {
    ArrayList<Edge>  newEdges = new ArrayList<Edge>();
    Iterator<Voronoi.Edge> it = edges.iterator();
    while(it.hasNext())
    {
      Voronoi.Edge e = it.next();
      newEdges.add(new Edge(turnToPVector(e.start),turnToPVector(e.end)));
    }
    return newEdges;  
  }
  