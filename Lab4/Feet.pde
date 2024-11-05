void drawFootBase(){
  foot.display(); 
}

void initializeFoot() {
  footImg = loadImage("FootBase.png");
  footX = graphWidth * 2 + (width - columnWidth - graphWidth * 2 - footImg.width) / 2;
  footY =  (height - footImg.height) / 2;
  
  foot = new Foot (footImg, footX, footY);
}


void drawBubbles(){
  drawBubble(footX + (0.407103825137 * footImg.width), footY + (0.226218097448 * footImg.height), 100);
  drawBubble(footX + (0.781420765027 * footImg.width), footY + (0.330626450116 * footImg.height), 200);
  drawBubble(footX + (0.286885245902 * footImg.width), footY + (0.430394431555 * footImg.height), 300);
  drawBubble(footX + (0.510928961749 * footImg.width), footY + (0.857308584687 * footImg.height), 400); //<>//
}

void drawBubble(float x, float y, float reading){
  float minSize = 10;
  float maxSize = 100;
  
  float percentMax = reading/MAX_FORCE_READING;
  
  float size = (percentMax * (maxSize - minSize)) + minSize;
  
  colorMode(HSB, 120);
  
  fill(color(map(reading, 0, MAX_FORCE_READING, 0, 120)));
  
  circle(x,y, size);
  
  colorMode(RGB, 255);
}
