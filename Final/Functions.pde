void initializeVariables(){
  currentState = State.Init;
  boldFont = createFont("SansSerif-Bold", 24);
  mossGreen = color(62, 86, 65);
  rustyRed = color(162, 73, 54);
  coralOrange = color(218, 125, 88);
  charcoalGray = color(29, 32, 29);
  seafoamGreen = color(131, 188, 169);
  
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

void performHandReadings() {
  JOptionPane.showMessageDialog(null, "Clench your hand and press spacebar to continue.");
  clenchedHandFlexReading = currentFlex;
  
  JOptionPane.showMessageDialog(null, "Relax your hand and press spacebar to continue.");
  relaxedHandFlexReading = currentFlex;
  
  currentState = State.Graph;
}
