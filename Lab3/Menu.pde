void drawMenu() {
  timeState += 0.05; // Adjust for speed of bouncing
  titleSize = lerp(minTitleSize, maxTitleSize, (sin(timeState) + 1) / 2);
  
  // Title
  textSize(titleSize);
  textAlign(CENTER);
  fill(GetColor()); // Random title color
  text(GetString("title"), width / 2, height * 0.3);
  
  // Subtitle
  textSize(24);
  fill(50, 150, 50); // Static subtitle color
  text(GetString("subtitle"), width / 2, height * 0.4);

  // Buttons
  float buttonWidth = width * 0.2; // 45% of the width
  float buttonHeight = height / 10; // Increased button height
  
  buttonY = (height - buttonHeight) / 2;
  pianoX = width / 2 - 2 * buttonWidth;
  learnX = (width - buttonWidth) / 2 ;
  guitarX = width / 2 + buttonWidth;
  
  pianoModeButton = new Button(pianoX, buttonY, buttonWidth, buttonHeight, "Piano Mode");
  pianoModeButton.display();
  if (pianoModeButton.isMouseOver()) {
    currentState = State.Piano;
    renderPiano(width / (numWhite + 1), height / 4 * 3, height / 4);
  }
  
  learnModeButton = new Button(learnX, buttonY, buttonWidth, buttonHeight, "Learn the Piano");
  learnModeButton.display();
  if (learnModeButton.isMouseOver()) {
    currentState = State.Recording;
    renderRecording();
  }
  
  guitarModeButton = new Button(guitarX, buttonY, buttonWidth, buttonHeight, "Guitar Mode");
  guitarModeButton.display();
  if (guitarModeButton.isMouseOver()) {
    // renderGuitar();
    currentState = State.Guitar;
  }
}
