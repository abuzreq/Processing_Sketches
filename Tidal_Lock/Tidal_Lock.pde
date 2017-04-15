float x,y;
float originX = width/2,originY= height/2;
float angle = 0 ;

void setup()
{
  size(800,800);
  originX = width/2;
  originY= height/2;
}
float radius = 140;
void draw()
{
  clear();
  translate(originX,originY);
  rect(0,0,5,5);
  rectMode(CENTER);
  rotate(angle%360);
  rect(radius+x,radius+y,25,25);
  //angle = map(angle+0.01,0,360,0,360);
  angle +=0.015;
  
   
 
 }