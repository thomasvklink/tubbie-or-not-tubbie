//Class for control of the experience (selects scenes and changes content, lights and sounds accordingly. Also keeps track of time).

class Control {

  int scene = 2;
  float time;
  int timer = 0;
  boolean isPressed;
  Connect connect;

  Control() {
  }

  void experience() { //One method to bundel them together so that we only need to call this once in main and pass the scenes via this into all
    content();
    light();
    sound();
  }

  void content() { //Code to change scene variable, we probably want to randomise the scene number once this method is activated by the arduino button
    if (pressed) {
      isPressed = true;
      scene(4, 7);
    }
    if (isPressed) {
      timer++;
    } else {
      timer = 0;
    }
    if (scene == 4 || scene == 5 || scene == 6 || scene == 7  && timer > 90) {
      isPressed = false;
      scene(2, 3);
    }
  }

  void scene(int start, int stop) {
    scene = int(random(start, stop+1));
    println(scene);
  }

  void light() { //Code to send something back to the arduino to change the lighting sequence that is programmed there
  }

  void sound() { //It's best to include sound in the video but if we want to add some via Processing we can do it here.
  }

  void clock(int max) { //Method to time the experience and take action accordingly
    //time = millis();
    time = time + 0.0333333333333333; //Convert framerate (30) to seconds
    println(time); //Bit slow still TODO
    if (time > max) { //End experience after a desired amount of time (max)
      println("3 minutes after the start of experience, end it now! You need to MOVE");
      time = 0;
      //scene = ? set the scene to a certain ending video/scene
    }
  }
}
