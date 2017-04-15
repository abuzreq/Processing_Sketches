// Declaring a variable of type PImage
/*PImage img;  
PImage img2;  
void setup() {
    img = loadImage("flammarion_engraving_custom-741e49ab7cc68a364f290fd15634c3c1f2ee30e5.jpg");
  size(img.width,img.height);
     img2 = loadImage("settling_the_score_battle.jpg");

  // Make a new instance of a PImage by loading an image file

}

void draw() {
  background(img);
  // Draw the image to the screen at coordinate (0,0)
  
 // tint(map(mouseY,0,width,0,255),map(mouseX,0,width,0,255));
 
   tint(255,0,0,100);
   image(img2,0,0);
  
 
}*/


/*  Light Ring  */
/*
PImage img;

void setup() {
 
  img = loadImage("settling_the_score_battle.jpg");
   size(img.width, img.height);
}

void draw() {
  loadPixels(); 
  // Since we are going to access the image's pixels too  
  img.loadPixels(); 
  for (int x = 0; x < img.width; x++) {
  for (int y = 0; y < img.height; y++ ) {
    // Calculate the 1D pixel location
    int loc = x + y*img.width;
    // Get the R,G,B values from image
    float r = red   (img.pixels[loc]);
    float g = green (img.pixels[loc]);
    float b = blue  (img.pixels[loc]);
    // Change brightness according to the mouse here
   // float adjustBrightness = ((float) mouseX / width) * 8.0;
   // float adjustBrightness = map(mouseX,0,width,0,255);
   float distance = dist(x,y,mouseX,mouseY); 
   float adjustBrightness = (200-distance)/200; 
    r *= adjustBrightness;
    g *= adjustBrightness;
    b *= adjustBrightness;
    // Constrain RGB to between 0-255
    r = constrain(r,0,255);
    g = constrain(g,0,255);
    b = constrain(b,0,255);
    // Make a new color and set pixel in the window
    color c = color(r,g,b);
    pixels[loc] = c;
  }
}
  updatePixels();
}*/

/* Threshold filter -mouse interactive*/
/*
PImage source;       // Source image
PImage destination;  // Destination image

void setup() {
 
  source = loadImage("flammarion_engraving_custom-741e49ab7cc68a364f290fd15634c3c1f2ee30e5.jpg");  
   size(source.width,source.height);
  // The destination image is created as a blank image the same size as the source.
  destination = createImage(source.width, source.height, RGB);
}

void draw() {  
  float threshold = map(mouseX,0,width,0,255); 
  // We are going to look at both image's pixels
  source.loadPixels();
  destination.loadPixels();
  
  for (int x = 0; x < source.width; x++) {
    for (int y = 0; y < source.height; y++ ) {
      int loc = x + y*source.width;
      // Test the brightness against the threshold
      if (brightness(source.pixels[loc]) > threshold) {
        destination.pixels[loc]  = color(255);  // White
      }  else {
        destination.pixels[loc]  = color(0);    // Black
      }
    }
  }

  // We changed the pixels in destination
  destination.updatePixels();
  // Display the destination
  image(destination,0,0);
}
*/
/*   Pixel Neighbor difference - mouse Interactive */
/*
PImage source;       // Source image
PImage destination;  // Destination image

void setup() {
 
  source = loadImage("flammarion_engraving_custom-741e49ab7cc68a364f290fd15634c3c1f2ee30e5.jpg");  
   size(source.width,source.height);
  // The destination image is created as a blank image the same size as the source.
  destination = createImage(source.width, source.height, RGB);
}

void draw() {  

  source.loadPixels();
  destination.loadPixels();
  
  for (int x = 1; x < source.width-1; x++) {
    for (int y = 1; y < source.height-1; y++ ) {
          int loc = x + y*source.width;
        color pix = source.pixels[loc];
         int leftLoc = (x-(int)(i)) + y*source.width;
          color leftPix = source.pixels[leftLoc];
            float diff = abs(brightness(pix) - brightness(leftPix));
        destination.pixels[N] = color(diff);
    }
  }
  // We changed the pixels in destination
  destination.updatePixels();
  // Display the destination
  image(destination,0,0);
}
*/

/*
a square filter
      int N = x + y*source.width;
          
          //  n1  n2  n3
         //   n4  N   n5
          //  n6  n7  n8          
            
      int n1 = (x-1) + (y-1)*source.width;
       int n2 = x + (y-1)*source.width;
        int n3 = (x+1) + (y-1)*source.width;
         int n4 = (x-1) + y*source.width;
          int n5 = (x+1) + y*source.width;
           int n6 = (x-1) + (y+1)*source.width;
            int n7 = x + (y+1)*source.width;
            int n8 = (x+1) + (y+1)*source.width;
           float i = map(mouseX,0,width,0,25);
           
*/


PImage img;
int w = 200;

// It's possible to perform a convolution
// the image with different matrices

//Gaussian Blur
/*
float[][] matrix = { { 1/16.0, 2/16.0, 1/16.0},
                     { 2/16.0,  4/16.0, 2/16.0 },
                     { 1/16.0, 2/16.0, 1/16.0 } }; 
                     */
        
       
   //   Sharpen: try changing 9 to 8 or the opposite
float[][] matrix = { {-1, -1,-1},
                     { -1, 9,-1 },
                     { -1,-1,-1 } }; 

// Box blur Normalized
/*
float[][] matrix = { { 1/9.0, 1/9.0, 1/9.0 },
                     { 1/9.0,  1/9.0, 1/9.0 },
                     { 1/9.0, 1/9.0, 1/9.0 } }; 
 */
 /* Unsharpening - try on Unsharped_eye.jpg  reduces blurring in image , also set matrixsize = 5
 float a = -1/256.0 ;
 float[][] matrix = { { a, 4*a, 6*a , 4*a , 1*a },
                     { 4*a,16*a,24*a,16*a,4*a },
                     { 6*a,24*a,-476*a,24*a,6*a } ,
                    { 4*a,16*a,24*a,16*a,4*a } ,
                   { 1*a, 4*a, 6*a , 4*a , a }}; 
                 */  
void setup() {
  
  frameRate(30);
  img = loadImage("Unsharped_eye.jpg");
  size(img.width,img.height);
}

void draw() {
  // We're only going to process a portion of the image
  // so let's set the whole image as the background first
  image(img,0,0);
  // Where is the small rectangle we will process
  int xstart = constrain(mouseX-w/2,0,img.width);
  int ystart = constrain(mouseY-w/2,0,img.height);
  int xend = constrain(mouseX+w/2,0,img.width);
  int yend = constrain(mouseY+w/2,0,img.height);
  int matrixsize = 3;
  loadPixels();
  // Begin our loop for every pixel
  for (int x = xstart; x < xend; x++) {
    for (int y = ystart; y < yend; y++ ) {
      // Each pixel location (x,y) gets passed into a function called convolution() 
      // which returns a new color value to be displayed.
      color c = convolution(x,y,matrix,3,img);
      int loc = x + y*img.width;
      pixels[loc] = c;
    }
  }
  updatePixels();

  stroke(0);
  noFill();
  rect(xstart,ystart,w,w);
}

color convolution(int x, int y, float[][] matrix, int matrixsize, PImage img) {
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  // Loop through convolution matrix
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      // What pixel are we testing
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // Make sure we have not walked off the edge of the pixel array
      loc = constrain(loc,0,img.pixels.length-1);
      // Calculate the convolution
      // We sum all the neighboring pixels multiplied by the values in the convolution matrix.
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal,0,255);
  gtotal = constrain(gtotal,0,255);
  btotal = constrain(btotal,0,255);
  // Return the resulting color
  return color(rtotal,gtotal,btotal);
}
