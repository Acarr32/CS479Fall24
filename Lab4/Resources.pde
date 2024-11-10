//Function defined in the lab manual to calculate our MFP
float calculateMFP(float MM, float MF, float LF, float Heel){
  float numerator = (MM + MF) * 100;
  float denominator = MM + MF + LF + Heel + 0.001;
  
  return (float)(numerator/denominator);
}

class Foot {
  float topLeftX;
  float topLeftY;
  PImage image;
  
  Foot (PImage image, float topLeftX, float topLeftY) {
    this.topLeftX = topLeftX;
    this.topLeftY = topLeftY;
    this.image = image;
  }
  
  void display() {
    image(this.image, this.topLeftX, this.topLeftY); 
  }
}

//Button class for easy management of buttons
class Button {
  float x, y, w, h;
  String label;
  PImage iconImage;
  color buttonColor;

  Button(float x, float y, float w, float h, String label, PImage iconImage, color buttonColor) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.iconImage = iconImage;
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
    } else if (iconImage != null) {
      imageMode(CENTER);
      image(iconImage, x + w / 2, y + h / 2, w * 0.8, h * 0.8);
      imageMode(CORNER); // Reset imageMode if needed
    }
  }

  void changeColor(color newColor) {
    this.buttonColor = newColor;
  }

  boolean isMouseOver() {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
}

void serialEvent(Serial myPort){
  String value = myPort.readStringUntil('\n');  // Read serial input until newline
  if(value != null){
    //System.out.println(value);
    try {
        value = trim(value);
        String[] values = split(value, " ");
        
        for(int i = 6; i < values.length; i++){
          System.out.println(values[i]);
        }
        System.out.println("==============");
        
        currAcc.setX(Float.parseFloat(values[0]));
        currAcc.setY(Float.parseFloat(values[1]));
        currAcc.setZ(Float.parseFloat(values[2]));
        if(accArr.size() > 20){
          accArr.remove(0);
        accArr.add(currAcc);
        
        currGyro.setX(Float.parseFloat(values[3]));
        currGyro.setY(Float.parseFloat(values[4]));
        currGyro.setZ(Float.parseFloat(values[5]));
        if(gyroArr.size() > 20){
          gyroArr.remove(0);
        }
        gyroArr.add(currGyro);
        
        cMF = Float.parseFloat(values[6]);
        cLF = Float.parseFloat(values[7]);
        cMM = Float.parseFloat(values[8]);
        cHeel = Float.parseFloat(values[9]);
        
        if(MMarr.size() > 20){
          MMarr.remove(0);
        }
        MMarr.add(cMM);
        
        for (int i = 0; i < MMarr.size(); i++) {
          System.out.print(MMarr.get(i) + ",");
        }
        System.out.println("");
        
        if(MFarr.size() > 20){
          MFarr.remove(0);
        }
        MFarr.add(cMF);
        
        if(LFarr.size() > 20){
          LFarr.remove(0);
        }
        LFarr.add(cLF);
        
        if(Heelarr.size() > 20){
          Heelarr.remove(0);
        }
        Heelarr.add(cHeel);
        
        System.out.println(cMF);
        System.out.println(cLF);
        System.out.println(cMM);
        System.out.println(cHeel);
        System.out.println("========");
        drawBubbles(cMM, cMF, cLF, cHeel);
      }
    } 
    catch(Exception e) {
    System.out.println("Parsing error: " + e);
  }
}
}


Profiles FindGait(float currMM, float currMF, float currLF, float currHeel, float minRead, float maxRead){
  float MFP = calculateMFP(currMM, currMF, currLF, currHeel);
  float confidenceWindow = 20;
  float readRange = maxRead - minRead;
  //float lowConfidenceBound = midRead - confidenceWindow;
  //float highConfidenceBound = midRead + confidenceWindow;
  
  if(MFP > 100 - confidenceWindow){
    if(currMF > currLF + (confidenceWindow / (4 * readRange))){
      return Profiles.OutToe;
    }
    else if(currLF > currMF){
      return Profiles.InToe;
    }
    else return Profiles.TipToeing;
  }
  else if (MFP < confidenceWindow){
    return Profiles.Heeling;
  }
  else{
    return Profiles.Normal;
  }
  
}
