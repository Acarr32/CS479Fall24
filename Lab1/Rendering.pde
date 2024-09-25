
void drawUI(String title, ArrayList<bioData> data) {
  
  //Set black background
  background(0,0,0);
  
  drawHeader(title);
  
  drawMetrics(data);
  
  drawGraph(data);
  
  drawStaticKey();
}

void drawHeader(String title){
  //Make Header Background
  fill(50);
  rect(0,0, width, height/ 8);
  
  textAlign(CENTER, CENTER);
  textSize(32);
  text(title, width / 2, height / 2); // Print the centered string
}

void drawMetrics(ArrayList<bioData> data){
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
  text("Bad Data Reads : ", width * 2/3 + 20, height/4  + 4*metricSpace - metricsPadding);
  
  textSize(15);
  //Add disclaimer text
  
  text("* = Indicates average of the last 10 read values", width * 2/3 + 30, height/4 + 4.5*metricSpace - metricsPadding);
  
  
  //Render and populate metrics
  bioData metrics = getMetrics(data); 
  
  bioData test = new bioData(0.0, 0.0, 0.0, 0);
  
  fill(255,255,255);
  text(df.format(test.confidence), width * 2/3 + 260, height/4 + 2*metricSpace - metricsPadding);
  text(df.format(test.oxygen), width * 2/3 + 260, height/4 + 3*metricSpace - metricsPadding);
  text(test.status, width * 2/3 + 140, height/4  + 4*metricSpace - metricsPadding);
  
  
  //fill(getZone(metrics.heartRate));
  text(df.format(test.heartRate), width * 2/3 + 260, height/4 + metricSpace - metricsPadding);
}

void drawGraph(ArrayList<bioData> data){
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
