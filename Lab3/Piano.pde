public void renderPiano(){
  background(255);
  currentState = State.Piano;
  // Load sound files for default octave (C3 to B3)
  loadOctaveNotes(currentOctave);

  // Define key dimensions
  whiteKeyWidth = width / (numWhite + 1);
  whiteKeyHeight = height / 4 * 3;
  blackKeyWidth = whiteKeyWidth / 3;
  blackKeyHeight = whiteKeyHeight / 2;

  // Set colors
  whiteKeyColor = color(255);
  blackKeyColor = color(0);
  pressedColor = color(200, 100, 100);
  
  marginX = (width - whiteKeyWidth * numWhite) / 2;
  marginY = (height - whiteKeyHeight);

  // Set x positions for white keys
  for (int i = 0; i < numWhite; i++) {
    whiteKeyX[i] = i * whiteKeyWidth + marginX;
  }

  // Set x positions for black keys (skip keys between B and C, E and F)
  blackKeyX[0] = whiteKeyX[2] - blackKeyWidth / 2;
  blackKeyX[1] = whiteKeyX[3] - blackKeyWidth / 2;
  blackKeyX[2] = whiteKeyX[5] - blackKeyWidth / 2;
  blackKeyX[3] = whiteKeyX[6] - blackKeyWidth / 2;
  blackKeyX[4] = whiteKeyX[7] - blackKeyWidth / 2;
  blackKeyX[5] = whiteKeyX[9] - blackKeyWidth / 2;
  
  // Set button positions
  buttonWidth = width / 5;
  buttonHeight = height / 10;
  octaveDownX = width / 2 - buttonWidth - 10;
  octaveUpX = width / 2 + 10;
  buttonY = marginY / 3;
  
  
  
}

public void drawPiano(){
  background(255);
  textSize(24);

  // Draw white keys
  for (int i = 0; i < numWhite; i++) {
    if (whiteKeyPressed[i]) {
      fill(pressedColor); // Change color when pressed
    } else {
      fill(whiteKeyColor);
    }
    
    rect(whiteKeyX[i], marginY, whiteKeyWidth, whiteKeyHeight);
  }

  // Draw black keys
  for (int i = 0; i < numBlack; i++) {
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

void loadOctaveNotes(int octave) {
  String noteFile;
  
  for (int i = 0; i < numWhite; i++) {
    if ((i == 0) && ((octave - 1) >= 0)) {
      noteFile = "./piano-mp3/" + octaves[i] + (octave - 1) + ".mp3";
    } else if ((i > 7) && ((octave + 1) <= 7)) {
      noteFile = "./piano-mp3/" + octaves[i] + (octave + 1) + ".mp3";
    } else {
      noteFile = "./piano-mp3/" + octaves[i] + octave + ".mp3";
    }
    
    whiteKeyNotes[i] = new SoundFile(this, noteFile);
  }
  
  for (int i = 0; i < numBlack; i++) {
    if ((i == (numBlack - 1)) && ((octave + 1) <= 7)) {
      noteFile = "./piano-mp3/" + blackOctaves[i] + (octave + 1) + ".mp3";
    } else {
      noteFile = "./piano-mp3/" + blackOctaves[i] + octave + ".mp3";
    }
    
    blackKeyNotes[i] = new SoundFile(this, noteFile);
  }
}

//void pianoSerial(int[] keysActive){
//}
