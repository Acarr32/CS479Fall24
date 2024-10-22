void setup() {
  fullScreen();
  currentState = State.Menu;
  maxTitleSize = height * 0.1; // 10% of the height
  minTitleSize = height * 0.03; // 3% of the height
}

void draw() {
  background(255);
  drawMenu();
}
