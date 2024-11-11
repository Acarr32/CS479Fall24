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
  //System.out.print("function hit: ");
  //System.out.print(currMF);
  //System.out.print(" ");
  //System.out.print(currLF); //<>// //<>// //<>//
  //System.out.print(" ");
  //System.out.print(currMM);
  //System.out.print(" ");
  //System.out.println(currHeel);
  drawBubble(footX + (0.407103825137 * footImg.width), footY + (0.226218097448 * footImg.height), cMF);
  drawBubble(footX + (0.781420765027 * footImg.width), footY + (0.330626450116 * footImg.height), cLF);
  drawBubble(footX + (0.286885245902 * footImg.width), footY + (0.430394431555 * footImg.height), cMM);
  drawBubble(footX + (0.510928961749 * footImg.width), footY + (0.857308584687 * footImg.height), cHeel); //<>//
}
 //<>// //<>//
void drawBubble(float x, float y, float reading){
  float minSize = 30;
  float maxSize = 200;
  
  float percentMax = reading/MAX_FORCE_READING;
  
  float size = (percentMax * (maxSize - minSize)) + minSize;
  
  float colorScale = map(reading, 0, MAX_FORCE_READING, 0, 255);
  
  
  fill(color(colorScale, 255-colorScale, colorScale/5));
  
  circle(x,y, size);
  
}
