ArrayList<Integer> x = new ArrayList<Integer>(), y = new ArrayList<Integer>();
int w = 30, h = 30, blocks = 20, direction = 2, foodx = 15, foody = 15, speed = 8;
boolean gameover = false;

// Direction for x and y
int[]x_direction={0, 0, 1, -1}, y_direction={1, -1, 0, 0};

void setup() {
  size(600, 600);

  // Start position
  x.add(0);
  y.add(15);
}

void draw() {
  background(0);

  // The snake
  fill(51, 204, 51);
  for (int i = 0; i < x.size(); i++) {
    rect(x.get(i)*blocks, y.get(i)*blocks, blocks, blocks);
  }

  // If gameover is false, the game is running
  if (gameover == false) {
    // Food
    fill(255, 0, 0);
    ellipse(foodx*blocks+10, foody*blocks+10, blocks, blocks);

    // The Score
    textAlign(LEFT);
    textSize(25);
    fill(255);
    text("Score :" + x.size(), 10, 10, width - 20, 50);

    // Speed of snake
    if (frameCount%speed == 0) {

      // Makes the snake longer
      x.add(0, x.get(0) + x_direction[direction]);
      y.add(0, y.get(0) + y_direction[direction]);

      // If the snake hits the walls, the game ends.
      if (x.get(0) < 0 || y.get(0) < 0 || x.get(0) >= w || y.get(0) >= h) gameover = true;

      // If the snakes hits itself, the game ends.
      for (int i = 1; i < x.size(); i++) {
        if (x.get(0) == x.get(i) && y.get(0) == y.get(i)) gameover = true;
      }

      // If the snake hits the apple, the apple respawns.
      if (x.get(0) == foodx && y.get(0) == foody) {

        // Makes the snake go faster after every 5 points.
        if (x.size() %5==0 && speed>=2) speed-=1;

        // New food
        foodx = (int)random(0, w);
        foody = (int)random(0, h);
      } else {

        // Makes the snake not endless
        x.remove(x.size()-1);
        y.remove(y.size()-1);
      }
    }
  }
  // If the game is over, it will return a screen with your final score and a restart function.
  else {
    fill(255, 255, 0);
    textSize(30);
    textAlign(CENTER);
    text("GAME OVER \n Your Score is: "+ x.size() +"\n Press ENTER", width/2, height/3);
    if (keyCode == ENTER) {
      x.clear();
      y.clear();
      x.add(0);
      y.add(15);
      direction = 2;
      speed = 8;
      gameover = false;
    }
  }
}

void keyPressed() {
  // Controlling the movement of the snake
  int newDirection = keyCode == DOWN? 0: (keyCode == UP? 1: (keyCode == RIGHT? 2: (keyCode == LEFT? 3: -1)));
  if (newDirection != -1) direction = newDirection;
}
