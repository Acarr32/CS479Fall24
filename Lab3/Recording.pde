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
  text(GetString("recording_title"), width / 2, 100);
  
  // Handle playback
  if (isPlayingBack) {    
    if (isPlayingSample) {
      playBack(sampleNotes);
    } else {
      playBack(keyPresses);
    }
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
  else {
    if (!sampleNotes.isEmpty()){
      sampleNotes.clear(); // Clears all elements from sampleNotes
    }
    
    // Add each note with a 5000 ms timestamp
    int time = 750;
    
    for (String note : notes) {
        sampleNotes.add(note + "," + String.valueOf(time));
        
        time += 750;
    }
        
    if (!sampleNotes.isEmpty()) {
      isPlayingBack = true;
      isPlayingSample = true;
      playbackStartTime = millis();
      playbackIndex = 0;
      println("Playback started...");
      
      playSampleButton.changeColor(color(0, 255, 0));
      playBack(sampleNotes);
    }
  }
}

// Playback logic (plays the recorded events)
void playBack(ArrayList<String> keys) {
  if (playbackIndex < keys.size()) {
    String[] data = split(keys.get(playbackIndex), ',');
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
    isPlayingSample = false;
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

//-----------------------------------------------------------------------------------------
public void renderSheetMusic(float barWidth, float barHeight, float staffY) {
  // Define dimensions of the entire section (4 bars)
  float barSpacing = 10;  // Space between bars
  float staffSpacing = barHeight / 4;  // Space between lines in the staff
  float marginX = width - (barWidth * 4 + barSpacing *5) - 20; // Offset for the right side

  // Draw the treble and bass staff lines across all 4 bars
  for (int line = 0; line < 11; line++) {
    float lineY = staffY + line * staffSpacing;
    if (line != 5){
    drawStaffLine(marginX, lineY, (barWidth * 4) + (barSpacing * 3)); // Draw one line across all 4 bars
    }
  }

  // Draw vertical measure bars between the bars (to split the staff into 4 equal sections)
  for (int bar = 0; bar < 3; bar++) { // Draw 3 measure bars between 4 bars
    float x = marginX + (bar + 1) * (barWidth + barSpacing); // Adjust x for spacing
    drawMeasureBar(x, staffY, barHeight);  // Draw the barlines at the end of each measure
    float bassStaffY = staffY + staffSpacing * 6;
    drawMeasureBar(x, bassStaffY, barHeight);
  //Draw Beginning and End vertical bars
  drawMeasureBar(marginX-50, staffY, barHeight*2.5);
  drawMeasureBar(marginX+ (barWidth * 4) + (barSpacing * 3), staffY, barHeight*2.5);
  }
}

// Helper function to draw a single staff line
void drawStaffLine(float x, float y, float newwidth) {
  stroke(0);  // Black lines for the staff
  line(x-50, y, x + newwidth, y);
}

// Helper function to draw vertical bars between measures
void drawMeasureBar(float x, float y, float barHeight) {
  stroke(0);  // Black line for measure bars
  line(x, y, x, y + barHeight);  // Vertical line
}

// Function to draw a note in the bar
// Function to draw a note in the bar
void drawNotesInBar(float x, float y, float barWidth, float barHeight, String[] notes) {
  // Define the positions within each bar where the notes should be placed
  float[] notePositions = {1.0/8, 3.0/8, 5.0/8, 7.0/8};

  // Loop over all 4 bars
  int totalBars = 4;
  int noteIndex = 0; // Keep track of the current note in the notes array

  for (int bar = 0; bar < totalBars; bar++) {
    float barX = x + bar * (barWidth + 10); // Calculate the starting X position for each bar

    // For each bar, place up to 4 notes at the specified positions
    for (int i = 0; i < notePositions.length && noteIndex < notes.length; i++) {
      String note = notes[noteIndex];
      char noteLetter = note.charAt(0); // Get the note letter (E, D, C, etc.)
      int octave = Character.getNumericValue(note.charAt(1)); // Get the octave (3, 4, etc.)

      // Calculate the y position for the note based on its letter and octave
      float noteY = calculateNoteYPosition(noteLetter, octave, y, barHeight);

      // Calculate the x position based on the notePositions array
      float noteX = barX + notePositions[i] * barWidth;

      fill(0);  // Black color for the note
      ellipse(noteX, noteY, 35, 25);  // Draw the note in the correct position

      noteIndex++;  // Move to the next note
    }
  }
}

// Function to calculate the y position based on note letter and octave
float calculateNoteYPosition(char noteLetter, int octave, float startY, float barHeight) {
  // Define the step size for each line/space in the staff
  float stepSize = barHeight / 4; // Adjust based on the bar height

  // Define the base line for the top of the staff (F5)
  float baseY = startY + (4 * stepSize); // F4 is on the top line
  float noteY = baseY;
if (octave == 5){
  switch (noteLetter) {
    case 'G':
      noteY -= 8 * stepSize; // G4 on the third line
      break;
    case 'F':
      noteY -= 7.5 * stepSize; // F4 in the fourth space
      break;
    case 'E':
      noteY -= 7 * stepSize; // E4 on the bottom line
      break;
    case 'D':
      noteY -= 6.5 * stepSize; // D5 on the top line
      break;
    case 'C':
      noteY -= 6 * stepSize; // C5 in the first space
      break;
    case 'B':
      noteY -= 5.5 * stepSize; // B5 on the second line
      break;
    case 'A':
      noteY -= 5 * stepSize; // A5 in the second space
      break;
    default:
      // Handle notes outside of the expected octaves as needed
      return startY + (barHeight / 2); // Default to middle of the staff
  }
}
  if (octave == 4){
  switch (noteLetter) {
    case 'G':
      noteY -= 4.5 * stepSize; // G4 on the third line
      break;
    case 'F':
      noteY -= 4 * stepSize; // F4 in the fourth space
      break;
    case 'E':
      noteY -= 3.5 * stepSize; // E4 on the bottom line
      break;
    case 'D':
      noteY -= 3 * stepSize; // D5 on the top line
      break;
    case 'C':
      noteY -= 2.5 * stepSize; // C5 in the first space
      break;
    case 'B':
      noteY -= 2 * stepSize; // B5 on the second line
      break;
    case 'A':
      noteY -= 1.5 * stepSize; // A5 in the second space
      break;
    default:
      // Handle notes outside of the expected octaves as needed
      return startY + (barHeight / 2); // Default to middle of the staff
  }
}
  
if (octave == 3){
  switch (noteLetter) {
    case 'G':
      noteY -= 1 * stepSize; // G4 on the third line
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
if (octave == 2){
  switch (noteLetter) {
    case 'G':
      noteY -= -2.5 * stepSize; // G4 on the third line
      break;
    case 'F':
      noteY -= -3 * stepSize; // F4 in the fourth space
      break;
    case 'E':
      noteY -= -3.5 * stepSize; // E4 on the bottom line
      break;
    case 'D':
      noteY -= -4 * stepSize; // D5 on the top line
      break;
    case 'C':
      noteY -= -4.5 * stepSize; // C5 in the first space
      break;
    case 'B':
      noteY -= -5 * stepSize; // B5 on the second line
      break;
    case 'A':
      noteY -= -5.5 * stepSize; // A5 in the second space
      break;
    default:
      // Handle notes outside of the expected octaves as needed
      return startY + (barHeight / 2); // Default to middle of the staff
  }
}
if (octave == 1){
  switch (noteLetter) {
    case 'G':
      noteY -= -6 * stepSize; // G4 on the third line
      break;
    case 'F':
      noteY -= -6.5 * stepSize; // F4 in the fourth space
      break;
    case 'E':
      noteY -= -7 * stepSize; // E4 on the bottom line
      break;
    case 'D':
      noteY -= -7.5 * stepSize; // D5 on the top line
      break;
    case 'C':
      noteY -= -8 * stepSize; // C5 in the first space
      break;
    case 'B':
      noteY -= -8.5 * stepSize; // B5 on the second line
      break;
    case 'A':
      noteY -= -9 * stepSize; // A5 in the second space
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
  float barWidth = width / 5;  // Width of each bar
  float barHeight = height / 10;  // Height for a single bar of music
  float staffY = height / 6;  // Y position for the top staff (above piano)
  float staffSpacing = height / 12;  // Vertical space between treble clef sections

  // Render the sheet music with 4 bars for the top section
  renderSheetMusic(barWidth, barHeight, staffY);

  // Draw notes for the top section in a single call
  float marginX = width - (barWidth * 4 + 10 * 5) - 20; // Offset for the right side

  drawNotesInBar(marginX, staffY, barWidth, barHeight, notes);
  image(trebleIcon, marginX-15, staffY + barHeight/2 +10, 150, 150);  // Draw treble clef image
  image(bassIcon, marginX-10, staffY + barHeight + staffSpacing +10 , 100, 100);  // Draw bass clef image
}
