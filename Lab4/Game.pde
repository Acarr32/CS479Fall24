void drawGame() {
  System.out.println("Game Mode entered");
  background(255);
  
  // Check if 3 seconds have passed since last color change
  if (millis() - lastColorChange >= colorChangeInterval) {
    newTargetColor();  // Change color
    lastColorChange = millis();  // Reset timer
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
    textSize(20);
    text(feedbackText, width / 4 - 40, height / 2 + 80);
  }

  // Display foot feedback on the right side
  drawFootBase();
  // drawBubbles(currMM, currMF, currLF, currHeel);
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
  newTargetColor();
}
