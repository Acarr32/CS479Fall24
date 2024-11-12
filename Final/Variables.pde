enum State{
  Menu
}

State currentState;
PFont boldFont;
Serial myPort;

class Data{
  public float reading;
  public int timeElapsed;
  
  public Data(float reading, int timeElapsed) {
    this.reading = reading;
    this.timeElapsed = timeElapsed;
  }
}
