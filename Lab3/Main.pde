import processing.sound.*;
import java.util.*;
import processing.serial.*; //**************************************
Serial myPort; //**************************************

void setup() {
  fullScreen();
  currentState = State.Menu;
  maxTitleSize = height * 0.1; // 10% of the height
  minTitleSize = height * 0.03; // 3% of the height
  myPort = new Serial(this, Serial.list()[0], 115200);//**************************************
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
      System.out.print("Serial Input: " + value);  // Debugging: print raw serial input
      value = trim(value);

      String[] values = split(value, " ");
      System.out.println("Parsed Values: " + Arrays.toString(values));  // Debugging: print parsed values

      Integer[] keysActive = new Integer[12];
      int count = 0;
      boolean keyPressed = false;
      int octave = 0;
     
      switch(currentState) {
        case Piano:
          for (int i = 0; i < values.length; i++) {
            if (values[i].equals("1")) {  // Detects active keys correctly
              System.out.println("Key Pressed at index: " + i);  // Debugging: log pressed key index
              keyPressed = true;
              
              if (i == 0) {
                octave = -1;  // Adjust octave down
              } else if (i == 11) {
                octave = 1;   // Adjust octave up
              } else {
                keysActive[count++] = i;  // Register active key
              }
            }
          }
          
          // Resize keysActive array to match the number of active keys
          keysActive = Arrays.copyOf(keysActive, count);
          
          if (!keyPressed) {
            System.out.println("No keys pressed.");
            keysActive = new Integer[0];  // No keys pressed, set active keys to empty
          }

          System.out.println("Active Keys: " + Arrays.toString(keysActive));  // Debugging: print active keys
          pianoSerial(keysActive, octave);  // Call pianoSerial function with detected keys and octave shift
          break;
          
          
        case Recording:
          for (int i = 0; i < values.length; i++) {
            if (values[i].equals("1")) {  // Detects active keys correctly
              System.out.println("Key Pressed at index: " + i);  // Debugging: log pressed key index
              keyPressed = true;
              
              if (i == 0) {
                octave = -1;  // Adjust octave down
              } else if (i == 11) {
                octave = 1;   // Adjust octave up
              } else {
                keysActive[count++] = i;  // Register active key
              }
            }
          }
          
          // Resize keysActive array to match the number of active keys
          keysActive = Arrays.copyOf(keysActive, count);
          
          if (!keyPressed) {
            System.out.println("No keys pressed.");
            keysActive = new Integer[0];  // No keys pressed, set active keys to empty
          }

          System.out.println("Active Keys: " + Arrays.toString(keysActive));  // Debugging: print active keys
          pianoSerial(keysActive, octave);  // Call pianoSerial function with detected keys and octave shift
          break;
        case Guitar:
          for (int i = 0; i < values.length; i++) {
            if (values[i].equals("1")) {  // Detects active guitar strings
              System.out.println("Key Pressed at index: " + i);  // Debugging: log pressed string index
              keysActive[count++] = i;  // Register active key
              keyPressed = true;
            }
          }

          // Resize keysActive array to match the number of active keys
          keysActive = Arrays.copyOf(keysActive, count);

          if (!keyPressed) {
            System.out.println("No keys pressed.");
            keysActive = new Integer[0];  // No keys pressed, set active keys to empty
          }

          System.out.println("Active Keys: " + Arrays.toString(keysActive));  // Debugging: print active keys
          guitarSerial(keysActive);
          break;
          
        default:
          break;
      }
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
     case Guitar:
        guitarMode();
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
