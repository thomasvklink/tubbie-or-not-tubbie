//Class for handeling the content (loading and playback)

class Content {

  int scene;
  //Videos
  //nice happy videos
  Movie startscene;
  Movie rabbit; 
  Movie alphabet;
  //'dark' videos

  Content(PApplet app) {
    //startscene = new Movie(app, "startscene.mp4");
    rabbit = new Movie(app, "rabbit.mp4"); //Upload something random into the data folder to make this work
    alphabet = new Movie(app, "alphabet.mp4");
    //rabbit.play(); //Play it once please although might want to loop this incase the scene isn't swiched automatically TODO
  }

  void display(int inputScene) { //Changing the scene variables switches the content (in theory)
    switch(inputScene) { //Tried to change the image name as string but that didn't work, so this ugly way it is.
    case 1: //Intro - Audio only
      
    break;
    case 2: //Happy - Rabbits
      rabbit.volume(0);
      rabbit.play();
      image(rabbit, 0, 0, width, height); //Video will resize according to window but let's try to focus on 16:9 HD to Full HD ish
     break;
    case 3: //Happy - Alphabet
      alphabet.play();
      image(alphabet, 0, 0, width, height);
     break;
     case 4: //Dark 1 -
       
     break;
    }
    scene = inputScene;
    autoplay();
  }

  void autoplay() { //If there is no interaction continue playing happy content
    if (rabbit.time() == rabbit.duration()) { //Check if movie has finished
      println("AUTOPLAY");
      reset();
      display(int(random(1,3)));
    }
  }

  void reset() {
    println("RESET");
    switch(scene) {
    case 1:
      rabbit.stop();
      break;
    case 2:
      alphabet.stop();
      break;
    }
  }
}
