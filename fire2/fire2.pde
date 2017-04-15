
ArrayList<Diamond> diamonds = new ArrayList<Diamond>();
float x , y , angle;
void setup()
{
  size(500,500,P2D);
  x = 0 ;
  y = height/2;
  angle = 0 ;
  //for(int i = 0; i < diamonds.size ; i++)
   diamonds.add(new Diamond(x,y,40,20,10,10));
    diamonds.add(new Diamond(x,y,40,20,10,0));
     diamonds.add(new Diamond(x,y,40,20,-10,10));
      diamonds.add(new Diamond(x,y,40,20,-10,0));
       diamonds.add(new Diamond(x,y,40,20,0,10));
        diamonds.add(new Diamond(x,y,40,20,0,-10));
         diamonds.add(new Diamond(x,y,40,20,0,0));

}


void draw()
{
    background(51);
    translate(0,height/2);
    for(int i = 0; i < diamonds.size() ; i++)
    {
      
      Diamond d = diamonds.get(i);
       translate(x,y);
      d.x =x;// x  + d.offsetX*2;
      d.y =y; //y + d.offsetY*2;
         rotate(angle);
      d.draw();
    }
   x =  (x + 1)%width;
   y = sin(angle)*20;

   angle +=0.1;

}


class Diamond
{
 
    float x , y , w , h;
    float x1 =  0   , x2 = w/2 ,x3 =  w   , x4 = w/2 ;
    float y1 =  h/2 , y2 = h   ,y3 =  h/2 , y4 =  0  ;
    float offsetY , offsetX;
Diamond(float _x , float _y , float _w , float  _h ,float offX , float offY)
{

  x = _x;
  y = _y;
  w = _w;
  h = _h;    
  offsetX = offX;
  offsetY = offY;
}
  void draw(){
    
      
     
      fill(102);
      stroke(255);
      strokeWeight(2);
      beginShape();
      vertex(0, 10);
      vertex(20, 20);
      vertex(40, 10);
      vertex(20, 0);
      endShape(CLOSE);
     
      
  }

}
