class Timer {

  PFont font;
  //String time = "010";
  int time;
  int secondTime = 0;
  int interval = 10;
  String type;

  Timer() {
    time = interval;
  }

  Timer( String type, int interval ) {
    //font = createFont("Arial", 100);
    this.type = type;
    this.interval = interval;
    fill(0);
    time = interval;
  }

  void reset() {
    time = interval;
  }

  void run()
  {
    if (time > 0) {
      if (millis() - secondTime > 1000) {
        time--;
        secondTime = millis();
      }
    }
    if (type == "Plant" ) {
      if (time == 0) {
        text("PLANTS: Ready!", width*0.8, 400);
      } else {
        text("PLANTS: " + time,  width*0.8, 400);
      }
    }
    if (type == "Bacteria" ) {
      if (time == 0) {
        text("BACTERIA: Ready!",  width*0.8, 450);
      } else {
        text("BACTERIA: " + time,  width*0.8, 450);
      }
    }
  }
}