void initializeVariables(){
   currentState = State.Menu;
   boldFont = createFont("SansSerif-Bold", 24);
}

void initializeSerialPort(int port, boolean debug){
  if (Serial.list().length > 0) {
    myPort = new Serial(this, Serial.list()[port], 115200);
  }
  else{
    if(debug){
      System.out.println("No serial ports available.");
      return;
    }
  }
  
  if(debug){
    System.out.println("Serial Ports:");
    for(int i = 0; i < Serial.list().length; i++){
      System.out.println(Serial.list()[i]);
    }
    printLine();
  }
}

void printLine(){
  System.out.println("=====================");
}
