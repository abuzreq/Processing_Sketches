
public  class Border extends DefaultWeightedEdge
{
  Cell s1, s2 ;  
  void show()
  {
    stroke(0,0,255);
    line(s1.x*dimensionToScreen+dimensionToScreen/2,s1.y*dimensionToScreen+dimensionToScreen/2,s2.x*dimensionToScreen+dimensionToScreen/2,s2.y*dimensionToScreen+dimensionToScreen/2);
  }
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
  public int hashCode()
  {
    return (s1.toString()+":"+s2.toString()).hashCode();
  }
  @Override
  public boolean equals(Object obj)
  {
    Border other = (Border)obj;
    return this.s1.equals(other.s1) && this.s2.equals(other.s2) || this.s1.equals(other.s2) && this.s2.equals(other.s1);
  }
}