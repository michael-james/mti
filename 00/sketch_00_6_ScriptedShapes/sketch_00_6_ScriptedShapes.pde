// Scripted Shapes

Shape s1, s2;
float grndThrsh;
boolean go;

void setup() {
  size(500, 300);
  
  grndThrsh = height / 3.0 * 2.0;
  go = false;
  
  s1 = new Shape(width * 0.3, height * -0.2, 35);
  int s2r = 15;
  s2 = new Shape(width + s2r, grndThrsh - s2r, s2r);
}

void draw() {
  control();
  
  background(0);
  noStroke();
  
  // ground
  fill(60, 0, 200);
  rectMode(CORNER);
  rect(0, height * 2/3.0, width, height/3.0);
  
  // shape 1  
  fill(s1.clr);
  rectMode(CENTER);
  rect(s1.pos.x, s1.pos.y, s1.rad * 2, s1.rad * 2);
  
  // shape 2
  fill(s2.clr);
  ellipseMode(CENTER);
  ellipse(s2.pos.x, s2.pos.y, s2.rad * 2, s2.rad * 2);
}

void control() {
  float dist = PVector.dist(s1.pos, s2.pos) - s1.rad - s2.rad;
  float alpha = 15;
  float s1rt = 2.0;
  float s2rt = 0.3;
  if (go) {
    if (s1.pos.y + s1.rad < grndThrsh) {
      s1.pos.y += s1rt;
    }
    else {
      if (dist > alpha && s2.pos.x > -0.5 * width) {
        s2.pos.x -= s2rt;
      }
      else {
        s2.clr = color(255, 0, 0);
      }
    }
    float shakeThresh = width * 0.75;
    if (s2.pos.x < shakeThresh) {
      float rand = map(dist, width/2, 0, 0, 5); // random magnitiude
      float s1ox = random(-rand, rand); // random x offset
      float s1oy = random(-rand, rand); // random y offset
      s1.pos.x += s1ox;
      s1.pos.y += s1oy;
    }
  }
}

class Shape {
  PVector pos;
  int rad;
  color clr;
  
  Shape(float x, float y, int r) {
    pos = new PVector(x, y);
    rad = r;
    clr = color(255, 255, 255);
  }
}

void keyPressed() {
  if (key == 'g' || key == 'g') {
    go = true;
  }
}