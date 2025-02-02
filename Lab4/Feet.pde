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
  drawBubble(footX + (0.407103825137 * footImg.width), footY + (0.226218097448 * footImg.height), cMF);
  drawBubble(footX + (0.781420765027 * footImg.width), footY + (0.330626450116 * footImg.height), cLF);
  drawBubble(footX + (0.286885245902 * footImg.width), footY + (0.430394431555 * footImg.height), cMM);
  drawBubble(footX + (0.510928961749 * footImg.width), footY + (0.857308584687 * footImg.height), cHeel); //<>// //<>//
}
 //<>// //<>//
void drawBubble(float x, float y, float reading){
  // cMF - red
  fill(color(255, 0, 0));
  circle(footX + (0.407103825137 * footImg.width), footY + (0.226218097448 * footImg.height), 30);
  
  // cLF - yellow
  fill(color(255, 255, 0));
  circle(footX + (0.781420765027 * footImg.width), footY + (0.330626450116 * footImg.height), 30);
  
  // cMM - green
  fill(color(0, 255, 0));
  circle(footX + (0.286885245902 * footImg.width), footY + (0.430394431555 * footImg.height), 30);
  
  // cHeel - blue
  fill(color(0, 0, 255));
  circle(footX + (0.510928961749 * footImg.width), footY + (0.857308584687 * footImg.height), 30);
  
  float minSize = 30;
  float maxSize = 200;
  
  float percentMax = reading/MAX_FORCE_READING;
   //<>//
  float size = (percentMax * (maxSize - minSize)) + minSize;
   //<>//
  float colorScale = map(reading, 0, MAX_FORCE_READING, 0, 255);
  
  
  fill(color(colorScale, 255-colorScale, colorScale/5));
  
  circle(x,y, size);
  
}

void StepCheck(){
  float accSum = (float)Math.pow(currAcc.getX(),2) + (float)Math.pow(currAcc.getY(),2) + (float)Math.pow(currAcc.getZ(),2);
  
  double totalAcc = Math.sqrt(accSum);
  
  if(totalAcc > ACCEL_CONFIDENCE){
    if(!moving){
      moving = true;
      userStatus = "Active";
      stepCount++;
      moveStart = millis();
      if(!firstStep){
        firstStepTime = millis();
        firstStep = true;
      }
    }
    moveDuration = (millis() - moveStart)/1000;
  }
  else{
    if(moving){
      moving = false;
      userStatus = "Stationary";
      moveDuration = 0;
    }
  }
  
  float stepL = float(stepLengthInput);
  
  strideLength = str(2 * stepL * stepCount);
  if(firstStep){
    cadence = str((stepCount * 1000) / (millis() - firstStepTime)); 
  }
  
}
