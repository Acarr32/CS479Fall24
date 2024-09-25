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


public bioData getMetrics(ArrayList<bioData> entries){
  float totalHr = 0.0;
  float totalC = 0.0;
  float totalO = 0.0;
  int size = entries.size();
  
   for(bioData bd: entries){
      totalHr += bd.heartRate;
      totalC += bd.confidence;
      totalO += bd.oxygen;
   }
   
   bioData result = new bioData(totalHr/size, totalC/size, totalO/size, -99);
   
   return result;
      
} //<>//

bioData ParseData(String input){   
    return new bioData();
}

boolean isGoodData(bioData bD){
  return (bD.status == 3) && (bD.heartRate >= 30); 
}
class bioData {
  public float heartRate;
  public float confidence;
  public float oxygen;
  public int status;
  
  public bioData(float HeartRate, float Confidence, float Oxygen, int Status){
    this.heartRate = HeartRate;
    this.confidence = Confidence;
    this.oxygen = Oxygen;
    this.status = Status;
  }
  
  public bioData(){
    this.heartRate = 0.0;
    this.confidence = 0.0;
    this.oxygen = 0.0;
    this.status = -99;
  }
  
}

void renderLoadingWindow(){
  JOptionPane.showMessageDialog(null, "The program will stall for a few seconds to give the sensor a few seconds to calibrate.", "WARNING", JOptionPane.ERROR_MESSAGE);
  delay(4000);
}

void showPortData(boolean show){
  if(!show){
    return;
  }
  println("Available Ports: ");
  printArray(Serial.list());
}

void CalmingMode(String musicFileName){
  JOptionPane.showMessageDialog(null, "We will now play calming music for the next minute. Please close your eyes and listen.");
  
  ArrayList<bioData> data = new ArrayList<>();
  
  //Load and play music
  SoundFile file = new SoundFile(this, musicFileName);
  file.play();
  
  long startTime = millis();
  
  //Reads in for 60 secs
  while(millis() - startTime <= 60000){
    String sensorData = myPort.readString();
    bioData parsedData = ParseData(sensorData);
    
    if(parsedData.status != 3){
      startTime += readBuffer;
    }
    
    data.add(parsedData);
    delay(readBuffer);
  }
  
  file.pause();
  
  String decisionText;
  
  if(getMetrics(data).heartRate >= resting){
    decisionText = "Not Calmed. :c";
  }
  else{
    decisionText = "Calmed :)";
  }
  
  
  drawUI("Calming Mode", data);
  
  JOptionPane.showMessageDialog(null, decisionText, "Process Complete", JOptionPane.PLAIN_MESSAGE);
  
}


void StressMode(){
  JOptionPane.showMessageDialog(null, "Recall a recent stressful event, such as a difficult exam or the year 2020, for at least 60 seconds", "Reccolection", JOptionPane.PLAIN_MESSAGE);
  
  ArrayList<bioData> data = new ArrayList<>();
  
  long startTime = millis();
  
  //Reads in for 60 secs of good input
  while(millis() - startTime <= 60000){
    String sensorData = myPort.readString();
    bioData parsedData = ParseData(sensorData);
    
    if(parsedData.status != 3){
      startTime += readBuffer;
    }
    
    data.add(parsedData);
    delay(readBuffer);
  }
  
  drawUI("Stressed Mode", data);
  
  JOptionPane.showMessageDialog(null, "Testing complete. You will now enter a passive stress analysis mode.");
}
