class Star
{
  
  float x ;
  float y ;
  float z ;
  
  float pz;


  public Star()
  {
    x = random(-width/2,width/2);
    y = random(-height/2,height/2);
    z = width;
    pz = z;  
  }
  
  
  void update()
  {
    z = z - speed;
    if(z < 1)
    {
      z = random(width);//try 10000
      x = random(-width/2,width/2);
      y = random(-height/2,height/2);
      pz = z;
    }
     
  }
  
  void show()
  {
    
    
       
    float sx = map(x/z,0,1,0,width);
    float sy = map(y/z,0,1,0,height);
      
    float r  = map(z,0,width,10,0);
    fill(255);
    noStroke();
    ellipse(sx,sy,r,r);

    float px = map(x/pz,0,1,0,width);
    float py = map(y/pz,0,1,0,height);
    
    float c = map(z,0,width,255,0);
    stroke(c);
    line(px,py,sx,sy);

  
  
  }
  
  
  
  



}