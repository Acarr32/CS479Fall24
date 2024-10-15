import grafica.*;
import javax.swing.*;
import processing.serial.*;
import processing.sound.*;

ArrayList<ArrayList<Integer>> hrdata;
ArrayList<ArrayList<Integer>> rrdata;
ArrayList<Integer> heartRates = new ArrayList<Integer>();
ArrayList<Integer> respirationRates = new ArrayList<Integer>();
ArrayList<Integer> ekgs = new ArrayList<Integer>();
Integer heartrate = 0;
Integer resprate = 0;
Integer ekg = 0;
GPlot respirationPlot, heartRatePlot, ekgPlot;
int baselineHeartRate = 0;
boolean baselineCollected = false;
int timeStep = 0; // To track the time for EKG data
float frequency = 30.0; // Frequency of the sinusoidal wave for EKG

float buttonWidth;
float buttonHeight;
float buttonYStart;
float buttonSpacing;

boolean collectingBaseline = true;
int baselineDuration = 30000; // 30 seconds in milliseconds
float restingHeartRate = 0;
float restingRespiratoryRate = 0;
int startTime;
int cardioZone = 0;
boolean inMenu = true;
boolean Graphing = false;
boolean MeditationMode = false;

int frameTracker = 0;
int breathCycleSeconds = 2;

void setup() {
  size(800, 600);
  
  buttonWidth = width * 0.4;
  buttonHeight = height * 0.1; 
  buttonYStart = height * 0.2;
  buttonSpacing = height * 0.05;
  
  InitializeData();
  
  DrawMenu();
  
  frameRate(4); // Set frame rate to 4 FPS for 1/4 second sampling
}

void serialEvent(Serial myPort) {
  String value = myPort.readStringUntil('\n');  // Read serial input until newline
  if (value != null) {
    value = trim(value);  // Trim whitespace or newline characters
    //println("Raw input: " + value);  // Print the raw input to verify format
    
    String[] values = split(value, ",");  // Split using comma (no space)
    
    // Check if the split operation returned exactly 2 values
    if (values.length == 2) {
      try {
        // Parse the first and second values as integers
        heartrate = int(trim(values[0]));  // Trim and parse the first value (heartrate)
        resprate = int(trim(values[1]));   // Trim and parse the second value (pressure)

        // Clear and add the new data to currData
        heartRates.clear();
        respirationRates.clear();
        heartRates.add(heartrate);
        respirationRates.add(resprate);
        
        // Limit the data array to store the last 10 readings
        if (rrdata.size() >= 25) {
          rrdata.remove(0);
        }
        rrdata.add(respirationRates);  // Add current data to the history
        
        if (hrdata.size() >= 25) {
          hrdata.remove(0);
        }
        hrdata.add(heartRates);
        
        // Print the parsed values
        System.out.print("Heartrate: " + heartrate + ", ");
        System.out.println("Pressure: " + resprate);
        
      } catch (NumberFormatException e) {
        // Handle any errors in parsing
        println("Error parsing the input values: " + value);
      }
    } else {
      // If we don't get exactly 2 values, report the issue
      println("Error: Unexpected data format. Expected 2 values, but got: " + values.length);
    }
  }
}

void draw() {
  if (Graphing) {
    background(255);  // Clear the background
    addData();        // Collect and add new data points
    InputLoop();      // Manage input loop, remove old data, and render graphs
    drawGraph();
    drawSpin();
    delay(250);       // Delay for each graph update
  }
  
  else if (MeditationMode) {
    background(255);  // Clear the background
    addData();        // Collect and add new data points
    drawGraph();
    drawMeditation();
    delay(250); 
    
    // breathCycleSeconds * 12 = 3s (sampling is 4FPS)
    if (frameTracker >= breathCycleSeconds * 3 * frameRate) {
      frameTracker = 0;  // Reset after each breath cycle
    } else {
      frameTracker++;
    }
  }
}
