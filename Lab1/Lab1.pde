import processing.serial.*;

// Serial communication object
Serial myPort;


void setup() {
  size(400, 400);
  
  // Initialize serial communication
  String portName = Serial.list()[1]; // Select the correct port (change index if needed)
  
  
  println("Available Ports: ");
  printArray(Serial.list());
  println("Port loaded: " + portName);
  myPort = new Serial(this, portName, 115200);
  
  delay(4000); // Give time for sensor to configure
}

void draw() {
  String sensorData = myPort.readString();
  
  bioData parsedData = ParseInput(sensorData);
  
  // Draw the UI elements
  drawUI();
  
  //Draw the Graph elements
  drawGraph();
  
}


bioData ParseInput(String input){   
    return new bioData();
}
