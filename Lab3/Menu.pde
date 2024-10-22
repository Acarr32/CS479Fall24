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
  float buttonWidth = width * 0.45; // 45% of the width
  float buttonHeight = 60; // Increased button height
  
  // Piano Mode Button
  if (mouseX > width * 0.25 - buttonWidth / 2 && mouseX < width * 0.25 + buttonWidth / 2 && 
      mouseY > height * 0.5 - buttonHeight / 2 && mouseY < height * 0.5 + buttonHeight / 2) {
    if (mousePressed) {
      pianoMode();
    }
  }
  fill(100, 200, 100); // Piano button color
  rect(width * 0.25 - buttonWidth / 2, height * 0.5 - buttonHeight / 2, buttonWidth, buttonHeight);
  fill(255); // Button text color
  textSize(20);
  textAlign(CENTER, CENTER);
  text(GetString("pianoMode"), width * 0.25, height * 0.5);
  
  // Guitar Mode Button
  if (mouseX > width * 0.75 - buttonWidth / 2 && mouseX < width * 0.75 + buttonWidth / 2 && 
      mouseY > height * 0.5 - buttonHeight / 2 && mouseY < height * 0.5 + buttonHeight / 2) {
    if (mousePressed) {
      guitarMode();
    }
  }
  fill(200, 100, 100); // Guitar button color
  rect(width * 0.75 - buttonWidth / 2, height * 0.5 - buttonHeight / 2, buttonWidth, buttonHeight);
  fill(255); // Button text color
  textSize(20);
  textAlign(CENTER, CENTER);
  text(GetString("guitarMode"), width * 0.75, height * 0.5);
}
