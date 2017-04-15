import org.jgrapht.graph.*; 
import java.util.*;
import java.util.function.*;
import org.jgrapht.graph.DefaultEdge;
import org.jgrapht.alg.*;


static  Cell[][] grid;
static int dimension = 40;
static int dimensionToScreen = 20;

void setup()
{
  surface.setSize(dimension*dimensionToScreen, dimension*dimensionToScreen);
  grid = new Cell[40][40];

  for (int i = 0; i< grid.length; i++)
  {
    for (int j = 0; j< grid[i].length; j++)
    {
      grid[i][j] = Cell.cell(i, j);
    }
  }
  createGraph();
  for (int i = 0; i< grid.length; i++)
  {
    for (int j = 0; j< grid[i].length; j++)
    {
      grid[i][j].value = random(100)*random(100);
    }
  }

  
}

void draw()
{

for (int i = 0; i< grid.length; i++)
  {
    for (int j = 0; j< grid[i].length; j++)
    {
      fill(0);
      //text((int)grid[i][j].value+"",grid[i][j].x*dimension/2.0,grid[i][j].y*dimension/2.0);
      ArrayList<Cell> adjs = Cell.getAdjacent8(i, j);
      Cell minCell = adjs.get(0);
      float minValue = adjs.get(0).value;
      for (int k = 1; k < adjs.size(); k++)
      {
        if (adjs.get(k).value < minValue)
        {   
          minValue = adjs.get(k).value;
          minCell = adjs.get(k);
        }
      }
      stroke(255);
      fill(255);
    line(grid[i][j].x*dimension/2.0,grid[i][j].y*dimension/2.0,minCell.x*dimension/2.0,minCell.y*dimension/2.0);
    }
  }
}


static Cell grid(int x, int y)
{
  x = constrain(x, 0, grid.length-1);
  y = constrain(y, 0, grid[0].length-1);
  return grid[x][y];
} 
static Cell phenotypeGraph(int x, int y)
{
  if (x < 0 || x >= dimension || y < 0 || y >= dimension)
    return null;
  return grid[x][y];
}

SimpleWeightedGraph<Cell, Border> graph = new SimpleWeightedGraph<Cell, Border>(Border.class); 
void createGraph()
{

  for (int i = 0; i< grid.length; i++)
  {
    for (int j = 0; j< grid[i].length; j++)
    {
      Cell cell = grid(i, j);
      graph.addVertex(cell);
      ArrayList<Cell> adjs = new ArrayList<Cell>();
      adjs.addAll(Cell.getAdjacent4Graph(grid(i, j)));
      for (int k = 0; k< adjs.size(); k++)
      {
        Cell adjacentCell = adjs.get(k);
        Border b =  new Border();
        b.setCells(cell, adjacentCell);

        if (adjacentCell != null)
        {
          graph.addVertex(adjacentCell);
          graph.addEdge(cell, adjacentCell, b); 
          graph.setEdgeWeight(b, random(20));
        }
      }
    }
  }
}