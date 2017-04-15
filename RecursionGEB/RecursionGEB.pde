import java.util.Hashtable;

//A Program to compute the recursive function G in Godel Esher Bach , page 136,137
void setup()
{
/*
   long time =  System.currentTimeMillis();
    println(G(1000));
    println(System.currentTimeMillis() - time );
    println("--------------");
     time =  System.currentTimeMillis();
     println(F(1000));
     println(System.currentTimeMillis() - time );
     */
     for(int  i =  1 ;i < 20;i++)
         println( i + "  :  "+F(i) + " : "+M(i));
}


// RECURSIVE WITH MEMOIZION
Hashtable<Integer, Integer> numbers
     = new Hashtable<Integer, Integer>();
int G(int n)
{ 
  if(n == 0) return 0;
  
  if(numbers.containsKey(n))
    return numbers.get(n);
  
  int num  = n  - G(G(n-1));
  numbers.put(n,num);    
  return num;
  
}

// RECURSIVE NO MEMOIZION
int N(int n)
{ 
    return n == 0 ? 0 : n - N(N(n-1)) ;
  //return n == 0 ? 0 : n - N(N(N(n-1)));
  //return n == 0 ? 0 : n - N(N(N(N(n-1))));  
}


//Experiment with number of testing functions
int F(int n)
{ 
    return n == 0 ? 1 : n - M(F(n-1)) ;
  //return n == 0 ? 0 : n - F(F(F(n-1)));
  //return n == 0 ? 0 : n - F(F(F(F(n-1))));
  
}

int M(int n)
{ 
    return n == 0 ? 0 : n - F(M(n-1)) ;
  //return n == 0 ? 0 : n - F(F(F(n-1)));
  //return n == 0 ? 0 : n - F(F(F(F(n-1))));
  
}