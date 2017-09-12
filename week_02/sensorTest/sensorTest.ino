

int redPin =  0;
int bluePin = 1;
int redVal, blueVal;



void setup() {
  Serial.begin(9600);
  pinMode(redPin, INPUT);
  pinMode(bluePin, INPUT);


}

void loop() {
    redVal = analogRead(redPin);
    blueVal = analogRead(bluePin);

    Serial.print("Red Value = ");
    Serial.print(redVal);
    //    Serial.print(',');
    Serial.print("blue Value = ");
    Serial.println(blueVal);
}


