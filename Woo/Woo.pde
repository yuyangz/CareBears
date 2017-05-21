ArrayList<Plant> plants = new ArrayList<Plant>();
ArrayList<Plant> allPlants = new ArrayList<Plant>();
boolean rain; //generates array[height][width] with random coordinates having water
// plants w waterPriority n will go in order or priority, and will take all the water in a circle of radius r
boolean snow;
boolean earthquake;
boolean thunderstorm;


void setup() {
  frameRate(60);
  size(600, 800);
}

void draw() {
  background(255);
  for (int i = 0; i < plants.size(); i++) {
    plants.get(i).run();
  }
  removeDeadPlants();
}

void mouseClicked() {
  plants.add(new Plant(mouseX, mouseY));
  allPlants.add(plants.get(plants.size()-1));
}

void removeDeadPlants() {
  for (int i = plants.size() - 1; i >= 0; i--) {
    if (plants.get(i).size <= 0) { 
      plants.remove(i);
    }
  }
}