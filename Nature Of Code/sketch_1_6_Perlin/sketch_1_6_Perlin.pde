void setup()
{
  size(500,500);

}
float t = 3;
float x  = 50 , y = 250;
float px,py;
void draw()
{
  px = x;
  py = y;
  y = map(noise(t),0,1,0,width);
  //choose one (Perlin noise is deterministic , taht's why we need
  //to supply different time t in x and y (e.g. by adding 100 here)
  //otherwise we will get a diagonal as x=y
  x = map(noise(t+100),0,1,0,width);//two dimensional
 // x += 0.5; //one dimensional
  point(x,y);
  line(px,py,x,y);
  t -=0.01;
  
}