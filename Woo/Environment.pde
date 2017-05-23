class Environment {
  int[][] rain;
  int[][] snow;
  int[][] soil;

  Environment(int h, int w ) {
    rain = new int[h][w];
    snow = new int[h][w];
    soil = new int[h][w];
  }

  void rain(int intensity) {
    print(rain.length, rain[0].length);
    for (int row = 0; row < rain.length; row++) {
      for (int col = 0; col < rain[row].length; col++) { 
        if (random(intensity) <= 1) {
          rain[row][col] += 1+ random(3); 
          stroke(0, 0, 120);
          fill(0, 0, 120);
          ellipse(row, col, 1, 1);
        }
      }
      println("it has rained");
    }
  }

  void fakerain() {
    int currFrame = frameCount;
    while ((frameCount-currFrame)%1000 < 20) {
      for (int row = 0; row < rain.length; row++) {
        for (int col = 0; col < rain[row].length; col++) { 
          if (random(intensity) <= 1) {
            stroke(0, 0, 120);
            fill(0, 0, 120);
            ellipse(row, col, 1, 1);
          }
        }
        println("it has rained");
      }
    }
  }
}