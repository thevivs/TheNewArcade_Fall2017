import processing.serial.*;
Serial myPort;
int serialData;
float siz = 100;

void setup() {
  size(500, 500);
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600);
}

void draw() {
  background(20);
  while(myPort.available()>0){
    serialData = myPort.read();
    if(serialData ==0){
      robot
    }
  
  }
  
  //while (myPort.available() > 0) {
  //  serialData = myPort.read();
  //  if (serialData == 0) {
  //    siz += 0.1;
  //  } else {
  //    if (siz > 0) {
  //      siz -= 0.1;
  //    }


  //    ellipse(width/2, height/2, siz, size);
    }
  }
}