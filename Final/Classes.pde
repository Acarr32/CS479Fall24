class Values{
  float thm;
  float ptr;
  float mid;
  float flx;
  float alt;
  float emg;
  Accelerometer acc;
  Gyroscope gyr;
  
  Values(float thm, float ptr, float mid, float flx, float alt, Accelerometer acc, Gyroscope gyr, float emg){
    this.thm = thm;
    this.ptr = ptr;
    this.mid = mid;
    this.flx = flx;
    this.alt = alt;
    this.acc = acc;
    this.gyr = gyr;
    this.emg = emg;
  }
  
  void printValues(){
    System.out.println(this.thm);
    System.out.println(this.ptr);
    System.out.println(this.mid);
    System.out.println(this.flx);
    System.out.println(this.alt);
    System.out.println(this.emg);
    //System.out.println(this.acc);
    //System.out.println(this.gyr);
  }
  
  public float GetThm(){
    return this.thm;
  }
  
  public float GetPtr(){
    return this.ptr;
  }
  
  public float GetMid(){
    return this.mid;
  }
  
  public float GetFlex(){
    return this.flx;
  }
  
  public float GetAlt(){
    return this.alt;
  }
  
  public Accelerometer GetAccel(){
    return this.acc;
  }
  
  public Gyroscope GetGyro(){
    return this.gyr;
  }
  
  public float GetEmg(){
    return this.emg;
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
  Menu,
  Replay
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
       return throwError(null, 2);
   }
}

String AboutStatus(ClimbingStatus status){
  switch (status){
     case Climbing:
       return "User is determined to be in motion and climbing currently.";
     case Stationary:
       return "The user is not moving vertically, or movements are insignificant.";
     case Falling:
       return "User is determined to be in motion and descending currently.";
     default:
       return throwError(null, 2);
   }
}

enum Hold{
  Sloper,
  Jug,
  Crimp
}

String HoldString(Hold hold){
  switch(hold){
    case Sloper:
      return "Sloper";
    case Jug:
      return "Jug";
    case Crimp:
      return "Crimp";
    default:
      return throwError(null, 3);
  }
}

String AboutHold(Hold hold){
  switch(hold){
    case Sloper:
      return "A big and blobby surface that is typically a very shallow, rounded surface.";
    case Crimp:
      return "A small edge on a rock or plastic that's only big enough to fit the pads of your fingers.";
    case Jug:
      return "A large, ergonomic shape that you can grip with your whole hand.";
    default:
      return throwError(null, 3);
  }
}
