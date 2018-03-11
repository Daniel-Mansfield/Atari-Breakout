                
// initial location of the ball and paddle
float x, y, a, b;

// velocity of the ball
float dx, dy;

// number of balls
int balls = 3;

// reset message, end of game message
String s = "Press r to start game, you have 3 balls";
String s1 = "Press r to reset, you have 2 balls left";
String s2 = "Press r to reset, you have 1 ball left";
String e = "GAME OVER, press r to play again";

// sets value of BRICKS_ACROSS and BRICKS_HIGH
final int BRICKS_ACROSS = 10, BRICKS_HIGH = 4;

// declares and initializes a two-dimensional array called bricks
boolean bricks[][] = new boolean[BRICKS_ACROSS][BRICKS_HIGH];

// setup
void setup() {
  size(750, 500);
  background(0);
  resetBall();
  resetPaddle();

  // creates array of boolean bricks and set each value equal to true
  for (int i = 0; i < BRICKS_ACROSS; i++) {
    for (int j = 0; j < BRICKS_HIGH; j++) {
      bricks[i][j] = true;
    }
  }
}

// centers ball and sets velocity
void resetBall() {
  x = width/2;
  y = height/2;
  dx = random(-2, 2);
  dy = 2;
}

// centers paddle and sets velocity
void resetPaddle() {
  a = 0;
  b = 490;
}

// draws rectangle to cover ball path
void draw() {
  fill(0);
  rect(0, 0, width, height);

  // draws paddle
  fill(51, 204, 255);
  rect(mouseX, b, 150, 10);

  // draws ball  
  fill(255);
  ellipse(x, y, 15, 15);
  x = x + dx;
  y = y + dy;

  // draws bricks if true, and if the ball collides with them set to false
  for (int i = 0; i < BRICKS_ACROSS; i++) {
    for (int j = 0; j < BRICKS_HIGH; j++) {
      if (bricks[i][j]) {
        fill(20*(i+j) + 51, 204 - 5*(i+j), 255 - 7*(i+j));
        if (x >= i*75 && x <= i*75 + 75 && y >= j*25 && y <= j*25 + 25) {
          bricks[i][j] = false;
          fill (0, 0, 0, 0);
          if (x > i*75 && x < i*75 + 75) {
            dy = -dy;
          } else if (y > j*25 && y < j*25 + 25) {
            dx = -dx;
          }
        }
        rect(i*75, j*25, 75, 25);
      }
    }
  }

  // creates collisions with walls, paddle and bricks  
  if (x > 750) {
    dx = -2;
  } else if (x < 0) {
    dx = 2;
  } else if (y < 0) {
    dy = 2;
  } else if (y > 500) {
    outOfBounds();
  }
  if (x > mouseX && x < (mouseX + 150) && y > 490 && y < 500) {
    dy = -2;
  } 
  if (x > mouseX && x < (mouseX + 75) && y > 490 && y < 500) {
    dx = -2;
  } 
  if (x > (mouseX + 75) && x < (mouseX + 150) && y > 490 && y < 500) {
    dx = 2;
  }
}

// reset
void reset() {
  resetBall();
  resetPaddle();
  background(0);
  loop();
}

// stops loop and accounts for balls
void outOfBounds() {
  noLoop();
  balls--;
  if (balls == 2) {
    fill(255);
    textSize(20);
    text(s1, 200, 350);
  } else if (balls == 1) {
    fill(255);
    textSize(20);
    text(s2, 200, 350);
  } else if (balls == 0) {
    fill(255, 0, 0);
    textSize(25);
    text(e, 180, 350);
    balls = 3;
    resetBricks();
  }
}

// resets all brick values to true and fills them
void resetBricks() {
  for (int i = 0; i < BRICKS_ACROSS; i++) {
    for (int j = 0; j < BRICKS_HIGH; j++) {
      bricks[i][j] = true;
      if (bricks[i][j]) {
        fill(255);
      }
    }
  }
}
// assigns resetBall() to a key
void keyPressed() {
  if (key == 'r') {
    reset();
  }
}  

// allows the player to move the paddle
void mouseMoved() {
  a = mouseX;
}
     
