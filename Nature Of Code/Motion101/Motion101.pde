Mover[] movers = new Mover[20];
static boolean isAttracting = true;

void setup()
{
  size(800,800);
    for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
}


void draw()
{
    background(255,10);
    for (int i = 0; i < movers.length; i++) 
    {
      movers[i].update();
      movers[i].checkEdges();
      movers[i].display();
    }
    if(mousePressed)
    {
          isAttracting = !isAttracting;
    }
}