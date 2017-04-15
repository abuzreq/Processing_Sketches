import java.util.*;
float angle1 = PI/3,angle2 = PI/3;
PVector p1 = new PVector(150,150);
PVector p2 = new PVector(200,150);
Queue<Line> queue = new Queue<Line>();
void setup()
{

  size(500,500);
  Line initialLine = new Line(p1,p2);
 // linesSet.add(initialLine);
  queue.enqueue(initialLine);
  int numIters = 10000;
  int iter = 0;
 
  while(iter < numIters)
  {
      Line[] newLines = new Line[4];
      Line l = queue.dequeue();
     
     if(!containsSet(linesSet,l) )
     {  
        linesSet.add(l);
        newLines = buildTriangle(l,angle1,angle2); 
        for(int i = 0 ; i < newLines.length;i++)
        {
          queue.enqueue(newLines[i]);
        }
     }

    iter++;
  }
}

boolean containsSet(Set<Line> lines , Line line)
{
     Iterator<Line> it = lines.iterator();
    while(it.hasNext())
    {
       boolean flag = it.next().equals(line);
       if(flag)return true;
    }
    return false;
}
Line[] buildTriangle(PVector p1 , PVector p2 , float angle1,float angle2)
{
  Line[] lines = new Line[4];
  Line initialLine = new Line(p1,p2);
  PVector midpoint = new PVector((p1.x+p2.x)/2 , (p1.y + p2.y)/2);
  float d =  (sin(angle1)*sin(angle2)*initialLine.distance())/sin(angle1 + angle2);
  
  PVector up = new PVector(0,0,1);
  PVector vectorUP = initialLine.vector().normalize().cross(up).mult(d);
  PVector p3Up = PVector.add(midpoint,vectorUP);
  lines[0] = new Line(p1,p3Up);
  lines[1] = new Line(p2,p3Up);
  
   PVector down = new PVector(0,0,-1);
   PVector vectorDown = initialLine.vector().normalize().cross(down).mult(d);
   PVector p3Down =  PVector.add(midpoint,vectorDown);
   lines[2] = new Line(p1,p3Down);
   lines[3]  = new Line(p2,p3Down);
   return lines;
}
Line[] buildTriangle(Line line, float angle1,float angle2)
{
     return buildTriangle(line.p1,line.p2,angle1,angle2);
}
void printArray(ArrayList objects)
{
    println();
    for(int i = 0 ; i < objects.size();i++)
    {
      print(objects.get(i)+" ");
    }
    println();
}
Set<Line> linesSet = new LinkedHashSet<Line>();
void draw()
{
  //clear();
    Iterator<Line> it = linesSet.iterator();
    while(it.hasNext())
    {
      it.next().draw();
    }
   
  
}
PVector vector(PVector v1 , PVector v2)
{
  return new PVector((v2.x-v1.x),(v2.y-v1.y));
}
class Line
{
    PVector p1 ,p2;
    public Line(PVector x ,PVector y)
    {
      p1 = x;
      p2 = y;
    }
    void draw()
    {
      line(p1.x,p1.y,p2.x,p2.y);
    }
    float distance()
    {
      return sqrt(pow((p1.x-p2.x),2)+pow((p1.y-p2.y),2));
    }
    PVector vector()
    {
      return new PVector((p2.x-p1.x),(p2.y-p1.y));
    }
    String toString()
    {
      return " [ "+p1.toString() + " : " + p2.toString() +" ] ";
    }
     boolean equals(Line other)
     {
      //   return (PVector.sub(other.p1 ,p1).mag() < 2) && (PVector.sub(other.p2 ,p2).mag() < 2);
       
        boolean flag = (approxEquals(p1,other.p1) && approxEquals(p2,other.p2) ) ||( approxEquals(p1,other.p2) && approxEquals(p2,other.p1) );   
      // println(flag +" : "+ toString() +" =? "+ other);
       return flag;
     }
     boolean approxEquals(PVector vec1 , PVector vec2)
     {
       return abs(vec1.x - vec2.x) < 5 && abs(vec1.y - vec2.y) < 5  ;
     }
      boolean approxEquals2(PVector vec1 , PVector vec2)
     {
       return vec1.dot(vec2) < 0.05;
     }
}
class Queue<Line>
{
  LinkedList<Line> myList = new LinkedList<Line>();
  void enqueue(Line line)
  {
    myList.addLast(line);
  }
  Line dequeue()
  {
     return myList.removeFirst();
  }
   int size()
    {
      return myList.size();
    }
    
    boolean contains(Line l)
    {
      return myList.contains(l);
    }
}