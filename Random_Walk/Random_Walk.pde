
boolean oneShot = true;
int numIterationOneShot = 100000;
void setup()
{
  size(400,400);
  x =width/2;
  y =height/2;
  //One Shot 
 if(oneShot)
 {
    xs.add(x);
    ys.add(y);
    int i = 1;
    while(i < numIterationOneShot)
    {
      int xx = xs.get(i-1),yy = ys.get(i-1);//first load previous x,y
     
        int r = (int)random(0,4);//adjust the point randomly
        if(r == 0)
        {
          xx += 1;
        }
        else if (r == 1)
        {    
          yy += 1;
        }
        else if (r == 2)
        {
          xx -= 1;
        }  
        else if(r ==3)
        {
          yy -= 1;
        }
      
      xs.add(xx);
      ys.add(yy);
      i++;
    }
 }
}
ArrayList<Integer> xs = new ArrayList<Integer>();
ArrayList<Integer> ys = new ArrayList<Integer>();

int x =width/2,y = height/2;
void draw()
{
  if(!oneShot)
  {
    point(x,y);
    int r = (int)random(0,4);
    if(r == 0)
    {
      x += 1;
    }
    else if (r == 1)
    {
    
      y += 1;
    }
    else if (r == 2)
    {
      x -= 1;
    }  
    else if(r ==3)
    {
      y -= 1;
    }
  }
  else
  {
    for(int i = 0 ; i < xs.size();i++)
    {
      point(xs.get(i),ys.get(i));  
    }
  }
  
  
}