class RainDrop
{
float x  = random(0,width);
float y  = random(-500,-200);
float z  = random(0,15);//to give a sence of 3d , the use this value to map thing accordign to their depth
float len = map(z,0,15,10,20);
float speed = map(z,0,15,4,10);

void fall()
{
  y += speed;

  //speed += 0.2;
  if(y > height)
  {
      y = random(-500,-200);
      speed = map(z,0,15,4,10);
    }
}
void show()
{
  float thick  = map(z,0,15,1,3);
  strokeWeight(thick);
  stroke(138,43,226);
  line(x,y,x,y+len);

}
  
  
  
  

}