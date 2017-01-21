
int rows = 10; 
int cols = 20;
int margin = 5;
int diamMin = 10;
int hueMax = 360;
int cellW, cellH;

void setup() {
  size(400, 800);
  background(255);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  
  cellW = width / rows - margin;
  cellH = height / cols - margin;

  for (int i = 0; i < rows * cols; i++) {
    drawCircle(i / 10, i % 10);
  }
}

void drawCircle(int r, int c) {
  // calculate index
  int id = (r * rows) + c;
  
  // calculate diameter
  float diam = map(id, 0, rows * cols - 1, diamMin, cellW);
  
  // calculate hue
  float hue = map(id, 0, rows * cols - 1, 0, hueMax);
  fill(hue, 100, 100);
  
  // draw ellipse
  float half = 0.5;
  ellipse((c + half) * (cellW + margin), (r + half) * (cellH + margin), diam, diam);
}