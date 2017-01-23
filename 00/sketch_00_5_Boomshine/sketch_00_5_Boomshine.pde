
ArrayList<Circle> circles = new ArrayList<Circle>();
ArrayList<Circle> grownCircles = new ArrayList<Circle>();
boolean incited;

void setup() {
  size(800, 800);
  frameRate(30);
  //blendMode(ADD);
}

void draw() { 
  if (frameCount == 0) {
    start();
  }
  
  background(255/2);
  
  for (int i = 0; i < circles.size(); i++) {
    // update each circle
    Circle thisCircle = circles.get(i);
    thisCircle.update();
    for (int j = 0; j < grownCircles.size(); j++) {
      // check for collisions with each circle that's grown
      Circle otherCircle = grownCircles.get(j);
      thisCircle.chkColl(j, otherCircle);
    }
  }
  
  for (int k = 1; k < (grownCircles.size() - 1); k++) {
    grownCircles.get(k).update();
  }
  
  if (grownCircles.size() > 0) {
    grownCircles.get(0).update();
  }
  
  int reset = 30 * 12;
  if (frameCount % reset == reset - 1) {
    reset();
  }  
} 

void start() {
  println("currentFrame", frameCount);
  incited = false;
  println(circles.size(), grownCircles.size());
  int count = 20;
  for (int c = 0; c < count; c++) {
    circles.add(new Circle());
  }
  println(circles.size(), grownCircles.size());
}

void reset() {
  println("reset!");
  circles.clear();
  grownCircles.clear();
  start();
}
 
class Circle { 
  PVector p;
  float r, s, d;
  color f;
  boolean v, grow;
  
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
    println("red", r);
    float g = random(fMin, fMax);
    float b = random(fMin, fMax);
    f = color(r, g, b, opac);
    v = true; // visible
    grow = false;
    println(red(f), green(f), red(f));
  } 
  
  // mouse
  Circle (boolean g, int x, int y) {  
    p = new PVector(x, y);
    r = 10;
    s = 0;
    d = 0;
    int opac = 200;
    f = color(255, opac);
    v = true; // visible
    grow = true;
  } 
  
  void update() { 
    p.x += s * cos(d);
    p.y += s * sin(d);
    
    if (p.y > height - r || p.y < r || p.x > width - r || p.x < r) { 
      flip();
    } 
    noStroke();
    fill(f);
    ellipseMode(CENTER);
    ellipse(p.x, p.y, r * 2, r * 2);
    
    int rMax = 70;
    float rGrowRate = 0.5;
    if (grow && r < rMax) {
      r += rGrowRate;
    }
  } 
  
  void flip() {
    d += HALF_PI;
  }
  
  void chkColl(int i, Circle other) {
    float dist = PVector.dist(p, other.p);
    if (grow == false && dist < (r + other.r)) {
      //flip();
      //other.flip();
      grow = true;
      s = 0;
      grownCircles.add(this);
      //circles.remove(this);
      //grownCircles.add(new Circle(true, (int)p.x, (int)p.y));
    }
  }
}

void mouseClicked() {
  if (!incited) {
    println("go!");
    incited = true;
    grownCircles.add(new Circle(true, mouseX, mouseY));
  }
}