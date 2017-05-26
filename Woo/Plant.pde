class Plant {

  int xcor, ycor;
  int size;
  int maxSize;
  int growthRate;
  int waterPriority;
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
    lifeTime= 0;
    birthDate = frameCount;
    int r = b = 0;
    int g = 120;
    peakStated = false;
  }

int health(){
  return size;
}


boolean checkWater(int x ,int y, Environment e){
  if (e.rain[x][y] > 0){
    return true;
  }
  return false;
}

 
  
  void grow(Environment e) {
    if (!peakStated && checkWater(xcor, ycor, e)) {
      size += growthRate;
      if (g < 255) { 
        g += (int)random(30);
      }
      if (random(3) <= 1) {
        waterPriority++;
      }
      if (size >= maxSize) {
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
    if ((frameCount - birthDate) % 20 == 0) { 
      grow(e);
    }
    display();
  }
}