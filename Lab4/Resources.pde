//Function defined in the lab manual to calculate our MFP
float calculateMFP(){
  float numerator = (cMM + cMF) * 100;
  float denominator = cMM + cMF + cLF + cHeel + 0.001;
  
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
        String[] values = split(value, " "); //<>// //<>//
        
        for(int i = 6; i < values.length; i++){
          System.out.println(values[i]);
        }
        System.out.println("==============");
        
        currAcc.setX(float(values[0]));
        currAcc.setY(float(values[1]));
        currAcc.setZ(float(values[2]));
        if(accArr.size() > 20){
          accArr.remove(0);
        accArr.add(currAcc);
        }
        currGyro.setX(float(values[3]));
        currGyro.setY(float(values[4]));
        currGyro.setZ(float(values[5]));
        if(gyroArr.size() > 20){ //<>// //<>//
          gyroArr.remove(0);
        gyroArr.add(currGyro); //<>// //<>//
        } //<>// //<>//
        cMF = float(values[6]); //<>// //<>//
        cLF = float(values[7]);
        cMM = float(values[8]);
        cHeel = float(values[9]);
        
        if(MMarr.length >=20 ){
          for (int i = 1; i < MMarr.length; i++) {
            MMarr[i - 1] = MMarr[i];
          }
          MMarr[MMarr.length - 1] = cMM;
        } else{
          MMarr[MMcount] = cMM;
          MMcount++;
        }
        //for(int i = 0; i < MMarr.length; i++) {
        //    System.out.print(MMarr[i] + " ");
        //}
        
        if(MFarr.length >=20 ){
          for (int i = 1; i < MFarr.length; i++) {
            MFarr[i - 1] = MFarr[i];
          }
          MFarr[MFarr.length - 1] = cMF;
        } else{
          MFarr[MFcount] = cMF;
          MFcount++;
        }
        
        if(LFarr.length >=20 ){
          for (int i = 1; i < LFarr.length; i++) {
            LFarr[i - 1] = LFarr[i];
          }
          LFarr[LFarr.length - 1] = cLF;
        } else{
          LFarr[LFcount] = cLF;
          LFcount++;
        }
        
        if(Heelarr.length >=20 ){
          for (int i = 1; i < Heelarr.length; i++) {
            Heelarr[i - 1] = Heelarr[i];
          }
          Heelarr[Heelarr.length - 1] = cHeel;
        } else{
          Heelarr[Heelcount] = cHeel;
          Heelcount++;
        }
        
      
    } 
    catch(Exception e) {
    System.out.println("Parsing error: " + e.getMessage());
  }
}
}


Profiles FindGait(){
  float MFP = calculateMFP();
  float confidenceWindow = 15;
  //float lowConfidenceBound = midRead - confidenceWindow;
  //float highConfidenceBound = midRead + confidenceWindow;
  
  if(MFP > 100 - confidenceWindow){
    if(cMF > cLF + (confidenceWindow / 4)){
      return Profiles.InToe;
    }
    else if(cLF > cMF){
      return Profiles.OutToe;
    }
    else return Profiles.TipToeing;
  }
  else if (MFP < confidenceWindow && cHeel > cMF){
    return Profiles.Heeling;
  }
  else{
    return Profiles.Normal;
  }
  
}
