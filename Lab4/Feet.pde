void drawFootBase(){
  foot.display(); 
}

void initializeFoot() {
  footImg = loadImage("FootBase.png");
  footX = graphWidth * 2 + (width - columnWidth - graphWidth * 2 - footImg.width) / 2;
  footY =  (height - footImg.height) / 2;
  
  foot = new Foot (footImg, footX, footY);
}

boolean drawBubbles(float MF, float LF, float MM, float Heel){
  boolean complete = false;
  
  return complete;
}
