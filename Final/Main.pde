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


void mouseClicked(){
  if(currentState == State.Graph){
    if(Started && stopButton.isMouseOver()){
      Stop();
    }
    else if(!Started && startButton.isMouseOver()){
      Start();
    }
  }
  
  if(holdButton.isMouseOver()){
    holdPopup();
  }
  if(statusButton.isMouseOver()){
    statusPopup();
  }
}
  

void serialEvent(Serial myPort){
   String value = myPort.readStringUntil('\n');
   if(value != null){
     try{
        value = trim(value);
        String[] values = split(value, " ");
     }
     catch(Exception e){
       System.out.println("Error occurred: "+e);
     }
   }
}
