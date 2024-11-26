class Values{
  float thm;
  float ind;
  float mid;
  float flx;
  float vtg;
  Accelerometer acc;
  Gyroscope gyr;
  
  Values(float thm, float ind, float mid, float flx, float vtg, Accelerometer acc, Gyroscope gyr){
    this.thm = thm;
    this.ind = ind;
    this.mid = mid;
    this.flx = flx;
    this.vtg = vtg;
    this.acc = acc;
    this.gyr = gyr;
  }
  void printValues(){
    System.out.println(this.thm);
    System.out.println(this.ind);
    System.out.println(this.mid);
    System.out.println(this.flx);
    System.out.println(this.flx);
    System.out.println(this.vtg);
  }
}

class Accelerometer{
  float x, y, z;
  Accelerometer(){ this.x = 0; this.y = 0; this.z = 0; }
  Accelerometer(float x, float y, float z){ this.x = x; this.y = y; this.z = z; }
  void setXYZ(float x, float y, float z){ this.x = x; this.y = y; this.z = z; }
  float getX(){ return x; }
  float getY(){ return y; }
  float getZ(){ return z; }
}

class Gyroscope{
  float x, y, z;
  Gyroscope(){ this.x = 0; this.y = 0; this.z = 0; }
  Gyroscope(float x, float y, float z){ this.x = x; this.y = y; this.z = z; }
  void setXYZ(float x, float y, float z){ this.x = x; this.y = y; this.z = z; }
  float getX(){ return x; }
  float getY(){ return y; }
  float getZ(){ return z; }
}

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
   
  void changeLabel(String newText){
    this.label = newText;
  }

  boolean isMouseOver() {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
}

enum State{
  Init,
  Graph,
  Menu
}

enum ClimbingStatus {
  Climbing,
  Stationary,
  Falling
}

String ClimbingString(ClimbingStatus status){
   switch (status){
     case Climbing:
       return "Climbing";
     case Stationary:
       return "Stationary";
     case Falling:
       return "Falling";
     default:
       return "ERROR";
   }
}

<<<<<<< HEAD
=======
String AboutStatus(ClimbingStatus status){
  switch (status){
     case Climbing:
       return "Climbing Description";
     case Stationary:
       return "Stationary Description";
     case Falling:
       return "Falling Description";
     default:
       return "ERROR (Again)";
   }
}
>>>>>>> AJ

enum Hold{
  Sloper,
  Jog,
  Crimp
}

String HoldString(Hold hold){
  switch(hold){
    case Sloper:
      return "Sloper";
    case Jog:
      return "Jog";
    case Crimp:
      return "Crimp";
    default:
      return "ERROR";
  }
}

String AboutHold(Hold hold){
  switch(hold){
    case Sloper:
      return "Sloper Description";
    case Jog:
      return "Jog Description";
    case Crimp:
      return "Crimp Description";
    default:
      return "ERROR (Again)";
  }
}
