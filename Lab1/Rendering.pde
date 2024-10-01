boolean calmingDone = false;
void drawUI(String title) {
  
  //Set black background
  background(0,0,0);
  
  drawHeader(title);
  
  drawGraph();
  
  drawStaticKey();
  
  drawMetrics();
}

void drawHeader(String title){
  //Make Header Background
  fill(50);
  rect(0,0, width, height/ 8);
  
  textAlign(CENTER, CENTER);
  textSize(32);
  text(title, width / 2, height / 2); // Print the centered string
}

void drawMetrics(){
  //Render section background
  fill(51);
  
  // Draw the rectangle for the section background
  //rectMode(CORNER);  // Ensure we're using CORNER mode
  rect(width * 2/3, height-700, width/3, height/2);
  // Set the fill color for the text (white)
  fill(255);
  
  // Add section header with appropriate text size
  textSize(50);
  text("Metrics", width * 2/3 + 200, height-670);
  
  //Add metric titles
  
  int metricSpace = 70;
  int metricsPadding = 50;
  
  textSize(35);
  
  text("Heart Rate* : " + heartrate, width * 3/4 + 40, height/10 + metricSpace - metricsPadding);
  text("Confidence* : " + confidence, width * 3/4 + 40, height/10 + 2*metricSpace - metricsPadding);
  text("Oxygen* : " + oxygen, width * 3/4 + 40, height/10 + 3*metricSpace - metricsPadding);
  text("Bad Data Reads : ", width * 3/4 + 50, height/10  + 4*metricSpace - metricsPadding);
  
  textSize(15);
  //Add disclaimer text
  
  text("* = Indicates average of the last 10 read values"+activity_level, width * 3/4 + 80, height/10 + 4.5*metricSpace - metricsPadding);
  
}


void drawGraph() {
  background(255); // White background
  
  fill(200,230,200);
  rect(width / 2 - 150, 20, 300, 100);
  fill(0);
  text("Home", width / 2 - 150, 20, 300, 100);
  
  // Set up graph dimensions
  int graphWidth = width - 500;  // Leave some space for margins
  int graphHeight = height - 100;
  int xOffset = 50;  // Left margin
  int yOffset = 50;  // Top margin

  // Draw the axis
  stroke(0);  // Set stroke color to black
  line(xOffset, yOffset, xOffset, graphHeight + yOffset);  // Y-axis
  line(xOffset, graphHeight + yOffset, graphWidth + xOffset, graphHeight + yOffset);  // X-axis
  
  // Label the Y-axis with heart rate values
  fill(0);  // Set text color to black
  textSize(12);  // Set text size
  int maxHeartRate = 200;  // You can adjust this depending on the expected range of heart rate values
  int minHeartRate = 50;   // Minimum expected heart rate
  
  // Number of Y-axis labels you want
  int numLabels = 10;
  for (int i = 0; i <= numLabels; i++) {
    // Calculate the value to label
    int heartRateLabel = int(map(i, 0, numLabels, minHeartRate, maxHeartRate));
    
    // Map the position of the label to the Y-axis
    float y = map(heartRateLabel, minHeartRate, maxHeartRate, graphHeight + yOffset, yOffset);
    
    // Draw the label
    text(heartRateLabel, xOffset - 30, y + 5);  // Offset to the left of the Y-axis for visibility
    line(xOffset - 5, y, xOffset, y);  // Draw tick marks on the Y-axis
  }

  // Draw X-axis labels (e.g., time or sample index)
  textSize(12);  // Set text size for X-axis labels
  int xLabelCount = 5; // Number of labels
  for (int i = 0; i <= xLabelCount; i++) {
    float x = map(i, 0, xLabelCount, xOffset, graphWidth + xOffset);
  }

  // Label for Y-axis
  fill(0);
  textSize(16);
  textAlign(CENTER, CENTER);
  pushMatrix(); // Save the current transformation matrix
  translate(xOffset - 40, graphHeight / 2 + yOffset); // Position the Y-axis label
  rotate(-HALF_PI); // Rotate for vertical label
  text("Heart Rate (bpm)", 0, 0);
  popMatrix(); // Restore the previous transformation matrix

  // Label for X-axis
  fill(0);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Time", width / 2, graphHeight + yOffset + 35); // Position the X-axis label

  // Set the fill color based on activity_level
  if(activity_level.equals("MAXIMUM")){
      fill(230, 30, 30, 100);  // Red with some transparency
  } else if(activity_level.equals("HARD")){
      fill(186, 142, 35, 100);  // Brownish color
  } else if(activity_level.equals("MODERATE")){
      fill(30, 220, 30, 100);  // Green
  } else if(activity_level.equals("LIGHT")){
      fill(30, 30, 220, 100);  // Blue
  } else{
      fill(60, 60, 60, 100);  // Gray
  }

  noStroke();  // Turn off stroke for the filled area

  // Draw the area under the line
  if (data.size() > 1) {
    beginShape();
    vertex(xOffset, graphHeight + yOffset);  // Start at the bottom left of the graph
    
    for (int i = 0; i < data.size(); i++) {
      ArrayList<Integer> currentPoint = data.get(i);

      // Extract heart rate values (assumed to be the first element in each sublist)
      int currentHeartRate = currentPoint.get(0);

      // Map the data to the graph dimensions
      float x = map(i, 0, data.size() - 1, xOffset, graphWidth + xOffset);
      float y = map(currentHeartRate, minHeartRate, maxHeartRate, graphHeight + yOffset, yOffset);

      // Add the vertex for the current point
      vertex(x, y);
    }
    
    // Complete the shape by connecting to the bottom right of the graph
    vertex(graphWidth + xOffset, graphHeight + yOffset);
    endShape(CLOSE);  // Close the shape to fill the area under the line
  } else {
    println("Not enough data to plot");
  }

  // Now draw the line graph on top of the filled area
  stroke(0);  // Set stroke back to black or any desired color for the line
  noFill();   // Don't fill the line graph itself
  if (data.size() > 1) {
    for (int i = 0; i < data.size() - 1; i++) {
      ArrayList<Integer> currentPoint = data.get(i);
      ArrayList<Integer> nextPoint = data.get(i + 1);

      // Extract heart rate values (assumed to be the first element in each sublist)
      int currentHeartRate = currentPoint.get(0);
      int nextHeartRate = nextPoint.get(0);

      // Map the data to the graph dimensions
      float x1 = map(i, 0, data.size() - 1, xOffset, graphWidth + xOffset);
      float x2 = map(i + 1, 0, data.size() - 1, xOffset, graphWidth + xOffset);
      float y1 = map(currentHeartRate, minHeartRate, maxHeartRate, graphHeight + yOffset, yOffset);
      float y2 = map(nextHeartRate, minHeartRate, maxHeartRate, graphHeight + yOffset, yOffset);

      // Draw the line between two points
      line(x1, y1, x2, y2);
    }
  }
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
  text("Key", width * 4/5, height* 4.8/8 + heightBuffer);
  
  
  int keySpace = 60;
  
  //Add key indexes
  
  
  textSize(30);
  //Red
  fill(255,0,0);
  rect(width * 2/3 + 10 + widthBuffer, height * 5/8 + 3 * heightBuffer, keySize , keySize);
  text("Maximum (90-100%)", width * 4/5 + 50 + widthBuffer, height * 5/8 +  textBuffer);
  
  
  //Yellow
  fill(255, 255, 0);
  rect(width * 2/3 + 10 + widthBuffer, height * 5/8 + 3 * heightBuffer + keySpace, keySize , keySize);
  text("Hard (80-90%)", width * 4/5 + 50 + widthBuffer, height * 5/8 +  textBuffer + keySpace);
  
  //Green
  fill(0, 255, 0);
  rect(width * 2/3 + 10 + widthBuffer, height * 5/8 + 3 * heightBuffer + 2 * keySpace, keySize , keySize);
  text("Moderate (70-80%)", width * 4/5 + 50 + widthBuffer, height * 5/8 +  textBuffer + 2*keySpace);

  //Blue
  fill(137,207,240);
  rect(width * 2/3 + 10 + widthBuffer, height * 5/8 + 3 * heightBuffer + 3 * keySpace, keySize , keySize);
  text("Light (60-70%)", width * 4/5 + 50 + widthBuffer, height * 5/8 +  textBuffer + 3*keySpace);

  
  //Gray
  fill(140);
  rect(width * 2/3 + 10 + widthBuffer, height * 5/8 + 3 * heightBuffer + 4 * keySpace, keySize , keySize);
  text("Very Light (50-60%)", width * 2/3 + 50 + widthBuffer, height * 5/8 +  textBuffer + 4*keySpace);

}
