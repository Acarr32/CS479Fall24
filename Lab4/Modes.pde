void initializeMode() {
  // Text Column dimensions
  columnWidth = width / 3;
  textWidth = width / 4;
  distX = columnWidth * 2;
  marginX = (columnWidth - textWidth) / 2;
  
  // Buttons dimensions
  modeButtonsY = height * 4 / 5;
  buttonWidth = textWidth * 2 / 5;
  buttonHeight = height / 14;
  
  profileButton = new Button(distX + marginX, modeButtonsY, buttonWidth, buttonHeight, "Add Profile", null, color(150));
  if (profileButton.isMouseOver()) {
    currentState = State.PROFILE;
  }
  
  gameButton = new Button(width - marginX - buttonWidth, modeButtonsY, buttonWidth, buttonHeight, "Game Mode", null, color(150));
  if (gameButton.isMouseOver()) {
    currentState = State.GAME;
  }
  
  // Labels positions
  labelX = distX + marginX;
  labelY = height / 10;
  lineHeight = height / 12;
  
  isStepLengthActive = false;
  isStepWidthActive = false;
}

void drawModeButtons() {
  fill(255);
  rect(2 * graphWidth, height, columnWidth, height);
  fill(0);
  // text("metrics", distX + marginX, height / 20);
  
  profileButton.display();
  gameButton.display();
}
  
  
void drawMode() { 
  drawText();
  drawModeButtons();
  drawGraphs();
}

void drawText() {
  // Reset labelY to its initial value at the start of each frame
  float currentLabelY = labelY;
  
  fill(0);
  textAlign(LEFT);
  
  // Step Length input
  text("Step Length:", labelX, currentLabelY);
  drawInputField(labelX + textWidth / 2, currentLabelY - 15, stepLengthInput, isStepLengthActive);
  
  // Step Width input
  currentLabelY += lineHeight;
  text("Step Width:", labelX, currentLabelY);
  drawInputField(labelX + textWidth / 2, currentLabelY - 15, stepWidthInput, isStepWidthActive);

  // Display calculated data
  currentLabelY += lineHeight * 2;
  text("Stride Length: " + strideLength, labelX, currentLabelY);
  
  currentLabelY += lineHeight;
  text("Step Count: " + stepCount, labelX, currentLabelY);
  
  currentLabelY += lineHeight;
  text("Cadence: " + cadence, labelX, currentLabelY);
  
  currentLabelY += lineHeight;
  text("Walking Profile: " + walkingProfile, labelX, currentLabelY);
  
  currentLabelY += lineHeight;
  text("User Status: " + userStatus, labelX, currentLabelY);
}

// Draw an input field, highlighting if active
void drawInputField(float x, float y, String inputText, boolean isActive) {
  if (isActive) {
    stroke(0, 0, 255);  // Highlight active field in blue
  } else {
    stroke(0);
  }
  
  fill(255);
  rect(x, y, textWidth / 2, lineHeight / 3);
  fill(0);
  text(inputText, x + 5, y + 15);
  noStroke();
}

void keyPressed() {
  if (key == BACKSPACE) {
    if (isStepLengthActive && stepLengthInput.length() > 0) {
      stepLengthInput = stepLengthInput.substring(0, stepLengthInput.length() - 1);
    } else if (isStepWidthActive && stepWidthInput.length() > 0) {
      stepWidthInput = stepWidthInput.substring(0, stepWidthInput.length() - 1);
    }
  } else if (key != CODED) {  // Ignore special keys like arrow keys
    if (isStepLengthActive) {
      stepLengthInput += key;
    } else if (isStepWidthActive) {
      stepWidthInput += key;
    }
  }
}


// Toggle active field based on mouse click position
void mousePressed() {
  if (mouseX > labelX + textWidth / 2 && mouseX < labelX + textWidth / 2 + textWidth / 2 && mouseY > labelY - 15 && mouseY < labelY + 5) {
    isStepLengthActive = true;
    isStepWidthActive = false;
  } else if (mouseX > labelX + textWidth / 2 && mouseX < labelX + textWidth / 2 + textWidth / 2 && mouseY > labelY + lineHeight - 15 && mouseY < labelY + lineHeight + 5) {
    isStepLengthActive = false;
    isStepWidthActive = true;
  } else {
    isStepLengthActive = false;
    isStepWidthActive = false;
  }
}
