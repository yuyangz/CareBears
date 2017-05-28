ArrayList<Plant> plants = new ArrayList<Plant>();
ArrayList<Plant> allPlants = new ArrayList<Plant>();
ArrayList<Bacteria> bacteria = new ArrayList<Bacteria>();
ArrayList<Bacteria> allBacteria = new ArrayList<Bacteria>();

ArrayList<Button> buttons = new ArrayList<Button>();
Environment environment;
boolean rain, showRain; //generates array[height][width] with random coordinates having water
// plants w waterPriority n will go in order or priority, and will take all the water in a circle of radius r
boolean sunlight, showSunlight;
boolean snow;
boolean earthquake;
boolean thunderstorm;

boolean b;


void setup() {
  frameRate(600);
  size(1000, 600);
  environment = new Environment(width-(int)(0.2*width), height);
  makeButtons();
  buttons.get(0).display();
  plants.add(new Plant((int)random(0.8*width), (int)random(height)));
  bacteria.add(new Bacteria((int)random(0.8*width), (int)random(height)));

  b = false;
  //allPlants.add(plants.get(plants.size()-1));
  environment.rain(30);
}

void makeButtons() {
  buttons.add(new Button(width - (int)(0.2*width), 0, width/10, height/10, color(0, 0, 120), color(120, 0, 0), "Rain"));
  buttons.add(new Button(width - (int)(0.1*width), 0, width/10, height/10, color(0, 120, 0), color(120, 0, 0), "Plant"));
  buttons.add(new Button(width - (int)(0.2*width), height/10, width/10, height/10, color(255, 255, 0), color(120, 0, 0), "Sunlight"));
  buttons.add(new Button(width - (int)(0.1*width), height/10, width/10, height/10, color(120, 120, 120), color(0, 120, 0), "Bacteria"));
}
void draw() {
  background(255);
  runButtons();
  //environment.showRain();
  for (int i = 0; i < plants.size(); i++) {
    plants.get(i).run(environment);
  }
  for (int i = 0; i < bacteria.size(); i++) {
    bacteria.get(i).run();
  }
  removeDeadPlants();
  showTheRain();
  showRaining();
  showTheSun();
  resetBools();
  //if (b){
  //  background(0);
  //  fill(255,0,0);
  //  text("RESTARTING", 100,100);
  //}
    
  //int i = 0;
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
  
  for (Button button : buttons){
    if (button.active){
      if(button.mouseOver()){
        if (button.name == "Restart"){
          b = true;
        }
      }
    }
  }
  
  for (Button button : buttons) {
    if (button.active) {
      if (mouseX < environment.rain.length) {
        if (button.name == "Plant") {
          plants.add(new Plant(mouseX, mouseY));
          allPlants.add(plants.get(plants.size()-1));
          print("planted");
        }
        if (button.name == "Bacteria") {
          bacteria.add(new Bacteria(mouseX, mouseY));
          allBacteria.add(bacteria.get(bacteria.size()-1));
          print("bacteriaed");
        }
      }
    }
  }
  for (Button button : buttons) {
    if (button.mouseOver()) {
      if (button.name == "Rain") {
        rain = true;
      } else if (button.name == "Sunlight") {
        sunlight = true;
      } else {
        //else if (button.name == "Plant"){
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
  
  if (key == 'b'){
   frameRate(600);
  size(1000, 600);
  environment = new Environment(width-(int)(0.2*width), height);
  makeButtons();
  buttons.get(0).display();
  plants.add(new Plant((int)random(0.8*width), (int)random(height)));
  bacteria.add(new Bacteria((int)random(0.8*width), (int)random(height)));

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
void showTheSun() {
  if (sunlight) {
    environment.sunlight(30);
    sunlight = false;
  }
}

void resetBools() {
  if (!keyPressed) {
    rain = false;
    showRain = false;
    sunlight = false;
    snow = false; 
    earthquake = false;
  }
}