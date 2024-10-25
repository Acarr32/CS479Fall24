public void renderPiano(float whiteWidth, float whiteHeight, float keysY){  
  // Load sound files for default octave (C3 to B3)
  loadOctaveNotes(currentOctave);

  // Define key dimensions
  whiteKeyWidth = whiteWidth;
  whiteKeyHeight = whiteHeight;
  blackKeyWidth = whiteKeyWidth / 3;
  blackKeyHeight = whiteKeyHeight / 2;
  
  marginX = (width - whiteKeyWidth * numWhite) / 2;
  marginY = keysY;

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
  
  if (currentState == State.Piano) {
    loadCommands();
  }
}

void loadCommands() {
  // Set button positions
  buttonWidth = width / 5;
  buttonHeight = height / 10;
  
  octaveDownX = width / 2 - buttonWidth - 10;
  octaveUpX = width / 2 + 10;
  
  buttonY = marginY / 3;
}

void drawCommands() {
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


public void drawPiano(){
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

  if (currentState == State.Piano) {
    drawCommands();
  }
  
  drawBackButton();
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
//**************************************Below
public void pianoSerial(Integer[] keys, int octaveEvent){
  // First, reset all keys to "not pressed"
  for (int i = 0; i < numWhite; i++) {
    whiteKeyPressed[i] = false;  // Reset white keys
  }
  for (int i = 0; i < numBlack; i++) {
    blackKeyPressed[i] = false;  // Reset black keys
  }

  List<Integer> kL = Arrays.asList(keys);
  
  //Black Key check
  if(kL.contains(2) && kL.contains(3)){
    blackKeyPressed[0] = true;
    blackKeyNotes[0].play();
  }
  
  if(kL.contains(3) && kL.contains(4)){
    blackKeyPressed[1] = true;
    blackKeyNotes[1].play();
  }
  
  if(kL.contains(5) && kL.contains(6)){
    blackKeyPressed[2] = true;
    blackKeyNotes[2].play();
  }
  
  if(kL.contains(6) && kL.contains(7)){
    blackKeyPressed[3] = true;
    blackKeyNotes[3].play();
  }
    
  if(kL.contains(7) && kL.contains(8)){
    blackKeyPressed[4] = true;
    blackKeyNotes[4].play();
  }
  
  if(kL.contains(9) && kL.contains(10)){
    blackKeyPressed[5] = true;
    blackKeyNotes[5].play();
  }
  
  // Remove corresponding white key if a black key is pressed
  for (int i = 0; i < blackKeyPressed.length; i++) {
    if (blackKeyPressed[i]) {
      // Remove white keys that are tied to black keys
      if(i == 0){ kL.remove(Integer.valueOf(2)); kL.remove(Integer.valueOf(3)); }
      if(i == 1){ kL.remove(Integer.valueOf(3)); kL.remove(Integer.valueOf(4)); }
      if(i == 2){ kL.remove(Integer.valueOf(5)); kL.remove(Integer.valueOf(6)); }
      if(i == 3){ kL.remove(Integer.valueOf(6)); kL.remove(Integer.valueOf(7)); }
      if(i == 4){ kL.remove(Integer.valueOf(7)); kL.remove(Integer.valueOf(8)); }
      if(i == 5){ kL.remove(Integer.valueOf(9)); kL.remove(Integer.valueOf(10)); }
    }
  }

  // White Key Check
  for (int i = 0; i < numWhite; i++) {
    if(kL.contains(i)){
      whiteKeyPressed[i] = true;  // Set the white key as pressed
      whiteKeyNotes[i].play();    // Play the note for the white key
    }
  }

  // Update the current octave if octave change event
  currentOctave += octaveEvent;
}


//**************************************Above
