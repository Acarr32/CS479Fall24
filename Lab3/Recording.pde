// Function to save key press data to a file
void saveKeyPressData() {
  saveStrings("key_presses_log.txt", keyPresses.toArray(new String[0]));
}

void renderRecording() {
  currentState = State.Recording;
  
  fill(255);
  buttonHeight = height / 15;
  buttonWidth = buttonHeight;
  
  // Set up recording buttons
  recordButtonY = height / 6 + buttonHeight;
  buttonX = width / 15;

  startRecordingButton = new Button(buttonX, recordButtonY, buttonWidth, buttonHeight, "", startIcon, color(150));
  stopRecordingButton = new Button(buttonX, recordButtonY + buttonHeight + 10, buttonWidth, buttonHeight, "", stopIcon, color(150)); 
  playRecordingButton = new Button(buttonX, recordButtonY + 2 * (buttonHeight + 10), buttonWidth, buttonHeight, "", playIcon, color(150));
  playSampleButton = new Button(buttonX, recordButtonY + 3 * (buttonHeight + 10), buttonWidth, buttonHeight, "", playSampleIcon, color(150));

  // You can initialize your piano here or any other needed setups
  renderPiano(width / (numWhite + 1), height / 3, height / 3 * 2);
}

void drawRecording() {
  textSize(24);
  textAlign(CENTER);
  text("Recording Page", width / 2, 100);
  
  // Handle playback
  if (isPlayingBack) {
    playBack();
  }

  // Display the recording buttons
  startRecordingButton.display();
  stopRecordingButton.display();
  playSampleButton.display();
  playRecordingButton.display();
}

// Function to draw the piano page (you can customize this part as needed)
void drawPianoPage() {
  textSize(32);
  textAlign(CENTER);
  text("Piano Page", width / 2, 100);
  
  // Add your piano drawing logic here
}

// Function to handle button clicks on the recording page
void handleRecordingPageButtons() {
  // Check if the mouse is pressed and if the mouse is over the button
  if (mousePressed) {
    if (startRecordingButton.isMouseOver()) {
      startRecording();
    }
    
    if (stopRecordingButton.isMouseOver()) {
      stopRecording();
    }

    if (playSampleButton.isMouseOver()) {
      playRecording("sample");
    }

    if (playRecordingButton.isMouseOver()) {
      playRecording("user");
    }
  }
}


// Start recording key presses
void startRecording() {
  if (!isRecording) {
    isRecording = true;
    keyPresses.clear();  // Clear previous recordings
    recordingStartTime = millis();  // Reset the time for recording start
    println("Recording started...");
    
    // Change the start button to red when recording
    startRecordingButton.changeColor(color(255, 0, 0));
    stopRecordingButton.changeColor(color(0, 255, 0));
  }
}

// Stop recording
void stopRecording() {
  if (isRecording) {
    isRecording = false;
    println("Recording stopped. Total events: " + keyPresses.size());
    
    // Change buttons back to their default colors
    startRecordingButton.changeColor(color(150));  // Default button color
    stopRecordingButton.changeColor(color(150)); 
  }
}

// Replay the recorded key presses
void playRecording(String type) {
  if (type == "user") {
    if (!keyPresses.isEmpty()) {
      isPlayingBack = true;
      playbackStartTime = millis();
      playbackIndex = 0;
      println("Playback started...");
      
      playRecordingButton.changeColor(color(0, 255, 0));
    }
  }
}

// Function to handle piano interaction (add your note-playing logic here)
void handlePianoInteraction() {

}

// Playback logic (plays the recorded events)
void playBack() {
  if (playbackIndex < keyPresses.size()) {
    String[] data = split(keyPresses.get(playbackIndex), ',');
    String note = data[0];
    int timeStamp = int(data[1]);

    // Check if the current time has reached the timestamp for the next note
    if (millis() - playbackStartTime >= timeStamp) {
      // Play the note (you'll need a method to trigger the correct sound file based on the note)
      playNoteByName(note);
      println("Replaying note: " + note + " at " + timeStamp + " ms");

      playbackIndex++;
    }
  } else {
    isPlayingBack = false;  // Stop playback when all notes have been played
    println("Playback finished.");
  }
}

void playNoteByName(String note) {
  // Logic to trigger the correct sound based on the note name
  // For example, if the note is "C4", find the correct index and play the sound
  for (int i = 0; i < numWhite; i++) {
    if (note.equals(octaves[i] + currentOctave)) {
      whiteKeyNotes[i].play();
      return;
    }
  }

  for (int i = 0; i < numBlack; i++) {
    if (note.equals(blackOctaves[i] + currentOctave)) {
      blackKeyNotes[i].play();
      return;
    }
  }
}
