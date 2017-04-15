public static class Cell
{
  boolean isVisited = false;
  int x, y;
  static Cell cell(int nx,int ny)
  {
    return new Cell(nx,ny);
  }
  private Cell(int nx,int ny)
  {
    x = nx;
    y = ny;
  }
  static ArrayList<Cell> getAdjacent4(Cell cell)
  {
    return getAdjacent4(cell.x,cell.y);
  }

   static ArrayList<Cell> getAdjacent8(Cell cell)
  {
    return getAdjacent8(cell.x,cell.y);
  }
  static ArrayList<Cell> getAdjacent4(int x,int y)
  {
    ArrayList<Cell> cells = new ArrayList<Cell>();
      cells.add(grid(x+1,y));
      cells.add(grid(x-1,y)); 
      cells.add(grid(x,y+1));
      cells.add(grid(x,y-1));
     return cells; 
  }
 static ArrayList<Cell> getAdjacent4Graph(int x,int y)
  {
    ArrayList<Cell> cells = new ArrayList<Cell>();
      cells.add(phenotypeGraph(x+1,y));
      cells.add(phenotypeGraph(x-1,y)); 
      cells.add(phenotypeGraph(x,y+1));
      cells.add(phenotypeGraph(x,y-1));
     return cells; 
  }
  static ArrayList<Cell> getAdjacent4Graph(Cell cell)
  {
     return getAdjacent4Graph(cell.x,cell.y);
  }
 static ArrayList<Cell> getAdjacent8(int x,int y)
  {    
    
    ArrayList<Cell> cells = new ArrayList<Cell>();
      cells.add(grid(x+1,y));
      cells.add(grid(x-1,y)); 
      cells.add(grid(x,y+1));
      cells.add(grid(x,y-1));
      cells.add(grid(x+1,y+1));
      cells.add(grid(x+1,y-1)); 
      cells.add(grid(x-1,y+1));
      cells.add(grid(x-1,y-1));  
     return cells;     
  }
 
  public boolean equals(Cell other)
  {
    return this.x == other.x && this.y == other.y;
  }
  
  public String toString() 
  {
     return x+":"+y;
  }
  public int hashCode()
  {
    return this.toString().hashCode();
  }
  
  public boolean contains(float x ,float y)
  {
      return (x > this.x*dimension && x < this.x*dimension + dimension ) && (y > this.y*dimension && y < this.y*dimension + dimension);
  }

}
  
  