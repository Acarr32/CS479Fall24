import processing.sound.*;
import processing.serial.*;

//void pianoSerial() - pass an array of keys pressed
void setup() {
  fullScreen();
  currentState = State.Menu;
  maxTitleSize = height * 0.1; // 10% of the height
  minTitleSize = height * 0.03; // 3% of the height
}

void draw() {
  background(255);
  switch (currentState){
    case Menu:
      drawMenu();
      break;
    case Piano:
      drawPiano();
      break;
    default:
      background(255);
  }
    
}

void serialEvent(Serial myPort){
  String value = myPort.readStringUntil('\n');  // Read serial input until newline
  if (value != null) {
    value = trim(value);
    
    String[] values = split(value, ",");
    switch(currentState){
      case Piano:
        int[] keysActive = new int[12];
        boolean keyPressed = false;
        for(int i = 0; i<values.length; i++){
          if(values[i] == "1"){
            keysActive[i] = i;
            keyPressed = true;
          }          
        }
        if(!keyPressed){
          keysActive = new int[0];
        }
        pianoSerial(keysActive);
    }
  }
}
