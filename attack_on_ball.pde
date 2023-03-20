import ddf.minim.*;

Minim minim;
AudioPlayer chop;
AudioPlayer composer;

PImage[][][] monster = new PImage[2][7][2];//[LR][who][move]
PImage[][] ball = new PImage[3][6];//[size][color]
PImage background;
PImage []floor = new PImage[7];
PImage []TimeImg = new PImage[6];
PImage []TimeFrontImg = new PImage[6];//Time img
PImage star;
PImage []die = new PImage[16];
PImage start;
PImage game;
float W = 1280, H = 720;
int floorColor;
int monsterDirection, monsterTypes, monsterTimes;
float monsterX, monsterY;
int monsterW, monsterH;
boolean monsterTypeChange;
int monsterChangeTimes = 0;
boolean monsterLive;
float [][]ballX = new float[3][6];
float [][]ballY = new float[3][6];
float [][]ballVX = new float[3][6];
float [][]ballVY = new float[3][6];
float [][]ballA = new float[3][6];
boolean [][]ballUseing = new boolean[3][6];
float []ballSize = new float[3];
float []ballLowY= new float[3];

int ballSizeRandom, ballColorRandom;
int times;
float nowtime;
float millisecond;

int TimeColor;
int TimeFrontColor;
PFont font;//Time display

float starX, starY;
boolean starUsing = true;
int starTime = 0;

float []dieX = new float[16];
float []dieY = new float[16];
float []dieVY = new float[16];
float []dieVX = new float[16];
float []dieVA = new float[16];

boolean clickStart = false;

void loadimg() {
  background = loadImage("bg.png");
  floor[0]  = loadImage("floor1.png");
  floor[1]  = loadImage("floor2.png");
  floor[2]  = loadImage("floor3.png");
  floor[3]  = loadImage("floor4.png");
  floor[4]  = loadImage("floor5.png");
  floor[5]  = loadImage("floor6.png");
  floor[6]  = loadImage("floor7.png");

  monster[0][0][0] = loadImage("100.png");
  monster[0][0][1] = loadImage("101.png");
  monster[0][1][0] = loadImage("110.png");
  monster[0][1][1] = loadImage("111.png");
  monster[0][2][0] = loadImage("120.png");
  monster[0][2][1] = loadImage("121.png");
  monster[0][3][0] = loadImage("130.png");
  monster[0][3][1] = loadImage("131.png");
  monster[0][4][0] = loadImage("140.png");
  monster[0][4][1] = loadImage("141.png");
  monster[0][5][0] = loadImage("150.png");
  monster[0][5][1] = loadImage("151.png");
  monster[0][6][0] = loadImage("160.png");
  monster[0][6][1] = loadImage("161.png");
  monster[1][0][0] = loadImage("200.png");
  monster[1][0][1] = loadImage("201.png");
  monster[1][1][0] = loadImage("210.png");
  monster[1][1][1] = loadImage("211.png");
  monster[1][2][0] = loadImage("220.png");
  monster[1][2][1] = loadImage("221.png");
  monster[1][3][0] = loadImage("230.png");
  monster[1][3][1] = loadImage("231.png");
  monster[1][4][0] = loadImage("240.png");
  monster[1][4][1] = loadImage("241.png");
  monster[1][5][0] = loadImage("250.png");
  monster[1][5][1] = loadImage("251.png");
  monster[1][6][0] = loadImage("260.png");
  monster[1][6][1] = loadImage("261.png");

  ball[0][0] = loadImage("big1.png");
  ball[1][0] = loadImage("min1.png");
  ball[2][0] = loadImage("small1.png");
  ball[0][1] = loadImage("big2.png");
  ball[1][1] = loadImage("min2.png");
  ball[2][1] = loadImage("small2.png");
  ball[0][2] = loadImage("big3.png");
  ball[1][2] = loadImage("min3.png");
  ball[2][2] = loadImage("small3.png");
  ball[0][3] = loadImage("big4.png");
  ball[1][3] = loadImage("min4.png");
  ball[2][3] = loadImage("small4.png");
  ball[0][4] = loadImage("big5.png");
  ball[1][4] = loadImage("min5.png");
  ball[2][4] = loadImage("small5.png");
  ball[0][5] = loadImage("big6.png");
  ball[1][5] = loadImage("min6.png");
  ball[2][5] = loadImage("small6.png");

  TimeImg[0] = loadImage("time1.png"); //TimeLINE IMG
  TimeImg[1] = loadImage("time2.png");
  TimeImg[2] = loadImage("time3.png");
  TimeImg[3] = loadImage("time4.png");
  TimeImg[4] = loadImage("time5.png");
  TimeImg[5] = loadImage("time6.png");
  TimeFrontImg[0] = loadImage("timefront1.png");
  TimeFrontImg[1] = loadImage("timefront2.png");
  TimeFrontImg[2] = loadImage("timefront3.png");
  TimeFrontImg[3] = loadImage("timefront4.png");
  TimeFrontImg[4] = loadImage("timefront5.png");
  TimeFrontImg[5] = loadImage("timefront6.png");
  
  star = loadImage("star.png");
  start = loadImage("start.png");
  game = loadImage("game.png");
  
  die[0] = loadImage("die1.png");
  die[1] = loadImage("die2.png");
  die[2] = loadImage("die3.png");
  die[3] = loadImage("die4.png");
  die[4] = loadImage("die5.png");
  die[5] = loadImage("die6.png");
  die[6] = loadImage("die7.png");
  die[7] = loadImage("die8.png");
  die[8] = loadImage("die9.png");
  die[9] = loadImage("die10.png");
  die[10] = loadImage("die11.png");
  die[11] = loadImage("die12.png");
  die[12] = loadImage("die13.png");
  die[13] = loadImage("die14.png");
  die[14] = loadImage("die15.png");
  die[15] = loadImage("die16.png");
  
}

void floorRandom() {
  if(millisecond%5 == 0){
    floorColor = (int)random(0, 6);
    TimeColor = (int)random(0, 6);
  }
  TimeCount+=0.12;
  TimeX+=7.0;
  if (keyPressed == true) monsterTypes = 6;
  else monsterTypes = 1;
}

void setMonster() {
  monsterDirection = 0;
  monsterTypes = 0;
  monsterTimes = 0;
  monsterX = W/2-100/2;
  monsterY = H-220;
  monsterTypeChange = false;
  monsterW = 132;
  monsterH = 120;
  monsterLive = true;
}


void moveMonster() {
  if (monsterDirection == 0 && monsterTypes >= 2) {
    if (monsterX>0) monsterX-=10;
  }
  if (monsterDirection == 1 && monsterTypes >= 2) {
    if (monsterX<W-monsterW) monsterX+=10;
  }
}

void drawMonster() {
  if (monsterLive == true) {
    image(monster[monsterDirection][monsterTypes][monsterTimes], monsterX, monsterY);
    monsterChangeTimes++;
    if (monsterChangeTimes%6 == 0) {
      if (monsterTimes == 0) {
        monsterTimes = 1;
      } else monsterTimes = 0;
    }
  }
}

void setball() {
  times = 0;
  nowtime = 0;
  for (int i=0; i<3; i++) {
    for (int j=0; j<6; j++) {
      ballUseing[i][j] = false;
      if (j%2 == 0) ballX[i][j] = -250;
      else ballX[i][j] = 1028;
    }
  }
  ballSize[0] = 250;
  ballSize[1] = 185;
  ballSize[2] = 115;
  ballLowY[0] = 191;
  ballLowY[1] = 158.5;
  ballLowY[2] = 123.5;
  
}

void ballRandom() {
  millisecond = millis();
  if (millisecond-nowtime>500) {
    nowtime = millisecond;
    ballSizeRandom = (int)random( 0, 3);
    ballColorRandom = (int)random( 0, 6);
    if (ballUseing[ballSizeRandom][ballColorRandom] == false) {
      ballUseing[ballSizeRandom][ballColorRandom] = true;
      ballY[ballSizeRandom][ballColorRandom] = random(50, 400);
      ballVX[ballSizeRandom][ballColorRandom] = random(5, 10);
      ballVY[ballSizeRandom][ballColorRandom] = random(18, 22);
      ballA[ballSizeRandom][ballColorRandom]= random(0.6, 1);
    }
  }
}

void drawBall() {
  for (int i=0; i<3; i++) {
    for (int j=0; j<6; j++) {
      if (ballUseing[i][j] == true) {
        image(ball[i][j], ballX[i][j], ballY[i][j]);
        if (j%2 == 0) {
          ballX[i][j]+=ballVX[i][j];
        } else ballX[i][j]-=ballVX[i][j];
        ballY[i][j]+=ballVY[i][j];
        ballVY[i][j]+=ballA[i][j];
      }
      if (ballY[i][j]>640-ballSize[i]) {
        ballVY[i][j]*=-1;
      }
      if (j%2 == 0) {
        if (ballX[i][j]>W) {
          ballUseing[i][j] = false;
          ballX[i][j] = -250;
        }
      } else {
        if (ballX[i][j]<-250) {
          ballUseing[i][j] = false;
          ballX[i][j] = 1028;
        }
      }
    }
  }
}

void LiveMonster(){
  for (int i=0; i<3; i++) {
    for (int j=0; j<6; j++) {
      if(monsterLive == true && dist(ballX[i][j]+ballSize[i]/2, ballY[i][j]+ballSize[i]/2,  monsterX+monsterW/2,  monsterY+monsterH/2) <= ballLowY[i]/2){
        monsterLive = false;
        composer.close();
        chop.play();
        for (int k=0; k<16; k++) {
          dieX[k] = monsterX+monsterW/2;
          dieY[k] = monsterY+monsterH-100;
        }
      }
    }
  }
}

void timeRandom(){
  if( millisecond%5==0 ){
    TimeFrontColor = (int)random(0, 6);
  }
}

float TimeX = 50;
float TimeCount = 0;
float Delay = 0;
boolean T = false;
void TimeLine() {   //timeDisplay
  
  font =createFont("Segoe Script", 16, true);
  textFont(font, 40);
  fill(54, 17, 3); 

  image(TimeFrontImg[TimeFrontColor], TimeX-1280, 0);
  image(TimeImg[TimeColor], TimeX-1280, 0);
  text(TimeCount, TimeX, 50);
  if(monsterLive == true){
    if (TimeX>1280) {
      TimeX=0;
    } else {
      TimeX+=3.5;
      TimeCount+=0.06;
      Delay+=0.06;
    }
  }
}
void fallStar(){
  starTime++;
  if(starUsing == true && starTime == 80){
    starUsing = false;
    starX = random(200, 1080);
    starY = 0;
  }
  if(starTime ==40){
    T=false;
  }
  if(starUsing == false && dist(starX+30, starY+60,  monsterX+monsterW/2,  monsterY+monsterH) <= monsterW/2+30){
    starUsing = true;
    starTime = 0;
    T=true;
  }
  if(starUsing == false){
    image(star, starX, starY);
    if(starY<H-160){
      starY+=20;
    }
  }
}

void setDie(){
  for(int i=0; i<16; i++){
    dieVX[i] = random(-10,10);
    dieVY[i] = random(-10, -5);
    dieVA[i] = random(0.5, 0.8);
  }
}

void dieMonster(){
  for(int i=0; i<16; i++){  
    image(die[i], dieX[i], dieY[i]);
    if(dieY[i] < monsterY+monsterH-30){
      dieX[i]+=dieVX[i];
      dieY[i]+=dieVY[i];
      dieVY[i]+=dieVA[i];
    }
  }
}

void startgame(){
  image(game, 0, -150);
  image(start, W/2-275/2, H/2-80);
}

void showScore(){
  font =createFont("Segoe Script", 16, true);
  textFont(font, 80);
  fill(0, 125, 255); 

  text("Your score: ", W/2-400, H/2);
  text(TimeCount, W/2+50, H/2);
}

void music(){
  minim = new Minim(this);
  composer = minim.loadFile("composer.mp3",2048);
  chop = minim.loadFile("chop.mp3",2048);
}

void setup() {
  size(1280, 720);
  loadimg();
  music();
  floorRandom();
  setMonster();
  setball();
  setDie();
}

void draw() {
  background(background);
  image(floor[floorColor], 0, 0);
  if(clickStart == true){
    fallStar();
    if(monsterLive == true){
      composer.play();
      moveMonster();
      drawMonster();
      ballRandom();
      if (T) {
        floorRandom();
      }
    }
    else{
      dieMonster();
      starTime = 0;
      showScore();
    }
    drawBall();
    timeRandom();
    TimeLine();
    LiveMonster();
  }
  else startgame();
}

void keyPressed() {
  if (keyCode == LEFT) {
    monsterDirection = 0;
  }
  if (keyCode == RIGHT) {
    monsterDirection = 1;
  }

  if (monsterTypeChange == false) {
    monsterTypeChange = true;
    monsterTypes = (int)random( 2, 6);
  }
}

void keyReleased() {
  if (monsterTypeChange == true) {
    monsterTypeChange = false;
  }
  monsterTypes = 0;
}

void mouseClicked() {
  if(dist(W/2, H/2,  mouseX,  mouseY) <= 275/2){
    clickStart = true;
  }
}