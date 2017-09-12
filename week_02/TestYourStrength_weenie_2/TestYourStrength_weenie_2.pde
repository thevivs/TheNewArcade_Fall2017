import processing.serial.*;

int counter;
PFont introFont;
int titleSize, firstTextY, yVariable;
boolean introOn;

PFont instructionsFont;
String gameInstructions = "grip the table with your palms with the four fingers on the bottom of the table and thumb on top. then both players press the button in front of them with their THUMB. the player with the strongest thumb wins the ultimate test of strength.";
int textX, textY, textSize;
//boolean instructionsOn = false;
boolean start;
boolean complete;
boolean redWin;
boolean blueWin;
boolean weenies;
boolean thumb;
boolean playAgain;

int state;

Serial myPort;
int redPlayer, bluePlayer;
int maxRed, maxBlue;

String time;
int t, startTime, interval;
boolean timerOn, timeOut;
boolean gameOver;

void setup() {
  background(255);
  //size(500, 500);
  fullScreen();
  frameRate(30);
  smooth(10);

  //for intro animation
  counter = 0;
  titleSize = 190;
  introFont = createFont("garagesh.ttf", titleSize);
  firstTextY = 85;
  yVariable = 180;

  //instrctions
  textX = 400;
  textY = 200;
  textSize = 35;
  instructionsFont = createFont("Young.ttf", textSize);

  start = false;
  introOn = false;
  complete = false;
  redWin = false;
  blueWin = false;
  gameOver = false;
  weenies = false;
  timeOut = false;
  thumb = false;
  playAgain = false;

  state = 0;

  maxRed = 0;
  maxBlue = 0;
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.bufferUntil('\n');

  interval = 3;
}

void draw() {
  background(255);
  fill(0);

  if (state == 0) {
    introOn = true;
    state = 1;
  }

  if (state == 1) {
    if (start == true) {
      if (keyPressed) {
        if (key== ' ') {
          introOn = false;
          timerOn = true;
          startTime = millis();
          thumb = true;
          state = 2;
        }
      }
    }
  }

  if (state == 2) {
    if (maxRed < redPlayer) {
      maxRed = redPlayer;
    }
    if (maxBlue < bluePlayer) {
      maxBlue = bluePlayer;
    }
    //state = 3;
  }

  if (timeOut == true) {
    if (maxRed > maxBlue) {
      redWin = true;
    } else if (maxBlue > maxRed) {
      blueWin = true;
    } else {
      weenies = true;
    }
    thumb = false;
    gameOver = true;
    playAgain = true;
  }

  if (gameOver == true) {
    if (keyPressed) {
      if (key == ' ');
      restart();
    }
  }


  if (introOn == true) {
    animateIntro();
  }

  if (timerOn == true) {
    timer();
  }

  if (redWin == true) {
    redWinner();
  }

  if (blueWin == true) {
    blueWinner();
  }

  if (weenies == true) {
    noWinner();
  }

  if (thumb == true) {
    thumbText();
  }

  if (playAgain == true) {
    restartText();
  }

  println("red val " + maxRed);
  println("blue val " + maxBlue);
}

void animateIntro() {
  counter ++;
  textFont(introFont);
  textAlign(CENTER, CENTER);


  if (counter >= 0 && counter <= 80) {
    text("TEST", width/2, firstTextY);
  }
  if (counter >= 10 && counter <= 80) {
    text("YOUR", width/2, firstTextY + yVariable);
  }
  if (counter >= 20 && counter <= 80) {
    text("STRENGTH", width/2, firstTextY + (yVariable*2));
  }
  if (counter >= 40 && counter <= 80) {
    fill(255, 0, 0);
    text("WEENIES!!", width/2, firstTextY + (yVariable*3));
  }
  if (counter >= 80) {
    textFont(instructionsFont);
    textAlign(CENTER, CENTER);
    text(gameInstructions, (width/2)-textX, 0-(textY/3), textX*2, height);
    //textFont(introFont);
    fill(255, 0, 0);
    text("press SPACEBAR to start", width/2, (height/2) + textY);
    start = true;
  }
}

void serialEvent(Serial myPort) {
  String myString = myPort.readStringUntil('\n');
  myString = trim(myString);
  int sensors[] = int(split(myString, ','));

  if (sensors.length > 1) {
    redPlayer = sensors[0];
    bluePlayer = sensors[1];
  }
  myPort.write("A");
}

void timer() {
  fill(255);
  textFont(introFont);
  textAlign(CENTER, TOP);
  textSize(70);

  t = interval - int((millis()- startTime)/1000);
  time = nf(t, 2);
  text("0:" + time, width/2, 25);
  if ( t == 0) {
    timeOut = true;
    timerOn = false;
  }
}

void redWinner() {
  noStroke();
  fill(255, 0, 0);
  rect(0, 0, width/2, height);
  fill(0, 0, 255);
  rect(width/2, 0, width, height);

  fill(255);
  textFont(introFont);
  textSize(200);
  text("WINNER", width/4, firstTextY + yVariable);
  fill(0);
  text("WEENIE", width - (width/4), firstTextY + yVariable);
}

void blueWinner() {
  noStroke();
  fill(255, 0, 0);
  rect(0, 0, width/2, height);
  fill(0, 0, 255);
  rect(width/2, 0, width, height);

  fill(0);
  textFont(introFont);
  textSize(200);
  text("WEENIE", width/4, firstTextY + yVariable);
  fill(255);
  text("WINNER", width - (width/4), firstTextY + yVariable);
}

void restart() {
  start = false;
  introOn = false;
  complete = false;
  redWin = false;
  blueWin = false;
  timeOut = false;
  weenies = false;
  timerOn = false;
  gameOver = false;
  thumb = false;
  playAgain = false;

  state = 0;
  counter = 0;
  maxRed = 0;
  maxBlue = 0;
}

void noWinner() {
  noStroke();
  fill(255, 0, 0);
  rect(0, 0, width/2, height);
  fill(0, 0, 255);
  rect(width/2, 0, width, height);

  fill(255);
  textFont(introFont);
  textSize(200);
  text("BOTH", width/2, 150);
  text("WEENIES", width/2, 350);
}

void thumbText() {
  noStroke();
  fill(255, 0, 0);
  rect(0, 0, width/2, height);
  fill(0, 0, 255);
  rect(width/2, 0, width, height);

  fill(255);
  textSize(200);
  text("THUMBS", width/2, firstTextY);
  text("GO!!", width/2, firstTextY + yVariable);
}

void restartText() {
  textFont(instructionsFont);
  textAlign(CENTER, CENTER);
  fill(255);
  text("press SPACEBAR to test your strength again", width/2, (height/2) + textY);
}