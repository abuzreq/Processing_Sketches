

Star[] stars = new Star[400];
float speed = 10;
void setup()
{
  size(800,800);
  for(int i = 0 ; i < stars.length;i++)
  {
        stars[i]   = new Star();
  }


}




void draw()
{
  
  translate(width/2,height/2);
  speed = map(mouseX,0,width,10,50);
  background(0);
  for(int i = 0 ; i < stars.length;i++)
  {
       stars[i].update();
        stars[i].show();
  }


}