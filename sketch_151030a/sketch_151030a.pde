float[] array = new float[100];

void setup()
{  float lambda = 0.15;
   size(800,400);
   for(int i = 0 ; i < array.length;i++)
   {
     float rand = random(1);
     array[i]  =-(1.0/lambda)* log(1-rand);
     println(rand + " : " +array[i]);

   }


}
float x = 25,y = 50;
void draw()
{
  background(255);
  scale(4);
  translate(x,y);
  strokeWeight(1);
  for(int i = 1 ; i < array.length;i++)
  {
    line(i-1,array[i-1],i,array[i]);
  
  }
  translate(0,0);



}