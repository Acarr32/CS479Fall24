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
        String[] values = split(value, ", ");
        float thm = float(values[0]);
        float ind = float(values[1]);
        float mid = float(values[2]);
        float flx = float(values[3]);
        float vtg = float(values[4]);
        Accelerometer acc = new Accelerometer(float(values[5]), float(values[6]), float(values[7]));
        Gyroscope gyr = new Gyroscope(float(values[8]), float(values[9]), float(values[10]));
        currValues = new Values(thm, ind, mid, flx, vtg, acc, gyr);
        currValues.printValues();
     }
     catch(Exception e){
       System.out.println("Error occurred: "+e);
     }
   }
}
