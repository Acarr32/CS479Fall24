import processing.serial.*;  // Import the Serial library
int wrongRespiration = 0;

public void drawMeditation() {   
  fill(0);
  rect(width - 300, height - 300, 500, 500);
  
  int x = width - 250;
  int y = height - 250;
  float inhalationRate = 0;
  float exhalationRate = 0;
  
  // Text in white
  fill(255);
  stroke(255);
  strokeWeight(4);
    
  if (frameTracker < breathCycleSeconds * frameRate) {
    text("Inhale", x, y);
    line(x + 30, y + 50, x + 30, y + 150);  // Vertical line
    line(x + 30, y + 50, x + 10, y + 80);  // Left diagonal line (arrow head)
    line(x + 30, y + 50, x + 50, y + 80);  // Right diagonal line (arrow head)
    
    if (respirationRates.size() > 8) {
      // during inhalation the heart rate is higher 
      inhalationRate = respirationRates.get(respirationRates.size() - 1);
      exhalationRate = respirationRates.get(respirationRates.size() - 9);
      System.out.println("In: " + inhalationRate + ", Out: " + exhalationRate);
    }
  } else {
    text("Exhale", x + 100, y);
    line(x + 130, y + 50, x + 130, y + 150);  // Vertical line
    line(x + 130, y + 150, x + 110, y + 120);  // Left diagonal line (arrow head)
    line(x + 130, y + 150, x + 150, y + 120);  // Right diagonal line (arrow head)
    
    
    if (respirationRates.size() > 8) {
      // during inhalation the heart rate is higher 
      exhalationRate = respirationRates.get(respirationRates.size() - 1);
      inhalationRate = respirationRates.get(respirationRates.size() - 9);
      System.out.println("In: " + inhalationRate + ", Out: " + exhalationRate);
    }
  }
  
  System.out.println(wrongRespiration);
  
  if (inhalationRate > (exhalationRate / 3) && (frameTracker % 4) == 0) {
    wrongRespiration++;
  } else if ((frameTracker % 4) == 0) {
    wrongRespiration = 0;
  }
  
  if (wrongRespiration >= 3 && (frameTracker % 4) == 0) {
    fill(255);
    text("Breathing Pattern \n NOT achieved", x, y + 200);
  }
}
