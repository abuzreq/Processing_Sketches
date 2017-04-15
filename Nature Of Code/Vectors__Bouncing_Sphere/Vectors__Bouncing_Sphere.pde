void setup()
{
  size(500,500,P3D);
  location = new PVector(width/2,height/2,100);
  velocity  = new PVector(1.3f,1.2f,2);
}

PVector location ,velocity;
void draw()
{
  location.add(velocity);
   if ((location.x > width) || (location.x < 0)) {
    velocity.x = velocity.x * -1;
  }
  if ((location.y > height) || (location.y < 0)) {
    velocity.y = velocity.y * -1;
  }
   if ((location.z > 100) || (location.z < 0)) {
    velocity.z = velocity.z * -1;
  }
  background(0);
  translate(location.x,location.y,location.z);
  sphere(25);
}