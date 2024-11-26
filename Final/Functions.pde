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
  currPointerForce = 0;
  currThumbForce = 0;
  
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
 
  
  //Determine Status
  determineHold();
  determineClimbingStatus();
  
  
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

  statusButton = new Button(width * .025, height * .5, width / 3, height / 8, ClimbingString(currentStatus), rustyRed);
  holdButton = new Button((width * .05) + width / 3, height * .5, width / 3, height / 8, HoldString(currentHold), coralOrange);
  
  
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
  
  pointerX = handAnchorX + (handWidth * .65);
  pointerY = handAnchorY + (handHeight * .2);
  
  thumbX = handAnchorX + (handWidth * .88);
  thumbY = handAnchorY + (handHeight * .55);
  
  //Initialize Plots
  initializeGraphs();

  
  
  
  
  //Set Load Flag
  GraphingLoaded = true;
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
