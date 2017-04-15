import java.util.*;
import java.util.function.*;
static float W,H ;


//is the model correct ?
//is the view correct?
//TODO draw a noisy line instead
//TODO choose a good discritization of domains
//TODO Choose a good constant a
static int citiesDistanceThreshold = 135;
static ArrayList<City> cities = new ArrayList<City>();
static ArrayList<Road> roads = new ArrayList<Road>();
static int numCities = 5;
void setup()
{

  size(800,800);
  W = width;
  H = height;
  generate();
}


  float a   = 2f;

  void generate()
  {
    roads.clear();
  City.numCities = 0;
  cities.clear();
  //init cities
  for(int  i = 0 ; i < numCities ; i++)
  {
      City city = new City();
      cities.add(city);
  }
  /*
  Collections.sort(cities,new Comparator<City>()
  {   
    public int compare(City city1,City city2)
    {
                return (int)((city2.size*10) - (city1.size*10));
    }
  });*/

  //println(Arrays.toString(cities.toArray()));
  
  for(int  i = 0 ; i < numCities ; i++)
  {
    for(int j = 0 ; j < numCities ; j++)
    {
      if(i != j)
        roads.add(new Road(cities.get(i),cities.get(j),0));
    }  
  }
  Collections.shuffle(roads);
  for(int  i = 0 ; i < roads.size() ; i++)
  {
          City city1 = roads.get(i).c1;
          City city2 = roads.get(i).c2;
          if(!city1.equals(city2))
          {
              float value =(a*M(city2)*M(city1))/(D(city1,city2)*N(city1)*N(city2));
              if(value <= 0.4f)
              {
                  //roads.add(new Road(city1,city2,0));
              }
              else
              {
                  city1.adjacents++;
                  city2.adjacents++;
                  if(value > 0.8f)
                  {
                      roads.get(i).type = 3;
                  }
                  else if(value > 0.6f)
                  {
                      roads.get(i).type = 2;
                  }
                  else if(value > 0.4)
                  {
                      roads.get(i).type = 1;
                  }                  
              }                    
          }
  }
  
  
 roads.removeIf(new Predicate<Road>(){public boolean test(Road road){return road.type == 0;}});

}
float M(City city)
{
   return city.size;
}
float N(City city)
{
  return (city.adjacents-1)/(City.numCities*1.0);
}


void draw()
{
  background(255);
  stroke(0);
    for(int j = 0; j < roads.size();j++)
  {
      roads.get(j).draw();
  }
  for(int  i = 0 ; i < numCities ; i++)
  {
    float size = cities.get(i).size; 
        if(size == City.sizes[0])
                rect(cities.get(i).x,cities.get(i).y,11,11);
        if(size == City.sizes[1])
              ellipse(cities.get(i).x,cities.get(i).y,9,9);
        if(size == City.sizes[2])
              rect(cities.get(i).x,cities.get(i).y,4,4);
  }
  
                
  if(mousePressed)
  {
    clear();
    generate();
   // a -= 0.005f;
    println(a);
  }
  
}

float D(City c1 ,City c2)
{
  return distance(c1,c2)/(W*sqrt(2));
}
static float distance(City c1 ,City c2)
{
  return sqrt(pow((c1.x-c2.x),2)+pow((c1.y-c2.y),2));
}