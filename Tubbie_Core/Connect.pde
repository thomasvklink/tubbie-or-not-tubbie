//TODO Coördinate with Ruben how we will handle the last part of the Arduino communication
//Data writer Edwin 13 M2 flashbacks

class Connect {

  PApplet app;
  Serial port;
  //Variables for Arduino communication
  String buff = "";
  char header[] = {'B'};
  int value[] = new int[1];
  int diffValue[] = new int[1];
  int NEWLINE = 10;
  int n;
  int b;
  int pressCounter;
  
  boolean calculate;
  
  Connect(PApplet app) {
    this.app = app;
  }
  
  void begin(){
    println("Available serial ports:");
    for (int i = 0; i<Serial.list ().length; i++) { 
      print("[" + i + "] ");
      println(Serial.list()[i]);
    }
    try{
    port = new Serial(app, Serial.list()[0], 9600);
    }catch(Exception e){
    println("Servo not connected, starting without!");
  }
  }

  void read() {
    //Arduino controller
    while (port.available() > 0) {
      serialEvent(port.read()); // read data
    }
    //if (boolean(value[0])){
    // pressCounter++;
    //}
    //if(pressCounter>=5){
    //  pressed = true;
    //  pressCounter = 0;
    //} else pressed = false;
    println("Interactions: " + interactions);
    if (pressed && !hasPressed) {
      pressed = true; 
      interactions++;
    } else {
      pressed = false;
    }
    pressed = boolean(value[0]); //level value
  } 

  //Catch and parse serial data from Arduino
  void serialEvent(int serial) 
  { 
    try {    // try-catch because of transmission errors
      if (serial != NEWLINE) { 
        buff += char(serial);
      } else {
        // The first character tells us which axis this value is for
        char c = buff.charAt(0);
        // Remove it from the string
        buff = buff.substring(1);
        // Discard the carriage return at the end of the buffer
        buff = buff.substring(0, buff.length()-1);
        // Parse the String into an integer
        for (int z=0; z<1; z++) {
          if (c == header[z]) {
            value[z] = Integer.parseInt(buff);
          }
        }
        buff = ""; // Clear the value of "buff"
      }
    }
    catch(Exception e) {
      println("no valid data");
    }
  }
}
