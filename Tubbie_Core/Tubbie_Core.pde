/***
Tubbie or not Tubbie
Group 15 - Ex-Pers
Creative Technology M4 @ University of Twente  
for GOGBOT Festival 2021
***/

import processing.video.*; //Don't forget to install the libary locally in the IDE
import processing.sound.*;
import processing.serial.*;

Content content;
Control control;
Connect connect;

boolean block;
boolean pressed;

void setup(){
  //fullScreen(2);  //For production
  size(1280, 720); //For development
  frameRate(30); //Video's won't be higher anyway
  content = new Content(this); //Pass the PApplet of the sketch to use libary in class.
  content.init();
  connect = new Connect(this);
  connect.begin();
  control = new Control(this);
}

void draw(){
  println(frameRate);
  background(0); //Black background as default backdrop
  content.showMovie(); //Display content
  control.experience(); //Control the experience based on the scene
  control.clock(180); //Set the control clock to let the experience last for 180 seconds max (not influnced by interaction)
  connect.read();
  println("ARDUINO READ: " + pressed);
  //pressed = false;
}

//Run the videos
void movieEvent(Movie m){
    m.read();
   }
