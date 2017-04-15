import java.util.*;
static int numPoints =50;
static int numSteps = 1;
static ArrayList<Circle> circles = new ArrayList<Circle>();
 void setup()
 {
   size(400,400);
   
    Vector<PVector> centers = new Vector<PVector>();

    PoissonDistribution distrib = new PoissonDistribution();
    float d = sqrt(width * height * 0.61 / numPoints);
    centers = distrib.generate(0, 0, width, height, d, 20);
 
 
     for(int i = 0 ; i < numPoints;i++)
     {
        circles.add(new Circle(centers.get(i),1f));     
     }
 
 for(int i = 0 ; i < numSteps ;i++)
 {
     for(int j = 0 ; j < circles.size();j++)
     {
        circles.get(j).grow();    
     } 
 }
 
  println("N "+n);
 
}
 
     static int n = 0 ;

void draw()
{
     for(int j = 0 ; j < circles.size();j++)
     {
        circles.get(j).display()  ; 
       // println(circles.get(j).radius);
     }
     if(keyPressed)
     {
         for(int j = 0 ; j < circles.size();j++)
         {
            circles.get(j).grow();    
         } 
     }
}
 
 
 
 