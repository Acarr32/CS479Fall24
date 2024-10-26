import processing.sound.*;
import java.util.*;
import processing.serial.*; //**************************************
Serial myPort; //**************************************

void setup() {
  fullScreen();
  currentState = State.Menu;
  maxTitleSize = height * 0.1; // 10% of the height
  minTitleSize = height * 0.03; // 3% of the height
  // myPort = new Serial(this, Serial.list()[0], 9600);//**************************************
  delay(3000);//**************************************

  // Set up the back button dimensions
  backButtonWidth = width / 15;
  backButtonHeight = height / 15;
  backButtonX = width - backButtonWidth - 20;
  backButtonY = 20;
  
  bassIcon = loadImage("img/bass.png");
  playIcon = loadImage("img/play.png");
  playSampleIcon = loadImage("img/playSample.png");
  startIcon = loadImage("img/start.png");
  stopIcon = loadImage("img/stop.png");
  trebleIcon = loadImage("img/treble.png");
}
//**************************************below
void serialEvent(Serial myPort) {
  String value = myPort.readStringUntil('\n');  // Read serial input until newline
  try {
    if (value != null) {
      System.out.println("Serial Input: " + value);  // Debugging: print raw serial input
      value = trim(value);
      
      String[] values = split(value, " ");
      System.out.println("Parsed Values: " + Arrays.toString(values));  // Debugging: print parsed values
      
      switch(currentState) {
        case Piano:
          Integer[] keysActive = new Integer[12];
          boolean keyPressed = false;
          int octave = 0;
          
          for (int i = 0; i < values.length; i++) {
            if (values[i].equals("1")) {  // Fix string comparison (use .equals() for string comparison)
              System.out.println("Key Pressed at index: " + i);  // Debugging: print which key is pressed
              
              if (i == 0) {
                octave = -1;  // Adjust octave down
              }
              if (i == 11) {
                octave = 1;   // Adjust octave up
              } else {
                octave = 0;   // No octave shift
                keysActive[i] = i;  // Register active key
                keyPressed = true;
              }
            }
          }
          
          if (!keyPressed) {
            System.out.println("No keys pressed.");
            keysActive = new Integer[0];  // No keys pressed, set active keys to empty
          }
          
          System.out.println("Active Keys: " + Arrays.toString(keysActive));  // Debugging: print active keys
          pianoSerial(keysActive, octave);  // Call pianoSerial function with detected keys and octave shift
          break;
          
        case Guitar:
          // Logic for Guitar mode if implemented
          break;
          
        default:
          break;
      }
    } else {
      return;
    }
  } catch (Exception e) {
    System.out.println("Parsing Error");
    System.out.println(e);
  }
}
//**************************************above
void draw() {
  background(255);
  
  switch (currentState){  
    case Menu:
      drawMenu();
      break;
    case Piano:
      currentState = State.Piano;
      drawPiano();
      drawBackButton();
      break;
    case Recording:
      currentState = State.Recording;
      drawRecording();
      handleRecordingPageButtons();
      drawBackButton();
      drawPiano();
      drawSheetMusic();
      break;
    default:
      background(255);
      drawBackButton();
  }
}

// Function to draw the back button
public void drawBackButton() {
  fill(150);
  backButton = new Button(backButtonX, backButtonY, backButtonWidth, backButtonHeight, "Back", null, color(150));
  backButton.display();
  
  if (backButton.isMouseOver()) {
    currentState = State.Menu;
  }
}
