void mousePressed() {
  // Check if white keys are pressed
  for (int i = 0; i < numWhite; i++) {
    if (mouseX > whiteKeyX[i] && mouseX < whiteKeyX[i] + whiteKeyWidth && mouseY < marginY + blackKeyHeight + whiteKeyHeight && mouseY > marginY + blackKeyHeight) {
      whiteKeyPressed[i] = true;
      whiteKeyNotes[i].play();
            
      // Only record the key if we're recording
      if (isRecording) {
        int relativeTime = millis() - recordingStartTime;  // Calculate time relative to the start of the recording
        keyPresses.add(octaves[i] + currentOctave + "," + relativeTime);  // Save note and time in CSV format
      }
    }
  }

  // Check if black keys are pressed
  for (int i = 0; i < numBlack; i++) {
    if (mouseX > blackKeyX[i] && mouseX < blackKeyX[i] + blackKeyWidth && mouseY < marginY + blackKeyHeight && mouseY > marginY) {
      blackKeyPressed[i] = true;
      blackKeyNotes[i].play();
      
      // Only record the key if we're recording
      if (isRecording) {
        int relativeTime = millis() - recordingStartTime;  // Calculate time relative to the start of the recording
        keyPresses.add(blackOctaves[i] + currentOctave + "," + relativeTime);  // Save note and time in CSV format
      }
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
  
  if(currentState == State.Guitar) {
    for (int i = 0; i < 6; i++) { // Change loop limit to 6
      if (abs(mouseY - stringY[i]) < stringSpacing / 2) { // Check if click is near the string
        
      }
    }
  }
}

void mouseReleased() {
  // Reset key press states when the mouse is released
  for (int i = 0; i < numWhite; i++) {
    whiteKeyPressed[i] = false;
  }
  
  for (int i = 0; i < numBlack; i++) {
    blackKeyPressed[i] = false;
  }
}
