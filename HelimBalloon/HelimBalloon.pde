
Mover[] movers = new Mover[100];
PVector gravity,wind;
void setup()
{
  size(500,500);
  for(int i = 0; i < movers.length;i++)
  { 
    movers[i] = new Mover(random(0.1,5),width,0);
  }
  wind= new PVector(0,0);
  gravity = new PVector(0,0);

}
float t = -20;
void draw()
{
    clear();
    wind = new PVector(-0.51,0);
    gravity = new PVector(0,0.1);

   for(int i = 0; i < movers.length;i++)
  { 
    //stronger as you get closer to the edge
    PVector leftEdgeForce = new PVector((width - movers[i].location.x)/width,0);
    movers[i].applyForce(leftEdgeForce);
   // movers[i].applyForce(edge2Force);

    movers[i].applyForce(gravity);
    movers[i].applyForce(wind);
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }

}