void DrawMenu() {
  // Draw Fitness Mode button
  fill(150);
  rect((width - buttonWidth) / 2, buttonYStart, buttonWidth, buttonHeight);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(buttonHeight * 0.4); // Font size based on button height
  text("Fitness Mode", width / 2, buttonYStart + buttonHeight / 2);
  
  // Draw Stress Monitoring Mode button
  fill(150);
  rect((width - buttonWidth) / 2, buttonYStart + buttonHeight + buttonSpacing, buttonWidth, buttonHeight);
  fill(255);
  text("Stress Monitoring Mode", width / 2, buttonYStart + buttonHeight + buttonSpacing + buttonHeight / 2);
  
  // Draw Meditation Monitoring Mode button
  fill(150);
  rect((width - buttonWidth) / 2, buttonYStart + 2 * (buttonHeight + buttonSpacing), buttonWidth, buttonHeight);
  fill(255);
  text("Meditation Monitoring Mode", width / 2, buttonYStart + 2 * (buttonHeight + buttonSpacing) + buttonHeight / 2);
  
  // Draw General Monitoring Mode button
  fill(150);
  rect((width - buttonWidth) / 2, buttonYStart + 3 * (buttonHeight + buttonSpacing), buttonWidth, buttonHeight);
  fill(255);
  text("General Monitoring Mode", width / 2, buttonYStart + 3 * (buttonHeight + buttonSpacing) + buttonHeight / 2);
}

void mousePressed() {
  if (inMenu) {
    if (mouseX >= (width - buttonWidth) / 2 && mouseX <= (width + buttonWidth) / 2 && 
        mouseY >= buttonYStart && mouseY <= buttonYStart + buttonHeight) {
      fitnessMode();
    } else if (mouseX >= (width - buttonWidth) / 2 && mouseX <= (width + buttonWidth) / 2 && 
               mouseY >= buttonYStart + buttonHeight + buttonSpacing && 
               mouseY <= buttonYStart + 2 * (buttonHeight + buttonSpacing)) {
      // stressMonitoringMode();
    } else if (mouseX >= (width - buttonWidth) / 2 && mouseX <= (width + buttonWidth) / 2 && 
               mouseY >= buttonYStart + 2 * (buttonHeight + buttonSpacing) && 
               mouseY <= buttonYStart + 3 * (buttonHeight + buttonSpacing)) {
      meditationMonitoringMode();
    } else if (mouseX >= (width - buttonWidth) / 2 && mouseX <= (width + buttonWidth) / 2 && 
               mouseY >= buttonYStart + 3 * (buttonHeight + buttonSpacing) && 
               mouseY <= buttonYStart + 4 * (buttonHeight + buttonSpacing)) {
      generalMonitoringMode();
    }
  } else {
    return;
  }
}

void fitnessMode() {
  System.out.println("Entering Fitness Mode..");
  startTime = millis();
  if(!baselineCollected){
    collectBaseline();
  }
  
  Graphing = true;
}

void meditationMonitoringMode() {
  System.out.println("Collecting Baseline...");
  startTime = millis();
  
  // while (!baselineCollected) {
  //  collectBaseline();
  //}
  
  System.out.println("Done");
  MeditationMode = true;
}


void generalMonitoringMode() {
  background(255);  // Clear the background
  inMenu = false;   // Exit menu
  Graphing = true;  // Start graphing
  //fill(150);
  //rect((width - buttonWidth) / 2, buttonYStart + 2 * (buttonHeight + buttonSpacing), buttonWidth, buttonHeight);
  System.out.println("Entering General Monitoring Mode...");
}
