float x,y,w,h;


void setup()
{
size(400,400);
x = width/2;
y=height/2;
w=100;
h = 100;
list.add(new Vector4(x,y,w,h));
}
ArrayList<Vector4> list = new ArrayList<Vector4>();

boolean changed  = false; 
void draw()
{
 // clear(); 
 background(0);
   
  if(mousePressed && !changed)
  {
    changed = true ; 
     
    list.add(new Vector4(x + w/2,y,w/2,h/2));
    list.add(new Vector4(x + w/2,y+h/2,w/2,h/2));
    list.add(new Vector4(x + 0,y,w/2,h/2));
    list.add(new Vector4(x + 0,y+h/2,w/2,h/2));
    list.remove(0);
  }
println(list.size());
  stroke(255);
  for(int i = 0 ; i< list.size();i++)
  {
  ellipseMode(CENTER);
  ellipse(list.get(i).x,list.get(i).y,list.get(i).w,list.get(i).h);
  }
  
}


class Vector4
{
  float x ,y , w,h;
Vector4(float _x , float _y, float _w , float _h)
{
x = _x ;
y  = _y;
w = _w;
h =_h;

}

public boolean equals(Vector4 other)
{
  return (x == other.x) && (y == other.y) &&(w == other.w)&&(h == other.h);

}


}
