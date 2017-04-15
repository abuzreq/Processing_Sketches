/**
Frequency is a property of repeating signals like sine waves, but we can look at noise this way too
having thought of noise this way , we know that frequency can be low or high or inbetween , so how can we say have more high frequency noise 
and less low frequency noise , how can we say explicitly that we want this amount of frequency 1 Hz and this amount of frequency 3 Hz
we do that using weighted sum 
*/


int lines = 1;
int size = 20 ;
String string  = "";
void setup()
{
  
    size(1100,550,P2D);
    surface.setSize(1100, 550);
     float[] amplitudes = {1.0, 0.7, 0.5, 0.3, 0.2, 0.1};
     float[] frequencies = {1, 2, 4, 8, 16, 32};
     float[][] noises = new float[frequencies.length][width];
        for(int n = 0 ; n < noises.length ; n++)
        {
          float[] tmp  =noise((int)width,frequencies[n]);
          for(int j = 0 ; j < tmp.length ; j++)
          {
           noises[n][j] =  tmp[j];
          }
         
        }
    print(noises[1][4]);
   background(0);
   float[] values = weightedSum(amplitudes,noises);
    for(int j = 0 ; j < values.length ; j++)
          {
             print(values[j] + " ");
          }
   stroke(255);
   
   scale(1, -1);
   translate(0, -height+50);
   for(int i  = 1 ; i < width ;i++)
   {
     
     line(i,20*values[i-1],i,20*values[i]);
   
   }

      for(int i = 0 ; i < width;i++)
      {
      
        string += values[i];
      }

  

}
String[] toStringArray(float[] array)
{
  String[] strings = new String[array.length];
  for(int i = 0 ;  i< array.length ;i++)
  {  
    strings[i] = "" + array[i]; 
  }
  return strings;
}

/**
return a sin wave values in an array given the frequency of the wave with randomized phase shift
*/
float[] noise(int size,float freq)
{
    float[] values = new float[size];
    float phase = random(0, 2*PI);
    for(int  x = 0 ; x < size ;x++)
    {
      values[x] = sin(2*PI * freq*x/size + phase);   
    }
    return values;
}

float[] weightedSum(float[] amplitudes , float[][] noises)
{
  float[] output = new float[width];
  
  for(int k = 0 ; k < noises.length ; k++)
  {
    for(int x = 0 ; x < width ;x++)
      output[x] = amplitudes[k]*noises[k][x];
  }
  return output;

}


int xoff  = 10;
int yoff  = 100;
int i = 0;
int lineX1 = xoff ;
int lineY1 = yoff + i*100;
int wRect = 1;
int spacingRect = 1;
void draw()
{
  
  scale(1, -1);
  translate(0, -height);
  
  background(0,0,100);
  fill(255);
  
 
    for(int c = 0 ; c < string.length();c++ )
    {
      int x = xoff +c*spacingRect;
      int y = yoff + i * 100 ;
      int height = (int(string.charAt(c))-48)*10;
      strokeWeight(wRect);
      stroke(250,150,0);
     rect(x,y,wRect,height);
    }
    int lineX2 = xoff  + string.length()*50 ;
    int lineY2 = lineY1;
     stroke(0,255,0);
    line(lineX1,lineY1,lineX2,lineY2);
  

}


%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem;%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\;
C:\Program Files (x86)\ATI Technologies\ATI.ACE\Core-Static;C:\Program Files (x86)\AMD\ATI.ACE\Core-Static;F:\gradle-2.2\bin;
C:\Program Files (x86)\Java\jre7\bin;C:\Program Files (x86)\Java\jdk1.7.0_79\bin;C:\Program Files\LOVE;
C:\Program Files\Microsoft SQL Server\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SDKs\TypeScript\1.0\;C:\Python27\