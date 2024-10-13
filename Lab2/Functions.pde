public void InitializeData() {
  hrdata = new ArrayList<ArrayList<Integer>>();
  rrdata = new ArrayList<ArrayList<Integer>>();
  ArrayList<Integer> respirationRates = new ArrayList<Integer>();
  ArrayList<Integer> heartRates = new ArrayList<Integer>();
  rrdata.add(respirationRates);
  hrdata.add(heartRates);
}

void collectBaseline() {
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
