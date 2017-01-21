// Pac Man Chase
// known issues:
// -- pacman does a weird rotation when switching from -x to x movement
//    (issue with implementation of atan)

IntList xHist, yHist;
FloatList tHist;
float theta;
float theta2;

int diam = 65;
int buffSize = 20;

void setup() {
  size(800, 800);
  
  // setup buffers
  xHist = new IntList();
  yHist = new IntList();
  tHist = new FloatList();
  xHist.append(width/2);
  yHist.append(height/2);
  tHist.append(0);
}

void draw() {
  background(0);
  
  // find average of each buffer
  int xSum = 0;
  int ySum = 0;
  float tSum = 0;
  int len = xHist.size();
  for (int i = 0; i < len; i++) {
    xSum += xHist.get(i);
    ySum += yHist.get(i);
    tSum += tHist.get(i); 
  }
  float xAvg = 1.0 * xSum / len;
  float yAvg = 1.0 * ySum / len;
  float tAvg = 1.0 * tSum / len;
  
  // calculate opposite & adjacent sides
  PVector v1 = new PVector(xAvg, yAvg);
  PVector v2 = new PVector(mouseX, mouseY);
  float xDelt = v2.x - v1.x;
  float yDelt = v2.y - v1.y;
  
  // calculate theta adjust to correct quadrant
  if (xDelt > 0.0) {
    theta = atan(yDelt/xDelt);
  }
  else {
    if (xDelt < 0.0) {
      theta = atan(yDelt/xDelt) + PI;
    }
  }
  
  // angle of mouth (half of it)
  float angle = abs(sin(frameCount / 4.0)) * QUARTER_PI;
  // distance between pacman and mouse
  float dist = PVector.dist(v1, v2);
  // map maginitude of angle to distance
  angle = map(dist, 0, 75, 0, 1) * angle;
  // clamp angle so mouth doesn't open too wide
  float limit = 0.9 * HALF_PI;
  if (angle > limit) {
    angle = limit;
  }
  
  // calculate positions so that pacman follows behind and isn't under mouse
  float xPos =  mouseX - xDelt - cos(tAvg) * (diam / 2); 
  float yPos = mouseY - yDelt - sin(tAvg) * (diam / 2);
  // draw pac man
  noStroke();
  fill(255, 255, 0); 
  arc(xPos, yPos, diam, diam, tAvg + angle, tAvg + 2 * PI - angle, PIE);

  // add new values to buffer and remove old
  xHist.append(mouseX);
  yHist.append(mouseY);
  tHist.append(theta);
  if (xHist.size() >= buffSize) {
    xHist.remove(0);
    yHist.remove(0);
    tHist.remove(0);
  }
}