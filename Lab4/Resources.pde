//Function defined in the lab manual to calculate our MFP
float calculateMFP(float MM, float MF, float LF, float Heel){
  float numerator = (MM + MF) * 100;
  float denominator = MM + MF + LF + Heel + 0.001;
  
  return (float)(numerator/denominator);
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
  //TODO: Read the data and put them into the graphs
  String value = myPort.readStringUntil('\n');  // Read serial input until newline
  try {
    if(value != null){
      value = trim(value);

      String[] values = split(value, " ");
      currAcc.setX(float(values[0]));
      currAcc.setY(float(values[1]));
      currAcc.setZ(float(values[2]));
      if(accArr.size() > 20){
        accArr.remove(0);
      }
      accArr.add(currAcc);
      
      currGyro.setX(float(values[3]));
      currGyro.setY(float(values[4]));
      currGyro.setZ(float(values[5]));
      if(gyroArr.size() > 20){
        gyroArr.remove(0);
      }
      gyroArr.add(currGyro);
      
      currMM = float(values[6]);
      currMF = float(values[7]);
      currLF = float(values[8]);
      currHeel = float(values[9]);
    }
  } catch(Exception e){
    System.out.println(e);
  }
}

Profiles FindGait(float currMM, float currMF, float currLF, float currHeel, float minRead, float maxRead){
  float MFP = calculateMFP(currMM, currMF, currLF, currHeel);
  float confidenceWindow = 20;
  float readRange = maxRead - minRead;
  float midRead = readRange / 2;
  float lowConfidenceBound = midRead - confidenceWindow;
  float highConfidenceBound = midRead + confidenceWindow;
  
  if(MFP > 100 - confidenceWindow){
    if(currMF > currLF + (confidenceWindow / (4 * readRange))){
      return Profiles.OutToe;
    }
    else if(currLF > currMF){
      return Profiles.InToe;
    }
    else return Profiles.TipToeing;
  }
  else{
    return Profiles.Normal;
  }
  
}

Profiles FindGaitAdv(float currMM, float currMF, float currLF, float currHeel){
  return Profiles.Normal;
}
