void stressMonitoringMode() {
  System.out.println("Enterting Stress Monitoring Mode..");
  if(!baselineCollected){
    collectBaseline();
  }
  
  Graphing = true;
 
  CalmProc("freudian.mp3");
  StressProc();
}

void CalmProc(String musicFileName){
  JOptionPane.showMessageDialog(null, "We will now play calming music for the next minute. Please close your eyes and listen.");
  
  //Load and play music
  SoundFile file = new SoundFile(this, musicFileName);
  file.play();
  
  delay(10000);
  
  file.pause();
  
  String decisionText;
  
  if(heartrate >= baselineHeartRate){
    decisionText = "Not Calmed. :c";
  }
  else{
    decisionText = "Calmed :)";
  }
  JOptionPane.showMessageDialog(null, decisionText, "Process Complete", JOptionPane.PLAIN_MESSAGE);
  
}

public void StressProc(){
  JOptionPane.showMessageDialog(null, "Recall a recent stressful event, such as a difficult exam or the year 2020, for at least 60 seconds", "Reccolection", JOptionPane.PLAIN_MESSAGE);
 
  long startTime = millis();
  int highestHR = 0;
  //Reads in for 60 secs of good input
  while(millis() - startTime <= 6000){
   //System.out.println(millis()- startTime);
    if(heartrate > highestHR){
      highestHR = heartrate;
    }
  }
  String decisionText;
  
  if(highestHR >= baselineHeartRate){
    decisionText = "Heart rate increased";
    myPort.write('B');
  }
  else{
    decisionText = "No increase in heart rate";
  }
  JOptionPane.showMessageDialog(null, decisionText, "Process Complete", JOptionPane.PLAIN_MESSAGE);
}
