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
  //Good content
  Movie rabbit; 
  Movie alphabet;
  Movie cats;
  Movie chicks;
  Movie ducks;
  Movie horses;
  Movie puppies;

  //Dark content
  Movie dark1;
  Movie dark2;
  Movie dark3;
  Movie dark4;
  Movie dark5;
  Movie dark6;
  Movie dark7;
  Movie dark8;
  Movie dark9;
  Movie dark10;
  Movie dark11;

  int press;
  ArrayList <Movie> goodMoviesToPlay;
  Movie nowPlaying;
  int currentIndex=0;
  float pauseTimer;
  ArrayList<Movie> goodOnes;
  ArrayList<Movie> badOnes;
  boolean hasEnded;


  Content(PApplet app) {

    dark = new SoundFile(app, "dark.wav");
    goodMoviesToPlay=new ArrayList<Movie>();
    goodOnes=new ArrayList<Movie>();
    badOnes=new ArrayList<Movie>();

    intro = new Movie(app, "intro.mp4");
    outro = new Movie(app, "outro.mp4");

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
    //println(goodMoviesToPlay);
    //println(hasEnded);
    if (keyPressed && !hasPressed && !dark.isPlaying()) { 
      pressed = true;  
      interactions++;
    } else { 
      pressed = false;
      hasPressed = false;
    } 

    if (interactions == 0 && pressed) {
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
    //if (nowPlaying==outro) {
    //  hasEnded = true;
    //}
    if  (abs(nowPlaying.time() - nowPlaying.duration()) < 0.05) {
      //println("Next?");
      hasPressed = false;
      introActive = false;
      nowPlaying.stop();
      nowPlaying=goodMoviesToPlay.get(0);
      nowPlaying.play();
      if (nowPlaying!=climax||nowPlaying!=outro) {
        goodMoviesToPlay.add(goodOnes.get((int)random(goodOnes.size())));
      }
      //if (hasEnded) {
      //  println("Looping?");
      //  nowPlaying.stop();
      //  goodMoviesToPlay=new ArrayList<Movie>();
      //  nowPlaying=dark1;
      //  nowPlaying.play();
      //  nowPlaying.loop();
      //  hasEnded = false;
      //}
      goodMoviesToPlay.remove(0);
    }

    if (nowPlaying.available()) {
      nowPlaying.read();
    }

    if (pressed && !hasPressed && interactions != -1 && !introActive && interactions != 5) {
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
