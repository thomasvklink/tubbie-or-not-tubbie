//Class for handeling the content (loading and playback)
//Written by the amazing and overall good guy who we owe eternal credits and beers to: Ysbrand Burgstede
//Hereby we also accept that ex-via is the better do group and we all secretly envy to be one of them
//if any of the above lines are removed Ysbrand immediately retracts the rights to use his code

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

  ArrayList <Movie> moviesToPlay;
  Movie nowPlaying;
  int currentIndex=0;
  float pauseTimer;
  ArrayList<Movie> goodOnes;
  ArrayList<Movie> badOnes;
  
  Content(PApplet app) {
    moviesToPlay=new ArrayList<Movie>();
    goodOnes=new ArrayList<Movie>();
    badOnes=new ArrayList<Movie>();
    
    intro = new Movie(app, "intro.mp4");
    goodOnes.add(new Movie(app, "rabbit.mp4"));
    goodOnes.add(new Movie(app, "alphabet.mp4"));
    badOnes.add(new Movie(app, "dark1.mov"));
    badOnes.add(new Movie(app, "dark2.mov"));
    badOnes.add(new Movie(app, "dark3.mov"));
    badOnes.add(new Movie(app, "dark4.mov"));
  }
  
  void init() {    
    moviesToPlay=new ArrayList<Movie>();
    currentIndex=0;
    pauseTimer=0;
    moviesToPlay.add(intro);
    moviesToPlay.add(goodOnes.get((int)random(goodOnes.size())));
  }
  
  void showMovie() {
    if (currentIndex<moviesToPlay.size()) {      
      if (nowPlaying==null) {
        nowPlaying=moviesToPlay.get(0);
        nowPlaying.play();
        nowPlaying=moviesToPlay.remove(0);
      }

      if (nowPlaying.duration()==nowPlaying.time()) {
        nowPlaying=moviesToPlay.get(0);
        nowPlaying.play();
        nowPlaying=moviesToPlay.remove(0);
      }
    }
    if (nowPlaying.available()) {
      nowPlaying.read();
    }
    println(nowPlaying.time());
    if (nowPlaying!=null) {
      image(nowPlaying, 0, 0, width, height);
    }
  }

  void addMovie(Movie newMovie) {
    moviesToPlay.add(newMovie);
  }
  
  void removeMovie(int index){
    moviesToPlay.remove(index);
  }
}
