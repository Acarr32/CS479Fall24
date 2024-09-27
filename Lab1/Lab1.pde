import processing.serial.*;
int heartrate = 0;
int confidence = 0;
int oxygen = 0;
int status = 0;
void setup() {
  size(1024, 900);
  
  boolean showPorts = false;
  System.out.println(Serial.list());
  //String portname = Serial.list()[1];
  //showPortData(showPorts);
  //myPort = new Serial(this, Serial.list()[1], 115200);
  
  //renderLoadingWindow();
  
  //modeI();
  
  //modeII();
  
  
}

void draw() {
  
  //SenseStress();
}

void serialEvent(Serial myPort){
  String Value = myPort.readStringUntil('\n');
  if(Value != null){
    String[] values = split(Value,", ");
    heartrate = int(values[0]);
    confidence = int(values[1]);
    oxygen = int(values[2]);
    status = int(values[3]);
    System.out.println(values);
  }
  else{
    System.out.println("not working");
  }
}
