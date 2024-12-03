void setup(){
  fullScreen();
  
  //Environment & Feature Initializations
  initializeVariables();
  initializeSerialPort(0, true); //port#, debug
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
    case Replay:
      if(!Started){
        if(replayClock == 0){ replayClock = millis(); }
        replay.drawReplay();
      }
    default:
      break;
  }
}


void mouseClicked(){
  if(currentState == State.Graph){
    if(Started && stopButton.isMouseOver()){
      Stop();
      replay = new Replay(replayValuesList);
    }
    else if(!Started && startButton.isMouseOver()){
      Start();
      hasStartedBefore = true;
    }
  }
  if(!Started && hasStartedBefore && replayButton.isMouseOver()){
      currentState = State.Replay;
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
        float ptr = float(values[1]);
        float mid = float(values[2]);
        float flx = float(values[3]);
        //float vtg = float(values[4]);
        Accelerometer acc = new Accelerometer(float(values[5]), float(values[6]), float(values[7]));
        Gyroscope gyr = new Gyroscope(float(values[8]), float(values[9]), float(values[10]));
        float alt = float(values[13]);
        float emg = float(values[11]);

        currValues = new Values(thm, ptr, mid, flx, alt, acc, gyr, emg);
        if(Started){
          if(prevThm == 0 && prevPtr == 0 && prevMid == 0){
            if(thm > 1 || ptr > 1 || mid > 1){
              ReplayValues temp = new ReplayValues(millis() - clock, thm, ptr, mid);
              temp.print();
              replayValuesList.add(temp);
            }
          }
           addData(currValues.GetThm(), currValues.GetPtr(), currValues.GetMid(),
           currValues.GetFlex(), currValues.GetAlt(), currValues.GetEmg());
        }
        prevThm = thm;
        prevPtr = ptr;
        prevMid = mid;
     }
     catch(Exception e){
       throwError(e, 5);
     }
   }
}
