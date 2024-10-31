import processing.sound.*;
import java.util.*;
import processing.serial.*; //**************************************
Serial myPort;
PFont boldFont;

void setup(){
  fullScreen();
  currentState = State.GRAPHS;
  boldFont = createFont("SansSerif-Bold", 24);
 
  initializeGraphs();
  initializeMode();
  
  // Set up the back button dimensions
  backButtonWidth = width / 15;
  backButtonHeight = height / 15;
  backButtonX = width - backButtonWidth * 3 / 2;
  backButtonY = height / 20;
}

void draw(){
  background(255);
  textSize(24);
  textAlign(CENTER);
  
  // Check the mode and display accordingly
  switch (currentState) {
    case GRAPHS:
      drawMode();
      break;
    case GAME:
      drawGame();
      drawBackButton();
      break;
    case PROFILE:
      drawFootBase();
      drawBackButton();
      break;
    default:
      drawMode();
      break;
  }
}

// Function to draw the back button
public void drawBackButton() {
  backButton = new Button(backButtonX, backButtonY, backButtonWidth, backButtonHeight, "Back", null, color(150));
  backButton.display();
  
  if (backButton.isMouseOver()) {
    currentState = State.GRAPHS;
  }
}
