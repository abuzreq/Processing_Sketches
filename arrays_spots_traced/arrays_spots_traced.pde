Spot[] spots; // Declare array
void setup() {
  size(700, 100);
  int numSpots = 70; // Number of objects
  int dia = width/numSpots; // Calculate diameter
  spots = new Spot[numSpots]; // Create array
  for (int i = 0; i < spots.length; i++) {
   float x = dia/2 + i*dia;
    float rate = random(0.1, 2.0);
    // Create each object
    spots[i] = new Spot(x, 50, dia, rate);
  }
  noStroke();
}
void draw() {
  fill(0, 12);
  //draw rectangle , draw spots , draw rectangle , draw spot ...ect 
  // doing this instead of using background() results in the trace effect seen
  rect(0, 0, width, height);
  fill(255);
  for (int i=0; i < spots.length; i++) {
    spots[i].move(); // Move each object
    spots[i].display(); // Display each object
  }
}


class Spot
{
  float x , y ;
  float diameter;
  float speed ;
  int direction = 1 ;
  
  Spot(float xpos , float ypos,float dia , float sp)
  {
    x  =  xpos ;
    y  =  ypos ;
    diameter = dia ;
    speed = sp ;
  
  }
void move()
{
  y += speed*direction;
  if((y > (height - diameter/2)) || (y < diameter/2))
    direction *= -1 ;
}

void display()
{
  ellipse(x,y,diameter,diameter);
}



}
