class Environment {
  int[][] grid;
  int[][] rain;
  int[][] snow;
  int[][] soil;
  int[][] sun;


  Environment(int w, int h ) {
    grid = new int[w][h];
    rain = new int[w][h];
    snow = new int[w][h];
    soil = new int[w][h];
    sun = new int[w][h];
  }

  //enters sunlight onto the map
  //sunlight will be uniform in the sun array, but will decrease water levels randomly
  void sunlight (int intensity) { //allows the presence of sunlight based on a certain intensity
    for (int row = 0; row < sun.length; row += 3) {
      for (int col = 0; col < sun[row].length; col += 3) {
        sun[row][col] += intensity;
        if (random(intensity) <= 1) {
          rain[row][col] -= random(4);  //decreases the water in each spot of the coordinate system
          stroke(0, 0, 120);
          fill(0, 0, 120);
          ellipse(row, col, 1, 1);
        }
        //rain[row][col] -=;
        stroke(255, 255, 0);
        fill(120, 120, 0);
        ellipse(row, col, 1, 1 );
      }
    }
    println("God has released light"); //gives statement that shows that sun has been released
    fill(120);
    stroke(120);
    text("God has released light", (width-(0.2*width))/2-("God has released light".length()*4), 10);
  }

  //makes it rain by adding random values to individual spots on the rain array
  void rain(int intensity) { //provides rain to each individual coordinate point on the grid
    //print(rain.length, rain[0].length);
    //int time = millis();
    //while (millis() < time + 1000) {
    //  ellipse((int)random(width-(width*0.2)), (int)random(height), 1, 1);
    //}
    for (int row = 0; row < rain.length; row+=3) {
      for (int col = 0; col < rain[row].length; col+= 3) { 
        if (random(intensity) <= 1) {
          rain[row][col] += 1+ random(4); 
          stroke(0, 0, 120);
          fill(0, 0, 120);
          ellipse(row, col, 1, 1);
        }
      }
    }
    println("It has rained"); //gives statement that show that rain has been released
    fill(120);
    stroke(120);
    text("It has rained", (width-(0.2*width))/2-("It has rained".length()*4), 10);

    frameRate(60);
  }

  //draws line in concurrence with the rainfall graph
  void getGrid() { //displays grid so that the user can more easily place plants
    int x = 0;
    stroke(0);
    //strokweight(2);
    x = 0; //width / 10;
    while ( x<= grid.length) { //horizontal
      line(x, 0, x, grid[0].length);
      x += grid.length / 20;
    }
    int y = 0;
    stroke(0);
    //strokweight(2);
    y = 0; //grid[0].length / 10;
    while ( y <=grid[0].length) { //vertical
      line(0, y, grid.length, y);
      y += grid[0].length / 20;
    }
  }

  //splits map into boxes concurrent with the grid
  //adds total water drops in that section in the rain array
  void showRain() { //displays rain so that the user can see average rain in each "block"
    int r = 30;
    int g = 30;
    int b = 120;
    //for (int ycenter = rain[0].length/20; ycenter < rain[0].length; ycenter += rain[0].length/10) {
    //for (int xcenter = rain.length/20; xcenter < rain.length; xcenter += rain.length/10) {
    for (int ycenter = rain[0].length/40; ycenter < rain[0].length; ycenter += rain[0].length/20) {
      for (int xcenter = rain.length/40; xcenter < rain.length; xcenter += rain.length/20) {
        int avgwater = 0;
        //for (int ydisplacement = -1* rain[0].length/20; ydisplacement < rain[0].length/20; ydisplacement++) {
        //for (int xdisplacement = -1* rain.length/20; xdisplacement < rain.length/20; xdisplacement++) {
        for (int ydisplacement = -1* rain[0].length/40; ydisplacement < rain[0].length/40; ydisplacement++) {
          for (int xdisplacement = -1* rain.length/40; xdisplacement < rain.length/40; xdisplacement++) {
            set(xcenter+xdisplacement, ycenter+ydisplacement, color(r, g, b));
            avgwater += rain[xcenter+xdisplacement][ycenter+ydisplacement];
            if (avgwater <= 0) {
              avgwater = 0;
            }
          }
        }
        //r-=2;
        //g-=2;
        //b-=1;
        stroke(color(255, 255, 0));
        fill(color(255, 255, 0));
        text(avgwater, xcenter-5, ycenter);
      }
      r-=2;
      g-=2;
      b-=1;
    }
  }
}