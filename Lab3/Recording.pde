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
  drawSheetMusic();
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

//-------------------------------------------------------
String[] notes = {
    "G4", "F4", "E4", "D4", "C4", "B4", "A4",
    "G3", "F3", "E3", "D3", "C3", "B3", "A3"};

public void renderSheetMusic(float barWidth, float barHeight, float staffY) {
  // Define dimensions of the entire section (4 bars)
  float barSpacing = 10;  // Space between bars
  float staffSpacing = barHeight / 4;  // Space between lines in the staff
  float marginX = width - (barWidth * 4 + barSpacing * 3) - 20; // Offset for the right side

  // Draw the staff lines across all 4 bars
  for (int line = 0; line < 5; line++) {
    float lineY = staffY + line * staffSpacing;
    drawStaffLine(marginX, lineY, (barWidth * 4) + (barSpacing * 3)); // Draw one line across all 4 bars
  }

  // Draw vertical measure bars between the bars
  for (int bar = 0; bar < 3; bar++) { // Draw 3 measure bars between 4 bars
    float x = marginX + (bar + 1) * (barWidth + barSpacing); // Adjust x for spacing
    drawMeasureBar(x, staffY, barHeight);  // Draw the barlines at the end of each measure
  }
}

// Helper function to draw a single staff line
void drawStaffLine(float x, float y, float width) {
  stroke(0);  // Black lines for the staff
  line(x, y, x + width, y);
}

// Helper function to draw vertical bars between measures
void drawMeasureBar(float x, float y, float barHeight) {
  stroke(0);  // Black line for measure bars
  line(x, y, x, y + barHeight);  // Vertical line
}

// Function to draw a note in the bar
void drawNotesInBar(float x, float y, float barWidth, float barHeight, String[] notes) {
  // Draw each note based on the provided array of note strings
  for (int i = 0; i < notes.length; i++) {
    String note = notes[i];
    char noteLetter = note.charAt(0); // Get the note letter (E, D, C, etc.)
    int octave = Character.getNumericValue(note.charAt(1)); // Get the octave (3, 4, etc.)

    // Calculate the y position for the note based on its letter and octave
    float noteY = calculateNoteYPosition(noteLetter, octave, y, barHeight);

    // Draw the note as a black circle
    fill(0);  // Black color for the note
    // Evenly distribute notes across the width of the entire staff
    float noteX = x + (barWidth / notes.length) * i + (barWidth / notes.length) / 2;  
    ellipse(noteX, noteY, 10, 10);  // Draw a note in the correct position
  }
}

// Function to calculate the y position based on note letter and octave
float calculateNoteYPosition(char noteLetter, int octave, float startY, float barHeight) {
  // Define the step size for each line/space in the staff
  float stepSize = barHeight / 4; // Adjust based on the bar height

  // Define the base line for the top of the staff (F5)
  float baseY = startY + (4 * stepSize); // F4 is on the top line
  float noteY = baseY;
if (octave == 4){
  switch (noteLetter) {
    case 'G':
      noteY -= 1.5 * stepSize; // G4 on the third line
      break;
    case 'F':
      noteY -= 0.5 * stepSize; // F4 in the fourth space
      break;
    case 'E':
      noteY -= 0 * stepSize; // E4 on the bottom line
      break;
    case 'D':
      noteY -= -0.5 * stepSize; // D5 on the top line
      break;
    case 'C':
      noteY -= -1 * stepSize; // C5 in the first space
      break;
    case 'B':
      noteY -= -1.5 * stepSize; // B5 on the second line
      break;
    case 'A':
      noteY -= -2 * stepSize; // A5 in the second space
      break;
    default:
      // Handle notes outside of the expected octaves as needed
      return startY + (barHeight / 2); // Default to middle of the staff
  }

}
  // Adjust noteY based on the note letter and octave
  

  return noteY;
}

public void drawSheetMusic() {
  float barWidth = width / 6;  // Width of each bar
  float barHeight = height / 10;  // Height for a single bar of music
  float staffY = height / 6;  // Y position for the top staff (above piano)
  float staffSpacing = height / 12;  // Vertical space between treble clef sections

  // Render the sheet music with 4 bars for the top section
  renderSheetMusic(barWidth, barHeight, staffY);

  // Draw notes for the top section in a single call
  float marginX = width - (barWidth * 4 + 10 * 3) - 20; // Adjust margin for notes
  drawNotesInBar(marginX, staffY, barWidth, barHeight, notes);
}
