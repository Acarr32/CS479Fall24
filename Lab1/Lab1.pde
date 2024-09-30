import processing.serial.*;

ArrayList<ArrayList<Integer>> data = new ArrayList<ArrayList<Integer>>();
String currPage = "home";
int heartrate = 0;
int confidence = 0;
int oxygen = 0;
int status = 0;
int USER_AGE = 24;
float activity_perc = 0;
String activity_level = "";
float avgHR = 0;
int count = 0;
int total = 0;
void setup() {
  size(1024, 700);
  boolean showPorts = false;
  //System.out.println(Serial.list()[3]);
  String portname = Serial.list()[3];
  //showPortData(showPorts);
  myPort = new Serial(this, portname, 115200);
  myPort.bufferUntil('\n');
  //renderLoadingWindow();
  
  //modeI();
  
  //modeII();
  
  
}

void mousePressed() {
  if(currPage.equals("home")){
    if (mouseX > width / 3 - 320 && mouseX < width / 3 - 320 + 300 &&
      mouseY > height / 2 - 75 && mouseY < height / 2 + 75) {
      println("Calming Mode pressed");
      CalmingMode("freudian.mp3");
      // Add code to trigger Calming Mode
    }
    
    // Check if the mouse is inside the "Normal Mode" button
    else if (mouseX > 2 * width / 3 - 320 && mouseX < 2 * width / 3 - 320 + 300 &&
             mouseY > height / 2 - 75 && mouseY < height / 2 + 75) {
      println("Normal Mode pressed");
      currPage = "normal";
      drawUI("Normal");
     
      // Add code to trigger Normal Mode
    }
    
    // Check if the mouse is inside the "Stress Mode" button
    else if (mouseX > 3 * width / 3 - 320 && mouseX < 3 * width / 3 - 320 + 300 &&
             mouseY > height / 2 - 75 && mouseY < height / 2 + 75) {
      println("Stress Mode pressed");
      StressMode();
      // Add code to trigger Stress Mode
    }
  } else if(currPage.equals("normal")){
      if (mouseX > width / 2 - 150 && mouseX < width / 2 - 150 + 300 &&
        mouseY > 20 && mouseY < 20 + 100) {
      println("Home button pressed");
      currPage = "home";
      openingScreen();
  
      // Add code to trigger Home action, like switching to a home screen
    }
  }
}

void draw() {
  //serialEvent(myPort);
  //SenseStress();
  //drawUI("Title");
  if(currPage.equals("home")){
    openingScreen();
  } else if(currPage.equals("calmed")){
    CalmingMode("freudian.mp3");
  } else if(currPage.equals("stressed")){
    StressMode();
  } else if(currPage.equals("normal")){
    drawUI("Normal");
  }
  //drawGraph();
}

void serialEvent(Serial myPort){
  String Value = myPort.readStringUntil('\n');
  if(Value != null){
    ArrayList<Integer> currData = new ArrayList<Integer>();
    String[] values = split(Value,", ");
    heartrate = int(values[0]);
    confidence = int(values[1]);
    oxygen = int(values[2]);
    status = int(values[3]);
    activity_perc = heartrate / float(220-USER_AGE);
    System.out.println(activity_perc);
    if (activity_perc >= 0.6) {
        activity_level = "MAXIMUM";
    } else if (activity_perc >= 0.5) {
        activity_level = "HARD";
    } else if (activity_perc >= 0.4) {
        activity_level = "MODERATE";
    } else if (activity_perc >= 0.3) {
        activity_level = "LIGHT";
    } else if (activity_perc >= 0.2) {
        activity_level = "VERY LIGHT";
    } else {
        activity_level = "RESTING";
    }
    currData.add(heartrate);
    currData.add(confidence);
    currData.add(oxygen);
    currData.add(status);
    if(data.size() >= 10){
      data.remove(0);
    }
    if(heartrate != 0){
      total += heartrate;
      count ++;
      avgHR = total / count;
    }
    data.add(currData);
    
    System.out.println(data);
    //System.out.print(heartrate);
    //System.out.print(", ");
    //System.out.print(confidence);
    //System.out.print(", ");
    //System.out.println(oxygen);
  }
  else{
    System.out.println("not working");
  }
}
