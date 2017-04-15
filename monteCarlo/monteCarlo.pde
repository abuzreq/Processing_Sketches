//Given a square , choose two points randomly , the average distance between them on average for many runs cinverges to X

int runs = 10000;
int currentRun = 0 ;
float sum = 0;
void setup()
{
  while(currentRun < runs)
  {
    float x1 = random(0.1);
    float y1 = random(0.1);
    
    float x2 = random(0.1);
    float y2 = random(0.1);

    float distance = sqrt(pow((x2-x1),2)+pow((y2-y1),2));
    sum = sum + distance;
    currentRun++;
  }
  print( sum/runs);
}

void draw()
{
  

}