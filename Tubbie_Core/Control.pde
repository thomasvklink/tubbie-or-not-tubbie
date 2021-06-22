//Class for control of the experience (selects scenes and changes content, lights and sounds accordingly. Also keeps track of time).
//Written by the amazing and overall good guy who we owe eternal credits and beers to: Ysbrand Burgstede
//Hereby we also accept that ex-via is the better do group and we all secretly envy to be one of them
//if any of the above lines are removed ysbrand immediately retracts the rights to use his code

class Control {

  Content content;
  //int scene = 2;
  float time;
  int timer = 0;
  boolean isPressed;
  boolean sceneSwitch;
  Connect connect;

  Control(PApplet app) {
    content = new Content(app);
  }

  void experience() { //One method to bundel them together so that we only need to call this once in main and pass the scenes via this into all
    content();
    light();
    sound();
    //println(timer);
  }

  void content() { //Code to change scene variable, we probably want to randomise the scene number once this method is activated by the arduino button
  println(scene);
    if (scene == 1){
      block = true;
    } else {
      block = false;
    }
    
    println(block);
    if (pressed && !block) {
      isPressed = true;
      //content.reset();
        if(!sceneSwitch){
          scene(4,7);
          sceneSwitch = true;
        }
    }
    if (isPressed) {
      timer++;
    } else {
      timer = 0;
    }
    if ((scene == 4 || scene == 5 || scene == 6 || scene == 7 ) && timer > 90) {
      isPressed = false;
      sceneSwitch = false;
      scene(2, 3);
      timer = 0;
    }
    
    //if (scene == 4 || scene == 5 || scene == 6 || scene == 7  && timer > 90) {
    //  isPressed = false;
    //  scene(2, 3);
    //}
  }

  void scene(int start, int stop) {
    scene = int(random(start, stop+1));
    //println("SCENE: " + scene);
  }

  void light() { //Code to send something back to the arduino to change the lighting sequence that is programmed there
  }

  void sound() { //It's best to include sound in the video but if we want to add some via Processing we can do it here.
    
  }

  void clock(int max) { //Method to time the experience and take action accordingly
    //time = millis();
    time = time + 0.0333333333333333; //Convert framerate (30) to seconds
    //println(time); //Bit slow still TODO
    if (time > max) { //End experience after a desired amount of time (max)
      println("3 minutes after the start of experience, end it now! You need to MOVE");
      time = 0;
      //scene = ? set the scene to a certain ending video/scene
    }
  }
}
