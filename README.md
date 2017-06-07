# CareBears
#### Yuyang Zhang, Ibnul Jahan, Joshel Xiedeng

# Plants vs. Bacteria
### What It Presents
Our project offers a simulation of a garden-like environment, in which there are two organisms: plants and bacteria. While the user is able to control the growth of plants, the bacteria will grow by themself. The bacteria will ultimately hit the plants causing them to shrink. There are also environmental factors that affect their growth and death; these include precipitation, temperature, sunlight, and food. The organisms will need to balance all of these factors to sustain their life. This means a plant will need certain amount of water present to grow, and if there is too much water, it will start to die.

### How It Works
There are two arrays that contain plants and bacteria, respectively, as well as one that contains buttons for plant, rain, sunlight, and plants.  These buttons will appear at the top right side of the screen, and must be pressed to use the desired function, i.e. press the "Plant" button to plant where the mouse is clicked.  Placing a plant requires the pixel that is clicked on to have a required amount of water (from rain) to allow the plant to grow. </br>

**PLANTS:**
Press "Q" on the keyboard to see if the environment has enough water. If so, select the plant button, and press a random area on the screen (perferable an area with higher rain count). By doing so, the plant will grow in the area clicked. However, depending on the amount on water on the pixel clicked, the plant may or may not sustain itself. </br>

**TEMPERATURE:**
The temperature in the beginning of the simulation is set to 65 degrees. As long as the temperature is between the range of 50 and 80, the plant will sustain itself. However, the temperature is seen to increase at a steady rate of 1 degree every 5 seconds. Once the temperature passes 80 degrees, it will begin to increment by 2 degrees every 5 seconds. However, if the temperature is below 50 degrees, it will begin to decrease at a rate of 2 degrees per 5 seconds. The only way to keep the temperature within the proper range is through the usage of sunlight and rain. If temperature is above 80 degrees, the plant will decrease in size by intervals of 1. If temperature is above 90, it will decrease by intervals of 2. If the temperature is above 100, it will decrease by intervals of 3. If temperature is below 50, it will decrease by intervals of 1. If temperature is below 40, it will decrease by intervals of 2. If temperature is below 30, it will decrease by intervals of 3.</br>

**SUNLIGHT:**
With sunlight, this will decrease the average water on the screen. At the same time, it will also increase the temperature by 5 degrees.</br>

**RAIN:**
With rain, this will increase the average water on the screen. At the same time, it will also decrease the temperature by 5 degrees.</br>

**BACTERIA:**
Bacteria is seen to randomlly spawn on the screen every 4 seconds. As they are spawned, they move around and hit the plants. If the bacteria hits the plant, it will cause the plants to decrease in size. The only way to kill the bacteria is to change the temperature to be either higher than 80 degrees or lower than 50 degrees.</br>

**FOOD:**
When plants touch a food particle, both their size and maxSize will increase. Food is seen to randomly scatter. However, if the user pleases, the user may also select the food button to increase the food count on the screen. </br>

**TIMERS:**
To limit the amount of times a button may be pressed, timers have been placed. A timer is used to limit the amount of times a plant may be grown. A timer for food and bacteria is shown to display when they are being spawned onto the screen.

# Launch Instructions
1) Open terminal
2) Go into desired directory:
` $ cd <directory name>`
3) Clone the repo into a new directory:
` $ git clone git@github.com:yuyangz/CareBears.git`
4) Go into CareBears/:
` $ cd CareBears/`
5) Open Woo.pde file with processing:
` $ processing Woo/Woo.pde`
6) Press the play button near the top left corner.
