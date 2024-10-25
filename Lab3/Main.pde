import processing.sound.*;
import java.util.*;
import processing.serial.*; //**************************************
Serial myPort; //**************************************

void setup() {
  fullScreen();
  currentState = State.Menu;
  maxTitleSize = height * 0.1; // 10% of the height
  minTitleSize = height * 0.03; // 3% of the height
  myPort = new Serial(this, Serial.list()[0], 9600);//**************************************
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
void serialEvent(Serial myPort){
  String value = myPort.readStringUntil('\n');  // Read serial input until newline
  try{
    if (value != null) {
      System.out.println(value);
      value = trim(value);
      
      String[] values = split(value, " ");
      
      //System.out.println("Values " + values);
      switch(currentState){
        case Piano:
          Integer[] keysActive = new Integer[12];
          boolean keyPressed = false;
          int octave = 0;
          for(int i = 0; i<values.length; i++){
            if(values[i] == "1"){
              if(i == 0){
                octave = -1;
              }
              if(i == 11){
                octave = 1;
              }
              else{
                octave = 0;
                keysActive[i] = i;
                keyPressed = true;
              }
            }
          }
          if(!keyPressed){
            keysActive = new Integer[0];
          }
          pianoSerial(keysActive, octave);
          
          case Guitar:
             break;
          default:
            break;
      }
    }
    else{
      return;
    }
  }
  catch(Exception e){
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
