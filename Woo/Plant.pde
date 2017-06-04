class Plant {

  int xcor, ycor;
  int size;
  int maxSize;
  int growthRate;
  int waterPriority;
  int waterNeed;
  int lifeTime;
  int birthDate;
  int r, g, b;
  int temp;
  boolean peakStated; //prime of life/ largest size


  //default constructor for plants
  Plant( int x, int y) { //initizalization of plants
    xcor = x;
    ycor = y;
    size = 10;
    maxSize = 300 + (int)random(100);
    growthRate = 1 +(int)random(3);
    waterPriority = (int)random(5);
    waterNeed = 1 + (int)random(4);
    lifeTime= 0;
    birthDate = frameCount;
    int r = b = 0;
    int g = 120;
    peakStated = false;
  }


    

void collision(Plant other){
  float distance = dist(this.xcor,this.ycor,other.xcor,other.ycor);
  if (distance <= 0){
    if(this.size > other.size){
      other.peakStated = true;
    }
    else if (this.size< other.size){
      this.peakStated = true;
    }
    else{
      this.peakStated = true;
      other.peakStated = true;
    }
  }
}
  
  int health() { //uses size as the health count
    return size;
  }

  //checks water in the environment to see how much it will grow/ if it can
  //this may be deleted soon
  boolean checkWater(Environment e) { //checks if the sum of the water in a block is 0
    int avgwater = 0;
    int ycenter = ycor;  //starts at one certain point
    int xcenter = xcor;
    //for (int ydisplacement = -1* e.rain[0].length/20; ydisplacement < e.rain[0].length/20; ydisplacement++) {
    //  for (int xdisplacement = -1* e.rain.length/20; xdisplacement < e.rain.length/20; xdisplacement++) {
    //    if (dist(xcenter+xdisplacement, ycenter+ydisplacement, xcor, ycor) < size*3) {
    //      avgwater += e.rain[xcenter+xdisplacement][ycenter+ydisplacement]; //occasionally exceptions
    //    }
    //  }
    //}
    for (int ydisplacement = -1* size*3; ydisplacement < size*3; ydisplacement++) {  //moves to surrounding points
      for (int xdisplacement = -1* size*3; xdisplacement < size*3; xdisplacement++) {
        if (dist(xcenter+xdisplacement, ycenter+ydisplacement, xcor, ycor) < size*3) {
          avgwater += e.rain[xcenter+xdisplacement][ycenter+ydisplacement]; //occasionally exceptions
        }
      }
    }
    if (avgwater > waterNeed) { 
      return true;
    }
    return false;
  }

  //takes water from the surrounding environment
  //returns amount of water taken
  //may run forever if not enough water in the area !!!needs to be fixed!!!
  int takeWater(Environment e) { 
    boolean isWater = false;
    int temp = waterNeed;
    int waterTaken = 0;
    int ycenter = ycor; 
    int xcenter = xcor;
    while (temp > 0) {
      isWater = false;
      for (int ydisplacement = -1* (int)random(size*1); ydisplacement < (int)random(size*1); ydisplacement++) {
        for (int xdisplacement = -1* (int)random(size*1); xdisplacement < (int)random(size*1); xdisplacement++) {
          //for (int ydisplacement = -1* size; ydisplacement < size; ydisplacement++) {
          //for (int xdisplacement = -1*size; xdisplacement < size; xdisplacement++) {
          if ((int)dist(xcenter+xdisplacement, ycenter+ydisplacement, xcor, ycor) < size*1) {
            if ((xcenter+xdisplacement >= 0 && xcenter+xdisplacement < e.rain.length) && (ycenter+ydisplacement >= 0 && ycenter+ydisplacement < e.rain[0].length) ) {
              if (e.rain[xcenter+xdisplacement][ycenter+ydisplacement] > 0) {
                e.rain[xcenter+xdisplacement][ycenter+ydisplacement] -= 1;
                temp -= 1;//occasionally exceptions
                waterTaken+=1;
                isWater = true;
                if (temp == 0) {
                  return waterTaken;
                }
              }
            }
          }
        }
      }
      if (!isWater) {
        return waterTaken;
      }
    }
    return waterTaken;
  }

  //increments the size of the plant based on hwo much water it received from the environment
  void grow(Environment e ) { //allows plant to grow
    //Plant second = new Plant(mouseX, mouseY); 
    if (!peakStated) {// && checkWater(e)) { //if plant is not at its max size
      float findGrowth = takeWater(e)/waterNeed;
      if (findGrowth == 1) {  //plant will grow based on specific growth rates and waterNeed
        size += growthRate;
        waterNeed *= growthRate;
      } else if (findGrowth > 0.75) { 
        size += growthRate/2;
        waterNeed *= growthRate/2;
      } else if (findGrowth >= 0.5) {
        size += 0;
        waterNeed *= growthRate/3;
      } else if (findGrowth >= 0.25) {
        size -= growthRate/2;
      } else {
        size -= growthRate;
      }
      if (g < 255) { 
        g += (int)random(30);
      }
      if (random(3) <= 1) {
        waterPriority++;
      }
      if (size >= maxSize) {
        peakStated = true;
      }
      //if (dist(this.xcor, this.ycor, second.xcor, second.ycor) <= 0) {
      //  peakStated = true;
      //}
    } else {
      if (size <= 0) {
        size = 0;
        return;
      }
      size -= 1 + growthRate/2;
      g -= (int)random(20);
      r += (int)random(10);
      b += (int)random(10);
      if (random(3) <= 1) {
        waterPriority--;
      }
    }
  }

  //each plant is an ellipse
  //colors approach green as it is healthy, and then approach purple as it is dying
  void display() {//displays each plant
    stroke(r, g, b);
    fill(color(r, g, b));
    ellipse(xcor, ycor, size, size);
  }

  //grows plant once a second
  void run(Environment e) { //display growth of plants
    //if ((frameCount - birthDate) % 60 == 0) { 
    if (second() % 1 == 0) {
      grow(e);
    }
    display();
  }
}