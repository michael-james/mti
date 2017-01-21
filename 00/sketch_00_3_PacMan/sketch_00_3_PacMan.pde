
IntList xHist, yHist, tHist;
float theta;
float theta2;

void setup() {
  size(800, 800);
  xHist = new IntList();
  yHist = new IntList();
  xHist.append(width/2);
  yHist.append(height/2);
  yHist = new IntList();
}

void draw() {
  background(0);
  noStroke();
  fill(255, 255, 0);
  int diam = 65; 
  int offset = diam / 2;
  float angle = abs(sin(frameCount / 4.0)) * QUARTER_PI;
    
  int xSum = 0;
  int ySum = 0;
  for (int i = 0; i < xHist.size(); i++) {
    xSum += xHist.get(i);
    ySum += yHist.get(i);
  }
  float xAvg = xSum / xHist.size() * 1.0;
  float yAvg = ySum / yHist.size() * 1.0;
  //println(xSum, xAvg);
  
  //pushMatrix();
  //translate(width/2, height/2);
  //translate(xAvg, yAvg);
  
  PVector v1 = new PVector(xAvg, yAvg);
  PVector v2 = new PVector(mouseX, mouseY);
  //PVector v2 = new PVector(0, 0);
  float a = PVector.angleBetween(v1, v2);
  float xDelt = v2.x - v1.x;
  float yDelt = v2.y - v1.y;
  
  if (xDelt > 0.0) {
    theta = atan(yDelt/xDelt);
    //theta2 = atan2(v1.y, v1.x);
  }
  else {
    if (xDelt < 0.0) {
      theta = atan(yDelt/xDelt) + PI;
    }
  }
  //println(xDelt, degrees(theta));
  //println(degrees(theta2));
  
  float dist = PVector.dist(v1, v2);
  angle = map(dist, 0, 75, 0, 1) * angle;
  float limit = 0.9 * HALF_PI;
  if (angle > limit) {
    angle = limit;
  }
  println(degrees(angle));
  
  //println(adj, opp, degrees(theta));
  arc(mouseX - xDelt - cos(theta) * offset , mouseY - yDelt - sin(theta) * offset, diam, diam, theta + angle, theta + 2 * PI - angle, PIE);
  stroke(255, 0, 0);
  //line(0, 0, mouseX, mouseY);
  noStroke();
  //popMatrix();
  
  fill(255);
  ellipseMode(CENTER);
  //ellipse(xHist.get(0), yHist.get(0), 2, 2);
  
  stroke(255);
  //line(v1.x, v1.y, v2.x, v2.y);
  
  text(degrees(theta), 10, 20);
  
  int buffSize = 20;
  xHist.append(mouseX);
  yHist.append(mouseY);
  if (xHist.size() >= buffSize) {
    xHist.remove(0);
    yHist.remove(0);
  }
}