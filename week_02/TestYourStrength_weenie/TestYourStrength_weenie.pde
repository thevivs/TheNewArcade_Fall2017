import processing.serial.*;

int counter;
PFont introFont;
int titleSize, firstTextY, yVariable;
boolean introOn;

PFont instructionsFont;
String gameInstructions = "both players press the button in front of them with their THUMB. the players with the strongest thumb wins.";
int textX, textY, textSize;
//boolean instructionsOn = false;
boolean start;
boolean complete;

int state;

Serial myPort;
int redPlayer, bluePlayer;
//int redNum, blueNum;

void setup() {
  background(255);
  size(500, 500);
  //fullScreen();
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
  textSize = 60;
  instructionsFont = createFont("Simple Print.ttf", textSize);

  start = false;
  introOn = false;
  complete = false;

  state = 0;

  //redNum = 0;
  //blueNum = 0;
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.bufferUntil('\n');
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
          state = 2;
        }
      }
    }
  }

  if (state == 2) {
    if(redPlayer > bluePlayer){
      text("RED", width/2, firstTextY);
    } else {
      text("BLUE", width/2, firstTextY);
    }
    
    println("red val " + redPlayer);
    println("blue val " + bluePlayer);
  }

  if (introOn == true) {
    animateIntro();
  }


  //println("red val " + redPlayer);
  //println("blue val " + bluePlayer);
  //println(counter);
}

void animateIntro() {
  counter ++;
  textFont(introFont);
  textAlign(CENTER, CENTER);


  if (counter >= 0 && counter <= 70) {
    text("TEST", width/2, firstTextY);
  }
  if (counter >= 10 && counter <= 70) {
    text("YOUR", width/2, firstTextY + yVariable);
  }
  if (counter >= 20 && counter <= 70) {
    text("STRENGTH", width/2, firstTextY + (yVariable*2));
  }
  if (counter >= 40 && counter <= 75) {
    fill(255, 0, 0);
    text("WEENIE!!", width/2, firstTextY + (yVariable*3));
  }
  if (counter >= 75) {
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