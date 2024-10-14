public void InitializeData() {
  hrdata = new ArrayList<ArrayList<Integer>>();
  rrdata = new ArrayList<ArrayList<Integer>>();
  ArrayList<Integer> respirationRates = new ArrayList<Integer>();
  ArrayList<Integer> heartRates = new ArrayList<Integer>();
  rrdata.add(respirationRates);
  hrdata.add(heartRates);
}

void collectBaseline() {
  System.out.println("Collecting Baseline...");
  
  int HRSum = 0;
  int RespSum = 0;
  int TotalReads = 0;
  ArrayList<Integer> averages = new ArrayList<Integer>();

  while (millis() - startTime < 10000) {
    HRSum += (int)random(60, 100);  // Simulated heart rate data
    heartRates.add(HRSum);
    RespSum += (int)random(200, 700);  // Simulated respiration data
    respirationRates.add(RespSum);
    TotalReads++;
    delay(250);
  }

  //rrdata.add(respirationRates);
  //hrdata.add(heartRates);
  if (HRSum == 0 || RespSum == 0 || TotalReads == 0) {
    baselineHeartRate = 0;
    baselineCollected = false;
  } else {
    averages.add(RespSum / TotalReads);
    averages.add(HRSum / TotalReads);
    baselineCollected = true;
  }
  
  displayCardioZone(averages);
  System.out.println("Done");
}

int determineCardioZone(float heartRate) {
  float percentage = heartRate / 200;
  
  if (percentage <= .6) return 0;
  if (percentage <= .7) return 1;
  if (percentage <= .8) return 2;
  if (percentage <= .9) return 3;
  else return 4;
  
}


String getCardioZoneName(int zone) {
  switch (zone) {
    case 0: return "Very Light";
    case 1: return "Light";
    case 2: return "Moderate";
    case 3: return "Hard";
    case 4: return "Maximum";
    default: return "Unknown";
  }
}

void displayCardioZone(ArrayList<Integer> averages) {
  fill(0);
  textSize(20);
  
  String line1 = "Current Cardio Zone: " + getCardioZoneName(cardioZone);
  String line2 = "Current Average Heart Rate: " + averages.get(1);
  String line3 = "Current Average Respitory Rate: " + averages.get(0);
  JOptionPane.showMessageDialog(null,
  line1 + '\n' + line2 + '\n' + line3,
  "Cardio Zone Indication", JOptionPane.INFORMATION_MESSAGE);
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
