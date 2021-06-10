/***
Tubbie or not Tubbie
Group 15 - Ex-Pers
Creative Technology M4 @ University of Twente  
for GOGBOT Festival 2021
***/

import processing.video.*; //Don't forget to install the libary locally in the IDE
import processing.serial.*;

Content content;
Control control;
Connect connect;

int level;

void setup(){
  //fullScreen();  //For production
  size(1280, 720); //For development
  frameRate(30); //Video's won't be higher anyway
  content = new Content(this); //Pass the PApplet of the sketch to use libary in class.
  connect = new Connect(this);
  connect.begin();
  control = new Control();
}

void draw(){
  background(0); //Black background as default backdrop
  content.display(control.scene); //Display the correct content according to scene number
  control.experience(); //Control the experience based on the scene
  control.clock(180); //Set the control clock to let the experience last for 180 seconds max (not influnced by interaction)
  connect.read();
  println("ARDUINO READ: " + level);
}

//Run the videos
void movieEvent(Movie m){
    m.read();
  }
 
void keyPressed(){
  control.scene();
  content.reset();
}

/***

Flow: Start intro video > loop until interaction > play dark content > return to happy > IF no interaction during video move on 

The scene variables seems to be global (for development it is) but it should be local to the classes. 
We do use a scene variable in each class we essentialy does the same.

Classes:

Content class
- inside a switch statement with all the different video's, handles playing and switching
Control class
- handles switching of the variable by time or user input
Connect class
- handles Arduino communication

***/
