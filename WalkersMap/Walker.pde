PVector pos;
int stepSize ;
PVector target ;
float endRealizationPerc = 0.7f;
int maximumLifetime ;

int lifetime;
float merger,collider,steerer,avoider,ignorer,passenger;//weight between 0 and 1 
PVector mergerVec,colliderVec,steererVec,avoiderVec,ignorerVec,passengerVec;//the amount of addition this behaviour will attribute to walker position

void step()
{
    pos.lerp(target,1f/width);
    
    
    PVector merge = mergerVec.mult(merger/6);
    PVector collid = colliderVec.mult(collider/6);

    PVector steer = steererVec.mult(steerer/6);
    PVector avoid = avoiderVec.mult(avoider/6);
    PVector ignore = ignorerVec.mult(ignorer/6);
    PVector pass = passengerVec.mult(passenger/6);

    
   // pos.add();
}
void display()
{



}