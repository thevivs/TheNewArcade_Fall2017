#include <SoftwareSerial.h>

int redPin =  0;
int bluePin = 1;
int redVal, blueVal;

int inByte = 0;

void setup() {
  Serial.begin(9600);
  pinMode(redPin, INPUT);
  pinMode(bluePin, INPUT);
  establishContact();

}

void loop() {
  if (Serial.available() > 0) {
    inByte = Serial.read();

    redVal = analogRead(redPin);
    blueVal = analogRead(bluePin);

    //    Serial.print("Red Value = ");
    Serial.print(redVal);
    Serial.print(',');
    //    Serial.print("blue Value = ");
    Serial.println(blueVal);
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("0,0");
  }
}

