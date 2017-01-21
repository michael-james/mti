
IntList xHist, yHist;
FloatList tHist;
float theta;
float theta2;

void setup() {
  size(800, 800);
  xHist = new IntList();
  yHist = new IntList();
  tHist = new FloatList();
  xHist.append(width/2);
  yHist.append(height/2);
  tHist.append(0);
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
  float tSum = 0;
  int len = xHist.size();
  for (int i = 0; i < xHist.size(); i++) {
    xSum += xHist.get(i);
    ySum += yHist.get(i);
    
  }
  for (int i = 0; i < tHist.size(); i++) {
    tSum += tHist.get(i);
  }
  float xAvg = 1.0 * xSum / len;
  float yAvg = 1.0 * ySum / len;
  float tAvg = 1.0 * tSum / tHist.size();
  //println(xSum, xAvg);
  println(tSum, tHist.size(), tAvg);
  
  //pushMatrix();
  //translate(width/2, height/2);
  //translate(xAvg, yAvg);
  
  PVector v1 = new PVector(xAvg, yAvg);
  PVector v2 = new PVector(mouseX, mouseY);
  //PVector v2 = new PVector(0, 0);
  float a = PVector.angleBetween(v1, v2);
  float xDelt = v2.x - v1.x;
  float yDelt = v2.y - v1.y;
  
  //if (xDelt != 0.0) {
  //  theta = atan(yDelt/xDelt);
  //}
  
  if (xDelt > 0.0) {
    theta = atan(yDelt/xDelt);
    //theta2 = atan2(v1.y, v1.x);
  }
  else {
    if (xDelt < 0.0) {
      theta = atan(yDelt/xDelt) + PI;
    }
  }
  println(xDelt, degrees(theta));
  println(degrees(theta2));
  
  float dist = PVector.dist(v1, v2);
  angle = map(dist, 0, 75, 0, 1) * angle;
  float limit = 0.9 * HALF_PI;
  if (angle > limit) {
    angle = limit;
  }
  //println(degrees(angle));
  
  //println(adj, opp, degrees(theta));
  float xPos =  mouseX - xDelt - cos(tAvg) * offset; 
  float yPos = mouseY - yDelt - sin(tAvg) * offset;
  arc(xPos, yPos, diam, diam, tAvg + angle, tAvg + 2 * PI - angle, PIE);
  stroke(255, 0, 0);
  //line(0, 0, mouseX, mouseY);
  noStroke();
  //popMatrix();
  
  fill(255);
  ellipseMode(CENTER);
  //ellipse(xHist.get(0), yHist.get(0), 2, 2);
  
  stroke(255);
  //line(v1.x, v1.y, v2.x, v2.y);
  
  //text(degrees(tAvg), 10, 20);
  
  int buffSize = 20;
  xHist.append(mouseX);
  yHist.append(mouseY);
  tHist.append(theta);
  if (xHist.size() >= buffSize) {
    xHist.remove(0);
    yHist.remove(0);
  }
  if (tHist.size() >= 20) {
    tHist.remove(0);
  }
}