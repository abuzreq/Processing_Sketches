void setup()
{
  size(400,400);
  background(0);
}

float x,y;
float w = 80,h = 80;
float m = 1; //modifier
float r,g,b;

void draw()
{
  clear();
  x = width/2;
  y = height/2;
  x = mouseX;
  y = mouseY;
  noStroke();
  rectMode(CENTER);
  
  if(key == 'q')
    r += 5;
  else if(key == 'a')
    r -= 5;
  else if(key == 'w')
    g += 5;
  else if(key == 's')
    g -= 5;
  else if(key == 'e')
    b += 5;
  else if(key == 'd')
    b -= 5;
    
      m = map(mouseX,0,width,0,8);
      w = map(mouseY,0,height,20,100);
      h = map(mouseY,0,height,20,100);
  while(m >0.5)
  {
    println(m);
    m -= 0.1;
    fill(r,g,b,255-(m-1)*255);
    ellipse(x,y,w*m,h*m);
  }
 
}