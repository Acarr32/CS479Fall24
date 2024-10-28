float[] stringY = new float[6]; // Array to store Y-coordinates of each string
int stringSpacing = 16; // Space between each string
int sizeOfGuitarString = 1;

void guitarMode() {
  calculateStringPositions();
  drawBackButton();
  renderGuitar();
  drawBackButton();
  drawTitle();
}

void drawTitle() {
  fill(0); // Set text color to black
  textAlign(CENTER, TOP);
  textSize(50);
  text("Virtual Guitar Simulator", width / 2, 100); // Title at the top center
  textSize(30);
}

void renderGuitar() {
  background(255); // Set background color

  // Draw guitar body (make it larger)
  fill(139, 69, 19); // Brown color for the guitar body
  ellipse(width / 2 + 50, height / 2 + 100, 600, 400); // Main body (enlarged and centered)

  // Draw guitar neck (make it wider and longer)
  fill(160, 82, 45); // Slightly darker color for the neck
  rect(width / 2 - 550, height / 2 +50, 700, 100); // Extended neck width and height

  // Draw sound hole (scaled up for the larger guitar body)
  fill(0); // Black color for sound hole
  ellipse(width / 2 + 50, height / 2 + 100, 100, 100); // Centered larger sound hole

  // Draw 6 strings and store their positions
  stroke(220);
  strokeWeight(3); // Make strings thicker for a larger guitar
  for (int i = 0; i < 6; i++) {
    float yPosition = height / 2 + (i - 2.5) * stringSpacing + 100; // Adjust Y-position for larger body
    stringY[i] = yPosition; // Store each string's Y-coordinate in array
    line(width / 2 - 350, yPosition, width / 2 + 150, yPosition); // Extended strings along the neck and body
  }
  fill(0);
  rect(width/2 - 350, height/2 + 50, 5, 100);
  fill(50, 50, 200);
  rect(width/2 - 530, height / 2 + 65, 30, 70);
  fill(50, 200, 50);
  rect(width/2 - 490, height / 2 + 65, 30, 70);
  fill(200, 50, 50);
  rect(width/2 - 450, height / 2 + 65, 30, 70);
  fill(100, 155, 100);
  rect(width/2 - 410, height / 2 + 65, 30, 70);
}

void calculateStringPositions() {
  for (int i = 0; i < 6; i++) {
    stringY[i] = height / 2 + (i - 2.5) * stringSpacing; // Set Y-coordinates for even spacing
  }
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
