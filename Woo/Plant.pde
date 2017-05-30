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


  Plant( int x, int y) {
    xcor = x;
    ycor = y;
    size = 5;
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

  int health() {
    return size;
  }


  boolean checkWater(Environment e) {
    int avgwater = 0;
    int ycenter = ycor; 
    int xcenter = xcor;
    //for (int ydisplacement = -1* e.rain[0].length/20; ydisplacement < e.rain[0].length/20; ydisplacement++) {
    //  for (int xdisplacement = -1* e.rain.length/20; xdisplacement < e.rain.length/20; xdisplacement++) {
    //    if (dist(xcenter+xdisplacement, ycenter+ydisplacement, xcor, ycor) < size*3) {
    //      avgwater += e.rain[xcenter+xdisplacement][ycenter+ydisplacement]; //occasionally exceptions
    //    }
    //  }
    //}
    for (int ydisplacement = -1* size*3; ydisplacement < size*3; ydisplacement++) {
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

  int takeWater(Environment e) {
    int temp = waterNeed;
    int waterTaken = 0;
    int ycenter = ycor; 
    int xcenter = xcor;
    while (temp > 0) {
      //for (int ydisplacement = -1* e.rain[0].length/20; ydisplacement < e.rain[0].length/20; ydisplacement++) {
      //for (int xdisplacement = -1* e.rain.length/20; xdisplacement < e.rain.length/20; xdisplacement++) {
      //for (int ydisplacement = -1* (int)random(e.rain[0].length/20); ydisplacement < (int)random(e.rain[0].length/20); ydisplacement++) {
      //for (int xdisplacement = -1* (int)random(e.rain.length/20); xdisplacement < (int)random(e.rain.length/20); xdisplacement++) {
      for (int ydisplacement = -1* (int)random(size*1); ydisplacement < (int)random(size*1); ydisplacement++) {
        for (int xdisplacement = -1* (int)random(size*1); xdisplacement < (int)random(size*1); xdisplacement++) {
          if (dist(xcenter+xdisplacement, ycenter+ydisplacement, xcor, ycor) < size*1) {
            if ((xcenter+xdisplacement >= 0 && xcenter+xdisplacement <= e.rain.length) && (ycenter+xdisplacement >= 0 && ycenter+ydisplacement <= e.rain.length) ) {
              e.rain[xcenter+xdisplacement][ycenter+ydisplacement] -= 1;
              temp -= 1;//occasionally exceptions
              waterTaken+=1;
              if (temp == 0) {
                return waterTaken;
              }
            }
          }
        }
      }
    }
    return waterTaken;
  }


  void grow(Environment e) {
    Plant second = new Plant(mouseX, mouseY);
    if (!peakStated) {// && checkWater(e)) {
      float findGrowth = takeWater(e)/waterNeed;
      if (findGrowth == 1) {
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
      if (dist(this.xcor, this.ycor, second.xcor, second.ycor) <= 0) {
        peakStated = true;
      }
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

  void display() {
    stroke(r, g, b);
    fill(color(r, g, b));
    ellipse(xcor, ycor, size, size);
  }

  void run(Environment e) {
    if ((frameCount - birthDate) % 60 == 0) { 
      //if (second() % 1 == 0) {
      grow(e);
    }
    display();
  }
}