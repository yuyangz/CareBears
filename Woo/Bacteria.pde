class Bacteria {
  int xcor, ycor;
  int dx, dy;
  int size;
  int maxSize;
  int growthRate;
  int waterPriority;
  int lifeTime;
  int birthDate;
  int r, g, b;

  Bacteria( int x, int y) {
    xcor = x;
    ycor = y;
    dx = dy = (int)random(5) +5;
    size = 10;
    //maxSize = 30 + (int)random(10);
    //growthRate = 1 +(int)random(5);
    waterPriority = (int)random(5);
    lifeTime= 0;
    birthDate = frameCount;
    int r = b = 0;
    int g = 120;
  }

  void move() {
    xcor+=dx;
    ycor+=dy;
    if ((xcor > width*0.8) || (xcor < 0) ) {
      xcor -= dx;
      dx *= -1;
      xcor += dx;
    }
    if ((ycor > height) || (ycor < 0) ) {
      ycor -= dx;
      dy *= -1;
      ycor += dy;
    }
  }

  void display() {
    stroke(r, g, b);
    fill(color(r, g, b));
    rect(xcor-size/2, ycor-size/2, size, size);
  }
  void run() {
    move();
    display();
  }
}