void setup()
{
  background(0);
  size(500,500);
}
int n =60 ;//60 every second , 1 is natural
//exchange the location of any two of these passed arguments
void draw()
{
  stroke(255);
 // line(mouseX,pmouseY,mouseY,pmouseX);
  line(pmouseX,pmouseY,mouseX,mouseY);
//play with the variable n 
if(frameCount % n == 0)
  background(0);
}
