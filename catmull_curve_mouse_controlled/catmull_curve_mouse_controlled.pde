
int cpx1 ,cpx2,cpy1,cpy2;
void setup()
{
  size(200, 200);
  background(255);
  smooth();
  stroke(0);
  cpx1 = cpy1 = 40 ;
  cpx2 = 60;
  cpy2 = 120;
 
}


void draw()
{
  background(0);
 
  if(mousePressed){
    cpx2 = mouseX;
    cpy2 = mouseY;
 curve(cpx1, cpy1, 80, 60, 100, 100, mouseX, mouseY);
  }
  else{
    cpx1 = mouseX;
    cpy1 = mouseY;
 curve(mouseX, mouseY, 80, 60, 100, 100, cpx2, cpy2);
  }
  noStroke();
  fill(255, 0, 0);
  
  
   if(!mousePressed)
    ellipse(mouseX, mouseY, 5, 5);
  else
    ellipse(cpx1, cpy1, 5, 5);
  
  fill(0, 0, 255, 192);
  ellipse(100, 100, 5, 5);
    fill(100,100, 100, 192);
  ellipse(80, 60, 5, 5);
  fill(150, 0, 0);
  if(mousePressed)
    ellipse(mouseX, mouseY, 5, 5);  
  else
    ellipse(cpx2, cpy2, 5, 5);  
}
