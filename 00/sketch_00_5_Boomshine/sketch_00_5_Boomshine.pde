
ArrayList<Circle> circles = new ArrayList<Circle>();
ArrayList<Circle> grownCircles = new ArrayList<Circle>();

void setup() {
  size(800, 800);
  frameRate(30);
}

void draw() { 
  background(0); // black
  //background(255/2); // gray
  
  // handle each normal circle
  for (int i = 0; i < circles.size(); i++) {
    // update each circle
    Circle thisCircle = circles.get(i);
    thisCircle.update();
    thisCircle.chkColl();
  }
  
  // update each grown circle
  for (int k = 1; k < (grownCircles.size() - 1); k++) {
    grownCircles.get(k).update();
  }
  
  // draw main circle on top
  if (grownCircles.size() > 0) {
    grownCircles.get(0).update();
  }
  
  // reset after time period
  int frameR = 30;
  int resetSeconds = 12;
  int resetFrames = resetSeconds * frameR;
  if (frameCount % resetFrames == resetFrames - 1) {
    reset();
  }  
} 

void start() {  
  int count = 25; // of circles
  for (int c = 0; c < count; c++) {
    circles.add(new Circle());
  }
}

void reset() {
  circles.clear();
  grownCircles.clear();
  start();
}
 
class Circle { 
  PVector p; // position
  float r, s, d; // radius, speed, direction
  color f; // fill color
  boolean grow; // growing?
  
  // default
  Circle () {  
    p = new PVector(random(width), random(height));
    r = random(15, 23);
    s = random(1,4);
    d = radians(random(0, 360));
    int fMin = 100;
    int fMax = 255;
    int opac = 175;
    float r = random(fMin, fMax);
    float g = random(fMin, fMax);
    float b = random(fMin, fMax);
    f = color(r, g, b, opac);
    println(red(f));
    grow = false;
  } 
  
  // mouse
  Circle (boolean g, int x, int y) {  
    p = new PVector(x, y);
    r = 10;
    s = 0;
    d = 0;
    int opac = 200;
    f = color(255, opac);
    grow = true;
  } 
  
  void update() {
    // update position based on speed and direction
    p.x += s * cos(d);
    p.y += s * sin(d);
    
    // if circle collides with window edge, change direction
    if (p.y > height - r || p.y < r || p.x > width - r || p.x < r) { 
      flip();
    } 
    
    // draw circle
    noStroke();
    fill(f);
    ellipseMode(CENTER);
    ellipse(p.x, p.y, r * 2, r * 2);
    
    // increase radius if circle is growing
    int rMax = 70;
    float rGrowRate = 0.7;
    if (grow && r < rMax) {
      r += rGrowRate;
    }
  } 
  
  void flip() {
    // change direction
    d += HALF_PI;
  }
  
  void chkColl() {
    // check for collisions with each circle that's grown
    for (int j = 0; j < grownCircles.size(); j++) {
      Circle otherCircle = grownCircles.get(j);
      float dist = PVector.dist(p, otherCircle.p);
      // if circle is not grown
      if (grow == false && dist < (r + otherCircle.r)) {
        grow = true; // start growing
        s = 0; // stop moving
        grownCircles.add(this); // add to grownCircles list
      }
    }
  }
}

void mouseClicked() {
  // if main circle has not been created yet, make one on click
  if (grownCircles.size() == 0) {
    grownCircles.add(new Circle(true, mouseX, mouseY));
  }
}