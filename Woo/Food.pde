class Food {
  int xcor, ycor;
  int r, g, b;

  Food(int x, int y) {
    xcor = x;
    ycor = y;
    r = (int)random(255);
    g = (int)random(255);
    b = (int)random(255);
  }

  void display() { //displays each food "pellet"
    stroke(r, g, b);
    fill(color(r, g, b));
    ellipse(xcor, ycor, 5, 5);
  }
}