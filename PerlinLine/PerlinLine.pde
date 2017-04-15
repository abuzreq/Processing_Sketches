
  void drawLine(float x1,float y1,float x2 ,float y2,float amp ,int steps)
  {
      ArrayList<PVector> points = new ArrayList<PVector>();
      points.add(new PVector(x1,y1));
       float mag   = new PVector(x1,y1).dist(new PVector(x2,y2));
      
      steps = steps * (int)map(mag,0,width,0,10);
      float step = 1.0/steps;
       
     
      float theta =  PVector.angleBetween(new PVector(x1,y1),new PVector(x2,y2));
      
      // println(step);
      float t = 0;
  
      float px = x1 ,py = y1;
      for(int i = 0 ; i < steps;i++)
      {
   //amp*map(noise(px,py,t),0,1,-10,10) ;
        float x   = lerp(px,x2,step) + amp*map(noise(px,py,t),0,1,-5,5) ;
        float y   = lerp(py,y2,step) + amp*map(noise(px,py,t+100),0,1,-5,5) ;
  
        px = x;
        py = y;
        points.add(new PVector(x,y));
        t += 0.1;
      }
      
       points.add(new PVector(x2,y2));
      
       for(int i = 1 ; i <  points.size();i++)
       {
         line(points.get(i-1).x,points.get(i-1).y,points.get(i).x,points.get(i).y);    
       }
      
      
      
      
      
  }
  
  
  
  
  void setup()
  {
    size(800,800);
  }
  ArrayList<PVector> points = new ArrayList<PVector>();
  
  
  void generate()
  {
    
      points.clear();
     for(int i = 0 ; i < 20;i++)
       points.add(new PVector(random(0,width),random(0,height)));
     
  }
  void draw()
  {
    
    
    background(255);
    float amp = map(mouseX,0,width,0,1);//1.8
    int steps =(int)map(mouseY,0,width,10,20); //15
     if(mousePressed)
     {
      // generate();
         points.add(new PVector(mouseX,mouseY));
     }
     
     
     
     if(points.size() > 3)
       for(int i = 1 ; i < points.size();i++)
         {
           drawLine(points.get(i-1).x,points.get(i-1).y,points.get(i).x,points.get(i).y,amp,steps);
          // line(points.get(i-1).x,points.get(i-1).y,points.get(i).x,points.get(i).y); 
         }
  
  }