
void drawUI() {
  
  //Set black background
  background(0,0,0);

  
  renderHeader();
  
  renderMetrics();
  
  renderKey();
}

void renderHeader(){
  String title = "CS/BME 479 Lab 1";
  
  //Make Header Background
  fill(51);
  rect(0,0, width, height/ 8);
  
  //Make header title
   textSize(80);
   fill(255,255,255);
   text(title, width/4.7, height / 8 - 20);
}

void renderMetrics(){
  //Render section background
  fill(51);
  rect(width * 2/3, height/8, width/3, height * 4/8);
  
  //Add section header
  fill(255,255,255);
  textSize(50);
  text("Metrics", width * 2/3 + 100, height/8 + 60);
  
  //Add metric titles
  
  int metricSpace = 70;
  int metricsPadding = 50;
  
  text("Thing 1 : ", width * 2/3 + 20, height/4 + metricSpace - metricsPadding);
  text("Thing 2 : ", width * 2/3 + 20, height/4 + 2*metricSpace - metricsPadding);
  text("Thing 3 : ", width * 2/3 + 20, height/4 + 3*metricSpace - metricsPadding);
  text("Thing 4 : ", width * 2/3 + 20, height/4  + 4*metricSpace - metricsPadding);
  
  
  //Render and populate metrics
  
}

void renderKey(){
  //Render section background
  int bgColor = 51;
  
  fill(bgColor);
  rect(width * 2/3, height* 5/8, width/3, height * 3/8);
  
  //Add section header
  fill(255,255,255);
  textSize(50);
  text("Key", width * 2/3 + 100, height* 5/8 + 60);
  
}
