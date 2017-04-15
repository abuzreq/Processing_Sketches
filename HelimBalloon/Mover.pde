// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float mass ;
  Mover(float m,float x , float y) 
  {
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0,0);
    topspeed = 6;
  }

  void update() 
  {

    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    acceleration.mult(0);
    
    if(location.y < 0)
      location.y = height;
    if(location.x < 0)
      location.x = width;
    else if(location.x > width)
      location.x = 0;
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(255);
    ellipse(location.x, location.y, mass*16, mass*16);
  }

  void applyForce(PVector force)
  {
  
    acceleration.add(PVector.div(force,mass));
    
  }
  void checkEdges() 
  {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }
 
    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }
  }
}