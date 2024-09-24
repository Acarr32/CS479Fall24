
void drawStaticUI() {
  
  //Set black background
  background(0,0,0);

  
  drawStaticHeader();
  
  drawStaticMetrics();
  
  drawStaticKey();
}

void drawStaticHeader(){
  String title = "CS/BME 479 Lab 1";
  
  //Make Header Background
  fill(50);
  rect(0,0, width, height/ 8);
  
  //Make header title
   textSize(80);
   fill(255,255,255);
   text(title, width/4.7, height / 8 - 20);
}

void drawStaticMetrics(){
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
  
  textSize(35);
  
  text("Heart Rate* : ", width * 2/3 + 20, height/4 + metricSpace - metricsPadding);
  text("Confidence* : ", width * 2/3 + 20, height/4 + 2*metricSpace - metricsPadding);
  text("Oxygen* : ", width * 2/3 + 20, height/4 + 3*metricSpace - metricsPadding);
  text("Current Status : ", width * 2/3 + 20, height/4  + 4*metricSpace - metricsPadding);
  
  textSize(15);
  //Add disclaimer text
  
  text("* = Indicates average of the last 10 read values", width * 2/3 + 30, height/4 + 4.5*metricSpace - metricsPadding);
  
  
  //Render and populate metrics
  
}

void drawStaticKey(){
  //Render section background
  int bgColor = 50;
  int heightBuffer = 10;
  int keySize = 30;
  int textBuffer = 55;
  int widthBuffer = 0;
  
  fill(bgColor);
  rect(width * 2/3, height* 9/16, width/3, height);
  
  //Add section header
  fill(255,255,255);
  textSize(50);
  text("Key", width * 2/3 + 130, height* 5/8 + heightBuffer);
  
  
  int keySpace = 60;
  
  //Add key indexes
  
  
  textSize(30);
  //Red
  fill(255,0,0);
  rect(width * 2/3 + 10 + widthBuffer, height * 5/8 + 3 * heightBuffer, keySize , keySize);
  text("Maximum (90-100%)", width * 2/3 + 50 + widthBuffer, height * 5/8 +  textBuffer);
  
  
  //Yellow
  fill(255, 255, 0);
  rect(width * 2/3 + 10 + widthBuffer, height * 5/8 + 3 * heightBuffer + keySpace, keySize , keySize);
  text("Hard (80-90%)", width * 2/3 + 50 + widthBuffer, height * 5/8 +  textBuffer + keySpace);
  
  //Green
  fill(0, 255, 0);
  rect(width * 2/3 + 10 + widthBuffer, height * 5/8 + 3 * heightBuffer + 2 * keySpace, keySize , keySize);
  text("Moderate (70-80%)", width * 2/3 + 50 + widthBuffer, height * 5/8 +  textBuffer + 2*keySpace);

  //Blue
  fill(137,207,240);
  rect(width * 2/3 + 10 + widthBuffer, height * 5/8 + 3 * heightBuffer + 3 * keySpace, keySize , keySize);
  text("Light (60-70%)", width * 2/3 + 50 + widthBuffer, height * 5/8 +  textBuffer + 3*keySpace);

  
  //Gray
  fill(140);
  rect(width * 2/3 + 10 + widthBuffer, height * 5/8 + 3 * heightBuffer + 4 * keySpace, keySize , keySize);
  text("Very Light (50-60%)", width * 2/3 + 50 + widthBuffer, height * 5/8 +  textBuffer + 4*keySpace);

}

void renderLoadingWindow(){
  JOptionPane.showMessageDialog(null, "The program will stall for a few seconds to give the sensor a few seconds to calibrate.", "WARNING", JOptionPane.ERROR_MESSAGE);
  delay(4000);
}
