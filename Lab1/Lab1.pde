import processing.serial.*;

// Serial communication object
Serial myPort;

// Simulate bioData object structure
class bioData {
  float heartRate;
  float confidence;
  float oxygen;
  int status;
}

// ArrayList to store bioData objects
ArrayList<bioData> infoList = new ArrayList<bioData>();

void setup() {
  size(400, 400);
  
  // Initialize serial communication
  String portName = Serial.list()[1]; // Select the correct port (change index if needed)
  
  
  println("Available Ports: ");
  printArray(Serial.list());
  println("Port loaded: " + portName);
  myPort = new Serial(this, portName, 115200);
  
  delay(1000); // Delay to stabilize the sensor
  
  println("Sensor started!");
  println("Configuring Sensor....");
  delay(4000); // Give time for sensor to configure
}

void draw() {
  String sensorData = myPort.readString();
  println(sensorData);
 
    if (false) {
      
      String[] values = split(trim(sensorData), ',');
      
      if (values.length == 4) {
        bioData body = new bioData();
        body.heartRate = float(values[0]);
        body.confidence = float(values[1]);
        body.oxygen = float(values[2]);
        body.status = int(values[3]);
        
        infoList.add(body);
        
        // Print the sensor data to the console
        println("Heart rate: " + body.heartRate);
        println("Confidence: " + body.confidence);
        println("Oxygen: " + body.oxygen);
        println("Status: " + body.status);
      }
    }
    else{
      //println("Invalid Read!");
    }
  
  // Delay between readings
  delay(500);
}
