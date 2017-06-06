//////////..........GLOBAL VARIABLES..........//////////
boolean startScreen;
boolean playing;
boolean endGame;
boolean areYouSure;
boolean sortStats;

/////.....IMAGES...../////
PImage startPic;

/////.....PLANTS AND BACTERIA...../////
ArrayList<Plant> plants = new ArrayList<Plant>(); //hold plants in an array
ArrayList<Plant> allPlants = new ArrayList<Plant>(); 
ArrayList<Integer> plantLifeTimes = new ArrayList<Integer>(); 

ArrayList<Bacteria> bacteria = new ArrayList<Bacteria>(); //hold bacterias in an array
ArrayList<Bacteria> allBacteria = new ArrayList<Bacteria>();
ArrayList<Integer> bacteriaLifeTimes = new ArrayList<Integer>(); 

/////.....FOOD...../////
ArrayList<Food> food = new ArrayList<Food>(); //hold food

/////.....BUTTON...../////
ArrayList<Button> buttons = new ArrayList<Button>(); //hold buttons in an array
Button startGame;

/////.....ENVIRONMENTAL VARIABLES...../////
Environment environment;
boolean rain, showRain; //generates array[height][width] with random coordinates having water
// plants w waterPriority n will go in order or priority, and will take all the water in a circle of radius r
boolean sunlight, showSunlight; //allows sunlight to be processed
//boolean snow;
//boolean earthquake;
//boolean thunderstorm;
boolean fooddrop;

/////.....TIMER...../////
long time; //to be used as a temporal reference point 
Timer plantTimer; //cooldown time for plants
Timer bacteriaTimer; //cooldown time for bacteria

/////.....OTHER...../////
boolean showGrid; //displays grid for plants
boolean b; //will be used in the future for reset
boolean shop;
Shop s;
//===========================================================================================================================================================================

void setup() { 
  startScreen = true;
  size(1000, 600);

  ///LOAD IMAGES///
  startPic = loadImage("plantsvzombies.jpg");

  ///START GAME///
  startGame = new Button((int)(0.3*width), (int)(height*0.8), (int)(width*0.4), (int)(height*0.15), color(0, 0, 120), color(120, 0, 0), "Start the Game!");
  environment = new Environment(width-(int)(0.2*width), height);
  makeButtons();
  s = new Shop();

  /////.....ORGANISMS...../////
  plants.add(new Plant((int)random(0.4*width)+(int)(width*0.2), (int)random(height)));
  bacteria.add(new Bacteria((int)random(0.8*width), (int)random(height)));

  /////.....TIMERS...../////
  plantTimer = new Timer("Plant", 0);
  bacteriaTimer = new Timer("Bacteria", 1);

  /////.....ALL ORGANISMS...../////
  allPlants.add(plants.get(plants.size()-1));
  allBacteria.add(bacteria.get(plants.size()-1));

  /////.....ENVIRONMENT...../////
  for (int i = 0; i < 1; i++) {
    environment.rain(1);
    environment.rain(2);
  }
} //end setup()==============================================================================================================================================================

void makeButtons() { //creates buttons
  buttons.add(new Button(width - (int)(0.2*width), 0, width/10, height/10, color(0, 0, 120), color(120, 0, 0), "Rain"));
  buttons.add(new Button(width - (int)(0.1*width), 0, width/10, height/10, color(0, 120, 0), color(120, 0, 0), "Plant"));
  buttons.add(new Button(width - (int)(0.2*width), height/10, width/10, height/10, color(255, 255, 0), color(120, 0, 0), "Sunlight"));
  buttons.add(new Button(width - (int)(0.1*width), height/10, width/10, height/10, color(120, 120, 120), color(0, 120, 0), "Bacteria"));
  buttons.add(new Button(width - (int)(0.2*width), height - (height/10), width/5, height/10, color(120, 120, 120), color(0, 120, 0), "End Game"));
  buttons.add(new Button(width - (int)(0.1*width), height/5, width/10, height/10, color(255, 175, 175), color(255, 0, 0), "Food"));
  buttons.add(new Button(width - (int)(0.2*width), height/5, width/10, height/10, color(255, 162, 51), color(255, 0, 0), "Shop"));
} //end makeButtons()========================================================================================================================================================

void draw() { //creates screen
  if (startScreen) {
    image(startPic, 0, 0);
    startGame.update();
  }
  if (playing) {
    background(255);
    runButtons();
    showTheRain();
    showRaining();
    showTheSun();
    showFood();
    openShop();
    for (Food eatMe : food) {
      eatMe.display();
    }
    for (int i = 0; i < plants.size(); i++) {
      plants.get(i).run(environment);
    }
    for (int i = 0; i < bacteria.size(); i++) {
      bacteria.get(i).run();
    }
    removeDeadPlants();
    showTheGrid();
    resetBools();
    runTimers();

    for (Bacteria z : bacteria) {
      for (Plant a : plants) {
        z.eat(a);
      }
    }
    environment.tempChange();
    text("Temperature: " + environment.temperature, 800, 500);
    checkFood();
    removeFood();
  }
} //end draw()===============================================================================================================================================================

void runButtons() {
  for (int i = 0; i < buttons.size(); i++) {
    buttons.get(i).update();
  }
} //end runButtons()=========================================================================================================================================================

void runTimers() {
  plantTimer.run();
  bacteriaTimer.run();
} //end runTimers()==========================================================================================================================================================

//goes over what happens when a button is clicked, or if a button is active a plant or bacteria is dropped
void mouseClicked() {
  //start screen mechanics
  if (startScreen) {
    if (startGame.mouseOver()) {
      startScreen=false;
      playing = true;
      draw();
    }
  }

  /////button mechanics (after exiting start screen)
  //for plant and bacteria
  if (playing) {
    for (Button button : buttons) { 
      //button when pressed will be on until pressed off
      if (button.active) { //if button is pressed for plants, a plant will be added.
        if (mouseX < environment.rain.length) {  
          if (button.name == "Plant") { 
            if (plantTimer.time == 0) {
              plants.add(new Plant(mouseX, mouseY));
              allPlants.add(plants.get(plants.size()-1));
              print("planted");
              plantTimer.reset();
            }
          }
          if (bacteriaTimer.time == 0) {
            if (button.name == "Bacteria") { //if button is pressed for bacteria, a bacteria will be added.      
              bacteria.add(new Bacteria(mouseX, mouseY));
              allBacteria.add(bacteria.get(bacteria.size()-1));
              print("bacteriaed");
              bacteriaTimer.reset();
            }
          }
        }
      }
    }

    //for weather  
    for (Button button : buttons) {
      //button will only be on for one press
      if (button.mouseOver()) { 
        if (button.name == "Rain") {
          rain = true;
        } else if (button.name == "Sunlight") {
          sunlight = true;
        } else if (button.name == "Food") {
          fooddrop = true;
        } else {
          //else if (button.name == "Plant"){
          //button.active = !button.active;
          //} else {
          button.click();
        }
      }
    }
    /*
     for (Button button : buttons) {
     if (button.mouseOver()) {
     if (button.name == "Shop") {
     shop = true;
     } else {
     button.click();
     }
     }
     }
     */
  }
} //end mouseClicked()=======================================================================================================================================================

//removes plants when they have a size that is less than or equal to 0
//this means they have shrunk to the point where they are negative size
void removeDeadPlants() {
  for (int i = plants.size() - 1; i >= 0; i--) {
    if (plants.get(i).size <= 0) { 
      plants.remove(i);
    }
  }
} //end removeDeadPlants()===================================================================================================================================================

void removeFood() {
  for (int i = food.size() - 1; i >= 0; i--) {
    if (food.get(i).eaten == true) { 
      food.remove(i);
    }
  }
} //end removeDeadPlants()===================================================================================================================================================

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

  //used for reset, but currently doesn't not work
  if (key == 'b') {
    frameRate(600);
    size(1000, 600);
    environment = new Environment(width-(int)(0.2*width), height);
    makeButtons();
    buttons.get(0).display();
    plants.add(new Plant((int)random(0.8*width), (int)random(height)));
    bacteria.add(new Bacteria((int)random(0.8*width), (int)random(height)));
  }
} //end keyPressed()=========================================================================================================================================================

//method for showing the rainfall graph
void showTheRain() {
  if (showRain) {
    environment.showRain();
  }
} //end showTheRain()========================================================================================================================================================

//method to make it rain
//rain is made false so there will not be a continious stream of rain.
void showRaining() {
  if (rain) {
    environment.rain(30);
    rain = false;
  }
} //end showRaining()========================================================================================================================================================

//method to make the sun come out (leads to evaporated water)
//sunlight will be released once and then turned off so there will not be a continious stream of light.
void showTheSun() {
  if (sunlight) {
    environment.sunlight(30);
    sunlight = false;
  }
} //end showTheSun()=========================================================================================================================================================

//method to show the grid
//checks if showGrid is true, if so, grid will be drawn onto the board.
void showTheGrid() {
  if (showGrid) {
    environment.getGrid();
  }
} //end showTheGrid()========================================================================================================================================================

void checkFood() {
  for (Plant plant : plants) {
    for ( Food x : food) {
      plant.toEat(x);
    }
  }
}


void showFood() {
  if (fooddrop) {
    environment.dropFood(2000);
    fooddrop = false;
  }
} //end showFood()===========================================================================================================================================================

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
} //end resetBools()=========================================================================================================================================================

void openShop() {
  if (shop) {
    s.display();
    shop = false;
  }
}


void makeLifeTimes() { //keeps a record of how long all plants and bacteria have lived
  for (Plant plant : allPlants) {
    plantLifeTimes.add(plant.lifeTime);
  }
  for (Bacteria bacteria : allBacteria) {
    bacteriaLifeTimes.add(bacteria.lifeTime);
  }
} //end makeLifeTimes()======================================================================================================================================================

///////////////...............SORTS...............///////////////
void sort( ArrayList<Integer> _heap) {
  int size = _heap.size();
  for (int x = size / 2 - 1; x >= 0; x -= 1) {
    heapify(_heap, size, x);
  }
  for (int y = size - 1; y >= 0; y -= 1) {
    int temp = _heap.get(0);
    _heap.set(0, y);
    _heap.set(y, temp);

    heapify(_heap, y, 0);
  }
} //end sort(ArrayList<Integer> _heap)=======================================================================================================================================

void heapify( ArrayList<Integer>_heap, int size, int x) {
  int largest = x;
  int left = 2*x + 1;
  int right= 2*x + 2;
  if (_heap.get(left) > _heap.get(largest)) {
    largest = left;
  }
  if (_heap.get(right) > _heap.get(largest)) {
    largest = right;
  }
  if (largest != x) {
    int temp = _heap.get(x);
    _heap.set(x, _heap.get(largest));
    _heap.set(largest, temp);
  }
  heapify(_heap, size, largest);
} //end heapify()============================================================================================================================================================