//gradiant descent , random but move to sorted by changes
//Try to make a metric that doesn't require a sorted array(like the distance) and is effecient
//when you have that metric ready you can start makes changes to the array at each turn in a way that makes the metric of sortability increase , the change could be elements swaps
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;

int[] sorted = {1,2,3,4,5,6,7,8,9,10};
int[] arr = {1,9,8,5,4,3,7,6,2,10};

void setup()
{
    while(distance(sorted,arr) > .2)
    {
       shuffleArray(arr);      
    }
    println("\nAhaaa " + distance(sorted,arr));
    for(int i = 0 ; i<arr.length;i++)
    {
        print(arr[i] + " " );
    }
     println("\nsorted " + distance(sorted,sorted));
    for(int i = 0 ; i<sorted.length;i++)
    {
        print(sorted[i] + " " );
    }

}

static double  distance(int[] sorted , int[] arr)
{
  int numMismatch =  0;
   for(int i = 0 ; i<arr.length;i++)
    {
       if(arr[i] != sorted[i])
       {
         numMismatch++;
       }
    }
 return (numMismatch*1.0)/arr.length;
}

static void shuffleArray(int[] ar)
{
  // If running on Java 6 or older, use `new Random()` on RHS here
  Random rnd = ThreadLocalRandom.current();
  for (int i = ar.length - 1; i > 0; i--)
  {
    int index = rnd.nextInt(i + 1);
    // Simple swap
    int a = ar[index];
    ar[index] = ar[i];
    ar[i] = a;
  }
}