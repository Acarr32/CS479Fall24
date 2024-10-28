void drawMenuText() {
  // Oscillating title header
  float secondaryTitleSize = lerp(minTitleSize / 2, maxTitleSize / 2, (sin(timeState) + 1) / 2);
  textSize(secondaryTitleSize);
  textAlign(CENTER);
  fill(getColor(timeState)); // Red color for title
  text(GetString("title2"), width / 2, height * 0.7); // Position below main title
  
  // Hardcoded menu content
  
  
  // Set position and styling for menu content text
  textSize(16); // Set smaller size for file content text
  fill(0); // White color for content text
  
  float contentX = 20; // Left margin for content
  float contentY = height * 0.8; // Adjust to display below secondary title
  
  // Display the menu content with word wrapping
  textAlign(CENTER);
  textSize(maxTitleSize/3);
  text(GetString("description"), contentX, contentY, width - 40, height * 0.2); // Adjust wrapping area
}

// Modified drawMenu function to include drawMenuText() at the end
void drawMenu() {
  timeState += 0.05; // Adjust for speed of bouncing
  titleSize = lerp(minTitleSize, maxTitleSize, (sin(timeState) + 1) / 2);

  // Title
  textSize(titleSize);
  textAlign(CENTER);
  fill(getColor(timeState));
  text(GetString("title"), width / 2, height * 0.3);

  // Subtitle
  textSize(24);
  fill(getColor(timeState)); // Static subtitle color
  text(GetString("subtitle"), width / 2, height * 0.4);

  // Buttons
  float buttonWidth = width * 0.2; // 20% of the width
  float buttonHeight = height / 10;
  
  buttonY = (height - buttonHeight) / 2;
  pianoX = width / 2 - 2 * buttonWidth;
  learnX = (width - buttonWidth) / 2;
  guitarX = width / 2 + buttonWidth;
  
  pianoModeButton = new Button(pianoX, buttonY, buttonWidth, buttonHeight, "Piano Mode", null, color(150));
  pianoModeButton.display();
  if (pianoModeButton.isMouseOver()) {
    currentState = State.Piano;
    renderPiano(width / (numWhite + 1), height / 4 * 3, height / 4);
  }
  
  learnModeButton = new Button(learnX, buttonY, buttonWidth, buttonHeight, "Learn the Piano", null, color(150));
  learnModeButton.display();
  if (learnModeButton.isMouseOver()) {
    currentState = State.Recording;
    renderRecording();
  }
  
  guitarModeButton = new Button(guitarX, buttonY, buttonWidth, buttonHeight, "Guitar Mode", null, color(150));
  guitarModeButton.display();
  if (guitarModeButton.isMouseOver()) {
    currentState = State.Guitar;
  }

  // Display secondary title and menu content text at the end
  drawMenuText();
}
