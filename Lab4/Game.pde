void drawGame() {
  System.out.println("Game Mode entered");
  background(255);
  
  // Check if 3 seconds have passed since last color change
  if (millis() - lastColorChange >= colorChangeInterval) {
    newTargetColor();  // Change color
    lastColorChange = millis();  // Reset timer
  } else {
    boolean correct = false;
    
    if (cMF > 10 && targetColor == color(255, 0, 0)) {
      correct = true;
    } else if (cLF > 10 && targetColor == color(255, 255, 0)) {
      correct = true;
    } else if (cMM > 10 && targetColor == color(0, 255, 0)) {
      correct = true;
    } else if (cHeel > 10 && targetColor == color(0, 0, 255)) {
      correct = true;
    }
    
    checkResponse(correct);
  }
  
  // Display the target color as a rectangle or other indicator
  fill(targetColor);
  rect(width / 4, height / 2 - 100, 200, 200);

  // Display score
  fill(0);
  textSize(30);
  text("Score: " + score, width / 4 + 100, height / 3);

  // Display feedback
  if (showFeedback) {
    fill(0);
    textSize(30);
    text(feedbackText, width / 4 + 100, height * 2 / 3);
  }

  // Display foot feedback on the right side
  drawFootBase();
  // drawBubbles(cMM, cMF, cF, cHeel);
}

// Selects a new random target color from red, green, blue, or yellow
void newTargetColor() {
  int randomColor = (int) random(4);
  switch (randomColor) {
    case 0:
      targetColor = color(255, 0, 0);  // Red
      break;
    case 1:
      targetColor = color(0, 255, 0);  // Green
      break;
    case 2:
      targetColor = color(0, 0, 255);  // Blue
      break;
    case 3:
      targetColor = color(255, 255, 0);  // Yellow
      break;
  }
}

void checkResponse(boolean correct) {
  if (correct) {
    feedbackText = "Correct!";
    score++;
  } else {
    feedbackText = "Wrong!";
  }
  showFeedback = true;
  // newTargetColor();
}
