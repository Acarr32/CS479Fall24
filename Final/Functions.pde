void initializeVariables(){
  currentState = State.Init;
  boldFont = createFont("SansSerif-Bold", 24);
  mossGreen = color(62, 86, 65); // #3E5641
  rustyRed = color(162, 73, 54); // #A24936
  coralOrange = color(218, 125, 88); // #DA7D58
  charcoalGray = color(29, 32, 29); // #1D201D
  seafoamGreen = color(131, 188, 169); // #83BCA9
  Started = false;
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

void determineHold() {
    if (currValues == null) {
        System.out.println("Error: currValues is null");
        currentHold = Hold.None0; // Set a default state if necessary
        return; // Exit the function early
    }
    else{
      System.out.println("currVals good");

    }

    // Debugging statements for validation
    System.out.println("Thumb Value: " + currValues.GetThm());
    System.out.println("Flex Value: " + currValues.GetFlex());

    // Evaluate flex thresholds for climbing holds
    float flex = currValues.GetFlex(); // Store the flex value to avoid repeated calls
    smoothFlex = (smoothingFactor * flex) + ((1 - smoothingFactor) * smoothFlex);

    if (flex > 0 && flex < 4) {
        currentHold = Hold.Sloper;
        System.out.println("Sloper");
    } else if (flex >= 4 && flex < 6) { // Updated to avoid overlap with the previous range
        currentHold = Hold.Crimp;
        System.out.println("Crimp");
    } else if (flex >= 6 && flex < 40) { // Avoid overlapping ranges
        currentHold = Hold.Jug;
        System.out.println("Jug");
    } else {
        currentHold = Hold.None;
        System.out.println("None");
    }
    
    holdButton.changeLabel(HoldString(currentHold));
}


void determineClimbingStatus(){
  if (currValues == null) {
        System.out.println("Error: currValues is null");
        currentStatus = ClimbingStatus.Stationary0; // Set a default state if necessary
        return; // Exit the function early
    }
    else{
      System.out.println("currVals good");
    }
      
    // Debugging statements for validation
    //System.out.println("Thumb Value: " + currValues.GetThm());
    //System.out.println("Flex Value: " + currValues.GetFlex());
    calcDeltaAlt();
    System.out.println(deltaAlt);

    if (smoothDeltaAlt > .04) { //if deltaAlt > 1
      currentStatus = ClimbingStatus.Climbing;
        System.out.println("Climbing");
    } else if (smoothDeltaAlt < -0.04) { //if deltaAlt <1
        currentStatus = ClimbingStatus.Falling;
        System.out.println("Falling");
    } else {
        currentStatus = ClimbingStatus.Stationary;
        System.out.println("Stationary");
    }
    statusButton.changeLabel(ClimbingString(currentStatus));
    ////currentStatus = ClimbingStatus.Climbing;
}

void calcDeltaAlt() {
  float alt = currValues.GetAlt();
  // Add the new altitude value to the ArrayList
  oldAltVals.add(alt);
  
  // Ensure the list contains no more than 10 values
  if (oldAltVals.size() > 10) {
      oldAltVals.remove(0);
  }

  // Calculate the average of the last 10 altitude values
  oldAltAvg = 0.0f;
  for (float value : oldAltVals) {
      oldAltAvg += value;
  }
  oldAltAvg /= oldAltVals.size();

  // Calculate the deltaAlt
  deltaAlt = alt - oldAltAvg;
  smoothDeltaAlt = (smoothingFactor * deltaAlt) + ((1 - smoothingFactor) * smoothDeltaAlt);

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
  if(!Started){ startButton.display(); }
  else{ stopButton.display(); }
  statusButton.display();
  holdButton.display();
  if(!Started && hasStartedBefore){
    replayButton.display();
  }
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
  replayButton = new Button(width * 0.81, (height * .025) + (height * 0.8), width * .18, height * .1, "Replay", coralOrange);
  
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
  middleX = handAnchorX + (handWidth * .48);
  middleY = handAnchorY + (handHeight * .13);
  
  pointerX = handAnchorX + (handWidth * .65);
  pointerY = handAnchorY + (handHeight * .2);
  
  thumbX = handAnchorX + (handWidth * .88);
  thumbY = handAnchorY + (handHeight * .55);
  
  //Initialize Plots
  initializeGraphs();
  //Set Load Flag
  GraphingLoaded = true;
}

void clearData(){
  fsrData.clear();
  flexData.clear();
  heightData.clear();
  emgData.clear();
}

void Start(){
  Started = true;
  clock = millis();
  clearData();

  seed = (int)(Math.random() * 4);
  
}
void Stop(){
  Started = false;
  writeClimbingData(fsrData, flexData, heightData, emgData);
}

void addData(float thumbReading, float pointerReading, float middleReading, float flexReading, float heightReading, float emgReading){
  if(!Started){
    return;
  }
  
  Data thumbData, pointerData, middleData, flexD, heightD, emgD;
  
  int currTime = (int)(millis() - clock);
  
  thumbData = new Data(thumbReading, currTime);
  pointerData = new Data(pointerReading, currTime);
  middleData = new Data(middleReading, currTime);
  flexD = new Data(flexReading, currTime);
  heightD = new Data(heightReading, currTime);
  emgD = new Data(emgReading, currTime);

  
  ArrayList<Data> tempForceData = new ArrayList<Data>();
  tempForceData.add(thumbData);
  tempForceData.add(pointerData);
  tempForceData.add(middleData);
  
  fsrData.add(tempForceData);
  flexData.add(flexD);
  heightData.add(heightD);
  emgData.add(emgD);

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
