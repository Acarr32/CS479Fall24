class Data{
  public float reading;
  public int timeElapsed;
  
  public Data(float reading, int timeElapsed) {
    this.reading = reading;
    this.timeElapsed = timeElapsed;
  }
  
  public float getReading(){ return this.reading; }
  public void setReading(float reading){ this.reading = reading; }
  
  public int getTime(){ return this.timeElapsed; }
  public void setTime(int time) { this.timeElapsed = time; }
  
}

class Button {
  float x, y, w, h;
  String label;
  color buttonColor;

  Button(float x, float y, float w, float h, String label, color buttonColor) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.buttonColor = buttonColor;
  }

  void display() {
    fill(buttonColor);
    rect(x, y, w, h);
    fill(0);

    if (label != "") {
      textAlign(CENTER, CENTER);
      text(label, x + w / 2, y + h / 2);
      textAlign(LEFT, BASELINE); // Reset textAlign if needed
    }
  }

  void changeColor(color newColor) {
    this.buttonColor = newColor;
  }

  boolean isMouseOver() {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
}

enum State{
  Init,
  Graph
}
