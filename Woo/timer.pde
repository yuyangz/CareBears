class Timer {

  PFont font;
  //String time = "010";
  int time;
  int secondTime = 0;
  int interval = 10;
  Timer() {
    time = interval;
  }

  Timer( int interval ) {
    //font = createFont("Arial", 100);
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
    //if (t >= 0){
    //t = interval-(int)(millis()/1000);
    //time = "WAIT: " + nf(t, 3);
    //}         
    text("PLANTS: " + time, 900, 400);
  }
}