int lines = 4;
int size = 20 ;
//you can create a non-uniform random ditribution using a uniform one
//here we take the module(or divide) the square of the random number,
//which limits the values to the left of the array
String[] strings ;
void setup()
{
  size(1100, 550, P2D);
  surface.setSize(1100, 550);
  strings = new String[lines];
  int rand = 0;
  for (int m = 0; m < lines; m++)
  {
    strings[m] = "";

    for (int i = 0; i < size; i++)
    {

      strings[m] += (int)random(0, 3);
    }
  }
  //above we took the randoms that are generated in isolation
  //below we will recreate our noise in such a manner such that randoms are generated with realtion to each other (e.g. min , max ,avg of two adjacents)
  //this will reduce the number of the randoms given above by one (due to the binary nature of the operaions applied i.e. max , min , avg)
  
  int  needed_num_of_smoothings = 1 ;
  //this will re apply the same noise reducing (i.e. by relating to adjacents by max , min  or avg) this amount of times, if this number exceeds the
  //number of elemnts in the original noise we lose all our elements in the smoothing(due to repeated minimizing)
  //also since we have 3 possible values we expect all terrain to become vallies eventually if we are minimizing each time .(vice versa for max but not for avg)
  //
  for(int current_num_of_smoothings = 0 ; current_num_of_smoothings < needed_num_of_smoothings ;current_num_of_smoothings++)
    for (int m = 0; m < strings.length; m++)
    {
      String newNoise = "";    
      int n = 0;
      for (int i = 1; i < strings[m].length(); i++)
      {
        // n = (strings[m].charAt(i-1)+ strings[m].charAt(i))/2;//average of adjcaents , more hills
        //n = max(strings[m].charAt(i-1), strings[m].charAt(i)); //max of adjcaents , more mountains
        n = min(strings[m].charAt(i-1), strings[m].charAt(i)); //min of adjcaents, more vallies , mountains adjacents to hills
  
        newNoise += n - 48; // turn from char to int
        //   println(n);
      }
      strings[m] = newNoise;
    }
 
 
}


void printLand(String[] array)
{
  for (int i = 0; i < array.length; i++ )
  {
    print(array[i]);
  }
  println();
}

int xoff  = 25;
int yoff  = 25;


void draw()
{
  float w = size/(width * 1.0);
  //println(size + " " +width);
  scale(1, -1);
  translate(0, -height);

  background(0, 0, 100);
  fill(255);

  for (int i = 0; i < strings.length; i++)
  {
    int lineX1 = xoff ;
    int lineY1 = yoff + i*100;
    for (int c = 0; c < strings[i].length(); c++ )
    {
      int x = xoff + c*50;
      int y = yoff + i * 100 ;
      int height = (int(strings[i].charAt(c))-48)*30;
      strokeWeight(2);
      stroke(250, 150, 0);
      rect(x, y, 50, height);
    }
    int lineX2 = xoff  + strings[i].length()*50 ;
    int lineY2 = lineY1;
    stroke(0, 255, 0);
    line(lineX1, lineY1, lineX2, lineY2);
  }
}