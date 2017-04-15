PFont f;
// The radius of the circle of rotation
float r = 100;
// The width and height of the box
float w = 40;


void setup() {
  size(320, 320);
  smooth();
}
float theta = 0 ;
void draw() {
  translate(width / 2, height / 2);
  noFill();
  stroke(0);
  // Our curve is a circle with radius r in the center of the window.
  ellipse(0, 0, r*2, r*2);  
  
    //the idea is incorprated from Arrays tut , see arrays_spots_traced
    fill(0,12);
    rect(0,0,width,height); 
    
    pushMatrix();
    /*tweaks :
     remove the multipication of the radius r 
    change the trigonometric function  to sin\cos\tan in any 
    or both of the two argumetns
    */
    translate(r*sin(theta), r*tan(theta));
    rotate(theta);
    fill(255);
    rectMode(CENTER);
    rect(0,0,w,w);  
    popMatrix();
    theta +=PI/42;
    
        

 
  
}
