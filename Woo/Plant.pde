class Plant {

  int xcor, ycor;
  int size;
  int maxSize;
  int growthRate;
  int waterPriority;
  int lifeTime;
  int birthDate;
  int r, g, b;
  boolean peakStated; //prime of life/ largest size
  
  Plant( int x, int y) {
    xcor = x;
    ycor = y;
    size = 5;
    maxSize = 30 + (int)random(10);
    growthRate = 1 +(int)random(5);
    waterPriority = (int)random(5);
    lifeTime= 0;
    birthDate = frameCount;
    int r = b = 0;
    int g = 120;
    peakStated = false;
  }

  void grow() {
    if (!peakStated) {
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
    fill(color(r, g, b));
    ellipse(xcor, ycor, size, size);
  }

  void run() {
    if ((frameCount - birthDate) % 20 == 0) { 
      grow();
    }
    display();
  }
}