
void setup() {
  size(360, 360);
  background(0);
}

void draw() {
  int d = 50;
  fill(255, 0, 0);
  stroke(0, 255, 0);
  strokeWeight(10);
  ellipseMode(CENTER);
  ellipse(width/2, width/2, d * 2, d * 2);
}