static class City
{

    private static int numCities = 0 ;
    int id ;
    
    int adjacents ;
        
    static float[] sizes = new float[]{0.33f,0.66f,0.99f};
    float size ;
    
    static Random rand  = new Random();
    float x ,y;
    City()
    {
        numCities++;
        id = numCities;
        adjacents = 1;
        size = sizes[(int)rand.nextInt(sizes.length)];
        
      
        boolean isVeryClose ;
        while(true)
        {
            isVeryClose = false;
            x = rand.nextFloat()*W;
            y = rand.nextFloat()*H;
            for(int i = 0 ; i < cities.size();i++)
            {
              City city = cities.get(i);
              if(distance(x,y,city.x,city.y) < citiesDistanceThreshold)            
                   isVeryClose = true;
            }
            if(isVeryClose)
                continue;
            else
                break;      
        }
        
        //  distances debug
        /*
            for(int i = 0 ; i < cities.size();i++)
            {
              println("City " +id);
                for(int k = 0 ; k < cities.size();k++)
                {
                  if(k != i)
                    println("    "+cities.get(k)+" => " +distance(x,y,cities.get(k).x,cities.get(k).y));
                }
                 println("******\n");
            }
        */
    }
    static float distance(float x1,float y1,float x2, float y2)
    {
      return sqrt(pow((x1-x2),2)+pow((y1-y2),2));   
    }

    public String toString()
    {
      return id + " size : "+size + " ,adjs: "+(adjacents-1)/(City.numCities*1.0) ;
    }
    public boolean equals(City city)
    {
      return id == city.id;
    }
}