/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/30809*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
import miny.render.*;
import miny.types.*;
import java.util.*;
Map map;
boolean showSteps = false;
boolean smoothColors = true;
boolean customRender = true;
int showData = 0; // 0 : default, 1 : elevation, 2 : moisture
int startTime;

Renderer renderer;

void setup()
{
  size(600, 600);
  map = new Map(this);
  map.nbPoints = 2000;
  launchCreation(26004); // good seeds : 48047, 24973,26004
  // BUG with 17504 (for example)
}

void drawPathForwards(ArrayList<PVector> path, MultiPoints shape)
{
  for(int i=0; i<path.size(); i++)
    shape.addPoint(path.get(i).x, path.get(i).y);
}

void drawPathBackwards(ArrayList<PVector> path, MultiPoints shape)
{
  for(int i=path.size()-1; i>+0; i--)
    shape.addPoint(path.get(i).x, path.get(i).y);
}

void drawEdge(Map.Edge e, Map.Face f, MultiPoints shape)
{
  shape.addPoint(f.pos.x, f.pos.y);
  if(e.f1 == f)
  {
    shape.addPoint(e.p1.pos.x, e.p1.pos.y);
    if(e.noisy1 != null && e.noisy2 != null) {
      drawPathForwards(e.noisy1, shape);     
      drawPathBackwards(e.noisy2, shape);   
    }
    shape.addPoint(e.p2.pos.x, e.p2.pos.y);
  } else { // reverse order
    shape.addPoint(e.p2.pos.x, e.p2.pos.y);
    if(e.noisy1 != null && e.noisy2 != null) {
      drawPathForwards(e.noisy2, shape);     
      drawPathBackwards(e.noisy1, shape);   
    }
    shape.addPoint(e.p1.pos.x, e.p1.pos.y);
  }
}

void renderMap()
{
  renderer = new Renderer(this);
  renderer.setBackground(map.biomesColor[1]);
  for(Map.Face f : map.facesList) {
    color fc = map.biomesColor[f.biome];
    for(Map.Edge e : f.edges) {
      if(smoothColors && !f.water && !e.coast && !e.shore) {
        BiomeTriangle tri = new BiomeTriangle(1, f.pos, e.p1.pos, e.p2.pos,
          f.elevation, e.p1.elevation, e.p2.elevation,
          f.moisture, e.p1.moisture, e.p2.moisture,
          f.water, f.ocean, f.coast, e.p1.coast, e.p2.coast,
          0.3, 0.1);  // noiseDist, noiseScale
        renderer.add(tri);
      } else {
        Polygon poly = new Polygon(1, map.biomesColor[f.biome]);
        drawEdge(e, f, poly);
        renderer.add(poly);
      }
    } 
  }

  // first only the coasts
  for(Map.Edge e : map.edgesList) {
    if(e.f2 == null || !e.coast)
      continue;
    
    if(e.noisy1 != null && e.noisy2 != null) {
      PolyLine line = new PolyLine(2, 1, map.colorCoast, false);    
      drawPathForwards(e.noisy1, line);  
      drawPathBackwards(e.noisy2, line);
      renderer.add(line);
    } else
      renderer.add(new Line(e.p1.pos.x, e.p1.pos.y, e.p2.pos.x, e.p2.pos.y, 2, 1, map.colorCoast));
  }
  
  // then all the rest
  for(Map.Edge e : map.edgesList) {
    if(e.f2 == null) // border
      continue;
    PolyLine line;
    if(e.coast)
      continue;
    else if(e.shore && e.f1.biome != 3 && e.f2.biome != 3)
      line = new PolyLine(1, 1, map.colorRiver, false);
    else if(e.f1.water || e.f2.water)  // inside a lake
      continue;
    else if(e.river > 0)
      line = new PolyLine(sqrt(e.river), 1, map.colorRiver, false);
    else
     continue;
      
    line.addPoint(e.p1.pos.x, e.p1.pos.y);
    if(e.noisy1 != null && e.noisy2 != null) {
      drawPathForwards(e.noisy1, line);  
      drawPathBackwards(e.noisy2, line);
    }
    line.addPoint(e.p2.pos.x, e.p2.pos.y);
    renderer.add(line);
  }
  
  NoiseImage ni = new NoiseImage(floor(random(1000)), 128-5, 128+5);
  ni.blendMode = HARD_LIGHT;
  renderer.add(ni); 
}

void draw()
{
  if(map.created || showSteps) {
    if(startTime > 0) {
      println((millis() - startTime) + " ms");
      startTime = -1;
    }
    if(showData == 1)
      map.drawElevation();
    else if(showData == 2)
      map.drawMoisture();
    else if(showSteps || !customRender)
      map.draw();
    else {
      if(renderer == null)
        renderMap();
      renderer.renderStep();
      image(renderer.getImage(), 0, 0);
      if(!renderer.finished())
      {
        fill(color(255));
        textAlign(CENTER, CENTER);
        text("rendering", width/2, height/2 - 25);
  
        stroke(color(255)); fill(color(0));
        rectMode(CORNER);
        rect(width/2-width/6, height/2-10, width/3, 20);
        fill(color(255));
        rect(width/2-width/6+1, height/2-9, width/3*renderer.getProgress()-2, 18);
      }
    }
  } else {
    smooth();
    background(0);
    fill(color(255));
    textAlign(CENTER, CENTER);
    text("creating map", width/2, height/2 - 75);
    
    // draw a small clock
    noFill();
    int cx = width/2, cy = height/2;
    int csize = 50;
    int seconds = (millis() - startTime) / 1000;
    float angle = PI / 30 * seconds - PI / 2;
    stroke(color(128));
    line(cx, cy, cx, cy - csize);
    stroke(color(255, 0, 0));
    strokeWeight(2);
    line(cx, cy, cx + cos(angle) * csize, cy + sin(angle) * csize);
    strokeWeight(1);
    stroke(color(255));
    ellipse(cx, cy, csize*2, csize*2);
  }
}

void launchCreation(int seed)
{  // Using a thread so we can display a nice message while the map is being generated
  startTime = millis();
  map.createMap(seed);
  class mapCreationRunnable implements Runnable{
    public void run() {
      map.fullCreation();
    }
  }
  Thread creationThread = new Thread(new mapCreationRunnable());
  creationThread.start();
}

void keyPressed()
{
  switch(keyCode)
  {
    // Create another map
    case ' ': 
      int seed = millis();
      println(seed);
      showSteps = false;
      renderer = null;
      launchCreation(seed);
    break;
    
    // Restart the creation of the same map, but waiting for each step
    case ENTER:
      if(!showSteps && !map.created)  // first wait for the thread to finish (bad things can happen otherwise)
        return;
      
      if(map.created) {
        if(renderer == null) {
          renderMap();
          showSteps = false;
        } else {
          map.createMap(map.mapSeed);
          renderer = null;
          showSteps = true;
          map.mapGenerationStep();
        }
      } else {
        renderer = null;
        showSteps = true;
        map.mapGenerationStep();
      }
    break;
    
    case 'E':
      if(showData == 1) showData = 0;
      else showData = 1;
    break;
    
    case 'M':
      if(showData == 2) showData = 0;
      else showData = 2;
    break;
    
    case 'B':
      showData = 0;
    break;
    
    case 'N':
      map.createNoisyEdges = !map.createNoisyEdges;
      if(map.createNoisyEdges)
        map.buildNoisyEdges();
      else {
        for(Map.Edge e : map.edgesList) {
          e.noisy1 = null;
          e.noisy2 = null;
        }
      }
      renderer = null;
    break;
    
    case 'S':
      smoothColors = !smoothColors;
      renderer = null;
    break;
    
    case 'R':
      customRender = !customRender;
      renderer = null;
    break;
  }
}

void drawMapElevation()
{
  background(map.biomesColor[1]);
  noStroke();
  noSmooth();
  
  for(Map.Face f : map.facesList) {
    if(f.ocean) continue;
    fill(color(f.elevation * 255));
    f.drawSimple();
  }
}
