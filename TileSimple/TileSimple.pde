void setup()
{
size(400,400);

}
//Try Tweaking the strokes weights
float tileWidth = 35;
int direction = 1;
void draw()
{
  background(255);
 
  for(int j = 0 ; j < height/tileWidth;j++)
    for(int i = 0 ; i < width/tileWidth ; i++)
    {
        strokeWeight(4);
        rect(i*tileWidth ,j*tileWidth,tileWidth,tileWidth);
        strokeWeight(1);
        if(direction == 1)
        {
          float midY = j*tileWidth+tileWidth/2; 
          line(i*tileWidth,midY,(i+1)*tileWidth,midY);
        }
         else if(direction == -1)
        {
          float midX = i*tileWidth+tileWidth/2; 
          line(midX,j*tileWidth,midX,(j+1)*tileWidth);
        }
        direction *= -1;
    }

}