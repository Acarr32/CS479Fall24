
import processing.serial.*;
import org.gicentre.utils.stat.*;
//import front_end;

Serial myPort;

void setup() {
  String portName = Serial.list()[0];
  print(portName);
  
  myPort = new Serial(this, portName, 115200);
  myPort.bufferUntil('\n');
  size(900,1000);

  
  //print (Serial.list());
  
  graph_setup();
}

void draw() {
  FrontEnd();
}


void serialEvent(Serial myPort) {
  String tempVal = myPort.readStringUntil('\n');
  
  if (tempVal != null) {
    tempVal = trim(tempVal);
    float  value = float(tempVal);
    
    println(value);
  }
}
