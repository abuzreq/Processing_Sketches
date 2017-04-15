int lines = 4;
//you can create a non-uniform random ditribution using a uniform one
//here we take the module(or divide) the square of the random number,
//which limits the values to the left of the array
void setup()
{

   for(int m = 0 ; m < lines ;m++)
   {
     String[] map  = new String[20];
     for(int i = 0; i < map.length;i++ )
      {
        map[i]  = "_" ;   
      }
      int random = (int)(random(0,map.length))/2;
      map[(random*random)%(map.length-4)] = "#";
      print(random+ " : " +(random*random)%(map.length-1) + " "  );
      printLand(map);
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