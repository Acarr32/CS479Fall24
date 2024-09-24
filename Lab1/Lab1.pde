import processing.serial.*;
import javax.swing.JOptionPane;

// Serial communication object
Serial myPort;


void setup() {
  size(1024, 900);
  
  // Initialize serial communication
  String portName = Serial.list()[1]; // Select the correct port (change index if needed)
  
  
  println("Available Ports: ");
  printArray(Serial.list());
  println("Port loaded: " + portName);
  myPort = new Serial(this, portName, 115200);
  
  renderLoadingWindow();
  
  drawStaticUI();
}

void draw() {
  String sensorData = myPort.readString();
  
  bioData parsedData = ParseInput(sensorData);
  
  updateMetrics();
  
}


bioData ParseInput(String input){   
    return new bioData();
}
