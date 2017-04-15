Mover snake ;

void setup()
{
  size(800,800);
    snake = new Mover();
}


void draw()
{
    background(255,10);
   
      snake.update();
      snake.checkEdges();
      snake.display();
 
}