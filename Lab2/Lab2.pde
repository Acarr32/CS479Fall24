import grafica.*;
import javax.swing.*;

ArrayList<ArrayList<Integer>> data;
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

void setup() {
  size(800, 600);
  
  buttonWidth = width * 0.4;
  buttonHeight = height * 0.1; 
  buttonYStart = height * 0.2;
  buttonSpacing = height * 0.05;
  
  InitializeData();
  //InitializePlots();
  DrawMenu();
  
  frameRate(4); // Set frame rate to 4 FPS for 1/4 second sampling
}

void draw() {
  //InputLoop();
}
