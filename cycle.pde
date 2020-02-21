void cycle() {
  image(gameSS, 0, 0);
  textFont(f);
  textSize(25);
  if (deathTime == 0) {
    text("You've survived "+(millis()-startTimeA)/1000+" Seconds", 0.85*width, 0.05*height);
  }
  if (deathTime == 1) {
    text("You've survived "+(millis()-startTimeB+timeA)/1000+" Seconds", 0.85*width, 0.05*height);
  }
  if (deathTime == 2) {
    text("You've survived "+(millis()-startTimeC+timeA+timeB)/1000+" Seconds", 0.85*width, 0.05*height);
  }
  //ray
  fill(150, 0, 0, 90); 

  //game difficulty will rising

  if (deathTime == 0) {
    moveOn();
    shapeAndDetect();
    player();
  }



  if (deathTime == 1) {
    if (millis() - directionTimer > directionFlipTime) {
      if (random(1) < 0.5) {
        clockwise = true;
      } else {
        clockwise = false;
      }
      directionTimer = millis();
      directionFlipTime = random(500, 2000);
    }

    //toTurn = int(random(10));
    if (clockwise) {
      moveOn();
      shapeAndDetect();
      player();
    } else {
      turnBack();
      shapeAndDetect();
      player();
    }
  }





  if (deathTime == 2) {
    if (millis() - directionTimer > directionFlipTime) {
      if (random(1) < 0.5) {
        clockwise = true;
      } else {
        clockwise = false;
      }
      directionTimer = millis();
      directionFlipTime = random(200, 2000);
    }

    //toTurn = int(random(10));
    if (clockwise) {
      moveOn();
      shapeAndDetect();
      player();
    } else {
      turnBack();
      shapeAndDetect();
      player();
    }
  }
}
