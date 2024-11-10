import java.util.ArrayList;
// States of the application
enum State {
  GRAPHS, GAME, PROFILE
}

enum Profiles{
  Normal,
  InToe,
  OutToe,
  TipToeing,
  Heeling
}

class Accelerometer{
  float x;
  float y;
  float z;
  
  Accelerometer(){
    this.x = 0.0;
    this.y = 0.0;
    this.z = 0.0;
  }
  Accelerometer(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void setX(float x){ this.x = x; }
  void setY(float y){ this.y = y; }
  void setZ(float z){ this.z = z; }
  
  float getX(){ return this.x; }
  float getY(){ return this.y; }
  float getZ(){ return this.z; }
}

class Gyroscope{
  float x;
  float y;
  float z;
  
  Gyroscope(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void setX(float x){ this.x = x; }
  void setY(float y){ this.y = y; }
  void setZ(float z){ this.z = z; }
  
  float getX(){ return this.x; }
  float getY(){ return this.y; }
  float getZ(){ return this.z; }
}

String GetProfileString(Profiles profile){
  switch(profile){
    case Normal:
      return "Profile: Walking Normally";
    case InToe:
      return "Profile: In-Toeing";
    case OutToe:
      return "Profile: Out-Toeing";
    case TipToeing:
      return "Profile: Tip Toeing";
    case Heeling:
      return "Profile: Walking on Heels";
    default:
      return "ERROR 001"; // String not processed
  }
}

State currentState = State.GRAPHS;

int inputBuffer = 10;
int sampleTime = 10;

Accelerometer currAcc = new Accelerometer();
Gyroscope currGyro;

ArrayList<Accelerometer> accArr = new ArrayList<Accelerometer>();
ArrayList<Gyroscope> gyroArr = new ArrayList<Gyroscope>();

float cMM; float cMF; float cLF; float cHeel;
int MMcount = 0; int MFcount = 0; int LFcount = 0; int Heelcount = 0;
float[] MMarr = new float[20]; float[] MFarr = new float[20]; float[] LFarr = new float[20]; float[] Heelarr = new float[20];
//ArrayList<Float> MMarr = new ArrayList<Float>(); ArrayList<Float> MFarr = new ArrayList<Float>(); ArrayList<Float> LFarr = new ArrayList<Float>(); ArrayList<Float> Heelarr = new ArrayList<Float>();
PImage img;

// Graphs dimensions
float graphWidth, graphHeight;

// Text Column dimensions
float columnWidth, textWidth, marginX, distX;

final float MAX_FORCE_READING = 1000;

// Buttons to change the view
Button gameButton, profileButton;
float modeButtonsY, buttonWidth, buttonHeight;

// Back Buttton
float backButtonX, backButtonY, backButtonWidth, backButtonHeight;
Button backButton;

// Variables for input fields
String stepLengthInput = "";
String stepWidthInput = "";

// Placeholder variables for calculated data
String strideLength = "0";
String stepCount = "0";
String cadence = "0";
String walkingProfile = "Normal";
String userStatus = "Active";

float labelX, labelY, lineHeight;
boolean isStepLengthActive, isStepWidthActive;

// Variables for foot image
PImage footImg;
float footX, footY;
Foot foot;

// Game mode
int score = 0;
color targetColor;
boolean showFeedback = false;
String feedbackText = "";
int lastColorChange = 0;
int colorChangeInterval = 1000;
