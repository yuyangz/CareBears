class Timer {

  PFont font;
  //String time = "010";
  int time;
  int secondTime = 0;
  int interval = 10;
  String type;

  Timer() {
    time = interval;
  } //end Timer()============================================================================================================================================================

  Timer( String type, int interval ) {
    //font = createFont("Arial", 100);
    this.type = type;
    this.interval = interval;
    //fill(0);
    time = interval;
  } //end Timer(String type, int interval)===================================================================================================================================

  void reset() {
    time = interval;
  } //end reset()============================================================================================================================================================

  void run() {
    if (time > 0) {
      if (millis() - secondTime > 1000) {
        time--;
        secondTime = millis();
      }
    }
    if (type == "Plant" ) {
      if (time == 0) {
        fill(255,255,255);
        text("PLANTS: Ready!", width*0.8, 400);
      } else {
        fill(255,255,255);
        text("PLANTS: " + time, width*0.8, 400);
      }
    }
    if (type == "Bacteria Drop" ) {
      if (time == 0) {
        fill(255,255,255);
        text("BACTERIA: Dropping!", width*0.8, 450);
      } else {
        fill(255,255,255);
        text("BACTERIA: " + time, width*0.8, 450);
      }
    }
    if (type == "Food Drop" ) {
      if (time == 0) {
        fill(255,255,255);
        text("FOOD: Dropping!", width*0.8, 475);
      } else {
        fill(255,255,255);
        text("FOOD: " + time, width*0.8, 475);
      }
    }
  } //end run()==============================================================================================================================================================
}