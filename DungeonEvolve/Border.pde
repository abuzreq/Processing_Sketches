
public static class Border extends DefaultEdge
{
  Cell s1, s2 ;  

  void setCells(Cell s1,Cell s2)
  {
    this.s1 = s1 ;
    this.s2 = s2 ;
  }
  Cell getC1()
  {
    return s1 ;
  }
  Cell getC2()
  {
    return s2 ;
  }
  
  @Override
  public boolean equals(Object obj)
  {
    Border other = (Border)obj;
    return this.s1.equals(other.s1) && this.s2.equals(other.s2);
  }
}