class timer {

  PFont font;
  String time = "010";
  int t;
  int interval = 10;

  void setup()
  {
    font = createFont("Arial", 100);
    fill(0);
  }

  void draw()
  {
    if (t >= 0){
    t = interval-int(millis()/1000);
    time = "WAIT: " + nf(t, 3);
    }         
    text(time, 900, 400);
  }
}