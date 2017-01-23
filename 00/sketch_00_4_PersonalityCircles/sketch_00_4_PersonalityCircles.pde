// Personality Circles
// known issues:
// -- pacman does a weird rotation when switching from -x to x movement
//    (issue with implementation of atan)

IntList xHist, yHist;
FloatList tHist;
float theta;
float theta2;

int diam = 65;
int buffSize = 20;
int offset = 60;

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
  
  // distance between pacman and mouse
  float dist = PVector.dist(v1, v2);
  
  // shape 1 - scale
  int sRs = 15;
  int s1r = sRs * 1;
  float s1a = 0;
  float s1oy = map(dist, 0, 50, 50, 150) * sin(frameCount / 100.0);
  float s1x =  mouseX - xDelt - cos(tAvg + s1a) * offset; 
  float s1y = mouseY - yDelt - sin(tAvg + s1a) * offset + s1oy;
  fill(255);
  ellipse(s1x, s1y, s1r, s1r);
  
  // shape 2 - jitter
  int s2r = sRs * 2;
  float s2a = 0.333 * (2 * PI);
  float rand = map(dist, 0, 50, 2, 15);
  float s2ox = random(-rand, rand);
  float s2oy = random(-rand, rand);
  float s2x =  mouseX - xDelt - cos(tAvg + s2a) * offset + s2ox; 
  float s2y = mouseY - yDelt - sin(tAvg + s2a) * offset + s2oy;
  fill(255);
  ellipse(s2x, s2y, s2r, s2r);
  
  // shape 3 - scale
  float s3r = sRs * map(dist, 0, 50, 3, 4.5) * abs(sin(frameCount / 17.0)) + 3;
  float s3a = 0.666 * (2 * PI);
  float s3x =  mouseX - xDelt - cos(tAvg + s3a) * offset; 
  float s3y = mouseY - yDelt - sin(tAvg + s3a) * offset;
  fill(255);
  ellipse(s3x, s3y, s3r, s3r);

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