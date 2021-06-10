//#include <DmxSimple.h>

#define trigPin1 4
#define echoPin1 5
#define trigPin2 6
#define echoPin2 7

byte level = 1;
byte maxLevel = 5;
byte r;
byte g;
byte b;

//Variables for Processing communication
int data[] = {level};                               //Variables to send to Processing
const int DATASIZE = sizeof(data) / sizeof(int);    //Calculate size of array in a integer
char headers[] = {'L'};                             //Prefix for the data (headers)
int incomingByte;    

void setup() {
  pinMode(trigPin1, OUTPUT);
  pinMode(trigPin2, OUTPUT);
  pinMode(echoPin1, INPUT);
  pinMode(echoPin2, INPUT);

  //DmxSimple.usePin(3);
  //DmxSimple.maxChannel(6);

  Serial.begin(9600);
}

void loop() {
  //Serial.print("L");
  //Serial.print(level);
  //Serial.print("D1:");
  //Serial.print(getDistance(1));
  //Serial.print("D2:");
  //Serial.println(getDistance(2));
  
  if ((buttonPressed() == 1) && (level < maxLevel)) {
    level++;
    delay(1000);
  }
  if ((buttonPressed() == 2) && (level > 1)) {
    level--;
    delay(1000);
  }

  r = map(level, 0, maxLevel, 255, 0);
  g = map(level, 0, maxLevel, 255, 0);
  b = map(level, 0, maxLevel, 255, 0);

  //sendDMX(r, g, b);

  //Serial communcation to Processing
  int data[] = {level};                          //Data array for Processing communication
  for(int z=0;z<DATASIZE;z++){                   //Print data to the serial port
    Serial.print(headers[z]);
    Serial.println(data[z]);
  }
}

byte buttonPressed() {
  if (getDistance(1) < 20) {
    delay(10);
    if (getDistance(1) < 20) {
      return 1;
    } else {
      return 0;
    }
  } else if (getDistance(2) < 20) {
    delay(10);
    if (getDistance(2) < 20) {
      return 2;
    } else {
      return 0;
    }
  } else {
    return 0;
  }
}

byte getDistance(byte sensor) {
  int distance;
  long duration;
  if (sensor == 1) {
    digitalWrite(trigPin1, LOW);
    delayMicroseconds(5);

    digitalWrite(trigPin1, HIGH);
    delayMicroseconds(10);
    digitalWrite(trigPin1, LOW);

    duration = pulseIn(echoPin1, HIGH);
    distance = duration * 0.034 / 2;
    return distance;
  } else {
    digitalWrite(trigPin2, LOW);
    delayMicroseconds(5);

    digitalWrite(trigPin2, HIGH);
    delayMicroseconds(10);
    digitalWrite(trigPin2, LOW);

    duration = pulseIn(echoPin2, HIGH);
    distance = duration * 0.034 / 2;
    return distance;
  }
}

void sendDMX(byte red, byte green, byte blue){
 // DmxSimple.write(1, red);
 // DmxSimple.write(2, green);
 // DmxSimple.write(3, blue);
}
