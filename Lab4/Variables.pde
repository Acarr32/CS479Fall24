// States of the application
enum State {
  GRAPHS, GAME, PROFILE
}

State currentState = State.GRAPHS;

int inputBuffer = 10;
int sampleTime = 10;

PImage img;

// Graphs dimensions
float graphWidth, graphHeight;

// Text Column dimensions
float columnWidth, textWidth, marginX, distX;


// Buttons to change the view
Button gameButton, profileButton;
float modeButtonsY, buttonWidth, buttonHeight;

// Back Buttton
float backButtonX, backButtonY, backButtonWidth, backButtonHeight;
Button backButton;

// Variables for input fields
String stepLengthInput = "";
String stepWidthInput = "";

// Placeholder variables for calculated data
String strideLength = "0";
String stepCount = "0";
String cadence = "0";
String walkingProfile = "Normal";
String userStatus = "Active";

float labelX, labelY, lineHeight;
boolean isStepLengthActive, isStepWidthActive;
