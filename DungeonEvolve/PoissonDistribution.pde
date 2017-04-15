import java.util.*;
class PoissonDistribution
{
  /** From "Fast Poisson Disk Sampling in Arbitrary Dimensions"
  * by Robert Bridson
  * http://www.cs.ubc.ca/~rbridson/docs/bridson-siggraph07-poissondisk.pdf
  **/
  
  PoissonDistribution()
  {
    _points = new ArrayList<PVector>();
  }
  
  ArrayList<PVector> getPoints() { return _points; }
  
  ArrayList<PVector> generate(float xmin, float ymin, float xmax, float ymax, float minDist, int rejectionLimit)
  {
    _xmin = xmin; _xmax = xmax; _ymin = ymin; _ymax = ymax;
    _cellSize = minDist / sqrt(2);
    _gridWidth = ceil((xmax-xmin) / _cellSize);
    _gridHeight = ceil((ymax-ymin) / _cellSize);
    int s = _gridWidth * _gridHeight;
    _grid = new ArrayList<ArrayList<PVector>>();
    for(int i=0; i<s; i++)
      _grid.add(new ArrayList<PVector>());
    
    _points.clear();
    LinkedList<PVector> processList = new LinkedList<PVector>();
    
    PVector p = new PVector(random(_xmin, _xmax), random(_ymin, _ymax));
    processList.add(p);
    _points.add(p);
    addToGrid(p);

    while(processList.size() > 0)
    {
      int i = floor(random(processList.size()));
      p = processList.get(i);
      processList.remove(i);
      for(i=0; i<rejectionLimit; i++)
      {
        PVector n = createRandomPointAround(p, minDist, minDist*2);
        if(insideBoundaries(n) && testGrid(n, minDist)) {
          processList.add(n);
          _points.add(n);
          addToGrid(n);
        }
      }
    }
    
    return _points;
  }
  
  boolean insideBoundaries(PVector p)
  {
    return (p.x >= _xmin && p.x < _xmax && p.y >= _ymin && p.y < _ymax);
  }
  
  PVector createRandomPointAround(PVector p, float minDist, float maxDist)
  {
    float a = random(2*PI);
    float r = random(minDist, maxDist);
    return new PVector(p.x + r * cos(a), p.y + r * sin(a));
  }
  
  // return true if there are no points inside the circle of minDist radius around p
  boolean testGrid(PVector p, float minDist)
  {
    int minX = floor(max(0, (p.x - minDist - _xmin) / _cellSize));
    int maxX = ceil(min(_gridWidth - 1, (p.x + minDist - _xmin) / _cellSize));
    int minY = floor(max(0, (p.y - minDist - _ymin) / _cellSize));
    int maxY = ceil(min(_gridHeight - 1, (p.y + minDist - _ymin) / _cellSize));
    
    for(int y=minY; y<=maxY; y++) {
      for(int x=minX; x<=maxX; x++) {
        ArrayList<PVector> cell = _grid.get(y * _gridWidth + x);
        for(PVector t : cell)
          if(dist(p.x, p.y, t.x, t.y) <= minDist)
            return false;
      }
    }
    
    return true;
  }
  
  void addToGrid(PVector p)
  {
    _grid.get(index(p.x, p.y)).add(p);
  }
  
  protected int index(float x, float y)
  {
    int gx = floor((x - _xmin) / _cellSize);
    int gy = floor((y - _ymin) / _cellSize);
    return gy * _gridWidth + gx;
  }
  
  private ArrayList<ArrayList<PVector>> _grid;
  private float _cellSize;
  private int _gridWidth, _gridHeight;
  private float _xmin, _xmax, _ymin, _ymax;
  private ArrayList<PVector> _points;
}