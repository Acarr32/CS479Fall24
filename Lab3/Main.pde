import processing.sound.*;
import java.util.*;
import processing.serial.*;

//void pianoSerial() - pass an array of keys pressed
void setup() {
  fullScreen();
  myPort = new Serial(this, Serial.list()[0], 9600); 
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

void serialEvent(){
  String value = myPort.readStringUntil('\n');  // Read serial input until newline
  if (value != null) {
    value = trim(value);
    
    String[] values = split(value, ",");
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
}
