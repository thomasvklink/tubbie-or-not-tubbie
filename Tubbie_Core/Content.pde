//Class for handeling the content (loading and playback)

class Content {

  //int scene;
  int timer;
  int timer2;
  //Sounds
  Movie intro;
  //Videos
  //nice happy videos
  Movie startscene;
  Movie rabbit; 
  Movie alphabet;
  //'dark' videos
  Movie dark1;
  Movie dark2;
  Movie dark3;
  Movie dark4;

  Content(PApplet app) {
    //startscene = new Movie(app, "startscene.mp4");
    intro = new Movie(app, "intro.mp4");
    rabbit = new Movie(app, "rabbit.mp4"); //Upload something random into the data folder to make this work
    alphabet = new Movie(app, "alphabet.mp4");
    dark1 = new Movie(app, "dark1.mov");
    dark2 = new Movie(app, "dark2.mov");
    dark3 = new Movie(app, "dark3.mov");
    dark4 = new Movie(app, "dark4.mov");
    //rabbit.play(); //Play it once please although might want to loop this incase the scene isn't swiched automatically TODO
  }

  void display(int inputScene) { //Changing the scene variables switches the content (in theory)
    switch(inputScene) { //Tried to change the image name as string but that didn't work, so this ugly way it is.
    case 1: //Intro
    intro.play();
    image(intro, 0, 0, width, height);
    timer2++;
    println(timer2);
    end();
      break;
    case 2: //Happy - Rabbits
      rabbit.volume(0);
      rabbit.play();
      image(rabbit, 0, 0, width, height); //Video will resize according to window but let's try to focus on 16:9 HD to Full HD ish
      break;
    case 3: //Happy - Alphabet
      alphabet.volume(0);
      alphabet.play();
      image(alphabet, 0, 0, width, height);
      break;
    case 4: //Dark 1 -
      dark1.play();
      timer++;
      image(dark1, 0, 0, width, height);
     end();
      break;
    case 5: //Dark 2 
      dark2.play();
      timer++;
    image(dark2, 0, 0, width, height);
    end();
      break;    
    case 6: //Dark 3 -
      dark3.play();
      image(dark3, 0, 0, width, height);
      end();
      break;    
    case 7: //Dark 4 -
      dark4.play();
      image(dark4, 0, 0, width, height);
      end();
      break;
    }
    //autoplay();
  }

  void autoplay() { //If there is no interaction continue playing happy content
    if (rabbit.time() >= rabbit.duration()) { //Check if movie has finished
      println("AUTOPLAY");
      reset();
      display(int(random(2, 3)));
    }
  }

  void end() {
    if (timer > 90) { //Check if movie has finished
      timer = 0;
      reset();
    }
    if (timer2 > 400){
      intro.stop();
      scene = 2;
      timer2 = 0;
    }
    //if (dark1.time() == dark1.duration()) { //Check if movie has finished
    //  reset();
    //}
    //if (dark2.time() == dark2.duration()) { //Check if movie has finished
    //  reset();
    //}
    //if (dark3.time() == dark3.duration()) { //Check if movie has finished
    //  reset();
    //}
    //if (dark4.time() == dark4.duration()) { //Check if movie has finished
    //  reset();
    //}
  };
  
  void reset() {
    println("RESET: " + scene);
    rabbit.stop();
    alphabet.stop();
    dark1.stop();
    dark2.stop();
    dark3.stop();
    dark4.stop();
    }
  
}
