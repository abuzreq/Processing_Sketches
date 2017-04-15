int getBiome(float elevation, float moisture, boolean water, boolean ocean, boolean coast)
{
  if(ocean) {
    return 1;  // Ocean
  } else if(water) {
    if (elevation < 0.1) return 2;  // Marsh
    if (elevation > 0.8) return 3;  // Ice
    return 4;  // Lake
  } else if(coast) {
    return 5;  // Beach
  } else if(elevation > 0.8) {
    if(moisture > 0.50) return 6;  // Snow
    else if(moisture > 0.33) return 7;  // Tundra
    else if(moisture > 0.16) return 8;  // Bare
    else return 9;  // Scorched
  } else if(elevation > 0.6) {
    if(moisture > 0.66) return 10;  // Taiga
    else if(moisture > 0.33) return 11;  // Shrubland
    else return 12;  // Temperate desert
  } else if(elevation > 0.3) {
    if(moisture > 0.83) return 13;  // Temperate rain forest
    else if(moisture > 0.50) return 14;  // Temperate deciduous forest
    else if(moisture > 0.16) return 15;  // Grassland
    else return 12;  // Temperate desert
  } else {
    if(moisture > 0.66) return 16;  // Tropical rain forest
    else if(moisture > 0.33) return 17;  // Tropical seasonal forest
    else if(moisture > 0.16) return 15;  // Grassland
    else return 18;  // Subtropical desert
  }
}

class Map
{
int nbPoints = 1000;
float relaxEdgesAmount = 0.5;  // uniformization of the edges length (for polygonal maps)
float noiseScale = 3;  // higher means more detailled features (if enough points to represent them)
float landMassFractionMin = 0.3;  // [0;1] fraction of points required to be land
float landMassFractionMax = 0.7;
float riversFraction = 0.15;  // [0;1] influence the number of rivers
float lakeThreshold = 0.3; // [0;1] fraction of water points required for a face to become a lake
boolean createNoisyEdges = true; // straight or noisy edges ?
final float epsilon = 0.1;

color[] biomesColor = {
  color(0, 0, 0),        // void
  color(68, 68, 122),    // Ocean
  color(47, 102, 102),   // Marsh
  color(153, 255, 255),  // Ice
  color(51, 102, 153),   // Lake
  color(160, 144, 119),  // Beach
  color(255, 255, 255),  // Snow
  color(187, 187, 170),  // Tundra
  color(136, 136, 136),  // Bare
  color(85, 85, 85),     // Scorched
  color(153, 170, 119),  // Taiga
  color(136, 153, 119),  // Shrubland
  color(201, 210, 155),  // Temperate desert
  color(68, 136, 85),    // Temperate rain forest
  color(103, 148, 89),   // Temperate deciduous forest
  color(136, 170, 85),   // Grassland
  color(51, 119, 85),    // Tropical rain forest
  color(85, 153, 68),    // Tropical seasonal forest
  color(210, 185, 139),  // Subtropical desert
};

final color colorRiver = color(34, 85, 136);
final color colorCoast = color(51, 51, 90);

class Point
{
  int index;
  PVector pos;
  boolean water, ocean, coast, border;
  float elevation, moisture;
  int river;
  Point downslope;
  
  ArrayList<Face> faces;
  ArrayList<Edge> edges;
  ArrayList<Point> neighbours;
  
  Point(PVector tpos) { 
    pos = tpos.get(); 
    faces = new ArrayList<Face>();
    edges = new ArrayList<Edge>();
    neighbours = new ArrayList<Point>();
    
    water = ocean = coast = false;
    border = (pos.x <= epsilon || pos.y <= epsilon 
      || pos.x >= width-epsilon || pos.y >= height-epsilon);
    elevation = moisture = 0.0;
    river = 0;
  }
}

class Edge
{
  int index;
  Face f1, f2;
  Point p1, p2;
  boolean coast, shore;
  ArrayList<PVector> noisy1, noisy2; // 2 noisy half edges
  int river;
  
  Edge() {
    river = 0;
    coast = shore = false;
  }
  
  boolean contains(Point p) {
    return (p1 == p || p2 == p);
  }
}

class Face
{
  int index;
  PVector pos;
  boolean water, ocean, coast, border;
  float elevation, moisture;
  int biome;
  
  ArrayList<Face> neighbours;
  ArrayList<Edge> edges;
  ArrayList<Point> points;
  
  Face() {
    neighbours = new ArrayList<Face>();
    edges = new ArrayList<Edge>();
    points = new ArrayList<Point>();
    elevation = moisture = 0.0;
    water = ocean = coast = border = false;
    biome = 0;
  }
  
  void drawSimple()
  {
    beginShape();
    for(Point p : points)
      vertex(p.pos.x, p.pos.y);
    endShape();
  }
  
  void drawNoisy()
  {
    beginShape();
    for(Edge e : edges) {
      if(e.f1 == this)
      {
        if(e.noisy1 == null || e.noisy2 == null) {
          vertex(e.p1.pos.x, e.p1.pos.y);
          vertex(e.p2.pos.x, e.p2.pos.y);
        } else {
          drawPathForwards(e.noisy1);     
          drawPathBackwards(e.noisy2);   
        }
      } else { // reverse order
        if(e.noisy1 == null || e.noisy2 == null) {
          vertex(e.p2.pos.x, e.p2.pos.y);
          vertex(e.p1.pos.x, e.p1.pos.y);
        } else {
          drawPathForwards(e.noisy2);     
          drawPathBackwards(e.noisy1);   
        }
      }
    } 
    endShape(CLOSE);
  }
  
  float getArea()
  {
    float area = 0;
    int nb = points.size();
    PVector p2 = points.get(nb-1).pos;
    for(Point p : points) {
      area += p.pos.x * p2.y - p2.x * p.pos.y;// (cross product)
      p2 = p.pos;
    }
    return area;
  }
  
  PVector getCentroid()
  {
    PVector centroid = new PVector();
    float area = 0;
    int nb = points.size();
    PVector p2 = points.get(nb-1).pos;
    for(Point p : points) {
      float a = p.pos.x * p2.y - p2.x * p.pos.y;// (cross product)
      area += a;
      centroid.add(PVector.mult(PVector.add(p.pos, p2), a));
      p2 = p.pos;
    }
    centroid.mult(1/(3*area));
    return centroid;
  }
  
  void flipVertexOrder()
  {
    ArrayList<Point> old = points;
    points = new ArrayList<Point>();
    for(int i=old.size()-1; i>=0; i--)
      points.add(old.get(i)); 
  }
}

void drawPathForwards(ArrayList<PVector> pts) {
  for(PVector p : pts) 
    vertex(p.x, p.y);
}

void drawPathBackwards(ArrayList<PVector> pts) {
  for(int i = pts.size()-1; i>=0; i--) {
    PVector p = pts.get(i);
    vertex(p.x, p.y);
  }
}

ArrayList<Point> pointsList;
ArrayList<Edge> edgesList;
ArrayList<Face> facesList;
Vector<PVector> voronoiPoints; // used before the creation of the graph
boolean created = false;
int creationStep = 0;
int mapSeed;
float landMassFraction = 0.5;
int nbRivers;

Map(PApplet applet)
{
  noiseDetail(8);
}

void createPoints()
{
  PoissonDistribution distrib = new PoissonDistribution();
  float d = sqrt(width * height * 0.61 / nbPoints);
  voronoiPoints = distrib.generate(0, 0, width, height, d, 20);
}

void addToList(ArrayList list, Object obj) {
  if(obj != null && !list.contains(obj))
    list.add(obj);
}

Edge getEdge(Point pt1, Point pt2)
{
  for(Edge e : pt1.edges) {
    if(e.contains(pt2))
      return e;
  }
  
  for(Edge e : pt2.edges) {
    if(e.contains(pt1))
      return e;
  }
  
  Edge e = new Edge();
  e.index = edgesList.size();
  e.p1 = pt1; e.p2 = pt2;
  edgesList.add(e);
  pt1.edges.add(e);
  pt1.neighbours.add(pt2);
  pt2.edges.add(e);
  pt2.neighbours.add(pt1);
  return e;
}

void createGraph()
{
  pointsList = new ArrayList<Point>();
  edgesList = new ArrayList<Edge>();
  facesList = new ArrayList<Face>();
  
  Voronoi voronoi = new Voronoi();
  voronoi.setBoundaries(0, 0, width, height);
  voronoi.computeVoronoi(voronoiPoints);
  if(!voronoi.ok) { // Rare bug I have yet to correct
    println("Error, stoping creation");
    return;
  }
  
  HashMap<PVector, Point> pointsLookup = new HashMap<PVector, Point>();
 
  for(Voronoi.Site site : voronoi.sites) {
    if(site.points.size() < 3) continue;
    Face f = new Face();
    f.index = facesList.size();
    facesList.add(f);

    for(PVector p : site.points) {
      Point pt = pointsLookup.get(p);
      if(pt == null) {
        pt = new Point(p);
        pointsList.add(pt);
        pointsLookup.put(p, pt);
      }
      addToList(f.points, pt);
      addToList(pt.faces, f);
    }
    
    if(f.getArea() < 0)
      f.flipVertexOrder();
    f.pos = f.getCentroid();
    
    int nb = f.points.size();
    for(int j=0; j<nb; j++) {
      Point pt1 = f.points.get(j);
      Point pt2 = f.points.get((j+1) % nb);
      Edge e = getEdge(pt1, pt2);
      if(e.f1 == null)
        e.f1 = f;
      else if(e.f2 == null) {
        e.f2 = f;
        f.neighbours.add(e.f1);
        e.f1.neighbours.add(f);
      }
      f.edges.add(e);
    }
  }

  voronoiPoints = null;
}

// TODO : useless with changes in Processing 2.0
PVector lerpVector(PVector v1, PVector v2, float amt)
{
  return new PVector(v1.x + (v2.x - v1.x) * amt, v1.y + (v2.y - v1.y) * amt);
}

// Moving close points apart
void relaxEdges()
{
  ArrayList<PVector> tempPos = new ArrayList<PVector>();
  for(int i=0; i<pointsList.size(); i++) {
    Point pt = pointsList.get(i);
    if(pt.border)
      tempPos.add(pt.pos);
    else {
      PVector p = new PVector(0, 0);
      for(Face f : pt.faces)
        p.add(f.pos);
      p.mult(1.0 / pt.faces.size());
      tempPos.add(p);
    }
  }
  
  for(int i=0; i<tempPos.size(); i++)
    pointsList.get(i).pos = lerpVector(pointsList.get(i).pos, tempPos.get(i), relaxEdgesAmount);
}

float getNoiseValue(PVector v)
{
  float tx = 2 * v.x / width - 1, ty = 2 * v.y / height - 1;
  float d = tx*tx + ty*ty;
  if(d < 0.5) d = 0;
  else d = pow(d * 2 - 1, 2);
  return noise(tx*noiseScale+1000, ty*noiseScale+1000) - 0.5 * d;
}

void createIslandForm()
{
  // I compute a noise threshold so that there always is a certain fration of land mass in the map
  ArrayList<Float> noiseValues = new ArrayList<Float>();
  for(Point p : pointsList)
    noiseValues.add(getNoiseValue(p.pos));
    
  Collections.sort(noiseValues, Collections.reverseOrder());
  int nb = noiseValues.size();
  int thresholdIndex = constrain(floor(nb * landMassFraction), 0, nb - 1);
  float noiseThreshold = noiseValues.isEmpty() ? 0 : noiseValues.get(thresholdIndex);
  
  for(Point p : pointsList)
    p.water = (getNoiseValue(p.pos) < noiseThreshold);
}

void assignWater()
{
  Queue<Face> queue = new LinkedList<Face>();
  // Borders
  for(Point p : pointsList) {
    if(p.border) {
      p.water = true;
      for(Face f : p.faces) {
        f.border = true;
        f.ocean = true;
        f.water = true;
        queue.offer(f);
      }
    }
  }
  
  // Determining water and land
  for(Face f :  facesList) {
    if(f.ocean) continue;
    int nbWater = 0;
    for(Point p : f.points) {
      if(p.water)
        nbWater++;
    }
    
    f.water = (nbWater >= f.points.size() * lakeThreshold);
  }
 
  // Propagation of oceans
  while(queue.peek() != null) {
    Face f = queue.poll();
    for(Face n : f.neighbours) {
      if(n.water && !n.ocean) {
        n.ocean = true;
        queue.offer(n);
      }
    }
  }
  
  // Coast
  for(Face f : facesList) {
    int nbOcean = 0;
    int nbLand = 0;
    for(Face n : f.neighbours) {
      if(n.ocean) nbOcean++;
      if(!n.water) nbLand++;
    }
    f.coast = (nbOcean > 0) && (nbLand > 0);
  }
  
  // Points attributes
  for(Point p : pointsList) {
    int nbOcean = 0;
    int nbLand = 0;
    for(Face f : p.faces) {
      if(f.ocean) nbOcean++;
      if(!f.water) nbLand++;
    }
    p.ocean = (nbOcean == p.faces.size());
    p.coast = (nbOcean > 0) && (nbLand > 0);
    p.water = p.border || (!p.coast && nbLand < p.faces.size());
  }
  
  // Edges attributes
  for(Edge e : edgesList) {
    if(e.f2 == null) continue;
    e.coast = (e.f1.ocean != e.f2.ocean);
    e.shore = (e.f1.water != e.f2.water);
  }
}

void computeElevation()
{
  Queue<Point> queue = new LinkedList<Point>();
  // Starting from borders
  for(Point p : pointsList) {
    if(p.border) {
      p.elevation = 0.0;  // points on the border are at the lowest elevation
      queue.offer(p);
    } else
      p.elevation = 1e10;
  }
  
  // Propagating elevation
  while(queue.peek() != null) {
    Point p = queue.poll();
    for(Point n : p.neighbours) {
      // value will be changed later on, but the order is better this way
      float ne = p.elevation + PVector.sub(p.pos, n.pos).mag();
      if(p.water && n.water)
        ne = p.elevation + 1e-3; 
        
      if(ne < n.elevation) {
        n.elevation = ne;
        queue.offer(n);
      }
    }
  }
  
  // Highest elevation ?
  float highest = 0;
  for(Point p : pointsList)
    if(p.elevation > highest)
      highest = p.elevation;
      
  // Scaling
  final float heightScaling = 2;
  ArrayList<Point> landPoints = new ArrayList<Point>();
  for(Point p : pointsList)
    if(!p.ocean && !p.coast)
      landPoints.add(p);
  class PointComparator implements Comparator<Point> { 
    public int compare(Point p1, Point p2) {
      return (p1.elevation < p2.elevation ? -1 : (p1.elevation == p2.elevation ? 0 : 1));
    }
  }
  Collections.sort(landPoints, new PointComparator());
  int l = landPoints.size();
  float v;
  for(int i=0; i<l; i++) {
    Point p = landPoints.get(i);
    //float frac = (float)i / (l - 1);
    float frac = p.elevation / highest;
    float e = sqrt(heightScaling) - sqrt(heightScaling * (1-frac));
    if(e > 1.0) e = 1.0;
    v = p.elevation;
    p.elevation = e;
    // if points share the same elevation
    int j=0;
    while((i+1)<l && landPoints.get(i+1).elevation < v + 1) {
      // just a little bit higher (for downslope computations)
      landPoints.get(i+1).elevation = e + j * 1e-5;  
      i++; j++;
    }
  }
  
  for(Point p : pointsList)
    if(p.ocean || p.coast)
      p.elevation = 0.0;
  
  for(Face f : facesList) {
    float sum = 0.0;
    for(Point p : f.points)
      sum += p.elevation;
    f.elevation = sum / f.points.size();
  }
}

void createRivers()
{
  // Determine downslope
  for(Point p : pointsList) {
    Point o = p;
    for(Point n : p.neighbours) {
      if(n.elevation <= o.elevation)
        o = n;
    }
    p.downslope = o;
  }
  
  // Determining possible river start points
  LinkedList<Point> riverPoints = new LinkedList<Point>();
  for(Point p : pointsList)
    if(!p.ocean && p.elevation >= 0.3 && p.elevation <= 0.9)
      riverPoints.add(p);
  class PointComparator implements Comparator<Point> { 
    public int compare(Point p1, Point p2) {
      return (p1.elevation < p2.elevation ? -1 : (p1.elevation == p2.elevation ? 0 : 1));
    }
  }
  Collections.sort(riverPoints, new PointComparator());
  
  // Generate some rivers
  // TODO river as float, grows depending on the edge length
  nbRivers = ceil(riversFraction * riverPoints.size());
  while(nbRivers > 0 && riverPoints.size()>0) {
    Point pStart = riverPoints.get(floor(random(riverPoints.size())));
    riverPoints.remove(pStart);
    Point p = pStart;
    
    // first testing the length of the river
    int l = 0;
    while(!p.coast) {
      if(p == p.downslope) {
        println("no downslope !");
        break;
      }
      p = p.downslope;
      l++;
    }
    
    if(l < 3) // min length of rivers (TODO : compute the length in pixels instead)
      continue;
    
    p = pStart;
    while(!p.coast) {
      if(p == p.downslope)
        break;
        
      Edge e = getEdge(p, p.downslope);
      e.river++;
      p.downslope.river += p.river;
      p = p.downslope;
      if(riverPoints.remove(p))
        nbRivers--;
    }
    
    pStart.river++;
    nbRivers--;
  }
}

void computeMoisture()
{
  // Moisture is created by rivers
  Queue<Point> queue = new LinkedList<Point>();
  for(Point p : pointsList) {
    if(!p.ocean && (p.water || p.river > 0)) {
      p.moisture = p.river > 0 ? min(3.0, (sqrt(p.river))) : 1.0;
      queue.offer(p);
    }
  }
  
  // Propagation of moisture
  float factor = 0.9;  // this is a factor I chose for nbPoints = 2000
  factor = pow(factor, sqrt(2000.0/nbPoints));
  while(queue.peek() != null) {
    Point p = queue.poll();
    float m = p.moisture * factor;
    for(Point n : p.neighbours) {
      if(m > n.moisture) {
        n.moisture = m;
        queue.offer(n);
      }
    }
  }
  
  // Scaling moisture
  ArrayList<Point> landPoints = new ArrayList<Point>();
  for(Point p : pointsList)
    if(!p.ocean && !p.coast && !p.water)
      landPoints.add(p);
  class PointComparator implements Comparator<Point> { 
    public int compare(Point p1, Point p2) {
      return (p1.moisture < p2.moisture ? -1 : (p1.moisture == p2.moisture ? 0 : 1));
    }
  }
  Collections.sort(landPoints, new PointComparator());
  int l = landPoints.size();
  for(int i=0; i<l; i++) {
    Point p = landPoints.get(i);
    p.moisture = (float)i / (l-1);
  }
  
  for(Point p : pointsList)
    p.moisture = constrain(p.moisture, 0, 1);
  
  // Updating faces
  for(Face f : facesList) {
    float sum = 0.0;
    for(Point p : f.points)
      sum += p.moisture;
    f.moisture = sum / f.points.size();
  }
}

void assignBiomes()
{
  for(Face f : facesList)
    f.biome = getBiome(f.elevation, f.moisture, f.water, f.ocean, f.coast);
}

void buildNoisyEdges()
{
  final float f = 0.5; // TODO : test other values
  for(Edge e : edgesList) {
    if(e.f2 == null) continue;
    
    PVector m = lerpVector(e.p1.pos, e.p2.pos, f);  // midpoint
    PVector t = lerpVector(e.p1.pos, e.f1.pos, f);
    PVector q = lerpVector(e.p1.pos, e.f2.pos, f);
    PVector r = lerpVector(e.p2.pos, e.f1.pos, f);
    PVector s = lerpVector(e.p2.pos, e.f2.pos, f);
    
    int minLength = 10;
    if(e.f1.biome != e.f2.biome) minLength = 3;
    if(e.f1.ocean && e.f2.ocean) minLength = 100;
    if(e.f1.ocean != e.f2.ocean) minLength = 2;  // coast
    if(e.river > 0) minLength = 3;
    
    e.noisy1 = buildNoisyLineSegments(e.p1.pos, t, m, q, minLength);
    e.noisy2 = buildNoisyLineSegments(e.p2.pos, s, m, r, minLength);
  }
}

void subdivideNoisyLineSegment(ArrayList<PVector> pts, 
  PVector A, PVector B, PVector C, PVector D, int minLength)
{
  if(PVector.sub(A, C).mag() < minLength || PVector.sub(B, D).mag() < minLength)
    return;
    
  float p = random(0.2, 0.8);
  float q = random(0.2, 0.8);
  
  PVector E = lerpVector(A, D, p);
  PVector F = lerpVector(B, C, p);
  PVector G = lerpVector(A, B, q);
  PVector I = lerpVector(D, C, q);
  
  PVector H = lerpVector(E, F, q);
  
  subdivideNoisyLineSegment(pts, A, G, H, E, minLength);
  pts.add(H);
  subdivideNoisyLineSegment(pts, H, F, C, I, minLength);
}

ArrayList<PVector> buildNoisyLineSegments(PVector A, PVector B, PVector C, PVector D, int minLength)
{
  ArrayList<PVector> pts = new ArrayList<PVector>();
  
  pts.add(A.get());
  subdivideNoisyLineSegment(pts, A, B, C, D, minLength);
  pts.add(C.get());
  return pts;
}

void mapGenerationStep()
{  // ... if we want to see the map being created !
  if(created) return;
  
  switch(creationStep) {
    case 0: createPoints();     break;
    case 1: createGraph();      break;
    case 2: relaxEdges();       break;
    case 3: createIslandForm(); break;
    case 4: assignWater();      break;
    case 5: computeElevation(); break;
    case 6: createRivers();     break;
    case 7: computeMoisture();  break;
    case 8: assignBiomes();     break;
    case 9: if(createNoisyEdges) buildNoisyEdges();
      // (no break)
    default:
      created = true;
  }
  
  if(!created) creationStep++;
}

void fullCreation()
{
  while(!created)
    mapGenerationStep();
}

void createMap(int seed)
{
  mapSeed = seed;
  randomSeed(seed);
  noiseSeed(seed);
  created = false;
  creationStep = 0;
  
  landMassFraction = random(landMassFractionMin, landMassFractionMax);
}

void drawElevation()
{
  background(biomesColor[1]);
  noStroke();
  noSmooth();
  
  for(Face f : facesList) {
    if(f.ocean) continue;
    fill(color(f.elevation * 255));
    f.drawSimple();
  }
}

void drawMoisture()
{
  background(biomesColor[1]);
  noStroke(); noSmooth();
  color water = color(64, 92, 255);
  color sand = color(224, 192, 32);

  for(Face f : facesList) {
    if(f.ocean) { }
    else if(f.water) {
      fill(color(0, 128, 255));
      f.drawSimple();
    } else {
      beginShape();
      for(Point p : f.points) {
        fill(lerpColor(sand, water, p.moisture));
        vertex(p.pos.x, p.pos.y);
      }
      endShape();
    }
  }
  
  for(Edge e : edgesList) {
    if(e.f2 == null) continue;  // border
    if(e.coast)  {
      strokeWeight(2);
      stroke(0);
    } else if(e.river > 0 && !(e.p1.water && e.p2.water)) {
      strokeWeight(sqrt(e.river));
      stroke(colorRiver);
    } else if(e.shore) {
      strokeWeight(1);
      stroke(color(0, 0, 255));
    } else continue;
    
    line(e.p1.pos.x, e.p1.pos.y, e.p2.pos.x, e.p2.pos.y);
  }
  strokeWeight(1);
}

void lineStrip(ArrayList<PVector> pts)
{
  beginShape();
  for(PVector p : pts)
    vertex(p.x, p.y);
  endShape();
}

void draw()
{
  smooth();
  background(color(0));

  if(created || creationStep>8)
  {
    background(biomesColor[1]);
  //  noSmooth();
    for(Face f : facesList) {
      stroke(biomesColor[f.biome]);
   //   noStroke();
      strokeWeight(1);
      fill(biomesColor[f.biome]);
      f.drawNoisy();
    } 
   
    smooth();
    for(Edge e : edgesList) {
      if(e.f2 == null) continue;  // border
      strokeWeight(1);
      if(e.coast) {
        strokeWeight(2);
        stroke(biomesColor[5]);  // coast
      } else if(e.shore && e.f1.biome != 3 && e.f2.biome != 3)
        stroke(colorRiver);
      else if(e.f1.water || e.f2.water)  // inside a lake
        continue;
      else if(e.river > 0) {
        strokeWeight(sqrt(e.river));
        stroke(colorRiver);
      }
      else
       continue;
      
      if(e.noisy1 != null && e.noisy2 != null) {
        lineStrip(e.noisy1);
        lineStrip(e.noisy2);
      }  
      else
        line(e.p1.pos.x, e.p1.pos.y, e.p2.pos.x, e.p2.pos.y);
    } 
  }
  else
  {
    switch(creationStep-1)
    {
      case 0:  
        noFill(); stroke(color(255,0,0));
        strokeWeight(4);
        for(PVector p : voronoiPoints)
          point(p.x, p.y);
        strokeWeight(1);
      break;
      
      case 1:        
      case 2:
        noStroke();
        fill(color(255,0,0));
      
        for(Face f : facesList)
          ellipse(f.pos.x, f.pos.y, 4, 4);
          
        noFill();
        stroke(color(255));
        for(Edge e : edgesList)
          line(e.p1.pos.x, e.p1.pos.y, e.p2.pos.x, e.p2.pos.y);
            
        strokeWeight(2);
        stroke(color(0,0,255));
        for(Point p : pointsList)
          point(p.pos.x, p.pos.y);
        strokeWeight(1);
        break;
        
      case 3:
        noStroke();
        for(Point p : pointsList) {
          if(p.water)
            fill(64, 64, 128);
          else
            fill(128, 192, 96);
          ellipse(p.pos.x, p.pos.y, 5, 5);
        }
        break;
        
      case 4:
        strokeWeight(0.5);
        stroke(color(0));
        for(Face f : facesList) {
          if(f.ocean)
            fill(color(0, 0, 255));
          else if(f.water)
            fill(color(0, 128, 255));
          else if(f.coast)
            fill(color(255, 192, 64));
          else
            fill(color(0, 192, 64));
          f.drawSimple();
        }
        strokeWeight(1);
        break;
        
      case 5:
        drawElevation();
        break;
        
      case 6:
        drawElevation();
        
        // Rivers
        smooth();
        for(Edge e : edgesList) {
          if(e.f2 == null) continue;
          if(e.river > 0 && !(e.p1.water && e.p2.water)) {
            strokeWeight(sqrt(e.river));
            stroke(colorRiver);
          } else if(e.shore && !e.coast) {
            strokeWeight(1);
            stroke(color(0, 0, 255));
          } else
            continue;
          line(e.p1.pos.x, e.p1.pos.y, e.p2.pos.x, e.p2.pos.y);
        }
        strokeWeight(1);
        break;
        
      case 7:
        drawMoisture();
    }
  }
}

}
