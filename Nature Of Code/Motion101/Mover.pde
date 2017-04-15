class Mover
{
  PVector location ,velocity,aceleration;
  float topSpeed;
  Mover()
  {
      location =   new PVector(random(width),random(height));
      velocity =   new PVector(random(-2,2),random(-2,2));
      aceleration =  new PVector(-0.001,0.01);
      topSpeed = 10;
  } 
  
  float t = 0 ;
  void update()
  {
    PVector vec ;
    PVector mouse = new PVector(mouseX,mouseY);
    if(!Motion101.isAttracting)
       vec =  PVector.sub(location,mouse);
    else 
       vec =  PVector.sub(mouse,location);

    vec.normalize();
    vec.mult(random(1));
    aceleration.set(vec);
    
    velocity.add(aceleration);
     velocity.limit(topSpeed);
    location.add(velocity);
    
  }
   void display()
  {
   stroke(0);
   fill(175);
   ellipse(location.x,location.y,16,16);
  }
  void checkEdges()
  {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
 
    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
   
  }



}