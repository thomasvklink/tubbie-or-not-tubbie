//Class for handeling the content (loading and playback)
//Written by the amazing and overall good guy who we owe eternal credits and beers to: Ysbrand Burgstede
//Hereby we also accept that ex-via is the better do group and we all secretly envy to be one of them
//if any of the above lines are removed Ysbrand immediately retracts the rights to use his code

class Content {

  //int scene;
  int timer;
  //Sounds
  SoundFile dark;

  //Videos
  Movie intro;
  Movie outro;
  Movie climax;
  //Movie waitingScreen;

  int press;
  ArrayList <Movie> goodMoviesToPlay;
  Movie nowPlaying;
  int currentIndex=0;
  float pauseTimer;
  ArrayList<Movie> goodOnes;
  ArrayList<Movie> badOnes;
  boolean hasEnded;
  boolean startScreenActive;


  Content(PApplet app) {

    dark = new SoundFile(app, "dark.wav");
    goodMoviesToPlay=new ArrayList<Movie>();
    goodOnes=new ArrayList<Movie>();
    badOnes=new ArrayList<Movie>();

    intro = new Movie(app, "intro.mp4");
    outro = new Movie(app, "outro.mp4");
    //waitingScreen = new Movie(app, "waiting.mp4");

    goodOnes.add(new Movie(app, "rabbit.mp4"));
    goodOnes.add(new Movie(app, "alphabet.mp4"));
    goodOnes.add(new Movie(app, "cats.mp4"));
    goodOnes.add(new Movie(app, "chicks.mp4"));
    goodOnes.add(new Movie(app, "ducks.mp4"));
    goodOnes.add(new Movie(app, "horses.mp4"));
    goodOnes.add(new Movie(app, "puppies.mp4"));
    badOnes.add(new Movie(app, "dark1.mov"));
    badOnes.add(new Movie(app, "dark2.mov"));
    badOnes.add(new Movie(app, "dark3.mov"));
    badOnes.add(new Movie(app, "dark4.mov"));
    badOnes.add(new Movie(app, "dark5.mov"));
    badOnes.add(new Movie(app, "dark6.mov"));
    badOnes.add(new Movie(app, "dark7.mov"));
    badOnes.add(new Movie(app, "dark8.mov"));
    badOnes.add(new Movie(app, "dark9.mov"));
    badOnes.add(new Movie(app, "dark10.mov"));
    badOnes.add(new Movie(app, "dark11.mov"));

    climax = new Movie(app, "climax.mp4");
  }

  void init() {    
    goodMoviesToPlay=new ArrayList<Movie>();
    currentIndex=0;
    pauseTimer=0;
    goodMoviesToPlay.add(intro);
    goodMoviesToPlay.add(goodOnes.get((int)random(goodOnes.size())));
  }

  void showMovie() {
    println(interactions);
    println(goodMoviesToPlay);
    if (keyPressed && nowPlaying!= intro && !dark.isPlaying() && nowPlaying!=climax && nowPlaying!= outro) { 
      pressed = true;  
      interactions++;
    } else { 
      pressed = false;
      hasPressed = false;
    } 

    if (interactions == 0 && pressed) {
      nowPlaying.stop();
      goodMoviesToPlay=new ArrayList<Movie>();
      goodMoviesToPlay.add(0, intro);
      nowPlaying=goodMoviesToPlay.get(0);
      nowPlaying.play();
      goodMoviesToPlay.remove(0);
      goodMoviesToPlay.add(goodOnes.get((int)random(goodOnes.size())));
      introActive = true;
    }

    if (interactions == 5) {
      nowPlaying.stop();
      goodMoviesToPlay.add(0, climax);
      nowPlaying=goodMoviesToPlay.get(0);
      nowPlaying.play();
      goodMoviesToPlay.remove(0);
      goodMoviesToPlay.add(0, outro);
      interactions = -1;
    }

    if (nowPlaying==null) {
      nowPlaying=goodMoviesToPlay.get(0);
      nowPlaying.play();
      goodMoviesToPlay.remove(0);
    }
    if (abs(nowPlaying.time() - nowPlaying.duration()) < 0.1 && interactions == -1) {
      println("werkt dit");
      startScreenActive = true;
    }
    if (startScreenActive) {
      println("is it working?");
      nowPlaying.stop();
      goodMoviesToPlay=new ArrayList<Movie>();
      goodMoviesToPlay.add(0, outro);
      nowPlaying=goodMoviesToPlay.get(0);
      nowPlaying.play();
      nowPlaying.loop();
      startScreenActive = false;
    }
    if  (abs(nowPlaying.time() - nowPlaying.duration()) < 0.05) {
      hasPressed = false;
      introActive = false;
      nowPlaying.stop();
      nowPlaying=goodMoviesToPlay.get(0);
      nowPlaying.play();
      if (nowPlaying!=climax||nowPlaying!=outro) {
        goodMoviesToPlay.add(goodOnes.get((int)random(goodOnes.size())));
      }
      goodMoviesToPlay.remove(0);
    }

    if (nowPlaying.available()) {
      nowPlaying.read();
    }

    if (pressed && !hasPressed && interactions != -1 && interactions != 0 && interactions != 5) {
      hasPressed = true;
      if (!dark.isPlaying() && !introActive) {
        dark.play();
      }
      nowPlaying.stop();
      nowPlaying=badOnes.get((int)random(badOnes.size()));
      nowPlaying.play();
    }

    if (nowPlaying!=null) {
      image(nowPlaying, 0, 0, width, height);
    }
  }
}
