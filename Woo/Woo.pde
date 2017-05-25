ArrayList<Plant> plants = new ArrayList<Plant>();
ArrayList<Plant> allPlants = new ArrayList<Plant>();
ArrayList<Button> buttons = new ArrayList<Button>();
Environment environment;
boolean rain, showRain; //generates array[height][width] with random coordinates having water
// plants w waterPriority n will go in order or priority, and will take all the water in a circle of radius r
boolean snow;
boolean earthquake;
boolean thunderstorm;


void setup() {
  frameRate(60);
  size(1000, 600);
  environment = new Environment(width-(int)(0.2*width), height);
  makeButtons();
  buttons.get(0).display();
  plants.add(new Plant((int)random(0.8*width), (int)random(height)));
  //allPlants.add(plants.get(plants.size()-1));
  environment.rain(30);
}

void makeButtons() {
  buttons.add(new Button(width - (int)(0.2*width), 0, width/10, height/10, color(0, 0, 120), color(120, 0, 0), "Rain"));
  buttons.add(new Button(width - (int)(0.1*width), 0, width/10, height/10, color(0, 120, 0), color(120, 0, 0), "Plant"));
}
void draw() {
  background(255);
  runButtons();
  //environment.showRain();
  for (int i = 0; i < plants.size(); i++) {
    plants.get(i).run();
  }
  removeDeadPlants();
  showTheRain();
  showRaining();
  resetBools();
  int i = 0;
  //while (keyPressed) {
  //  print(i);
  //  if (key == 'r') {
  //    environment.showRain();
  //  }
  //  i++;
  //}
  //if ((frameCount%1000) <= 20) {
  //  environment.rain(30);
  //}
}

void runButtons() {
  for (int i = 0; i < buttons.size(); i++) {
    buttons.get(i).update();
  }
}

void mouseClicked() {
  //plants.add(new Plant(mouseX, mouseY));
  //allPlants.add(plants.get(plants.size()-1));
  print("planted");
  for (Button button : buttons) {
    if (button.active) {
      print("planted");
      if (mouseX < environment.rain.length) {
        print("planted");
        if (button.name == "Plant") {
          plants.add(new Plant(mouseX, mouseY));
          allPlants.add(plants.get(plants.size()-1));
          print("planted");
        }
      }
    }
  }
  for (Button button : buttons) {
    if (button.mouseOver()) {
      if (button.name == "Rain") {
        rain = true;
      } else {//else if (button.name == "Plant"){
        //button.active = !button.active;
        //} else {
        button.click();
      }
    }
  }
}

void removeDeadPlants() {
  for (int i = plants.size() - 1; i >= 0; i--) {
    if (plants.get(i).size <= 0) { 
      plants.remove(i);
    }
  }
}

void keyPressed() {
  if (key == 'r') {
    rain = true;
  }
  if (key == 'q') {
    showRain = true;
  }
}

void showTheRain() {
  if (showRain) {
    environment.showRain();
  }
}
void showRaining() {
  if (rain) {
    environment.rain(30);
    rain = false;
  }
}

void resetBools() {
  if (!keyPressed) {
    rain = false;
    showRain = false;
    snow = false; 
    earthquake = false;
  }
}