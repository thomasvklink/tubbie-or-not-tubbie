//Class for handeling the content (loading and playback)

class Content {
  
  //Videos
  Movie astro; //AsTrOlOgY 
  Movie astro2;
  
  Content(PApplet app){
    astro = new Movie(app, "rabbit.mp4"); //Upload something random into the data folder to make this work
    astro2 = new Movie(app, "alphabet.mp4");
    //astro.play(); //Play it once please although might want to loop this incase the scene isn't swiched automatically TODO
  }
  
  void display(int scene){ //Changing the scene variables switches the content (in theory)
    switch(scene){ //Tried to change the image name as string but that didn't work, so this ugly way it is.
      case 1:
        astro.play();
        image(astro, 0,0, width, height); //Video will resize according to window but let's try to focus on 16:9 HD to Full HD ish
      break;
      case 2:
        astro2.play();
        image(astro2, 0,0, width, height);
      break;
    }
  }
  
  void reset(){
    switch(scene){
      case 1:
      astro.stop();
      break;
      case 2:
      astro2.stop();
      break;
    }
  }
  
}
