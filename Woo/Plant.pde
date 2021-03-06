class Plant implements Comparable<Plant> {
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
  int time;
  boolean peakStated; //prime of life/ largest size
  int foodEaten;

  Timer intPlantTimer;
  Timer peakTimer;

  //default constructor for plants
  Plant( int x, int y) { //initizalization of plants
    xcor = x;
    ycor = y;
    size = 10;
    maxSize = 100 + (int)random(100);
    growthRate = 1 +(int)random(3);
    waterPriority = (int)random(5);
    waterNeed = 1 + (int)random(4);
    lifeTime= 0;
    birthDate = frameCount;
    int r = b = 0;
    int g = 120;
    peakStated = false;
    foodEaten = 0;

    time = 0;
    intPlantTimer = new Timer("Internal Plant", 1);
  } //end Plant()============================================================================================================================================================

  void collision(Plant other) {
    float distance = dist(this.xcor, this.ycor, other.xcor, other.ycor);
    if (distance <= size/2 + other.size/2) {
      if (this.size/2 > other.size/2) {
        other.peakStated = true;
      } else if (this.size/2< other.size/2) {
        this.peakStated = true;
      } else {
        this.peakStated = true;
        other.peakStated = true;
      }
    }
  } //end collision()========================================================================================================================================================

  int health() { //uses size as the health count
    return size;
  } //end health()===========================================================================================================================================================

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
      for (int i = 0; i < 100; i++) {
        for (int ydisplacement = -1* (int)random(size/2*1); ydisplacement < (int)random(size/2*1); ydisplacement++) {
          for (int xdisplacement = -1* (int)random(size/2*1); xdisplacement < (int)random(size/2*1); xdisplacement++) {
            if ((int)dist(xcenter+xdisplacement, ycenter+ydisplacement, xcor, ycor) < size/2*1) {
              if ((xcenter+xdisplacement >= 0 && xcenter+xdisplacement < e.rain.length) && (ycenter+ydisplacement >= 0 && ycenter+ydisplacement < e.rain[0].length) ) {
                if (e.rain[xcenter+xdisplacement][ycenter+ydisplacement] > 0) {
                  e.rain[xcenter+xdisplacement][ycenter+ydisplacement] -= 1;
                  temp -= 1;
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
      }
      if (!isWater) {
        return waterTaken;
      }
    }
    return waterTaken;
  } //end takeWater()========================================================================================================================================================

  //increments the size of the plant based on hwo much water it received from the environment
  void grow(Environment e, ArrayList<Plant> plants ) { //allows plant to grow
    //Plant second = new Plant(mouseX, mouseY);   
    time = millis();
    for (Plant other : plants) {
      if (this != other) {
        collision(other);
      }
    }

    //if (time%500 <= 20) {
    if (!peakStated) {  // && checkWater(e)) { //if plant is not at its max size
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
      //}
    }
  } //end grow()=============================================================================================================================================================

  //each plant is an ellipse
  //colors approach green as it is healthy, and then approach purple as it is dying
  void display() {//displays each plant
    stroke(r, g, b);
    fill(color(r, g, b));
    ellipse(xcor, ycor, size, size);
  } //end display()==========================================================================================================================================================

  //grows plant once a second
  void run(Environment e) { //display growth of plants
    lifeTime++;
    intPlantTimer.run();
    if (intPlantTimer.time == 0) {
      grow(e, plants);
      intPlantTimer.reset();
    }
    display();
  } //end run()==============================================================================================================================================================

  int compareTo (Plant other) {
    if (this.lifeTime > (other).lifeTime) {
      return 1;
    } else if (this.lifeTime < ((Plant)other).lifeTime) {
      return -1;
    } else {
      return 0;
    }
  }// end compareTo()========================================================================================================================================================

//if plant touches food, it will "eat" it and increase stats
  void toEat(Food f) {
    float distance = dist(this.xcor, this.ycor, f.xcor, f.ycor);
    if (distance < this.size/2 + 2.5) {
      f.eaten = true;
      this.maxSize += 10;
      this.size += 2;
      foodEaten++;
    }
  }//end toEat(Food f)======================================================================================================================================================  
}