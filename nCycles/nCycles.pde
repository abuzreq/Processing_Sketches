/*
  a point rotates in a circle , a circle rotates around that point and so on , n times 
  amount of change of the angle will determine how fast the circles are swept
   if one circle is faster than other , the slower shape will dissappear in favor of the faster and thus more effective
  frequency adds a general speed limiter for all angles , instead of changes all angles in the array when wanting to scale them up by 10 , you multiply them by frequency = 10
  so a combination of all those result in many beatifull patterns
  I was inspired by how fourier transform works (given this wave , decompose it to the circles constitutiing it ,i.e if I give you this wave you should till me the angleChanges and radiis that I supplied here)
  @AUTHER Abuzreq
*/

//I guess what is in this websites samrizes what I tried to accomplish 
//http://toxicdump.org/stuff/FourierToy.swf

int n = 10;//number of cycles
float frequency = 1;
PVector[] centers;//(x,y)
float[] anglesChanges = {0 , 4 ,1 ,1 ,1};//num of angles changes supplied should be equal to n , otherwise unsupplied angles will be dealt with as zero (first element is zero is default)
float[] radiis        = {0,100,50,20,20,20,20,20,20};   //num of radiis  supplied should be equal to n , otherwise unsupplied radius will be dealt with as zero (first element is zero is default)
float[] angles = new float[n];

float xWave ,yWave;
void setup()
{
  size(1280,640,FX2D);
  surface.setSize(1280, 640);
  fill(255);
  
  float centerX = width / 5;
  xWave = 500 ;
  float centerY = height / 2 ;
  centers = new PVector[n];
  for(int i = 0 ; i < centers.length;i++)
    centers[i] = new PVector();
  centers[0].set(centerX,centerY);
} 

ArrayList<PVector> array = new   ArrayList<PVector>();//used to store points generated from the epicycles
ArrayList<PVector> wavePoints = new   ArrayList<PVector>();//used to store point related to drawing the wave
float ac,r;//tmp variables
void draw()
{
  
    background(0);
    for(int i = 1 ; i< n ; i++ )
    {
       ac = getAngleChange(i);
       r = getRadius(i);
      float tx = centers[i-1].x + cos(radians(angles[i]*frequency))*r;
      float ty = centers[i-1].y + sin(radians(angles[i]*frequency))*r;
      centers[i] = new PVector(tx,ty);
      angles[i] = angles[i] + ac;
    }
    float x = centers[centers.length-1].x;
    float y = centers[centers.length-1].y;
    array.add(new PVector(x,y));
    
    //wave drawing and maintaince
    xWave = xWave  + 1 ;
    yWave = y;
    
    if(xWave >= width)
    {
      xWave = 500 ;
      yWave = y;
      wavePoints.clear();
    }
    wavePoints.add(new PVector(xWave,yWave));
    stroke(255,255,0);
    if(wavePoints.size() > 1)
      for(int i = 1 ; i < wavePoints.size();i++)
      {
        line(wavePoints.get(i-1).x,wavePoints.get(i-1).y,wavePoints.get(i).x,wavePoints.get(i).y);
      }
      
     line(xWave,yWave,x,y);//drawing a line from last point in the shhape to last point in the wave
     
    //drawing shapes
    stroke(255);
    if(array.size() > 1)
      for(int i = 1 ; i < array.size();i++)
      {
        line(array.get(i-1).x,array.get(i-1).y,array.get(i).x,array.get(i).y);
      }
      
     //drawong circles
      noFill();
      stroke(255,0,0);
      for(int i = 0 ; i < centers.length;i++)
      {
        float radius = getRadius(i);
        ellipse(centers[i].x,centers[i].y,radius,radius);
      }
  

}

//return the ith elemnt in anglesChanges array , if not found returns 0;
float getAngleChange(int i)
{
   float ac = 0;
      if(anglesChanges.length < i+1)
        ac = 0;
      else
       ac =  anglesChanges[i];
   return ac;
}
//return the ith elemnt in radiis array , if not found returns 0;
float getRadius(int i)
{     
       float r = 0;
      if(radiis.length < i+1)
        r = 0;
      else
       r =  radiis[i];
       
       return r;
}