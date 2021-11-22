/*
* Author: Tristan Farrell
* Description: Processing program written in java.
*    Generates a dynamic beach scene with fractal trees.
*    Interact with mouse and keys.
*/
int count = 0;
float r = random(5);
float g = random(100);
float b = random(50);
float rx = 0;
float gx = 50;
float bx = 255;
int refreshRate = 120;
float w = 0;
float wr = 0;
float r1=1;
float r2=1;
float md = 35;
int seed = 0;
int val = 255;
float backR = 255;
float backG = 255;
float backB = 255;
float backRRand = 255;
float backGRand = 255;
float backBRand = 255;
float sandR = 204;
float sandG = 173;
float sandB = 137;
int foamOpaRand = (int)random(350);
int foamOpa = 20;
boolean fire = false;

float treeR = random(100);
float treeG = random(255);
float treeB = random(100);
float treeWeight = random(0.5, 4);
float treeLenBase = random(15, 100);
float treeLenChange = random(0.6, 0.8);
float treeTheta = random(-PI/2, PI/2);

float strokeW = random(0.5,4);
float baseL = random(40,70);
float baseC = random(0.7, 0.8);
float theta = random(.1,.3);

ArrayList<float[]> trees = new ArrayList();
ArrayList<float[]> palms = new ArrayList();

float x = 400;
float y = 400;
float x1 = x;
float y1 = y;
int wid = 5;
int hei = 10;
int fc = 1;

int tr = (int)random(120, 180);
int tg = (int)random(100, 150);
int tb = (int)random(30, 80);

float palmRCh=random(-20,-5);
float palmGCh=random(-10,10);
float palmBCh=random(-10,10);



void setup() {
  size(600, 600);
  frameRate(60);

  float[] t = new float[]{random(200), random(255), random(200), random(0.5, 4), random(10, 30), random(0.7, 0.9), random(.1,.5)};
  float[] t2 = new float[]{random(200), random(155), random(200), random(0.5, 4), random(10, 30), random(0.6, 0.9), random(-.5, -.1)};
  float[] t3 = new float[]{random(100), random(255), random(200), random(0.5, 4), random(5, 20), random(0.6, 0.9), random(.2,.9)};
  float[] t4 = new float[]{random(100), random(255), random(100), random(0.5, 4), random(5, 20), random(0.8, 0.9), random(-.9,-.2)};
  trees.add(t);
  trees.add(t2);
  trees.add(t3);
  trees.add(t4);
}

void draw() {
  randomizeVars();
  background(180-backR, 255-backG, 255-backB);
  drawSun();
  drawIsland();
  drawCircle(-50, 400, 650, 20.0, 1.5, 0, 255-r, g, b, 150, 1);
  drawPalms();
  if (fire) {
    drawFirework();
  }
  drawTrees();
  count+=1;
}

void randomizeVars() {
  //randomize values after refreshRate # of frame
  if (count%refreshRate == 0) {
    rx = random(20); //red randomizer
    gx = random(200);//green randomizer
    bx = random(100);//blue randomizer
    wr = random(5);  //water spacing randomizer
    backRRand = 0;   //background red randomizer
    backGRand = 0;   //background green randomizer
    backBRand = 0;   //background blue randomizer
    foamOpaRand = (int)random(300); //foam opacity randomizer
  }

  //slowly transition rgb values to new random
  float dr = rx-r;
  float dg = gx-g;
  float db = bx-b;
  r+= (dr/abs(dr))*(abs(dr)/refreshRate);
  g+= (dg/abs(dg))*(abs(dg)/refreshRate);
  b+= (db/abs(db))*(abs(db)/refreshRate);

  //slowly transition background rgb values to new random
  float dbr = backRRand-backR;
  float dbg = backGRand-backG;
  float dbb = backBRand-backB;
  backR+= (dbr/abs(dbr))*(abs(dbr)/refreshRate);
  backG+= (dbg/abs(dbg))*(abs(dbg)/refreshRate);
  backB+= (dbb/abs(dbb))*(abs(dbb)/refreshRate);

  //slowly transition foam opacity value to new random
  float foamOpaDiff = foamOpaRand-foamOpa;
  foamOpa+= (foamOpaDiff/abs(foamOpaDiff))*(abs(foamOpaDiff)/refreshRate);

  //slowly transition water spacing value to new random
  float dw = wr-w;
  w+= (dw/abs(dw))*(abs(dw)/refreshRate);
}

int click = 0;
void keyPressed() {
  //randomize back colors
  backR = random(255);
  backG = random(255);
  backB = random(255);
  r = 255-backR;
  g = 255-backG;
  b = 255-backB;
  
  //toggle firework setup
  fire = !fire;
  float waveX = sin(radians(frameCount*2));
  float waveY = cos(radians(frameCount*2));
  x = 500+(waveX*10);
  y = 400+(waveY*30);
  wid = 5;
  hei = 10;
  fc = 1;
}

void mousePressed() {
  //randomize palm colors
  palmRCh=random(-20,-5);
  palmGCh=random(-10,10);
  palmBCh=random(-10,10);
  
  //randomize tree color
  tr = (int)random(120, 180);
  tg = (int)random(100, 150);
  tb = (int)random(30, 80);
  
  //make new random trees
  trees.clear();
  float[] t = new float[]{random(200), random(255), random(200), random(0.5, 4), random(10, 30), random(0.7, 0.9), random(.1,.5)};
  float[] t2 = new float[]{random(100), random(255), random(100), random(0.5, 4), random(10, 30), random(0.6, 0.9), random(-.5, -.1)};
  float[] t3 = new float[]{random(100), random(255), random(200), random(0.5, 4), random(5, 20), random(0.6, 0.9), random(.2,.9)};
  float[] t4 = new float[]{random(200), random(255), random(100), random(0.5, 4), random(5, 20), random(0.8, 0.9), random(-.9,-.2)};
  trees.add(t);
  trees.add(t2);
  trees.add(t3);
  trees.add(t4);
  
  //randomize three palms
  strokeW = random(0.5,4);
  baseL = random(60,80);
  baseC = random(0.7, 0.8);
  theta = random(-PI/7,PI/7);
}

//Draw Ocean
void drawCircle(float a, float b, int size, float radius, float radAdj, int q, float r2, float g2, float b2, int opa, int stroke) {
  if (q<1) {
    drawCircle(a, b, size, radius/2, radAdj, q+1, 0, 0, 0, foamOpa, 2);
  }
  fill(255-r2, 255-g2, 255-b2, opa);
  stroke(255-r2, 255-g2, 255-b2);
  strokeWeight(stroke);
  float waveX = sin(radians(frameCount*2));
  float waveY = cos(radians(frameCount*2));
  float xSize = size-500;  
  for (float y=b; y<size; y +=(radius/radAdj)+w) {
    xSize +=20;
    for (float x=a; x<xSize; x+=(radius/radAdj)+w) {
      float mx = x-mouseX;
      float my = y-mouseY;
      if ( abs(mx+my)<md  && abs(mx-my)<md ) {
        ellipse((x+(waveX*40))-mx, (y+(waveY*30))-my, radius/2, radius/2);
      } else {
        if (q==0) {
          ellipse((x+(waveX*40)), (y+(waveY*30)), radius, radius);
        } else {
          ellipse((x+(waveX*40))+random(-1, 1), (y+(waveY*30))+random(-1, 1), radius, radius);
        }
      }
    }
  }
}  

//Draws Island
void drawIsland() {
  float waveX = sin(radians(frameCount*2));
  float waveY = cos(radians(frameCount*2));
  fill(sandR, sandG, sandB);
  noStroke();
  triangle(100+(waveX*10), 400+(waveY*30), 650+(waveX*10), 300+(waveY*30), 650+(waveX*10), 800+(waveY*30));
}

//Draws Firework animation
void drawFirework() {
  fill(255, 0, 0);
  stroke(255, 255, 255);
  strokeWeight(1);
  
  //EXPLOSION
  if (x<300 && y<200) {
    if (hei*fc<500) {
      fill(random(200, 255), random(200), random(100));
      ellipse(x+fc+random(100), y+fc+random(50), (wid+random(5))*fc, (wid+random(5))*fc);
      fill(random(50, 255), random(200), random(150));
      ellipse(x-fc-random(100), y-fc-random(50), (wid+random(5))*fc, (wid+random(5))*fc);
      fill(random(100, 255), random(200), random(50));
      ellipse(x+fc+random(100), y-fc-random(50), (wid+random(5))*fc, (wid+random(5))*fc);
      fill(random(0, 255), random(200), random(200));
      ellipse(x-fc-random(100), y+fc+random(50), (wid+random(5))*fc, (wid+random(5))*fc);
    }
    fc+=3;
  } 
  //FIRE ROCKET
  else {
    stroke(255, 255, 255);
    strokeWeight(1);
    fill(255, 169, 0);
    triangle(x-10, y-5, x, y-10, x-10, y-15);
    fill(255, 0, 0);
    quad(x-10, y-5, x, y-10, x+10, y+5, x, y+10);
    fill(255, 255, 255);
    quad(x+10, y+5, x, y+10, x-1, y+20, x+19, y+10  );  
    x-=5;
    y-=7;
  }
}

//Draws the sun
void drawSun() {
  float waveX = sin(radians(frameCount*2));
  float waveY = cos(radians(frameCount*2));

  fill(255-r+(waveX*50), 155-255-g+(waveY*10), 255-255-b-(waveY*50));
  stroke(255-r, 255-255-g, 255-255-b);
  strokeWeight(1);
  ellipse(50+(waveX*10), 50+(waveX*10), 100+(waveX*10), 100+(waveX*10));
}

//Draws three Palms
void drawPalms() {
  translate(-100, 0);
  pushMatrix();
  translate(200, 350);  
  for(int i=0;i<3;i++){
    float tranX = 150;
    float tranY = 45;
    translate(tranX,tranY);
    strokeWeight(strokeW);
    palm(baseL,0,i,tr,tg,tb, baseC, theta);
  }
  popMatrix();
}

//Draw Trees
void drawTrees() {
  pushMatrix();
  translate(100,100);
  for(int i=0; i<trees.size();i++){
    switch (i){
      case 0: translate(525, 300);
              break;
      case 1: translate(-150, 0);
              break;
      case 2: translate(20, +60);
              break;
      case 3: translate(+150, +60);
              break;
    }
    stroke(trees.get(i)[0], trees.get(i)[1], trees.get(i)[2]);
    strokeWeight(trees.get(i)[3]);
    tree(trees.get(i)[4], 0, i);
  }
  popMatrix();
}

//New version of recursive tree algorithm
//Creates an occilating fractal tree using lines
//Inspiration Source: https://processing.org/examples/tree.html
void tree(float l, int c, int index) {
  float waveX = sin(radians(frameCount*2));
  float waveY = cos(radians(frameCount*2));
  line(0+(waveX*10), 0+(waveY*30), 0+(waveX*10), -l+(waveY*30));
  translate(0, -l);
  l *= trees.get(index)[5];
  if (l > 2 && c<10) {
    float rotation = trees.get(index)[6];
    pushMatrix();
    rotate(rotation);
    tree(l, c+1, index);
    popMatrix();
    pushMatrix();
    rotate(-rotation);
    tree(l, c+1, index);
    popMatrix();
  }
}

//New version of recursive tree algorithm
//Creates an occilating fractal palm trees with a color scale
void palm(float l, int c, int index, int r, int g, int b, float lenCh, float theta) {
  stroke(r, g, b);
  float waveX = sin(radians(frameCount*2));
  float waveY = cos(radians(frameCount*2));
  line(0+(waveX*10), 0+(waveY*30), 0+(waveX*10), -l+(waveY*30));
  translate(0, -l);
  l *= lenCh;
  if (l > 2 && c<10) {
    float rotation = theta;
    pushMatrix();
    rotate(rotation);
    palm(l, c+1, index, r+(int)palmRCh, g+(int)palmGCh, b+(int)palmBCh, lenCh, theta);
    popMatrix();
    pushMatrix();
    rotate(-rotation);
    palm(l, c+1, index, r+(int)palmRCh, g+(int)palmGCh, b+(int)palmBCh, lenCh, theta);
    popMatrix();
  }
}
