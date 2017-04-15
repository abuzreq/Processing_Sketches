//An attempt to make the fir effect in this 
//feed the head  a red ball and press on the ear to have fire
//http://www.feedthehead.net/
ArrayList<Diamond> diamonds = new ArrayList<Diamond>();
float x , y , angle , time;
void setup()
{
  size(500,500,P2D);
  x = 0 ;
  y = height/2;
  angle = 0 ;
  for(int i = 0; i < 50 ; i++){

   diamonds.add(new Diamond(x,y,40,20,random(-60,30),random(-10,10),map(i,0,49,0,1),map(i,0,49,400,100)));
  }

        
}
boolean firing = false ;
void draw()
{
    background(51);
    translate(0,height/2);
    for(int i = 0; i < diamonds.size() ; i++)
    {
      Diamond d = diamonds.get(i);
      d.x = x  ;//+ d.offsetX*2;
      d.y = y + d.offsetY*2;     
      if((keyPressed  == true)&& key == 'a'&&!firing){
        firing = true;
        time = millis() ;   
      }
       println(firing);
      if(abs(millis() - time) >= 1000)
        firing = false ;
      
      if(firing)
         d.draw();
  
   y = sin(angle)*20;
   
    }
angle +=0.1;

}


class Diamond
{
 
  
    float x , y , w , h;
    float x1 =  0   , x2 = w/2 ,x3 =  w   , x4 = w/2 ;
    float y1 =  h/2 , y2 = h   ,y3 =  h/2 , y4 =  0  ;
    float offsetY , offsetX;
    float fill ,scalar,initial;
    
Diamond(float _x , float _y , float _w , float  _h ,float offX , float offY,float scal,float init)
{

  x = _x +init;
  initial = init;
  y = _y;
  w = _w;
  h = _h;    
  offsetX = offX;
  offsetY = offY;
  fill = random(100,230);
  scalar =scal;
}
  void draw(){
    
      pushMatrix();
      translate(x-w/2+initial, y-h/2);
      scale(scalar);
      fill(fill,0,0,255);
      noStroke();
      beginShape();
      vertex(0, 10);
      vertex(20, 20);
      vertex(40, 10);
      vertex(20, 0);
      endShape(CLOSE);
       popMatrix();
       
       scalar -= 0.015;
       if(scalar <= 0)
       {
          x = 0 ;
         scalar = 1;
          
       }
       
      
  }

}
