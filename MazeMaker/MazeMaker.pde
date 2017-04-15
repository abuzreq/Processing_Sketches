static int n = 10;//number of squares per row or column
static int dimension = 50; //size of each square edge
static int offsetX = 15,offsetY = 15;//for presenting purposes
static float  scl = 1;//for magnifying
/* TASKS
Document what you did in the zooming and the translation when pressing WASD
talk about the peoblem that happened when iscaled down the the drawing by using scale() which is related to the OpenGl and thus the drawing only
while I didn't scale the coordinates

abstract square to have any type of object(tiles,walls,constraint problem variable,platform)

there is a bug in the offset 
press to the left of the grid and to the right of the grid
it's caused by the translation by an offset in draw()
which is not accompained with a change in x,y of lines
(maybe squares having different types , maybe represented by different colors)
*/


static ArrayList<Line> lines= new ArrayList<Line>();
static ArrayList<Square> squares= new ArrayList<Square>();
void setup()
{
  println(inRange(300,100));
 // size(n*dimension+30,n*dimension+30,FX2D);

  surface.setSize(n*dimension+offsetX*2, n*dimension+offsetY*2);
  fill(255);
  
  /*
  For each point we will generate the lines coming out of it 
  the result is all lines in the grid (Replicates are ommited)
  *--*--*--*
  |  |  |  |
  *--*--*--*
  |  |  |  |
  *--*--*--*
  */
  ArrayList<Line> tmpList = new ArrayList<Line>();//will store the 4 lines spanning from a point in each direction
  for(int i =  0 ; i < (n+1)*(n+1);i++)
  {
      int x =  (i%(n+1))*dimension,y = (i/(n+1))*dimension;
      Line line1 = new Line(x,y,x+dimension,y);
      Line line2 = new Line(x,y,x-dimension,y);
      Line line3 = new Line(x,y,x,y+dimension);
      Line line4 = new Line(x,y,x,y-dimension);
      tmpList.add(line1);
      tmpList.add(line2);
      tmpList.add(line3);
      tmpList.add(line4);
      for(int t =  0 ; t < tmpList.size();t++)
      {
        int tx1  = tmpList.get(t).x1,
            ty1  = tmpList.get(t).y1,
            tx2  = tmpList.get(t).x2,
            ty2  = tmpList.get(t).y2;
        if(!inRange(tx1,ty1) || !inRange(tx2,ty2))
        {
          tmpList.set(t,null);
        }
      }
      for(int t =  0 ; t < tmpList.size();t++)
      {
          Line line = tmpList.get(t);
         if(line != null)
         {
            int index = indexOf(line);
            if(index == -1)
            {
              lines.add(line);
            }
         }
         
      }
    tmpList.clear();    
  }
  
  /*
  # origin x,y
  #--*
  |  |
  *--*
  
  After the above initializing of lines
  create squares each with it's origin as one of the grid points
  note that if the grid is N*N
  there will be (N+1)(N+1) points
  and N*N rectangles
  */
  
  for(int i = 0 ;  i< n*n ;i++)
  {
    int x =  (i%n)*dimension,y = (i/n)*dimension;
    int[] indices = new int[4];
    indices[0] = indexOf(new Line(x,y,x+dimension,y));
    indices[1] = indexOf(new Line(x+dimension,y,x+dimension,y+dimension));
    indices[2] = indexOf(new Line(x,y+dimension,x+dimension,y+dimension));    
    indices[3] = indexOf(new Line(x,y,x,y+dimension));
    Square square = new Square(indices);
    squares.add(square); 
  }  
  
}

//
/*
wether a line is a the outer border of the grid
#--------#
|        |
|        |  
|        |
#--------#

*/
boolean isBorderLine(Line line)
{
  return ((line.x1 == line.x2 )&& (line.x1== 0 || line.x1 == dimension*n))
        ||((line.y1 == line.y2 )&& (line.y1== 0 || line.y1 == dimension*n));
}
//index of lie in lines array
int indexOf(Line line)
{
  for(int i = 0 ; i < lines.size();i++)
  {
    if(lines.get(i).equals(line))
      return i;
  }
  return -1;

}
//wether the point x,y is contained in the grid boundary
boolean inRange(int x , int y)
{
  boolean flag = true;
  flag &= (x >= 0);
  flag &= (x <= n*dimension);
  flag &= (y >= 0);
  flag &= (y <= n*dimension);
  return flag;

}
void draw()
{
  clear();
  strokeWeight(2.5);
   translate(offsetX+tx,offsetY+ty);
   scale(scl);
 for(int i = 0 ; i< lines.size();i++)
  {
     Line l =  lines.get(i);
    if(l.isInner)
     {
      strokeWeight(0.5);
      stroke(255,0,0);
     }
     else
     {
      strokeWeight(2.5);
      stroke(0,0,255);
     }
     
    line(l.x1,l.y1,l.x2,l.y2); 
  }
    fill(0,0,180,200);
   for(int i = 0 ; i< squares.size();i++)
   {
    
    if(squares.get(i).isInner)
       rect(squares.get(i).getX(),squares.get(i).getY(),dimension,dimension);
   }

}


void mousePressed()
{   
  for(int i = 0 ; i < squares.size();i++)
  {
    boolean flag = Square.contains(squares.get(i),(int)getMouseX(),(int)getMouseY());
    if (flag)
    {
        Line[] edges = squares.get(i).edges;
        for(int e = 0 ; e < edges.length ;e++)
        {
          edges[e].isInner =  !edges[e].isInner;
          //squares.get(i).checkEdges(); used for squares identifying as outer or inner see comment on 
        }
      break;
    }
  
  }

}

void mouseDragged()
{
   for(int i = 0 ; i < squares.size();i++)
  {
    boolean flag = Square.contains(squares.get(i),(int)getMouseX(),(int)getMouseY());
    if (flag && !squares.get(i).justDragged)
    {
        Line[] edges = squares.get(i).edges;
        for(int e = 0 ; e < edges.length ;e++)
        {
          edges[e].isInner =  !edges[e].isInner;
        }
       squares.get(i).justDragged = true;
    }
  
  }
}

void mouseReleased()
{
   for(int i = 0 ; i < squares.size();i++)
  {
     squares.get(i).justDragged = false;
  }
}

float getMouseX()
{
  return mouseX/scl - tx/scl;
}

float getMouseY()
{
  return mouseY/scl - ty/scl ;
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
   if(e >0)
     scl += 0.1;   
   else
     scl -= 0.1; 
     
   if( scl < 1)
        scl = 1;    
}

float tx = 0 , ty = 0;//translation tmp variables
void keyPressed()
{
  if(key == 'a' || key == 'A')
    tx += 10;  
   if (key == 'd' || key == 'D')
    tx -= 10; 
   if (key == 'w' || key == 'W')
    ty += 10;
   if (key == 's' || key == 'S')
    ty -= 10;

}

static class Square
{
  Line[] edges = new Line[4];
  boolean isInner = false;
  boolean justDragged = false;
  Square(int[] linesIndices)
  {
    for(int i = 0  ; i < linesIndices.length ; i++)
    {
      edges[i] = lines.get(linesIndices[i]);
    }
    
  }

  int getX()
  {
    return edges[0].x1;
  
  }
  int getY()
  {
    return edges[0].y1; 
  }
  
  static boolean contains(Square sq,int x , int y)
  {
    //println(x+"/"+y +" vs. " +getX() + "/" + getY());
    boolean flag = true;
    flag &= x >= sq.getX();
    flag &= x <=  sq.getX()+dimension;
    flag &= y >= sq.getY();
    flag &= y <=  sq.getY()+dimension;
    return flag;    
  }
   String toString()
  {
    return "["+ getX() + "," + getY()+"]";
  }
  
  //
  /*
  
  this won't work (if all edges are outer say it's outer)
  what is needed is to keep track of the squares that are within the outer borders 
  then those in those borders can be declared blocks or walls or outer
  */
  void checkEdges()
  {
   /* println(isInner);
   for(int i = 0  ; i < edges.length ; i++)
    {
      if(edges[i].isInner)
        {
          isInner = true;
          continue;
        }
    }
    isInner = false;
  */
  }

}




class Line
{
  boolean isInner = true;
  int x1 ,y1,x2 ,y2;
  Line(int nx1,int ny1,int nx2,int ny2)
  {
    x1 = nx1;
    y1 = ny1;
    x2 = nx2;
    y2 = ny2;
  }


  //two lines are equal if their start points are equal and their end points are 
  //equal also if he start of one is equal to end of other and vice versa
  //(i.e the two lines are just the flip of each other)
  boolean equals(Line other)
  {
    return ((x1  == other.x1) && (y1 == other.y1) 
          &&(x2  == other.x2) && (y2 == other.y2))
          ||
          ((x1  == other.x2) && (y1 == other.y2) 
          &&(x2  == other.x1) && (y2 == other.y1));
  
  }
  int hashCode()
  {
    return  toString().hashCode();
  
  }
  String toString()
  {
    return "[("+ x1 + "," + y1+") : ("+x2 +","+ y2 +")] " + isInner;
  }
  

}