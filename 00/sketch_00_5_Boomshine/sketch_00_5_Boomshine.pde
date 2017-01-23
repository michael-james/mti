
ArrayList<Circle> circles = new ArrayList<Circle>();
ArrayList<Circle> grownCircles = new ArrayList<Circle>();

void setup() 
{
  size(800, 800);
  frameRate(30);
  
  int count = 20;
  for (int c = 0; c < count; c++) {
    circles.add(new Circle());
  }
  
  grownCircles.add(new Circle(true, width/2, height/2));
}

void draw() { 
  background(0);
  
  for (int i = 0; i < circles.size(); i++) {
    Circle thisCircle = circles.get(i);
    thisCircle.update();
    for (int j = 0; j < grownCircles.size(); j++) {
      Circle otherCircle = grownCircles.get(j);
      thisCircle.chkColl(otherCircle);
    }
  }
  
  for (int k = 0; k < grownCircles.size(); k++) {
    grownCircles.get(k).update();
  }
} 
 
class Circle { 
  PVector p;
  float r, s, d;
  color f;
  boolean grow;
  
  // default
  Circle () {  
    p = new PVector(random(width), random(height));
    r = random(15, 23);
    s = random(1,4);
    d = radians(random(0, 360));
    int fMin = 75;
    int fMax = 255;
    int opac = 175;
    f = color(random(fMin, fMax), random(fMin, fMax), random(fMin, fMax), opac);
    grow = false;
  } 
  
  // mouse
  Circle (boolean g, int x, int y) {  
    p = new PVector(x, y);
    r = 10;
    s = 0;
    d = 0;
    int opac = 175;
    f = color(255, opac);
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
  
  void chkColl(Circle other) {
    float dist = PVector.dist(p, other.p);
    if (dist < (r + other.r)) {
      println("collision!");
      //flip();
      //other.flip();
      grow = true;
      s = 0;
      //grownCircles.add(this);
      //circles.remove(this);
    }
  }
} 

void mouseClicked() {
  println("go!");
  //grownCircles.add(new Circle(true, mouseX, mouseY));
}