

RainDrop[] drops  = new RainDrop[500];

void setup()
{

  size(640,360);
 
  for(int i = 0; i<drops.length;i++)
  {
     drops[i] = new RainDrop();
  }
}



void draw()
{
  //background(230,230,250);
  
   fill(230,230,250, 80);
   rect(0, 0, width, height);
 for(int i = 0; i<drops.length;i++)
  {
     drops[i].fall();
      drops[i].show();

  }
}