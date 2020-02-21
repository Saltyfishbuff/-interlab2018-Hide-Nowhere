

// the player
void player() {
  //sound
  prevVolume = volume;
  volume = amp.analyze()*100 - basicV;
  if (volume>0) {
    if (ballClockWise  == true) {

      s = s+0.001*volume*PI;
      ballXX = hdfw*cos(s)+width/2;
      ballYY = hdfw*sin(s)+height/2;
      fill(255, 80, 80);
      ellipse(ballXX, ballYY, 50, 50);
      imageMode(CENTER);
      image(player, ballXX, ballYY);
      imageMode(CORNER);
    } else {

      s = s-0.001*volume*PI;
      ballXX = hdfw*cos(s)+width/2;
      ballYY = hdfw*sin(s)+height/2;
      fill(80, 80, 80);
      ellipse(ballXX, ballYY, 50, 50);
      imageMode(CENTER);
      image(player, ballXX, ballYY);
      imageMode(CORNER);
    }
  }
}




void fasterAndLarger() {
  int moveOrNot = int(random(3));
  if (moveOrNot != 0) {
    //faster/slower!!!!!!
    float fate = int(random(5));
    if (fate == 1) {
      x = x + 0.00003;
      n = n + 0.0005;
    }
    if (fate == 2) {
      x = x + 0.00006;
      n = n + 0.001;
    }
    if (fate == 3) {
      x = x + 0.00009;
      n = n + 0.0015;
    }
    if (fate == 4) {
      x = x - 0.00006;
      n = n - 0.001;
    }
    if (fate == 5) {
      x = x - 0.00009;
      n = n - 0.0001;
    }
    if (fate == 0) {
      x = x - 0.00003;
      n = n - 0.0005;
    }
  }
}


void turnBack() {
  a = a - x*PI;
  b = a - n*PI;
}

void moveOn() {
  a = a + x*PI;
  b = a + n*PI;
}


void shapeAndDetect() {

  float rrr = 2.5*width;
  float line1X = (rrr) * cos(a);
  float line1Y = (rrr) * sin(a);

  float line2X = (rrr) * cos(b);
  float line2Y = (rrr) * sin(b);

  beginShape();
  vertex(width/2, height/2);
  vertex(line1X, line1Y);
  vertex(line2X, line2Y);
  endShape(CLOSE);

  if (circleLineIntersect(width/2, height/2, line1X, line1Y, ballXX, ballYY, 25) == true) {
    death = true;
  }
  if (circleLineIntersect(width/2, height/2, line2X, line2Y, ballXX, ballYY, 25) == true) {
    death = true;
  }
  fasterAndLarger();
}




// Code adapted from Paul Bourke:
// http://local.wasp.uwa.edu.au/~pbourke/geometry/sphereline/raysphere.c
boolean circleLineIntersect(float x1, float y1, float x2, float y2, float cx, float cy, float cr ) {
  float dx = x2 - x1;
  float dy = y2 - y1;
  float a = dx * dx + dy * dy;
  float b = 2 * (dx * (x1 - cx) + dy * (y1 - cy));
  float c = cx * cx + cy * cy;
  c += x1 * x1 + y1 * y1;
  c -= 2 * (cx * x1 + cy * y1);
  c -= cr * cr;
  float bb4ac = b * b - 4 * a * c;

  //println(bb4ac);

  if (bb4ac < 0) {  // Not intersecting
    return false;
  } else {

    float mu = (-b + sqrt( b*b - 4*a*c )) / (2*a);
    float ix1 = x1 + mu*(dx);
    float iy1 = y1 + mu*(dy);
    mu = (-b - sqrt(b*b - 4*a*c )) / (2*a);
    float ix2 = x1 + mu*(dx);
    float iy2 = y1 + mu*(dy);

    // The intersection points
    //ellipse(ix1, iy1, 10, 10);
    //ellipse(ix2, iy2, 10, 10);

    float testX;
    float testY;
    // Figure out which point is closer to the circle
    if (dist(x1, y1, cx, cy) < dist(x2, y2, cx, cy)) {
      testX = x2;
      testY = y2;
    } else {
      testX = x1;
      testY = y1;
    }

    if (dist(testX, testY, ix1, iy1) < dist(x1, y1, x2, y2) || dist(testX, testY, ix2, iy2) < dist(x1, y1, x2, y2)) {
      return true;
    } else {
      return false;
    }
  }
}
