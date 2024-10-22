void maousePressed() {
  // Check if white keys are pressed
  for (int i = 0; i < numWhite; i++) {
    if (mouseX > whiteKeyX[i] && mouseX < whiteKeyX[i] + whiteKeyWidth && mouseY < marginY + blackKeyHeight + whiteKeyHeight && mouseY > marginY + blackKeyHeight) {
      whiteKeyPressed[i] = true;
      println("White key " + (i + 1) + " pressed!");
      whiteKeyNotes[i].play();
    }
  }

  // Check if black keys are pressed
  for (int i = 0; i < numBlack; i++) {
    if (mouseX > blackKeyX[i] && mouseX < blackKeyX[i] + blackKeyWidth && mouseY < marginY + blackKeyHeight && mouseY > marginY) {
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

void maouseReleased() {
  // Reset key press states when the mouse is released
  for (int i = 0; i < numWhite; i++) {
    whiteKeyPressed[i] = false;
  }
  
  for (int i = 0; i < numBlack; i++) {
    blackKeyPressed[i] = false;
  }
}