int lines = 4;
int size = 20 ;
//you can create a non-uniform random ditribution using a uniform one
//here we take the module(or divide) the square of the random number,
//which limits the values to the left of the array
String[] strings ;
void setup()
{
    size(1100,550,P2D);
    surface.setSize(1100, 550);
    strings = new String[lines];
    int rand = 0;
   for(int m = 0 ; m < lines ;m++)
   {
      strings[m] = "";
      
      for(int i = 0 ; i < size;i++)
      {
       rand = (int)random(0,3);//uniform distribution
       /* OR(non-uniform)
       posibilities are rand[0,0],rand[0,1],rand[0,2]
       it's like this :
             0
           1 0 1 
         2 1 0 1 2
         note those ways are not coherent as every random is generated in isolation of the others
         (see Noise 3 ) for a coherent way
       */
       //rand =  (int)random(0, random(0, 3));
        strings[m] += rand;
      }
      
   }
   
  

}


void printLand(String[] array)
{
  for(int i = 0; i < array.length;i++ )
  {
    print(array[i]);  
  }
  println();

}

int xoff  = 25;
int yoff  = 25;
void draw()
{
  
  scale(1, -1);
  translate(0, -height);
  
  background(0,0,100);
  fill(255);
  
  for(int i = 0 ; i < strings.length;i++)
  {
    int lineX1 = xoff ;
    int lineY1 = yoff + i*100;
    for(int c = 0 ; c < strings[i].length();c++ )
    {
      int x = xoff +c*50;
      int y = yoff + i * 100 ;
      int height = (int(strings[i].charAt(c))-48)*30;
      strokeWeight(2);
      stroke(250,150,0);
     rect(x,y,50,height);
    }
    int lineX2 = xoff  + strings[i].length()*50 ;
    int lineY2 = lineY1;
     stroke(0,255,0);
    line(lineX1,lineY1,lineX2,lineY2);
  }

}