class Ring
{
  int x , y ;
  boolean start = false;
  float radius = 0 ;
 Ring(int nx,int ny)
{
  x = nx ;
  y = ny ;
} 
Ring()
{

}

void start(int nx , int ny )
{
  x = nx ;
  y = ny ;
  start  = true;
}
void grow()
{
  if(start)
  radius += 2 ;
}

void display()
{
 stroke(100);
  noFill();
  ellipse(x,y,radius,radius);
  
}
  
  
}  

Ring[] rings; // Declare the array
int numRings = 50;
int currentRing = 0; 
void setup() {
  size(100, 100);
  rings = new Ring[numRings]; // Create the array
  for (int i = 0; i < rings.length; i++) {
    rings[i] = new Ring(); // Create each object
  }
}
void draw() {
  background(0);
  for (int i = 0; i < rings.length; i++) {
    rings[i].grow();
    rings[i].display();
  }
}
// Click to create a new Ring
void mousePressed() {
  rings[currentRing].start(mouseX, mouseY);
  currentRing++;
  if (currentRing >= numRings) {
    currentRing = 0;
  }
}
