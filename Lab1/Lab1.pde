import processing.serial.*;

ArrayList<ArrayList<Integer>> data = new ArrayList<ArrayList<Integer>>();
int heartrate = 0;
int confidence = 0;
int oxygen = 0;
int status = 0;
int USER_AGE = 24;
float activity_perc = 0;
String activity_level = "";
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

void draw() {
  //serialEvent(myPort);
  //SenseStress();
  drawUI("Title");
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
    if (activity_perc >= 0.7) {
        activity_level = "MAXIMUM";
    } else if (activity_perc >= 0.6) {
        activity_level = "HARD";
    } else if (activity_perc >= 0.5) {
        activity_level = "MODERATE";
    } else if (activity_perc >= 0.4) {
        activity_level = "LIGHT";
    } else if (activity_perc >= 0.3) {
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
