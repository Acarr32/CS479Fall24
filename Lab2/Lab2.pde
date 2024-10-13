import grafica.*;
import javax.swing.*;

ArrayList<ArrayList<Integer>> hrdata;
ArrayList<ArrayList<Integer>> rrdata;
ArrayList<Integer> heartRates = new ArrayList<Integer>();
ArrayList<Integer> respirationRates = new ArrayList<Integer>();
Integer heartrate = 0;
Integer resprate = 0;
GPlot respirationPlot, heartRatePlot;
int baselineHeartRate = 0;
boolean baselineCollected = false;

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

void draw() {
  if (Graphing) {
    background(255);  // Clear the background
    addData();        // Collect and add new data points
    InputLoop();      // Manage input loop, remove old data, and render graphs
    drawGraph();      // Draw the graphs
    delay(250);       // Delay for each graph update
  }
}
