import processing.sound.*;
import java.util.ArrayList;

void setup() {
  fullScreen();
  currentState = State.Menu;
  maxTitleSize = height * 0.1; // 10% of the height
  minTitleSize = height * 0.03; // 3% of the height
  
  // Set up the back button dimensions
  backButtonWidth = width / 15;
  backButtonHeight = height / 15;
  backButtonX = width - backButtonWidth - 20;
  backButtonY = 20;
  
  playIcon = loadImage("img/play.png");
  playSampleIcon = loadImage("img/playSample.png");
  startIcon = loadImage("img/start.png");
  stopIcon = loadImage("img/stop.png");
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
      drawPiano();
      break;
    default:
      background(255);
      drawBackButton();
  }
}

// Function to draw the back button
public void drawBackButton() {
  fill(150);
  backButton = new Button(backButtonX, backButtonY, backButtonWidth, backButtonHeight, "Back", null, color(150));
  backButton.display();
  
  if (backButton.isMouseOver()) {
    currentState = State.Menu;
  }
}
