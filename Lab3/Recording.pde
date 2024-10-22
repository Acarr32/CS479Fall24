// Function to save key press data to a file
void saveKeyPressData() {
  saveStrings("key_presses_log.txt", keyPresses.toArray(new String[0]));
}

void renderRecording() {
  currentState = State.Recording;
  
  buttonHeight = height / 15;
  buttonWidth = width / 10;
  
  // Set up recording buttons
  recordButtonY = height / 6 + buttonHeight;
  buttonX = width / 15;

  recordButton = new Button(buttonX, recordButtonY, buttonWidth, buttonHeight, "Start Recording");
  playRecordingButton = new Button(buttonX, recordButtonY + buttonHeight + 10, buttonWidth, buttonHeight, "Pause");
  playSampleButton = new Button(buttonX, recordButtonY + 2 * (buttonHeight + 10), buttonWidth, buttonHeight, "Replay");

  // You can initialize your piano here or any other needed setups
  renderPiano(width / (numWhite + 1), height / 3, height / 3 * 2);
}

void drawRecording() {
  background(255);
  textSize(24);
  textAlign(CENTER);
  text("Recording Page", width / 2, 100);
  
  // Handle playback
  if (isPlayingBack) {
    playBack();
  }

  // Display the recording buttons
  recordButton.display();
  playSampleButton.display();
  playRecordingButton.display();
  
  drawPiano();
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
  if (recordButton.isMouseOver()) {
    startRecording();
  }
 
  if (playSampleButton.isMouseOver()) {
    stopRecording();
  }
  if (playRecordingButton.isMouseOver()) {
    playRecording();
  }
}

// Start recording key presses
void startRecording() {
  if (!isRecording) {
    isRecording = true;
    isPaused = false;
    keyPresses.clear();  // Clear previous recordings
    println("Recording started...");
  }
}

// Pause the recording
void pauseRecording() {
  if (isRecording && !isPaused) {
    isPaused = true;
    println("Recording paused...");
  } else if (isPaused) {
    isPaused = false;
    println("Recording resumed...");
  }
}

// Stop recording
void stopRecording() {
  if (isRecording) {
    isRecording = false;
    isPaused = false;
    println("Recording stopped. Total events: " + keyPresses.size());
  }
}

// Replay the recorded key presses
void playRecording() {
  if (!keyPresses.isEmpty()) {
    isPlayingBack = true;
    playbackStartTime = millis();
    playbackIndex = 0;
    println("Playback started...");
  }
}

// Function to handle piano interaction (add your note-playing logic here)
void handlePianoInteraction() {

}

// Playback logic (plays the recorded events)
void playBack() {
}
