import processing.sound.*;

// Declare arrays for sound files
SoundFile[] whiteKeyNotes = new SoundFile[7];
SoundFile[] blackKeyNotes = new SoundFile[5];

// Octave handling
int currentOctave = 3; // Start at octave 3 (default)
String[] octaves = {"C", "D", "E", "F", "G", "A", "B"};
String[] blackOctaves = {"Db", "Eb", "Gb", "Ab", "Bb"};

// Piano Keys declarations
int whiteKeyWidth, whiteKeyHeight, blackKeyWidth, blackKeyHeight;
color whiteKeyColor, blackKeyColor, pressedColor;
int[] whiteKeyX = new int[7]; // Positions for white keys
int[] blackKeyX = new int[5]; // Positions for black keys
boolean[] whiteKeyPressed = new boolean[7];
boolean[] blackKeyPressed = new boolean[5];

// Button positions and sizes
int buttonWidth;
int buttonHeight;
int octaveUpX, octaveDownX, buttonY;

int marginX, marginY;

void setup() {
  fullScreen();

  // Load sound files for default octave (C3 to B3)
  loadOctaveNotes(currentOctave);

  // Define key dimensions
  whiteKeyWidth = width / 9;
  whiteKeyHeight = height / 4 * 3;
  blackKeyWidth = whiteKeyWidth / 2;
  blackKeyHeight = whiteKeyHeight / 2;

  // Set colors
  whiteKeyColor = color(255);
  blackKeyColor = color(0);
  pressedColor = color(200, 100, 100);
  
  marginX = (width - whiteKeyWidth * 7) / 2;
  marginY = (height - whiteKeyHeight);

  // Set x positions for white keys
  for (int i = 0; i < 7; i++) {
    whiteKeyX[i] = i * whiteKeyWidth + marginX;
  }

  // Set x positions for black keys (skip keys between B and C, E and F)
  blackKeyX[0] = whiteKeyX[1] - blackKeyWidth / 2;
  blackKeyX[1] = whiteKeyX[2] - blackKeyWidth / 2;
  blackKeyX[2] = whiteKeyX[4] - blackKeyWidth / 2;
  blackKeyX[3] = whiteKeyX[5] - blackKeyWidth / 2;
  blackKeyX[4] = whiteKeyX[6] - blackKeyWidth / 2;

  // Set button positions
  buttonWidth = width / 5;
  buttonHeight = height / 10;
  octaveUpX = width / 2 - buttonWidth - 10;
  octaveDownX = width / 2 + 10;
  buttonY = marginY / 3;
}

void draw() {
  background(255);
  textSize(24);

  // Draw white keys
  for (int i = 0; i < 7; i++) {
    if (whiteKeyPressed[i]) {
      fill(pressedColor); // Change color when pressed
    } else {
      fill(whiteKeyColor);
    }
    
    rect(whiteKeyX[i], marginY, whiteKeyWidth, whiteKeyHeight);
  }

  // Draw black keys
  for (int i = 0; i < 5; i++) {
    if (blackKeyPressed[i]) {
      fill(pressedColor); // Change color when pressed
    } else {
      fill(blackKeyColor);
    }
    rect(blackKeyX[i], marginY, blackKeyWidth, blackKeyHeight);
  }

  // Draw Octave Up button
  fill(150);
  rect(octaveUpX, buttonY, buttonWidth, buttonHeight);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Octave Up", octaveUpX + buttonWidth / 2, buttonY + buttonHeight / 2);

  // Draw Octave Down button
  fill(150);
  rect(octaveDownX, buttonY, buttonWidth, buttonHeight);
  fill(0);
  text("Octave Down", octaveDownX + buttonWidth / 2, buttonY + buttonHeight / 2);
}

void mousePressed() {
  // Check if white keys are pressed
  for (int i = 0; i < 7; i++) {
    if (mouseX > whiteKeyX[i] && mouseX < whiteKeyX[i] + whiteKeyWidth && mouseY < marginY + blackKeyHeight + whiteKeyHeight && mouseY > marginY + blackKeyHeight) {
      whiteKeyPressed[i] = true;
      println("White key " + (i + 1) + " pressed!");
      whiteKeyNotes[i].play();
    }
  }

  // Check if black keys are pressed
  for (int i = 0; i < 5; i++) {
    if (mouseX > blackKeyX[i] && mouseX < blackKeyX[i] + blackKeyWidth && mouseY < blackKeyHeight && mouseY > marginY) {
      blackKeyPressed[i] = true;
      println("Black key " + (i + 1) + " pressed!");
      blackKeyNotes[i].play();
    }
  }

  // Check if Octave Up button is pressed
  if (mouseX > octaveUpX && mouseX < octaveUpX + buttonWidth && mouseY > buttonY && mouseY < buttonY + buttonHeight) {
    if (currentOctave < 7) {
      currentOctave++;
      loadOctaveNotes(currentOctave);
      println("Octave Up: Now at octave " + currentOctave);
    }
  }

  // Check if Octave Down button is pressed
  if (mouseX > octaveDownX && mouseX < octaveDownX + buttonWidth && mouseY > buttonY && mouseY < buttonY + buttonHeight) {
    if (currentOctave > 1) {
      currentOctave--;
      loadOctaveNotes(currentOctave);
      println("Octave Down: Now at octave " + currentOctave);
    }
  }
}

void mouseReleased() {
  // Reset key press states when the mouse is released
  for (int i = 0; i < 7; i++) {
    whiteKeyPressed[i] = false;
  }
  for (int i = 0; i < 5; i++) {
    blackKeyPressed[i] = false;
  }
}

// Function to load sound files based on the current octave
void loadOctaveNotes(int octave) {
  for (int i = 0; i < 7; i++) {
    String noteFile = "./piano-mp3/" + octaves[i] + octave + ".mp3";
    whiteKeyNotes[i] = new SoundFile(this, noteFile);
  }
  for (int i = 0; i < 5; i++) {
    String noteFile = "./piano-mp3/" + blackOctaves[i] + octave + ".mp3";
    blackKeyNotes[i] = new SoundFile(this, noteFile);
  }
}
