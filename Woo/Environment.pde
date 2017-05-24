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
    for (int row = 0; row < rain.length; row+=3) {
      for (int col = 0; col < rain[row].length; col+= 3) { 
        if (random(intensity) <= 1) {
          rain[row][col] += 1+ random(3); 
          stroke(0, 0, 120);
          fill(0, 0, 120);
          ellipse(row, col, 1, 1);
        }
      }
      println("it has rained");
        //frameRate(60);
        print(frameCount);
        int currFrame = frameCount;
        //while (frameCount < currFrame + 1){
        //  fill(120);
        //  ellipse (30,30,30,30);
        //}
        frameRate(60);

    }
  }

  void showRain(){
    for (int ycenter = height/10; ycenter < height; ycenter += height/5){
      for (int xcenter = width/10; ycenter < width; ycenter += width/5){
        int avgwater = 0;
        for (int ydisplacement = -1* height/10; ydisplacement <= height/10; ydisplacement++){
          for (int xdisplacement = -1* width/10; xdisplacement <= width/10; xdisplacement++){
            avgwater += rain[ycenter+ydisplacement][xcenter+xdisplacement];
          }
        }
        text(avgwater,ycenter,xcenter);
      }
    }
    
    
  }
}