import processing.serial.*;
import javax.swing.JOptionPane;
import java.text.DecimalFormat;
import processing.sound.*;

static final DecimalFormat df = new DecimalFormat("0.00");
Serial myPort;
float resting = -0.0;

boolean m1Flag = false;
boolean m2Flag = false;

int readBuffer = 250;

int userAge;

 //<>//

void renderLoadingWindow(){
  JOptionPane.showMessageDialog(null, "The program will stall for a few seconds to give the sensor a few seconds to calibrate.", "WARNING", JOptionPane.ERROR_MESSAGE);
  delay(4000);
}

//void showPortData(boolean show){
//  if(!show){
//    return;
//  }
//  println("Available Ports: ");
//  printArray(Serial.list());
//}

void openingScreen(){
  background(100,100, 180);
  fill(220,230, 220);
  rect(width/3-320, height/2 -75, 300, 150);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Calming Mode", width/3-320, height/2 -75, 300, 150);
  fill(220,230, 220);
  rect(2*width/3-320, height/2 -75, 300, 150);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Normal Mode", 2*width/3-320, height/2 -75, 300, 150);
  fill(220,230, 220);
  rect(3*width/3-320, height/2 -75, 300, 150);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Stress Mode", 3*width/3-320, height/2 -75, 300, 150);
}

void CalmingMode(String musicFileName){
  JOptionPane.showMessageDialog(null, "We will now play calming music for the next minute. Please close your eyes and listen.");
  
  //Load and play music
  SoundFile file = new SoundFile(this, musicFileName);
  file.play();
  
  long startTime = millis();
  
  //Reads in for 60 secs
  while(millis() - startTime <= 700){ //ORIGINALLY: 60000
    
    println(millis()-startTime);
    delay(readBuffer);
    //serialEvent(myPort);
  }
  
  file.pause();
  
  String decisionText;
  
  if(heartrate >= avgHR){
    decisionText = "Not Calmed. :c";
  }
  else{
    decisionText = "Calmed :)";
  }
  JOptionPane.showMessageDialog(null, decisionText, "Process Complete", JOptionPane.PLAIN_MESSAGE);
  
}


void StressMode(){
  JOptionPane.showMessageDialog(null, "Recall a recent stressful event, such as a difficult exam or the year 2020, for at least 60 seconds", "Reccolection", JOptionPane.PLAIN_MESSAGE);
 
  long startTime = millis();
  int highestHR = 0;
  //Reads in for 60 secs of good input
  while(millis() - startTime <= 60000){
   //System.out.println(millis()- startTime);
    if(heartrate > highestHR){
      highestHR = heartrate;
    }
  }
  String decisionText;
  System.out.println(avgHR);
  if(highestHR >= avgHR){
    decisionText = "Heart rate increased";
    myPort.write('B');
  }
  else{
    decisionText = "No increase in heart rate";
  }
  JOptionPane.showMessageDialog(null, decisionText, "Process Complete", JOptionPane.PLAIN_MESSAGE);
  
}
