float a =  2*PI;
float b =  0;
float x = 0.001 ; //speed
float n = 0.05; //arc kuandu
boolean death = false;

float[] colors = new float[width*height];

int deathTime = 0;

int conditionb = 1;
int conditionc = 1;

int startTimeA, startTimeB, startTimeC;
int endTimeA, endTimeB, endTimeC;
float timeA, timeB, timeC;
float totalTime;

int timeCondA =1;
int timeCondB =1;
int timeCondC =1;

int ranTimeCon = 1;
int ranTime1, ranTime2;

boolean gameStart = false;

PImage beginP;
PImage endP;
PImage gameSS;
PImage player;
PImage notice1;
PImage notice2;
PImage insp1;
PImage insp2;
PImage insp3;

boolean clockwise = true;
int directionTimer = 0;
float directionFlipTime = random(500, 2000);

boolean ins1 = true;
boolean ins2 = true;
boolean ins3 = true;

// sound part
import processing.sound.*;

// noiseLevel = 100;
int env = 20;

AudioIn input;
Amplitude amp;

float volume = 0;
float prevVolume = 0;
float basicV = 0;

float ballXX = 800;
float ballYY = 400;

int hdfw = 200;//huodongbanjin

float s = PI;

boolean ballClockWise = true;


//textbox
import controlP5.*;
ControlP5 cp5;
String saved = "";

PFont f;


//send data
// This code sends one value from Processing to Arduino 
import processing.serial.*;
Serial myPort;
int valueFromArduino;


void setup() {
  //size(1500, 1200); 
  //pixelDensity(displayDensity());
  fullScreen();
  //size(1440, 900);
  ellipseMode(CENTER);
  //frameRate(240);
  rectMode(CENTER);
  textAlign(CENTER);
  beginP = loadImage("hidenowhere.png");
  f = createFont("Helvetica neue", 25);
  endP = loadImage("ending.png");
  gameSS = loadImage("gameSS.png");
  player = loadImage("player.png");
  notice1 = loadImage("notice1.png");
  notice2 = loadImage("notice2.png");
  insp1 = loadImage("ins1.png");
  insp2 = loadImage("ins2.png");
  insp3 = loadImage("ins3.png");
  //sound part
  input = new AudioIn(this, 0);
  input.start();
  amp = new Amplitude(this);
  amp.input(input);
  basicV = amp.analyze()*100+env;

  //textbox
  cp5 = new ControlP5(this);
  cp5.addTextfield("PlayerName").setPosition(761, 528).setSize(300, 60).setAutoClear(false);
  cp5.addBang("Start").setPosition(761, 633).setSize(300, 60);
  //send data
  printArray(Serial.list());
  //myPort = new Serial(this, Serial.list()[9], 9600);
}

void draw() {
  //println(mouseX, mouseY);
  //sound
  volume = amp.analyze()*100 - basicV;
  if (volume>0) {
    println(volume);
  }

  if (gameStart == false) {
    image(beginP, 0, 0);
  } else {
    if (deathTime == 0) {
      if (ins1) {
        image(insp1, 0, 0); 
        if (keyPressed) {
          if (key == 'a' || key == 'A') {
            ins1 = false;
          }
        }
      }
      if ((ins1 ==false) &&(ins2 == true) ) {
        image(insp2, 0, 0);
        if (keyPressed) {
          if (key == 's' || key == 'S') {
            ins2 = false;
          }
        }
      }
      if ((ins1 ==false) &&(ins2 == false) &&(ins3 == true)) {
        image(insp3, 0, 0);
        if (keyPressed) {
          if (key == 'd' || key == 'D') {
            ins3 = false;
          }
        }
      }


      if ((ins1 ==false) &&(ins2 == false) &&(ins3 == false)) {
        //Start Counting
        image(gameSS, 0, 0);

        if (timeCondA == 1) {
          startTimeA = millis();
          timeCondA = 2;
        }

        if (timeCondA == 2) {    

          cycle();
          if (death == true) {
            background(70);
            deathTime = 1;
            directionTimer = millis();
            s=PI;
            a =  2*PI;
            b =  0;
            x = 0.001 ; //speed
            n = 0.05; //arc kuandu
            endTimeA = millis();
            timeA = (endTimeA - startTimeA);
            image(notice1, 0, 0);
            //myPort.write('1');
          }
          //blinking
          int elapsedTimeA = abs(startTimeA - millis());
          if (elapsedTimeA < 1000) {
            if (elapsedTimeA % 200 < 100) {
              ballXX = hdfw*cos(s)+width/2;
              ballYY = hdfw*sin(s)+height/2;
              fill(255, 80, 80);
              imageMode(CENTER);
              image(player, ballXX, ballYY);
              imageMode(CORNER);
            }
            s = PI;
            a = 0;
          }
        }
      }
    }

    // the second round
    if (deathTime == 1) {
      if (conditionb == 1) {
        death = false;
        noStroke();
        fill(220, 220, 220);
        ellipse(1327, 429, 50, 50);
        if (mouseButton == LEFT&&dist(1327, 429, mouseX, mouseY)<71) {
          background(70);
          conditionb = 2;
        }
      }

      if (conditionb == 2) {
        if (timeCondB == 1) {
          startTimeB = millis(); 
          timeCondB = 2;
        }
        if (timeCondB == 2) {
          cycle();
          if (death == true) {
            background(70);
            deathTime = 2;
            //death=false;
            directionTimer = millis();
            s=PI;
            a =  2*PI;
            b =  0;
            x = 0.001 ; //speed
            n = 0.05; //arc kuandu
            endTimeB = millis();
            timeB = endTimeB - startTimeB;
            //myPort.write('2');
          }
          //blinking
          int elapsedTimeB = abs(startTimeB - millis());
          if (elapsedTimeB < 1000) {
            if (elapsedTimeB % 200 < 100) {
              ballXX = hdfw*cos(s)+width/2;
              ballYY = hdfw*sin(s)+height/2;
              imageMode(CENTER);
              image(player, ballXX, ballYY);
              imageMode(CORNER);
            }
            s = PI;
            a = 0;
          }
        }
      }
    }



    //the third round
    if (deathTime == 2) {
      if (conditionc == 1) {
        background(70);
        image(notice2, 0, 0);
        fill(0);
        textFont(f);
        text(saved, 1010, 279);
        death = false;
        if (mouseButton == LEFT&&dist(1298, 727, mouseX, mouseY)<30) {
          background(70);
          conditionc = 2;
        }
      }
      if (conditionc == 2) {
        if (timeCondC == 1) {
          startTimeC = millis(); 
          timeCondC = 2;
          s=PI;
        }
        if (timeCondC == 2) {
          cycle();
          if (death == true) {
            deathTime = 3;
            background(70);
            endTimeC = millis();
            timeC = endTimeC - startTimeC;
            //myPort.write('3');
          }
          //blinking
          int elapsedTimeC = abs(startTimeC - millis());
          if (elapsedTimeC < 1000) {
            if (elapsedTimeC % 200 < 100) {
              ballXX = hdfw*cos(s)+width/2;
              ballYY = hdfw*sin(s)+height/2;
              imageMode(CENTER);
              image(player, ballXX, ballYY);
              imageMode(CORNER);
            }
            s = PI;
            a = 0;
          }
        }
      }
    }

    //final display
    if (deathTime == 3) {
      image(endP, 0, 0);
      totalTime = timeA+timeB+timeC;
      textSize(20);
      fill(0);
      textFont(f);
      text(saved, 755, 340);
      textSize(50);
      fill(255);
      text(totalTime/1000, 662, 640);
    }
  }

  fill(255);
}


void keyPressed() {
  if (key == 32) {
    ballClockWise = !ballClockWise;
  }
}

void Start() {
  saved = cp5.get(Textfield.class, "PlayerName").getText();
  cp5.dispose();
  gameStart = true;
}
