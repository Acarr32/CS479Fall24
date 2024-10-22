import processing.sound.*;
import java.util.ArrayList;

void setup() {
  fullScreen();
  currentState = State.Menu;
  maxTitleSize = height * 0.1; // 10% of the height
  minTitleSize = height * 0.03; // 3% of the height
  
  // Set up the back button dimensions
  backButtonWidth = 100;
  backButtonHeight = 40;
  backButtonX = width - backButtonWidth - 20;
  backButtonY = 20;
}

void draw() {
  background(255);
  switch (currentState){  
    case Menu:
      drawMenu();
      break;
    case Piano:
      currentState = State.Piano;
      drawPiano();
      drawBackButton();
      break;
    case Recording:
      currentState = State.Recording;
      drawRecording();
      handleRecordingPageButtons();
      drawBackButton();
      break;
    default:
      background(255);
  }
}

// Function to draw the back button
void drawBackButton() {
  fill(200);
  backButton = new Button(backButtonX, backButtonY, backButtonWidth, backButtonHeight, "Back");
  
  if (backButton.isMouseOver()) {
    currentState = State.Menu;
  }
}
