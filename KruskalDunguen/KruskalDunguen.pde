import org.jgrapht.graph.*; 
import java.util.*;
import java.util.function.*;
import org.jgrapht.graph.DefaultEdge;
import org.jgrapht.alg.*;


static  Cell[][] grid;
static int dimension = 20;
static int dimensionToScreen = 40;

ArrayList<Border> treeArray;



//TODO
/**
currently I created a maze through finding the minimum spanning tree after assigning random weights to the edges in graph of the grid 
now I want to create a Tree out of this to make operations like "cutting the child with minumun weight" easier
currently I reassign all the weights to 1 afer fining the MSP to help in that
so turn @treeArray  to a tree
Use the class NODE

pick a root
get the outgoing edges (based on infro in treeArray NOT on the gragh , or get the edges from graph then filter those not in treeArray)
for each target vertex create a child
assign value = 1
assign parent to self
add child to children
add children to a queue (BFS)

continue until ....

then having the tree ready 
start from the root
remove the child with the minimum sum of value in his childes recursivle
          1(root)
value = 3/ \    value = 5
        /   \
       /     \
      1       1
     / \     / \
    /   \   /   \
   1     1 1     1
                / \
               /   \
              1     1
           
           
      here you remove the first child becaue his sum of value is 3 while the second is 5

*/
void setup()
{
  //size(800,800);
  surface.setSize(dimension*dimensionToScreen,dimension*dimensionToScreen);
  grid = new Cell[40][40];
  
  for(int i = 0;i< grid.length;i++)
  {
    for(int j = 0;j< grid[i].length;j++)
    {
      grid[i][j] = Cell.cell(i,j);
    }
  }
     createGraph();  
     KruskalMinimumSpanningTree spanningTree=new KruskalMinimumSpanningTree(graph);
     treeArray = new ArrayList<Border>(spanningTree.getMinimumSpanningTreeEdgeSet());
     
     Iterator<Border> it = graph.edgeSet().iterator();
     while(it.hasNext())
     {
       graph.setEdgeWeight(it.next(),1);
     }
    
    

}



Node root;

void draw()
{
   clear();



  if(mousePressed)
  {
      for(int i = 0;i< grid.length;i++)
      {
        for(int j = 0;j< grid[i].length;j++)
        {
          if(grid[i][j].contains(mouseX,mouseY))
          {
            rect(grid[i][j].x*dimension,grid[i][j].y *dimension,dimension,dimension);
            println(Cell.getAdjacent8(i,j));
          }
        }
      }
  }
  if(keyPressed)
  {
    if(key == ' ')
    {
        clear();
        graph = new SimpleWeightedGraph<Cell, Border>(Border.class);
        createGraph();  
        KruskalMinimumSpanningTree spanningTree=new KruskalMinimumSpanningTree(graph);     
        treeArray = new ArrayList<Border>(spanningTree.getMinimumSpanningTreeEdgeSet());
        Iterator<Border> it = graph.edgeSet().iterator();
         while(it.hasNext())
         {
           graph.setEdgeWeight(it.next(),1);
         }
    }
    if(key == 't')//create Tree
    {
         ArrayList<Node<Cell>> visited =  new ArrayList<Node<Cell>>();
    
         Queue<Node<Cell>> queue = new  LinkedList<Node<Cell>>();
         ArrayList<Cell> vertices = getVerticesFromSet(treeArray);
         //  println("vertices "+vertices);
         root = new Node(vertices.get(0));
         root.addAllChildren(getChildrenInTree(treeArray,root));
         queue.add(root);
          int count = 0 ; 
         while(!queue.isEmpty())
          {
          //     println("Queue : "+queue);
               Node<Cell> n = queue.remove();
               if(!visited.contains(n))
                {
                    visited.add(n);
             //       println(n + " : "+n.children);
                   for(int i = 0;i< n.children.size();i++)
                    {
                       Node<Cell> child = n.children.get(i);
                       
                       child.addAllChildren(getChildrenInTree(treeArray,child));
                       
                       child.children.remove(child.parent);
                       if(!queue.contains(child))
                           queue.offer(child);
                    } 
                    count++;
                    if(count > vertices.size())
                    {
                      break;
                    }
                }
          }
          
          //   println(vertices.size() + " Final Num nodes = " + root.getValue(root));
          //   println("Final Queue " +queue);
    }
    if(key == 'r')//create Tree
    {
      
      Node<Cell> m = root;
      for(int i = 0 ; i < 10 ;i++)
      {
         /*
         ArrayList<Node<Cell>> childrenArray = new ArrayList<Node<Cell>>(m.children);
         if(childrenArray.size() == 0)
           break;
         if(childrenArray.size() == 1)
           {
               m = childrenArray.get(0);
               continue;
           }
         Collections.sort(childrenArray);
         childrenArray.remove(0);
         m.children = childrenArray;
         m = m.children.get(0);
         */
         removeALeaf(root);         
      }
      updateTreeArray(treeArray,root);    
    }
    
  }
  
  for(int i = 0;i< treeArray.size();i++)
  {
    treeArray.get(i).show(); 
  }
  
}

void removeALeaf(Node<Cell> tree)
{
  Node<Cell> node = tree;
  while(true)
  {
    Node<Cell> child = node.children.get((int)random(node.children.size()));
    if(child.isLeaf())
    {      
      node.children.remove(child);
      break;
    }
    node = child;
  }
}
void updateTreeArray(ArrayList<Border> treeArray,Node<Cell> tree)
{
     Queue<Node<Cell>> queue = new  LinkedList<Node<Cell>>();
      treeArray.clear();
      queue.add(tree);
      while(!queue.isEmpty())
      {
            Node<Cell> n = queue.remove();
           for(int i = 0;i< n.children.size();i++)
            {
                  
               Node<Cell> child = n.children.get(i);
                Border b =new Border();
                b.setCells(n.data,child.data);
                treeArray.add(b);  
               for(int j = 0;j< child.children.size();j++)
                {
                   queue.add( child.children.get(j));
                }
            }        
      }
      

}



ArrayList<Node<Cell>> getChildrenInTree(final ArrayList<Border> treeArray,Node<Cell> node)
{
    //  println(node + " ,Tree array = "+treeArray);
     ArrayList<Border>  adjacents = new ArrayList<Border>(graph.edgesOf(node.data));
     adjacents.removeIf(new Predicate<Border>(){
          @Override
          public boolean test(Border edge) 
          {  
            return !treeArray.contains(edge);
          } 
     });

     ArrayList<Node<Cell>> result = getNodesFromSetAndAssignParent(root,adjacents);
     result.remove(node);
   //  println("Result = "+result);
      return result;

    //getNodesFromSetAndSetParent(root,graph.edgesOf(vertices.get(0)))
}

ArrayList<Node<Cell>> getNodesFromSetAndAssignParent(Node<Cell> parent ,ArrayList<Border> array)
{
  ArrayList<Cell> vertices =getVerticesFromSet(array);
  ArrayList<Node<Cell>> nodes = new ArrayList<Node<Cell>>();
  for(int i = 0;i< vertices.size();i++)
  {
    Node<Cell> node = new Node<Cell>(vertices.get(i));
    node.parent = parent;
    nodes.add(node);
  }
    return nodes;
}


ArrayList<Cell> getVerticesFromSet(ArrayList<Border> array)
{
  Set<Cell> vertices = new LinkedHashSet<Cell>();
  Iterator<Border> it = array.iterator();
  while(it.hasNext())
  { 
    Border b = it.next();
    vertices.add((Cell)graph.getEdgeTarget(b));  
    vertices.add((Cell)graph.getEdgeSource(b)); 
  } 
    return new ArrayList<Cell>(vertices);
}
SimpleWeightedGraph<Cell, Border> graph = new SimpleWeightedGraph<Cell, Border>(Border.class);
void createGraph()
{

  for(int i = 0;i< grid.length;i++)
  {
    for(int j = 0;j< grid[i].length;j++)
    {
       Cell cell = grid(i,j);
           graph.addVertex(cell);
           ArrayList<Cell> adjs = new ArrayList<Cell>();
           adjs.addAll(Cell.getAdjacent4Graph(grid(i,j)));
           for(int k = 0;k< adjs.size();k++)
            {
              Cell adjacentCell = adjs.get(k);
               Border b =  new Border();
               b.setCells(cell,adjacentCell);
               
              if(adjacentCell != null)
              {
                 graph.addVertex(adjacentCell);
                 graph.addEdge(cell,adjacentCell,b); 
                 graph.setEdgeWeight(b,random(20));
              }
            }
         
        

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







  static Cell grid(int x,int y)
  {
    x = constrain(x,0,grid.length-1);
    y = constrain(y,0,grid[0].length-1);
    return grid[x][y];
  } 
  static Cell phenotypeGraph(int x,int y)
  {
    if(x < 0 || x >= dimension || y < 0 || y >= dimension)
        return null;
    return grid[x][y];
  }
  