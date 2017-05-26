class Button {
  int x, y;      // Position of square button
  int rectSize;     // Diameter of rect
  int w, h; //width/height
  color rectColor, baseColor;
  color rectHighlight;
  color currentColor;
  boolean rectOver = false;
  String name;
  boolean active = false;

//deafult construcot, specifies location, size, color, and name
  Button(int x, int y, int w, int h, color rectColor, color rectHighlight, String name) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.rectColor = rectColor;
    this.rectHighlight = rectHighlight;
    this.name = name;
  }

//returns whether or not the mouse is over the button
  boolean mouseOver() {
    if (mouseX >= x && mouseX <= x+w && 
      mouseY >= y && mouseY <= y+h) {
      return true;
    } else {
      return false;
    }
  }

//shows the button on the display window
//updates to show a different color if the mouse is over
  void display() {
    stroke(255);
    fill(rectColor);
    if (mouseOver()) {
      fill(rectHighlight);
    }
    rect(x, y, w, h);
    fill(255);
    text(name, x+(int)(w/2)-(name.length()*4), y+(int)(h/2));
  }


  //Clicking the button leads to the button becoming active
  
  void click() {
    if (mouseOver()) {
      if (name == "Rain") {
        active = true;
      } else {
        active = !active;
      }
    } else {
      text("Put the mouse on the button please", 5, 5);
    }
  }

  void update() {
    display();
  }
}