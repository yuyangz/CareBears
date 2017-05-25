class Environment {
  int[][] rain;
  int[][] snow;
  int[][] soil;
  int[][] sun;

  Environment(int w, int h ) {
    rain = new int[w][h];
    snow = new int[w][h];
    soil = new int[w][h];
    sun = new int[w][h];
  }

  void sunlight (int intensity) {
    for (int row = 0; row < sun.length; row += 3) {
      for (int col = 0; col < sun[row].length; col += 3) {
        sun[row][col] += intensity;
        stroke(255, 255, 0);
        fill(120, 120, 0);
        ellipse(row, col, 1, 1 );
      }
    }
    println("God has released light");
    fill(120);
    stroke(120);
    text("God has released light", (width-(0.2*width))/2-("God has released light".length()*4), 10);
  }


  void rain(int intensity) {
    //print(rain.length, rain[0].length);
    //int time = millis();
    //while (millis() < time + 1000) {
    //  ellipse((int)random(width-(width*0.2)), (int)random(height), 1, 1);
    //}
    for (int row = 0; row < rain.length; row+=3) {
      for (int col = 0; col < rain[row].length; col+= 3) { 
        if (random(intensity) <= 1) {
          rain[row][col] += 1+ random(7); 
          stroke(0, 0, 120);
          fill(0, 0, 120);
          ellipse(row, col, 1, 1);
        }
      }
    }
    println("It has rained");
    fill(120);
    stroke(120);
    text("It has rained", (width-(0.2*width))/2-("It has rained".length()*4), 10);

    frameRate(60);
  }


  void showRain() {
    int r = 255;
    int g = 255;
    int b = 255;
    for (int ycenter = rain[0].length/20; ycenter < rain[0].length; ycenter += rain[0].length/10) {
      for (int xcenter = rain.length/20; xcenter < rain.length; xcenter += rain.length/10) {
        int avgwater = 0;
        for (int ydisplacement = -1* rain[0].length/20; ydisplacement < rain[0].length/20; ydisplacement++) {
          for (int xdisplacement = -1* rain.length/20; xdisplacement < rain.length/20; xdisplacement++) {
            set(xcenter+xdisplacement, ycenter+ydisplacement, color(r, g, b));
            avgwater += rain[xcenter+xdisplacement][ycenter+ydisplacement];
          }
        }
        r-=2;
        g-=2;
        b-=1;
        stroke(color(255, 255, 0));
        fill(color(255, 255, 0));
        text(avgwater, xcenter, ycenter);
      }
      r-=2;
      g-=2;
      b-=1;
    }
  }
}