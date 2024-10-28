float[] stringY = new float[6]; // Array to store Y-coordinates of each string
int stringSpacing = 8; // Space between each string
int sizeOfGuitarString = 1;

void guitarMode() {
  calculateStringPositions();
  drawBackButton();
  renderGuitar();
  drawBackButton();
}

void renderGuitar() {
  background(255); // Set background color

  // Draw guitar body
  fill(139, 69, 19); // Brown color for the guitar body
  ellipse(width / 2 - 250, height / 2, 500, 300); // Main body (horizontal)

  // Draw guitar neck
  fill(160, 82, 45); // Slightly darker color for the neck
  rect(width / 2 - 600, height / 2 - 25, 400, 50);

  // Draw sound hole
  fill(0); // Black color for sound hole
  ellipse(width / 2 - 250, height / 2, 80, 80);

  // Draw 6 strings and store their positions
  stroke(220);
  strokeWeight(2);
  for (int i = 0; i < 6; i++) { // Change loop limit to 6
    float yPosition = height / 2 + (i - 2.5) * stringSpacing; // Calculate Y-position for each string
    stringY[i] = yPosition; // Store each string's Y-coordinate in array
    line(width / 2 - 600, yPosition, width / 2, yPosition);
  }
  //drawGameInterface();
}

//void drawGameInterface() {
//  int interfaceWidth = 700; // Width of the game interface
//  int interfaceHeight = height; // Full height of the screen
//  int interfaceX = width - interfaceWidth; // X position for the interface
//  int interfaceY = 0; // Y position for the interface

//  // Draw interface background
//  fill(240); // Light gray background for the interface
//  rect(interfaceX, interfaceY, interfaceWidth, interfaceHeight);

//  // Draw some sample buttons/notes (you can customize this)
//  for (int i = 0; i < 5; i++) {
//    fill(100 + i * 30, 150, 200); // Different colors for each button
//    rect(interfaceX + 20, interfaceY + 50 + i * 50, 160, 40); // Draw buttons
//  }
//}

void calculateStringPositions() {
  for (int i = 0; i < 6; i++) { // Change loop limit to 6
    stringY[i] = height / 2 + (i - 2.5) * stringSpacing; // Set Y-coordinates for even spacing
  }
}

void guitarSerial(Integer[] keysActive){
  SoundFile[] guitarNotes = new SoundFile[sizeOfGuitarString];
  for(int i = 0; i<keysActive.length; i++){
    String noteFile = "./guitar-mp3/";
    if(keysActive[i] == 0){
      break;
    }
    switch(keysActive[i]){
      case 1:
        noteFile += "1st_String_E_64kb.mp3";
        guitarNotes[i] = new SoundFile(this, noteFile);
        break;
      case 2:
        noteFile += "2nd_String_B_64kb.mp3";
        guitarNotes[i] = new SoundFile(this, noteFile);
        break;
      case 3:
        noteFile += "3rd_String_G_64kb.mp3";
        guitarNotes[i] = new SoundFile(this, noteFile);
        break;
      case 4:
        noteFile += "4th_String_D_64kb.mp3";
        guitarNotes[i] = new SoundFile(this, noteFile);
        break;
      case 5:
        noteFile += "5th_String_A_64kb.mp3";
        guitarNotes[i] = new SoundFile(this, noteFile);
        break;
      case 6:
        noteFile += "6th_String_E_64kb.mp3";
        guitarNotes[i] = new SoundFile(this, noteFile);
        break;
      case 7:
        noteFile += "C_64kb.mp3";
        guitarNotes[i] = new SoundFile(this, noteFile);
        break;
      case 8:
        noteFile += "D_64kb.mp3";
        guitarNotes[i] = new SoundFile(this, noteFile);
        break;
      case 9:
        noteFile += "Dm_64kb.mp3";
        guitarNotes[i] = new SoundFile(this, noteFile);
        break;
      case 10:
        noteFile += "E_64kb.mp3";
        guitarNotes[i] = new SoundFile(this, noteFile);
        break;
    }
  }
  playString(guitarNotes);
}

void playString(SoundFile[] guitarNotes) {
  for(int i = 0; i<guitarNotes.length; i++){
    guitarNotes[i].play();
  }
}
