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
