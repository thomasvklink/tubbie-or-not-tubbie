#include <DmxSimple.h>

#define trigPin 4
#define echoPin 5

byte r;
byte g;
byte b;

boolean buttonPressed;

//Variables for Processing communication
int data[] = {buttonPressed};                     //Variables to send to Processing
const int DATASIZE = sizeof(data) / sizeof(int);    //Calculate size of array in a integer
char headers[] = {'B'};                             //Prefix for the data (headers)
int incomingByte;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  DmxSimple.usePin(3);
  DmxSimple.maxChannel(6);

  Serial.begin(9600);
}

void loop() {
  sendDMX(r, g, b);
  
  buttonPressed = isButtonPressed();
  //Serial communcation to Processing
  int data[] = {buttonPressed};                //Data array for Processing communication
  for (int z = 0; z < DATASIZE; z++) {           //Print data to the serial port
    Serial.print(headers[z]);
    Serial.println(data[z]);
  }
  
  while ((buttonPressed == true)) {
    buttonPressed = isButtonPressed();
    delay(200);
  }

  //  r = map(level, 0, maxLevel, 255, 0);
  //  g = map(level, 0, maxLevel, 255, 0);
  //  b = map(level, 0, maxLevel, 255, 0);
}

byte isButtonPressed() {
  if (getDistance() < 20) {
    delay(10);
    if (getDistance() < 20) {
      return 1;
    } else {
      return 0;
    }
  }    else {
    return 0;
  }
}

byte getDistance() {
  int distance;
  long duration;

  digitalWrite(trigPin, LOW);
  delayMicroseconds(5);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH);
  distance = duration * 0.034 / 2;
  return distance;
}

void sendDMX(byte red, byte green, byte blue) {
  DmxSimple.write(1, red);
  DmxSimple.write(2, green);
  DmxSimple.write(3, blue);
}
