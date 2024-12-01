class Replay{
  ArrayList<ReplayValues> replayValues;
  private int REPLAY_HEIGHT = 800;
  private int REPLAY_WIDTH = 400;
  private int climberIndex = 0;
  //private float startTimer;
  private ArrayList<ArrayList<Integer>> rockPositions = new ArrayList<ArrayList<Integer>>();
  Replay(ArrayList<ReplayValues> data){
    this.replayValues = data;
  }
  void drawReplay(){
    background(255);
    image(loadImage("./data/replayBackground.jpg"),0, 0, width, height);
    fill(225, 203, 190);
    rect(width / 2 - REPLAY_WIDTH/2, height/2 - REPLAY_HEIGHT/2, REPLAY_WIDTH, REPLAY_HEIGHT);
    drawRocks();
    drawClimber();
  }
  void drawRocks() {
    int numRocks = this.replayValues.size();
    if (numRocks == 0) return;

    // Calculate uniform spacing
    float spacing = (REPLAY_HEIGHT - 20) / (float)numRocks; // 20 for padding
    float rectCenterX = width / 2;
    for (int i = 0; i < numRocks; i++) {
      fill(getRockColor(i));
      
      // Calculate Y position from bottom to top
      float y = height / 2 + REPLAY_HEIGHT / 2 - 10 - i * spacing;

      // Calculate alternating X positions
      float xOffset = REPLAY_WIDTH / 8;
      float x = (i % 2 == 0) 
                ? rectCenterX - xOffset 
                : rectCenterX + xOffset;

      // Store rock position
      ArrayList<Integer> temp = new ArrayList<Integer>();
      temp.add(int(x));
      temp.add(int(y));
      rockPositions.add(temp);

      // Draw the rock
      rect(x, y, 10, 10);
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
  
  private color getRockColor(int i){
    int j = i % 5;
    switch(j){
      case 0:
        return(mossGreen);
      case 1:
        return(rustyRed);
      case 2:
        return(coralOrange);
      case 3:
        return(charcoalGray);
      case 4:
        return(seafoamGreen);
      default:
        return(coralOrange);
    }
  }
}

class ReplayValues{
  float clock;
  float thm;
  float ind;
  float mid;
  ReplayValues(float clock, float thm, float ind, float mid){
    this.clock = clock;
    this.thm = thm;
    this.ind = ind;
    this.mid = mid;
  }
  void print(){
    System.out.print(this.clock / 1000 + "s "+ this.thm + " " + this.ind + " " + this.mid + "\n");
  }
}
