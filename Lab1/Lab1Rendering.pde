
void drawUI() {
  
  //Set black background
  background(0,0,0);

  
  renderHeader();
  
  renderMetrics();
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
  rect(width * 2/3, height/8, width/3, height * 7/8);
  
  //Add section header
  fill(255,255,255);
  textSize(50);
  text("Metrics", width * 2/3 + 100, height/8 + 60);
  
  //Add metric titles
  
  //Render and populate metrics
  
  //Summary option?
  
}
