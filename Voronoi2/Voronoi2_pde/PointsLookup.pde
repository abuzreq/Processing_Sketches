// Because I am messy when creating polygons, I have to look for similar points
class PointsLookup
{
  PointsLookup(float xmin, float ymin, float xmax, float ymax, int cellSize, float tolerance)
  {
    _xmin = xmin; _xmax=xmax;
    _ymin = ymin; _ymax=ymax;
    _cs = cellSize;
    _tol = tolerance;
    _tol2 = tolerance*tolerance;
    _data = new Vector<Vector<PVector>>();
    float fw = xmax - xmin, fh = ymax - ymin;
    _w = ceil(fw / (float)_cs); _h = ceil(fh / (float)_cs); // grid of 10x10 pixels
    int s = _w * _h; 
    for(int i=0; i<s; i++)
      _data.add(new Vector<PVector>());
    _points = new Vector<PVector>();
  }
  
  PVector getPoint(float x, float y)
  {
    // if outside boundaries
    if((x < _xmin - _tol || x > _xmax + _tol) && (y < _ymin - _tol || y > _ymax + _tol))
      return new PVector(x, y); // don't save that point for lookup
      
    int px = constrain(floor((x-_xmin)/_cs), 0, _w-1);
    int py = constrain(floor((y-_ymin)/_cs), 0, _h-1);
    
    // first try the most plausible location
    Vector<PVector> pts = _data.get(py*_w+px);
    for(PVector p : pts) {
      float dx = x-p.x, dy = y-p.y;
      if(dx*dx+dy*dy <= _tol2)
        return p;
    }
    
    // then check the neighbours
    for(int gy=max(py-1, 0); gy<=min(py+1, _h-1); gy++) {
      for(int gx=max(px-1, 0); gx<=min(px+1, _w-1); gx++) {
        if(gx==px && gy==py) // already tested
          continue;
        pts = _data.get(gy*_w+gx);
        for(PVector p : pts) {
          float dx = x-p.x, dy = y-p.y;
          if(dx*dx+dy*dy <= _tol2)
            return p;
        }
      }
    }
      
    PVector pt = new PVector(x, y);
    _points.add(pt);
    _data.get(py*_w+px).add(pt);
    return pt;
  }
  
  PVector getPoint(PVector p) { 
    if(p == null) return null;
    return getPoint(p.x, p.y); 
  }
  
  Vector<PVector> getPoints() { return _points; }
  
  private float _tol, _tol2;
  private int _w, _h, _cs;
  private float _xmin, _xmax, _ymin, _ymax;
  private Vector<PVector> _points;
  private Vector<Vector<PVector>> _data;
}