void initializeGraphs(){
}

void drawGraphs(){
}
 //<>//
void drawBubbles(){
}

void drawBubble(float x, float y, float reading){
  float minSize = 30;
  float maxSize = 200;
  
  float size = map(reading, 0, MAX_FORCE_READING, minSize, maxSize);
  
  // Smooth color gradient
  float t = map(reading, 0, MAX_FORCE_READING, 0, 1);
  color startColor = color(0, 0, 255);
  color endColor = color(255, 0, 0);   
  color bubbleColor = lerpColor(startColor, endColor, t);
  
  // Set the fill color and draw the circle
  fill(bubbleColor);
  noStroke();
  
  circle(x,y, size);
  
}
