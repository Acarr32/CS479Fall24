void setup() {
  size(1024, 900);
  
  boolean showPorts = false;
  
  showPortData(showPorts);
  
  myPort = new Serial(this, Serial.list()[1], 115200);
  
  renderLoadingWindow();
  
  modeI();
  
  modeII();
  
  
}

void draw() {
  SenseStress();
}
