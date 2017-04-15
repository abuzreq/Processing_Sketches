import org.jgrapht.graph.*; 
import java.util.*;
import org.jgrapht.graph.DefaultEdge;
import org.jgrapht.alg.*;

final static int SPACE = 0;
final static int  WALL = 1;
final static int STARTING = 2;
final static int END = 3;
final static int MONSTER = 4;
final static int TREASURE = 5;
final static int ENTRANCE = 6;

static  Cell[][] phenotype;
static int dimension = 40;
static int dimensionToScreen = 20;

final static int DEFAULT_OUTER_WIDTH  =1;

/**


This is a trial to evolve a dunguen
I first choose points in the plane with a poisson diostrubtion 
then I flood fill in BFS manner for each point to create the rooms
in this process I also assign one of the borders cells of the room to be the entrance
then after the starting place is chosen and space is pressed
I create a graph out of the non-wall cells and find the shortest paths between the entrances and the starting point
I use the vertices in these paths to assign my corridors











*/
void setup()
{
  size(800,800);
  phenotype = new Cell[40][40];
  
  for(int i = 0;i< phenotype.length;i++)
  {
    for(int j = 0;j< phenotype[i].length;j++)
    {
      phenotype[i][j] = Cell.cell(i,j,WALL);
    }
  }
  PoissonDistribution distrib = new PoissonDistribution();
  ArrayList<PVector>  roomsPoints = distrib.generate(0, 0, dimension-1, dimension-1, 10, 10);

  int x,y;
  for(int  i = 0 ; i < roomsPoints.size();i++)
  { 
    spaceFill((int)roomsPoints.get(i).x,(int)roomsPoints.get(i).y,(int)random(3)+2,SPACE,WALL,1);
  }
  
    for(int j = 0 ; j < entrances.size();j++)
     {
       entrances.get(j).type = ENTRANCE;
            
     }
  
  
  
  
}




void draw()
{
  
  if(mousePressed)
  {
    //spaceFill(phenotype((int)(mouseX/dimensionToScreen),(int)(mouseY/dimensionToScreen)),2,SPACE,WALL,2);
    
    phenotype((int)(mouseX/dimensionToScreen),(int)(mouseY/dimensionToScreen)).type = STARTING;
    entrances.add( phenotype((int)(mouseX/dimensionToScreen),(int)(mouseY/dimensionToScreen)));
    startChosen = true;
  }
  if(keyPressed)
  {
    if(key == ' ' && startChosen)
    {
        createGraph();  
        createInitialCorridors();  
       //  createFinalCorridors();  
    }
  }
  for(int i = 0;i< phenotype.length;i++)
  {
    for(int j = 0;j< phenotype[i].length;j++)
    {
    
      fill(getAppearance(phenotype[i][j].type));
      rect(i*dimensionToScreen,j*dimensionToScreen,dimensionToScreen,dimensionToScreen);

    }
  }
  
}

SimpleGraph<Cell, Border> graph = new SimpleGraph<Cell, Border>(Border.class);
void createGraph()
{

 for(int i = 0;i< phenotype.length;i++)
  {
    for(int j = 0;j< phenotype[i].length;j++)
    {
       Cell cell = phenotype(i,j);
       if(cell.type != SPACE)
       {
           graph.addVertex(cell);
           ArrayList<Cell> adjs = new ArrayList<Cell>();
           adjs.addAll(Cell.getAdjacent4Graph(phenotype(i,j)));
           for(int k = 0;k< adjs.size();k++)
            {
              Cell adjacentCell = adjs.get(k);
               Border b =  new Border();
               b.setCells(cell,adjacentCell);
              if(adjacentCell != null && adjacentCell.type != SPACE )
              {
                 graph.addVertex(adjacentCell);
                 graph.addEdge(cell,adjacentCell,b); 
                 
              }
            }
         
        }

    }
  }
}
 ArrayList<Cell> verticesInPath = new ArrayList<Cell>();
   ArrayList<Cell> entrances = new ArrayList<Cell>();
   boolean startChosen = false;
void createFinalCorridors()
{
  
 KruskalMinimumSpanningTree spanningTree=new KruskalMinimumSpanningTree(graph);
 
 Set<Border> treeSet = spanningTree.getMinimumSpanningTreeEdgeSet();
 
 Cell v1 = entrances.get(entrances.size()-1);//the entracnce is chosen at last
  for(int j = entrances.size()-1 ; j >=0;j--)
   {
                Cell v2 = entrances.get(j);
                verticesInPath.addAll(getVerticesFromSet(treeSet));              
   }
 
    for(int i = 0 ; i <verticesInPath.size();i++ )
        {
          verticesInPath.get(i).type = TREASURE;
        }
}

void createInitialCorridors()
{
   /*
  Iterator<Cell> it = graph.vertexSet().iterator();
    while(it.hasNext())
    {
      Cell cell = it.next();
      if(cell.type == ENTRANCE)
      {
          entrances.add(cell);
      }
    }*/
  if(!entrances.isEmpty())
   {
       // for(int i = 0 ; i <entraces.size();i++ )
       // {
          Cell v1 = entrances.get(entrances.size()-1);//the entracnce is chosen at last
          for(int j = entrances.size()-1 ; j >=0;j--)
          {
                Cell v2 = entrances.get(j);
                DijkstraShortestPath path = new DijkstraShortestPath(graph,v1,v2) ;        
                verticesInPath.addAll(getVertices(path.getPathEdgeList()));  
  
            
          }
        
       // }
      
        
        for(int i = 0 ; i <verticesInPath.size();i++ )
        {
          verticesInPath.get(i).type = TREASURE;
        }
  }
  
}

ArrayList<Cell> getVertices(List<Border> path)
{
  ArrayList<Cell> vertices = new ArrayList<Cell>();
  for(int i = 0 ; i <path.size();i++ )
  {
    vertices.add((Cell)graph.getEdgeTarget(path.get(i)));  
  }
    return vertices;

}

ArrayList<Cell> getVerticesFromSet(Set<Border> set)
{
  ArrayList<Cell> vertices = new ArrayList<Cell>();
  Iterator<Border> it = set.iterator();
  while(it.hasNext())
  { 
    vertices.add((Cell)graph.getEdgeTarget(it.next()));  
  } 
    return vertices;
}
void spaceFill(Cell cell,int halfWidth,int type,int outerCellType,int outerWidth)
{

    ArrayList<Cell> cells = new ArrayList<Cell>();
    cells.add(cell);
     ArrayList<Cell> outerCells = new ArrayList<Cell>();

    for(int i = 0 ; i < halfWidth+outerWidth;i++)
    {
       ArrayList<Cell> tmp = new ArrayList<Cell>();
        for(int j = 0 ; j < cells.size();j++)
        {  
              ArrayList<Cell> adj = new ArrayList<Cell>();
              adj.addAll(Cell.getAdjacent8(cells.get(j)));
              for(int k = 0 ; k < adj.size();k++)
              {
                 if(!cells.contains(adj.get(k)))
                 {
                     tmp.add(adj.get(k));
                 }
              }
              
        }
        if(i >= halfWidth )
        {
          if(outerCellType != -1)
          {
            outerCells.addAll(tmp);
            cells.addAll(tmp);
          }
        }
        else
          cells.addAll(tmp);
        
    }
     for(int j = 0 ; j < cells.size();j++)
     {
        cells.get(j).type = type;
     }
     int n =  (int)random(outerCells.size());
     
     for(int j = 0 ; j < outerCells.size();j++)
     {
       if(j==n)
           entrances.add(outerCells.get(j));

         outerCells.get(j).type = outerCellType;
     }
}
void spaceFill(Cell cell,int halfWidth)
{
    spaceFill(cell,halfWidth,cell.type,-1,DEFAULT_OUTER_WIDTH);
}
void spaceFill(Cell cell,int halfWidth,int innerType)
{
    spaceFill(cell,halfWidth,innerType,-1,DEFAULT_OUTER_WIDTH);
}
void spaceFill(int x,int y ,int halfWidth,int innerType)
{
    spaceFill(Cell.cell(x,y,innerType),halfWidth,innerType,-1,DEFAULT_OUTER_WIDTH);
}
void spaceFill(int x,int y ,int halfWidth,int innerType,int outerType)
{
    spaceFill(Cell.cell(x,y,innerType),halfWidth,innerType,outerType,DEFAULT_OUTER_WIDTH);
}
void spaceFill(int x,int y ,int halfWidth,int innerType,int outerType,int outerWidth)
{
    spaceFill(Cell.cell(x,y,innerType),halfWidth,innerType,outerType,outerWidth);
}

  color getAppearance(int cellType)
  {
    if(cellType == SPACE)
        return color(133,172,178);
    else if (cellType == WALL)
        return color(55,61,64);
    else if (cellType == STARTING)
         return color(68,170,41);
    else if (cellType == END)
         return color(243,248,20);      
   else if (cellType == MONSTER)
          return color(255,100,28);
    else if (cellType == TREASURE)
          return color(214,200,20);
   else if (cellType == ENTRANCE)
          return color(255,0,0);
    else
          return color(0);
  }

//Fills cells surrounding(x,y) in all eight directions with TYPE
void fillSurounding(int x,int y,int TYPE)
{
  phenotype(x+1,y).type = TYPE;
  phenotype(x-1,y).type = TYPE;
  phenotype(x,y+1).type = TYPE;
  phenotype(x,y-1).type = TYPE;
  phenotype(x+1,y+1).type = TYPE;
  phenotype(x+1,y-1).type = TYPE;
  phenotype(x-1,y+1).type = TYPE;
  phenotype(x-1,y-1).type = TYPE;
}
void fillSurounding(Cell cell,int fillType)
{
   fillSurounding(cell.x,cell.y,fillType);
}

void fillSurounding(Cell cell)
{
 fillSurounding(cell.x,cell.y,cell.type);
}
  static Cell phenotype(int x,int y)
  {
    x = constrain(x,0,phenotype.length-1);
    y = constrain(y,0,phenotype[0].length-1);
    return phenotype[x][y];
  } 
  static Cell phenotypeGraph(int x,int y)
  {
    if(x < 0 || x >= dimension || y < 0 || y >= dimension)
        return null;
    return phenotype[x][y];
  }