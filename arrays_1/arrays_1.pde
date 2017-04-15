int[] y;
int[] x;
void setup() {
  size(100, 100);
  y = new int[width];
  x = new int[width];
}

void draw() {
  background(204); // Read the array from the end to the
  // beginning to avoid overwriting the data
  for (int i = y.length-1; i > 0; i--) {
    y[i] = y[i-1];
    x[i] = x[i-1];
  }
  // Add new values to the beginning
  y[0] = mouseY;
  x[0] = mouseX;
 
  
  //Enable one for loop at a time ,
 // choose what's to be drawn by uncommenting
  for (int i = 1; i < y.length; i++) {
    //line(i, y[i], i-1, y[i-1]);
   // line(x[i],y[i],x[i-1],y[i-1]);
   //  ellipse(x[i], y[i], i/2.0, i/2.0);
  }
   for (int i = y.length-1; i >1; i--) {
   // line(i, y[i], i-1, y[i-1]);
  //  line(x[i],y[i],x[i-1],y[i-1]);
  //   ellipse(x[i], y[i], i/2.0, i/2.0);
  }

  
  
}
