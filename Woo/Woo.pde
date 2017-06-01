ArrayList<Plant> plants = new ArrayList<Plant>(); //hold plants in an array
ArrayList<Plant> allPlants = new ArrayList<Plant>(); 
ArrayList<Bacteria> bacteria = new ArrayList<Bacteria>(); //hold bacterias in an array
ArrayList<Bacteria> allBacteria = new ArrayList<Bacteria>();

ArrayList<Button> buttons = new ArrayList<Button>(); //hold buttons in an array
Environment environment;
boolean rain, showRain; //generates array[height][width] with random coordinates having water
// plants w waterPriority n will go in order or priority, and will take all the water in a circle of radius r
boolean sunlight, showSunlight; //allows sunlight to be processed
//boolean snow;
//boolean earthquake;
//boolean thunderstorm;

boolean showGrid; //displays grid for plants

boolean b; //will be used in the future for reset


void setup() { 
  frameRate(60);
  size(1000, 600);
  environment = new Environment(width-(int)(0.2*width), height);
  makeButtons();
  buttons.get(0).display();
  plants.add(new Plant((int)random(0.4*width)+(int)(width*0.2), (int)random(height)));
  bacteria.add(new Bacteria((int)random(0.8*width), (int)random(height)));

  b = false;
  //allPlants.add(plants.get(plants.size()-1));
  environment.rain(30);
}

void makeButtons() { //creates buttons
  buttons.add(new Button(width - (int)(0.2*width), 0, width/10, height/10, color(0, 0, 120), color(120, 0, 0), "Rain"));
  buttons.add(new Button(width - (int)(0.1*width), 0, width/10, height/10, color(0, 120, 0), color(120, 0, 0), "Plant"));
  buttons.add(new Button(width - (int)(0.2*width), height/10, width/10, height/10, color(255, 255, 0), color(120, 0, 0), "Sunlight"));
  buttons.add(new Button(width - (int)(0.1*width), height/10, width/10, height/10, color(120, 120, 120), color(0, 120, 0), "Bacteria"));
}
void draw() { //creates screen
  background(255);
  //environment.getGrid();
  runButtons();
  //environment.showRain();
  showTheRain();
  showRaining();
  showTheSun();
  for (int i = 0; i < plants.size(); i++) {
    plants.get(i).run(environment);
  }
  for (int i = 0; i < bacteria.size(); i++) {
    bacteria.get(i).run();
  }
  removeDeadPlants();
  //showTheRain();
  //showRaining();
  //showTheSun();
  showTheGrid();
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


//goes over what happens when a button is clicked, or if a button is active a plant or bacteria is dropped
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
    //button when pressed will be on until pressed off
    if (button.active) { //if button is pressed for plants, a plant will be added.
      if (mouseX < environment.rain.length) {
        if (button.name == "Plant") {
          plants.add(new Plant(mouseX, mouseY));
          allPlants.add(plants.get(plants.size()-1));
          print("planted");
        }
        if (button.name == "Bacteria") { //if button is pressed for bacteria, a bacteria will be added.
          bacteria.add(new Bacteria(mouseX, mouseY));
          allBacteria.add(bacteria.get(bacteria.size()-1));
          print("bacteriaed");
        }
      }
    }
  }
  for (Button button : buttons) {
    //button will only be on for one press
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

//removes plants when they have a size that is less than or equal to 0
//this means they have shrunk to the point where they are negative size
void removeDeadPlants() {
  for (int i = plants.size() - 1; i >= 0; i--) {
    if (plants.get(i).size <= 0) { 
      plants.remove(i);
    }
  }
}

//pressing keys allows the user to make it rain, to see the rainfall graph, to see the blocked grid, and to in the future reset
void keyPressed() {
  if (key == 'r') { //connects to showRainning
    rain = true;
  }
  if (key == 'q') { //connects to showTheRain
    showRain = true;
  }
  if (key == 'g') { //connects to showTheGrid
    showGrid = true;
    //environment.getGrid();
  }
  
  //used for reset, but currenlt doesn't not work
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

//method for showing the rainfall graph
void showTheRain() {
  if (showRain) {
    environment.showRain();
  }
}
//method to make it rain
//rain is made false so there will not be a continious stream of rain.
void showRaining() {
  if (rain) {
    environment.rain(30);
    rain = false;
  }
}
//method to make the sun come out (leads to evaporated water)
//sunlight will be released once and then turned off so there will not be a continious stream of light.
void showTheSun() {
  if (sunlight) {
    environment.sunlight(30);
    sunlight = false;
  }
}
//method to show the grid
//checks if showGrid is true, if so, grid will be drawn onto the board.
void showTheGrid() {
  if (showGrid) {
    environment.getGrid();
  }
}
//turns all the boolean variables to false, so any graphs don't stay on after they are released
//currently does not work
void resetBools() {
  if (!keyPressed) {
    rain = false;
    showRain = false;
    sunlight = false;
    //snow = false; 
    //earthquake = false;
    showGrid = false;
  }
}