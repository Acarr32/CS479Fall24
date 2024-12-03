class Replay{
  ArrayList<ReplayValues> replayValues;
  private int REPLAY_HEIGHT = 800;
  private int REPLAY_WIDTH = 400;
  private int climberIndex = 0;
  //private float startTimer;
  private Button backButton;
  private ArrayList<ArrayList<Integer>> rockPositions = new ArrayList<ArrayList<Integer>>();
  
  Replay(){
    this.replayValues = new ArrayList<ReplayValues>();
  }
  
  Replay(ArrayList<ReplayValues> data){
    this.replayValues = data;
  }
  
  void drawReplay(){
    background(255);
    try{
      image(loadImage("./data/rockbackground.png"),0, 0, width, height);
    }
    catch(NullPointerException p) {
      background(255);
      fill(0,0,0);
      text(throwError(p, 1), height/8, width/2);
      return;
    }
    backButton = new Button(width * .81, height * .025, width * .18, height * .1, "Back", coralOrange);
    if(currentState == State.Replay){
      if(backButton.isMouseOver()){
        currentState = State.Graph;
      }
    }
    backButton.display();
    //fill(225, 203, 190);
    //rect(width / 2 - REPLAY_WIDTH/2, height/2 - REPLAY_HEIGHT/2, REPLAY_WIDTH, REPLAY_HEIGHT);
    drawRocks();
    drawClimber();
    drawStats();
  }
 
  void drawRocks() {
    int numRocks = this.replayValues.size();
    if (numRocks == 0) return;

    // Calculate uniform spacing
    float spacing = (REPLAY_HEIGHT - 20) / (float)numRocks; // 20 for padding
    float rectCenterX = width / 2;
    for (int i = 0; i < numRocks; i++) {
      
      
      // Calculate Y position from bottom to top
      float y = height / 2 + REPLAY_HEIGHT / 2 - 10 - i * spacing;

      // Calculate alternating X positions
      float xOffset = REPLAY_WIDTH / 8;
      float x = (i % 2 == 0) 
                ? rectCenterX - xOffset 
                : rectCenterX + xOffset;
      PImage rockImage = getRockColor(i);
      // Store rock position
      ArrayList<Integer> temp = new ArrayList<Integer>();
      temp.add(int(x));
      temp.add(int(y));
      
      rockPositions.add(temp);

      // Draw the rock
      image(rockImage, x, y, 50, 50);
    }
  }
  
  void drawClimber() {
    if (rockPositions.size() == 0 || climberIndex >= this.replayValues.size()) return; // Ensure rocks are drawn before climber

    PImage img;
    int climberWidth = 80;
    int climberHeight = 150;

    // Get the current time
    int currentTime = int(millis() - replayClock);

    // Determine if it's time to move to the next rock
    if (climberIndex < this.replayValues.size() - 1 && currentTime >= this.replayValues.get(climberIndex + 1).clock) {
      climberIndex++; // Move to the next rock
    }

    // Draw the climber at the current position
    if (climberIndex < this.replayValues.size()) {
        // Alternate between left and right hand climbing images
      if (climberIndex % 2 == 0) {
          img = loadImage("./data/lefthandclimb.png");
      } else {
          img = loadImage("./data/righthandclimb.png");
      }

      // Get the position of the current rock
      int x = rockPositions.get(climberIndex).get(0);
      int y = rockPositions.get(climberIndex).get(1);

      // Draw the climber
      image(img, x - climberWidth + 50, y - climberHeight + 145, climberWidth, climberHeight);
    }
  }
  
  void drawStats(){
     fill(coralOrange, 220);
     rect(width * .75, height * .3, width * .3, height * 0.35, 20);
     int currentTime = int((millis() - replayClock) / 1000);
     stroke(0);
     fill(0);
     text("Time: " + currentTime + "s", width * .76, height * .35);
     text("FSR Values: ", width * .76, height * .49);
     if (climberIndex < this.replayValues.size()) {
       text("Altitude: " + this.replayValues.get(climberIndex).altitude + "m", width * .76, height * .42);
       text("Thumb: " + this.replayValues.get(climberIndex).thm, width * .8, height * .535);
       text("Index: " + this.replayValues.get(climberIndex).ptr, width * .8, height * .57);
       text("Middle: " + this.replayValues.get(climberIndex).mid, width * .8, height * .605);
     }
  }
  
  private PImage getRockColor(int i){
    int j = i % 5;
    switch(j){
      case 0:
        return loadImage("./data/orangerock.png");
      case 1:
        return loadImage("./data/purplerock.png");
      case 2:
        return loadImage("./data/bluerock.png");
      case 3:
        return loadImage("./data/yellowrock.png");
      case 4:
        return loadImage("./data/greenrock.png");
      default:
        return loadImage("./data/orangerock.png");
    }
  }
  
  void clearData(){
    if(this.replayValues.size() > 0){
      this.replayValues = new ArrayList<ReplayValues>();
    }
    if(rockPositions.size() > 0){
      rockPositions = new ArrayList<ArrayList<Integer>>();
    }
  }
}

class ReplayValues{
  float clock;
  float thm;
  float ptr;
  float mid;
  float altitude;
  ReplayValues(float clock, float thm, float ptr, float mid, float altitude){
    this.clock = clock;
    this.thm = thm;
    this.ptr = ptr;
    this.mid = mid;
    this.altitude = altitude;
  }
  void print(){
    System.out.print(this.clock / 1000 + "s "+ this.thm + " " + this.ptr + " " + this.mid + "\n");
  }
}
