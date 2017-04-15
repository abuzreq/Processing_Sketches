public static class Cell
{
  
  int x, y;
  int type ;
  
  static Cell cell(int nx,int ny,int type)
  {
    return new Cell(nx,ny,type);
  }
  private Cell(int nx,int ny,int ntype)
  {
    x = nx;
    y = ny;
    type = ntype;
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
      cells.add(phenotype(x+1,y));
      cells.add(phenotype(x-1,y)); 
      cells.add(phenotype(x,y+1));
      cells.add(phenotype(x,y-1));
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
      cells.add(phenotype(x+1,y));
      cells.add(phenotype(x-1,y)); 
      cells.add(phenotype(x,y+1));
      cells.add(phenotype(x,y-1));
      cells.add(phenotype(x+1,y+1));
      cells.add(phenotype(x+1,y-1)); 
      cells.add(phenotype(x-1,y+1));
      cells.add(phenotype(x-1,y-1));  
     return cells;     
  }
  boolean isSpace()
  {
    return type == SPACE;
  }
 boolean isWall()
  {
    return type == WALL;
  }

 boolean isStarting()
  {
    return type == STARTING;
  }
   boolean isEnd()
  {
    return type == END;
  }
   boolean isMonster()
  {
    return type == MONSTER;
  }
    boolean isTreasure()
  {
    return type == TREASURE;
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

}