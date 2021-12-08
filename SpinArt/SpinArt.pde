/**
* LIBRARY: Processing Video
*
* TITLE  : Interactive-Generative Spin Art
* AUTHOR : TRISTAN FARRELL
* PROJECT: ISTA 301 Final Project
*
* DESCRIPTION:
*  This project contains five paintings which were randomly generated
*  by an algorithm. The creation was recorded and this program displays
*  each painting and its creation. It is interactive so the user can
*  switch between paintings by pressing ENTER and they can choose which 
*  part of the creation(pour,flick,spin) they want to view by 
*  pressing numbers 1-3. All files are inside data folder.
*  The Painting class holds information for each of the 5 paintings.
*
* ALGORITHM:
*  Colors(1:White,2:Brown,3:Red,4:Orange,5:Yellow,6:Green,
*         7:Light Blue,8:Blue,9:Dark Blue,10:Purple,11:Pink,12:Black)
*  #Colors: 6-sided dice roll
*  Colors: 12-sided dice roll
*  Spin Speed: 6-sided dice roll
*  Flicks: Coin Flip # of heads in a row
*  Repeat: 4-sided dice roll
*
*  Generate each variable value randomly, then apply each paint color
*  to the canvas in order of selection. Repeat paint application as many
*  times as generated. Then flick a stick through the paint by the flick
*  number generated. Then spin the painting at the speed generated.
*
*/

import processing.video.*;

Painting[] paintings = new Painting[5];
String[] pourTitles = {"1-pour.mkv", "2-pour.mkv", "3-pour.mkv", "4-pour.mkv", "5-pour.mkv"};
String[] flickTitles = {"1-flick.mkv", "2-flick.mkv", "3-flick.mkv", "4-flick.mkv", "5-flick.mkv"};
String[] spinTitles = {"1-spin.mkv", "2-spin.mkv", "3-spin.mkv", "4-spin.mkv", "5-spin.mkv"};

Painting currPainting;
Movie curr;
int index = 0;
int mode = 1;

void setup() {
  size(700, 700);
  background(255);
  makePaintings();
}

void draw() {
  curr = currPainting.pour;
  switch(mode){
    case 1:
      curr = currPainting.pour;
      break;
    case 2:
      curr = currPainting.flick;
      break;
    case 3:
      curr = currPainting.spin;
      break;
  }
  curr.loop();
  textSize(28);
  fill(0, 0, 0);
  infoBox();
  try{
    if(currPainting.num == 4){
     curr.volume(0); 
    }
    image(curr, 200, 200, 495, 495);
  }catch(Exception e){
    println(curr);
  }
  image(currPainting.img,5,400,190,295);
}

//Create Painting Information Text 
void infoBox(){
  String colors = "";
  for(int i=0; i<currPainting.colors.length;i++){
   colors += " "+currPainting.colors[i]; 
   if(i<currPainting.colors.length-1){
     colors+=",";
   }
  }
  int starty =50;
  textSize(48);
  fill(0, 0, 0);
  text("Painting "+currPainting.num, 0, starty);
  textSize(28);
  fill(255, 0, 0);
  starty+=30;
  text("#Colors:  "+currPainting.numColors, 0, starty);
  starty+=30;
  text("  Colors: "+colors, 0, starty);
  starty+=30;
  text("  Repeat: "+currPainting.repeat, 0, starty);
  starty+=30;
  text("  Flicks:   "+currPainting.flicks, 0, starty);
  starty+=30;
  text("  Speed:  "+currPainting.speed, 0, starty);
  fill(0, 255, 0);
  text("ENTER: Next Painting", 400, 30);
  starty+=50;
  fill(0, 0, 255);
  text("1:Pour",5,starty+30);
  text("2:Flick",5,starty+60);
  text("3:Spin",5,starty+90);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

// ON Key Pressed Actions
void keyPressed(){
  if(keyCode == ENTER || keyCode == RETURN){
    curr.stop();
    index +=1;
    if(index>4){
      index = 0;
    }
    currPainting = paintings[index];
    mode=1;
    clear();
    background(255);
  }
  if(key == '1'){
    curr.stop();
    mode = 1;
    clear();
    background(255);
  }
  if(key == '2'){
    curr.stop();
    mode = 2;
    clear();
    background(255);
  }
  if(key == '3'){
    curr.stop();
    mode = 3;
    clear();
    background(255);
  }
}

// Initialize Painting objects for each painting
void makePaintings(){
  Painting painting = new Painting();
  painting.num = 1;
  painting.pour = new Movie(this, pourTitles[0]);
  painting.flick = new Movie(this, flickTitles[0]);
  painting.spin = new Movie(this, spinTitles[0]);
  painting.numColors = 3;
  painting.colors = new String[]{"Purple", "Light Blue", "Yellow"};
  painting.speed = 2;
  painting.flicks = 3;
  painting.repeat = 1;
  painting.img = loadImage("1.jpg");
  paintings[0] = painting;
  
  painting = new Painting();
  painting.num = 2;
  painting.pour = new Movie(this, pourTitles[1]);
  painting.flick = new Movie(this, flickTitles[1]);
  painting.spin = new Movie(this, spinTitles[1]);  
  painting.numColors = 2;
  painting.colors = new String[]{"Blue", "Orange"};
  painting.speed = 4;
  painting.flicks = 1;
  painting.repeat = 5;
  painting.img = loadImage("2.jpg");
  paintings[1] = painting;
  
  painting = new Painting();
  painting.num = 3;
  painting.pour = new Movie(this, pourTitles[2]);
  painting.flick = new Movie(this, flickTitles[2]);
  painting.spin = new Movie(this, spinTitles[2]);
  painting.numColors = 4;
  painting.colors = new String[]{"Purple", "Light BLue", "Orange", "Black"};
  painting.speed = 4;
  painting.flicks = 3;
  painting.repeat = 2;
  painting.img = loadImage("3.jpg");
  paintings[2] = painting;
  
  painting = new Painting();
  painting.num = 4;
  painting.pour = new Movie(this, pourTitles[3]);
  painting.flick = new Movie(this, flickTitles[3]);
  painting.spin = new Movie(this, spinTitles[3]);
  painting.numColors = 3;
  painting.colors = new String[]{"Light Blue", "Dark BLue", "Orange"};
  painting.speed = 5;
  painting.flicks = 4;
  painting.repeat = 2;
  painting.img = loadImage("4.jpg");
  paintings[3] = painting;
  
  painting = new Painting();
  painting.num = 5;
  painting.pour = new Movie(this, pourTitles[4]);
  painting.flick = new Movie(this, flickTitles[4]);
  painting.spin = new Movie(this, spinTitles[4]);
  painting.numColors = 5;
  painting.colors = new String[]{"Purple", "Pink", "Yellow", "Black", "Dark Blue"};
  painting.speed = 1;
  painting.flicks = 4;
  painting.repeat = 3;
  painting.img = loadImage("5.jpg");
  paintings[4] = painting;
  
  currPainting = paintings[0];
}
