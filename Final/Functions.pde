void initializeVariables(){
  currentState = State.Init;
  boldFont = createFont("SansSerif-Bold", 24);
  mossGreen = color(62, 86, 65);
  rustyRed = color(162, 73, 54);
  coralOrange = color(218, 125, 88);
  charcoalGray = color(29, 32, 29);
  seafoamGreen = color(131, 188, 169);
  currPinkyForce = 0;
  currRingForce = 0;
  currMiddleForce = 0;
  Started = false;
  currentFlex = 0;
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


public static <T> T[] clipArray(ArrayList<T> arr, int start, int end) {
  int size = end - start;
  
  T[] ret = (T[]) new Object[size];
  
  for(int i = start; i < end; i++){
    ret[start-i] = arr.get(i);
  }
  
  return ret;
}

void printLine(){
  System.out.println("=====================");
}

void determineHold(){
  currentHold = Hold.Jog;
}

void determineClimbingStatus(){
  currentStatus = ClimbingStatus.Climbing;
}

void performHandReadings() {
  JOptionPane.showMessageDialog(null, "Clench your hand and press spacebar to continue.");
  clenchedHandFlexReading = currentFlex;
  
  JOptionPane.showMessageDialog(null, "Relax your hand and press spacebar to continue.");
  relaxedHandFlexReading = currentFlex;
  
  currentState = State.Graph;
}

void drawGraphing(){
  if(Started){
    //Determine Status
    determineHold();
    determineClimbingStatus();
  }
  else{
    textSize(50);
    fill(seafoamGreen);
    text("Press the 'Start' button to begin tracking data!", width *.1, height *.45);
    textSize(50);
    fill(0);
  }
  
  
  //Draw Buttons
  startButton.display();
  stopButton.display();
  statusButton.display();
  holdButton.display();
  
  //Draw Images
  image(handImg, handAnchorX, handAnchorY, handWidth, handHeight); 
  
  //Draw Bubbles
  drawBubbles();
  
  drawGraphs();
}

void LoadGraphing(){  
  //Initialize buttons
  startButton = new Button(width * .81, height * .025, width * .18, height * .1, "Start", mossGreen); 
  stopButton = new Button(width * .81, (height * .025) + (height * .15), width * .18, height * .1, "Stop", rustyRed);
  
  determineHold();
  determineClimbingStatus();

  statusButton = new Button(width * .025, height * .5, width / 3, height / 8, "Climber Status: " + ClimbingString(currentStatus), rustyRed);
  holdButton = new Button((width * .05) + width / 3, height * .5, width / 3, height / 8, "Current Hold: " + HoldString(currentHold), coralOrange);
  
  
  //Initialize images
  handImg = loadImage("hand.png");
  //climbing1 = loadImage("climb1.png");
  //climbing2 = loadImage("climb1.png");
  
  handAnchorX = width * .825;
  handAnchorY = (height * .025) + (height * .15) + (height * .1) + (height * .025);
  handWidth = width * .15;
  handHeight = height * .25;
  
  //Initialize Bubble Locations
  pinkyX = handAnchorX + (handWidth * .14);
  pinkyY = handAnchorY + (handHeight * .3);
  
  ringX = handAnchorX + (handWidth * .31);
  ringY = handAnchorY + (handHeight * .19);
  
  middleX = handAnchorX + (handWidth * .48);
  middleY = handAnchorY + (handHeight * .13);
  
  //Initialize Plots
  initializeGraphs();
  //Set Load Flag
  GraphingLoaded = true;
}


void Start(){
  Started = true;
  clock = millis();
  fsrData.clear();
  flexData.clear();
  heightData.clear();
  
}
void Stop(){
  Started = false;
  writeClimbingData(fsrData, flexData, heightData);
}

void addData(float pinkyReading, float ringReading, float middleReading, float flexReading, float heightReading){
  currPinkyForce = pinkyReading;
  currRingForce = ringReading;
  currMiddleForce = middleReading;
  
  if(!Started){
    return;
  }
  
  Data pinkyData, ringData, middleData, flexD, heightD;
  
  int currTime = (int)(millis() - clock);
  
  pinkyData = new Data(pinkyReading, currTime);
  ringData = new Data(ringReading, currTime);
  middleData = new Data(middleReading, currTime);
  flexD = new Data(flexReading, currTime);
  heightD = new Data(heightReading, currTime);
  
  ArrayList<Data> tempFlexData = new ArrayList<Data>();
  tempFlexData.add(pinkyData);
  tempFlexData.add(ringData);
  tempFlexData.add(middleData);
  
  fsrData.add(tempFlexData);
  flexData.add(flexD);
  heightData.add(heightD);
}
ArrayList<ArrayList<Data>> addShell(ArrayList<Data> data){
  ArrayList<ArrayList<Data>> d = new ArrayList<ArrayList<Data>>();
  d.add(data);
  return d;
}


ArrayList<Data> generateDummyData(int numPoints) {
    ArrayList<Data> data = new ArrayList<>();
    for (int i = 0; i < numPoints; i++) {
        data.add(new Data(random(0, 100), i * 1000)); // Replace with your real data
    }
    return data;
}
