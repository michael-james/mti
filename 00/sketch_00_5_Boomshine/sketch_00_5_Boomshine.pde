
ArrayList<Circle> circles = new ArrayList<Circle>();

void setup() 
{
  size(800, 800);
  frameRate(30);
  
  int count = 30;
  for (int c = 0; c < count; c++) {
    circles.add(new Circle());
  }
}

void draw() { 
  background(0);
  
  for (int i = 0; i < circles.size(); i++) {
    circles.get(i).update();
  }
} 
 
class Circle { 
  PVector pos;
  float radius, speed, direction;
  color fill;
  Circle () {  
    pos = new PVector(random(width), random(height));
    //radius = random(20, 25);
    radius = random(30, 45);
    speed = random(1,4);
    direction = radians(random(0, 360));
    int fMin = 75;
    int fMax = 255;
    int opac = 175;
    fill = color(random(fMin, fMax), random(fMin, fMax), random(fMin, fMax), opac);
  } 
  void update() { 
    pos.x += speed * cos(direction);
    pos.y += speed * sin(direction);
    
    if (pos.y > height || pos.y < 0 || pos.x > width || pos.x < 0) { 
      direction += HALF_PI; 
    } 
    noStroke();
    fill(fill);
    ellipse(pos.x, pos.y, radius, radius); 
  } 
  
  void checkCollision() {
    //PVector.dist
  }
} 