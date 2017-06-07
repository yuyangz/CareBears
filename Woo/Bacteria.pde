  class Bacteria {
  int xcor, ycor;
  int dx, dy;
  int size;
  int health;
  int maxSize;
  int growthRate;
  int waterPriority;
  int lifeTime;
  int birthDate;
  int r, g, b;

  //constructor for bacteria
  //requires a given x and y coordinate
  //randomizes most other things
  Bacteria( int x, int y) {
    xcor = x;
    ycor = y;
    health = 10 + (int)(random (10));
    dx = dy = (int)random(5) +2;
    size = 10;
    //maxSize = 30 + (int)random(10);
    //growthRate = 1 +(int)random(5);
    waterPriority = (int)random(5);
    lifeTime= 0;
    birthDate = frameCount;
    int r = b = 0;
    int g = 120;
  } //end Bacteria()========================================================================================================================================================

  //basic adds speed to position
  //checks for collisions as to not leave the screen
  void move() {
    xcor+=dx;
    ycor+=dy;
    //checks horizontal size
    if ((xcor > width*0.8) || (xcor < 0) ) {
      xcor -= dx;
      dx *= -1;
      xcor += dx;
    }
    //checks vertical size
    if ((ycor > height) || (ycor < 0) ) {
      ycor -= dx;
      dy *= -1;
      ycor += dy;
    }
  } //end move()=============================================================================================================================================================

//when bacteria collides with plant, it will "eat" the plant
  void eat(Plant p) {
    float distance = dist(this.xcor, this.ycor, p.xcor,p.ycor);
    if (distance < this.size/2 + p.size /2) {
      p.size -= 1;
    }
  } //end eat()==============================================================================================================================================================
  
//causes bacteria to shrink when health is too low
void shrink(){
  if (health <= 0){
    size -= 1;
  }
  if (size <= 0){
    size = 0;
  }
}
//end shrink()======================================================================================================================================================

  //displayed as a circle for now, but will later be changed to be more distinguishable
  void display() {
    stroke(r, g, b);
    fill(color(r, g, b));
    rect(xcor-size/2, ycor-size/2, size, size);
  } //end display()==========================================================================================================================================================

  //moves and displays the bacteria
  void run() {
    lifeTime++;
    move();
    display();
  } //end run()==============================================================================================================================================================
}