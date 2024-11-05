void drawFootBase(){
  img = loadImage("FootBase.png");
  
  float x = graphWidth * 2 + (width - columnWidth - graphWidth * 2 - img.width) / 2;
  float y = (height - img.height) / 2;
  
  image(img, x, y); 
}

boolean drawBubbles(float MF, float LF, float MM, float Heel){
  boolean complete = false;
  
  return complete;
}
