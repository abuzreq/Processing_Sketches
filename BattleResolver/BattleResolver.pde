float armor = 0.5 ,organization = 0.8;
float armorImportance = 0.3,organizationImportance = 0.5 ;
PFont f;
void setup()
{

size(400,400);
f =  createFont("Arial",30,true);
}
float value ,previous;
boolean change = false;
void draw()
{
   armor = 0.5 ;
   organization = 0.8;
   armorImportance = 0.3;
   organizationImportance = 0.5 ;
   change = false;
  if(frameCount%30==0)
  {
    textFont(f);
    clear();
    if(change)
      previous = value;
    value = armorImportance*armor + organizationImportance*organization;
    
    text("Previous " + previous,width/2-100,height/2-100);
    text("Value " + value,width/2-100,height/2);
    
    println (value);
  }
     

}