float[] heights = new float[8];

void setup()
{
  size(400,400);
  scale(1, -1);
  translate(0, -height);
    for(int i = 1 ;i < heights.length;i++)
          heights[i]  = random(0,200);
}

float rw = 40;
float t  = 0;
void draw()
{
 
  clear();
  scale(1, -1);
  translate(0, -height);
  noStroke();
  fill(47,65,114);
  for(int i = 0 ;i < heights.length;i++)
  {
    rect(i*50,0,rw,heights[i]);    
  } 
   stroke(170,63,57);
  for(int i = 1 ;i < heights.length;i++)
  {     
    line((i-1)*50+20,heights[i-1],i*50+20,heights[i]);
  }
  if(frameCount%10==0)
  {
    for(int i = 0 ;i < heights.length;i++)
    {
       heights[i] = noise(t)*200;
      //  heights[i] += map(noise(t),0,1,0,20);  
      //  constrain(heights[i],0,height);
        t += 10;
    } 
  }
  
}