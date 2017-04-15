float[] array = new float[100];




/*
say you have a function f(x), either in a closed form like f(x) = e^-rx or in the form of data points(first value , x = 0 y = 0th element in list) [0,1,5,2,1,1,3,7,5,2,1,0]
that can be interpolated 
now if you want to generate random numbers such that the frequency of a value x is equal to the corrosponding f(x) to that x
your function will be the pdf (probability density function) which describes the peobability of each value
when you integrate the pdf you gain the cmf which is the cumulative density function denoted by a capital F and F(x)
is equal to the area under the curve for x between - infifnity and x
the max value of teh cdf with x = xmax is 1, minimum = 0 (so range is 0-1)
now for example the pdf of the exponential distribuion is f(x) = lambda*e^(- lambda * x) , F(x) = 1-e^(-lambda * x)
solve the cmf for x 
x = -(1/lambda)*ln(1-F(x))
now choose F(x) randomly (uniform distribution)
and the result is that you get values of x that reflects the pebability desired in the pdf
in a more general case where it's hard to solve for x , choose the value of F(x) randomly (remember it's between 0 and 1)
and find the value of x that will givev you this number

Algorithm(input : f(x)):

F(x) = integrate f(x)
result in an equation (eq)  = (solve F(x) for x)
choose randomly a value for F(x) in eq


This is agood source using matlab 
http://matlabtricks.com/post-44/generate-random-numbers-with-a-given-distribution
*/


void setup()
{  float lambda = 0.2;
   size(800,800);
   for(int i = 0 ; i < 20000;i++)
   {
     float rand = random(1);
     float num  = -(1.0/lambda)* log(1-rand);//the shape genrated is actually that of the pdf (but the main usage is the values generated not the graph)
     float index = floor(num*10);//this may vary ,it's way to handle continious values by getting one digit extra and flooring 
     
     if(index > array.length -1 )
       continue;
     array[(int)index] += 1;//the more probable a number is the more +1's he will get(this is only for illustraion as we are truly intrested in the value num
     
   }

   for(int i = 0 ; i < array.length;i++)
   {
      
      print(array[i] + " "); 
   }

}
float x = 100,y = 15;
float xScale = 4,yScale = 2;
void draw()
{
  background(255);
  
  scale(1, -1);          // To revesre 
  translate(0, -height); // the y axis
  
  strokeWeight(3);
  for(int i = 1 ; i < array.length;i++)
  {
     point(x+i*xScale,array[i]*yScale);//scale this graph to fit the resulting plot
  
  }
  line(x-25,y,x+width,y);
  line(x-25,y,x-25,y+height);
  translate(0,0);



}