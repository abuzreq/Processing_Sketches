





 Production[]  productions = 
  {
    new Production("A","apple"),
    new Production("B","bag"),
    new Production("S","shop"),
    new Production("T","the"),
    new Production("the shop","my brother"),
    new Production("a never used","terminating rule",true),   
  };
int numProduction = 1;
boolean terminate ;

String input = "I bought a B of As from T S.";//Here you can change the input
void setup()
{
   println("0: "+input);   
   while(!terminate)
   {
       input = step(productions,input);
       println(numProduction+": "+input); 
       numProduction++;
       if(numProduction > 10)
         break;
   }
}

String step(Production[] productions,String input)
{
  
  String word = input ;
  int i = 0 ;
  for(i = 0 ; i < productions.length;i++)
  {   
    //iterate over productions in order,if the pattern exist , 
    //replace the first occurance only
    if(word.contains(productions[i].pattern))
    {
        word = word.replaceFirst(productions[i].pattern,productions[i].replacemnt);
        break;
    }    
    if(productions[i].isTerminating)//Stop on terminating productions
    {
      terminate = true;
    }
  }
  
  if(i == productions.length)//if no production were applicable, terminate
     terminate = true;

  return word;
}