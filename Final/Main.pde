import java.util.*;
void setup(){
  fullScreen();
  
  //Environment & Feature Initializations
  initializeVariables();
  initializeSerialPort(0, false); //port#, debug
  initializeGraphs();
  
  
  //Print 
  background(255);
  textSize(24);
  textAlign(CENTER);
}

void draw(){
  background(charcoalGray);
  switch(currentState){
    case Init:
      performHandReadings();
      break;
    case Graph:
      if(!GraphingLoaded){
        LoadGraphing();
      }
      drawGraphing();
      break;
    default:
      break;
  }
}
