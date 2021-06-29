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
  ArrayList <Movie> badMoviesToPlay;
  Movie nowPlaying;
  int currentIndex=0;
  float pauseTimer;
  ArrayList<Movie> goodOnes;
  ArrayList<Movie> badOnes;

  Content(PApplet app) {

    dark = new SoundFile(app, "dark.wav");
    goodMoviesToPlay=new ArrayList<Movie>();
    goodOnes=new ArrayList<Movie>();
    badOnes=new ArrayList<Movie>();
    

    intro = new Movie(app, "intro.mp4");
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
    
    nowPlaying = goodOnes.get(0);
    climax = new Movie(app, "climax.mkv");
  }

  void init() {    
    goodMoviesToPlay=new ArrayList<Movie>();
    badMoviesToPlay=new ArrayList<Movie>();
    currentIndex=0;
    pauseTimer=0;
    //goodMoviesToPlay.add(intro);
    goodMoviesToPlay.add(goodOnes.get((int)random(goodOnes.size())));
    badMoviesToPlay.add(badOnes.get((int)random(badOnes.size())));
  }

  void showMovie() {
    //Checkt elke keer of de huidige soundfile afgelopen is en de timer ook en speelt dan de track af
    if (currentIndex<goodMoviesToPlay.size()) {      
      if (pressed == false && interactions != 0  && interactions !=5) {
        if (nowPlaying==null) {
          nowPlaying=goodMoviesToPlay.get(0);
          nowPlaying.play();
          nowPlaying=goodMoviesToPlay.remove(0);
        }
        if (nowPlaying.duration()==nowPlaying.time()) {
          nowPlaying=goodMoviesToPlay.get(0);
          nowPlaying.play();
          nowPlaying=goodMoviesToPlay.remove(0);
        }
    }}
    if (interactions !=0) {
      nowPlaying.read();
    }

    if (pressed && !hasPressed && interactions != 0  && interactions !=5) {
      hasPressed = true;
      if (!dark.isPlaying()) {
        dark.play();
      }
      nowPlaying.jump(nowPlaying.duration());
      nowPlaying.stop();
      goodMoviesToPlay.add(badOnes.get((int)random(badOnes.size())));
    }

    if (hasPressed) {
      timer++;
    } 
    if (timer > 60) {
      hasPressed = false;
      timer = 0;
      nowPlaying.stop();
      goodMoviesToPlay.add(goodOnes.get((int)random(goodOnes.size())));
    }

    if (nowPlaying!=null) {
      image(nowPlaying, 0, 0, width, height);
    }
  }
  
  void check(){
    if (nowPlaying == intro){
      introActive = true;
    } else {
      introActive = false;
    }
    
    if (nowPlaying == climax){
      climaxActive = true;
    } else {
      climaxActive = false;
    }
  }
}
