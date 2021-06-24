//Tubbie or not Tubbie arduino code

#include <DmxSimple.h>

#define trigPin 4
#define echoPin 5

byte r = 255;
byte g = 255;
byte b = 255;

byte targetR;
byte targetG;
byte targetB;

boolean buttonPressed;
boolean chaos = false;
unsigned long startTime = millis();

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
  buttonPressed = isButtonPressed();
  //Serial communcation to Processing
  int data[] = {buttonPressed};                //Data array for Processing communication
  for (int z = 0; z < DATASIZE; z++) {           //Print data to the serial port
    Serial.print(headers[z]);
    Serial.println(data[z]);
  }

  while ((buttonPressed == true)) {
    buttonPressed = isButtonPressed();
    chaos = true;
    delay(200);
    startTime = millis();
  }

  if (chaos) {
    chaosLighting();
  } else {
    defaultLighting();
    sendDMX(r, g, b, 0);
  }
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

void chaosLighting() {
  while (millis() < startTime + 3000) {
    dimLights();
    delay(200);
    sendDMX(255, 255, 255, 255);
    delay(3000);
  }
  if (millis() > startTime + 3000) {
    chaos = false;
    r = 0;
    g = 0;
    b = 0;

    brightenLights();
  }
}

void defaultLighting() {
  if (millis() < startTime + 5000) {
    if (r < targetR) {
      r++;
    }
    if (r > targetR) {
      r--;
    }
    if (g < targetG) {
      g++;
    }
    if (g > targetG) {
      g--;
    }
    if (b < targetB) {
      b++;
    }
    if (b > targetB) {
      b--;
    }
    delay(5);
  } else {
    targetR = random(170, 220);
    targetG = random(180, 255);
    targetB = random(50, 100);
    startTime = millis();
  }
}

void dimLights() {
  //dim values:
  byte dimR = 80;
  byte dimG = 0;
  byte dimB = 0;

  for (int i = 0; i <= 255; i++) {
    if (r > dimR) {
      r--;
    }
    if (g > dimG) {
      g--;
    }
    if (b > dimB) {
      b--;
    }
    delay(2);
    sendDMX(r, g, b, 0);
  }
  delay(200);
  for (int i = 0; i <= dimR; i++) {
    if (r > 0) {
      r--;
      delay(1);
      sendDMX(r, g, b, 0);
    }
  }
}

void brightenLights() {
  //bright values:
  byte litR = 210;
  byte litG = 255;
  byte litB = 75;

  for (int i = 0; i <= 255; i++) {
    if (r < litR) {
      r++;
    }
    if (g < litG) {
      g++;
    }
    if (b < litB) {
      b++;
    }
    delay(8 );
    sendDMX(r, g, b, 0);
  }
  startTime = millis();
}

void sendDMX(byte red, byte green, byte blue, byte strobe) {
//  Serial.print(" ");
//  Serial.print(red);
//  Serial.print(" ");
//  Serial.print(green);
//  Serial.print(" ");
//  Serial.println(blue);
//  Serial.print(" ");
  
  DmxSimple.write(1, red);
  DmxSimple.write(2, green);
  DmxSimple.write(3, blue);
  DmxSimple.write(5, strobe);
}
