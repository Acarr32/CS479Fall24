public void InitializeData(){
  data = new ArrayList<ArrayList<Integer>>();
  ArrayList<Integer> respirationRates = new ArrayList<Integer>();
  ArrayList<Integer> heartRates = new ArrayList<Integer>();
  data.add(respirationRates);
  data.add(heartRates);
}

void collectBaseline() {
  ArrayList<Integer> heartRates = data.get(1);
  ArrayList<Integer> respirationRates = data.get(0);
  if (millis() - startTime < 3000) {
    heartRates.add((int)random(60, 100));
    respirationRates.add((int)random(200,700));
  } else {
    int sum = 0;
    for (int rate : heartRates) {
      sum += rate;
    }
    baselineHeartRate = sum / heartRates.size();
    baselineCollected = true;
  }
  
  cardioZone = determineCardioZone(restingHeartRate);
}

int determineCardioZone(float heartRate) {
  float percentage = heartRate / 200;
  
  if (percentage <= .6) return 0;
  if (percentage <= .7) return 1;
  if (percentage <= .8) return 2;
  if (percentage <= .9) return 3;
  else return 4;
  
}

ArrayList<Integer> getAverages(ArrayList<ArrayList<Integer>> d){
  
  int AvgHeartRate, TotalHeartRate = 0;
  int AvgResp, TotalResp = 0;
  
  ArrayList<Integer> result = new ArrayList<Integer>();
  
  for(int rate: d.get(0)){
    TotalResp += rate;
  }
  
  for(int rate: d.get(1)){
    TotalHeartRate += rate;
  }
  
  AvgResp = TotalResp / d.get(0).size();
  AvgHeartRate = TotalHeartRate / d.get(1).size();
  
  
  result.add(AvgResp);
  result.add(AvgHeartRate);
  
  return result; 
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

void displayCardioZone() {
  fill(0);
  textSize(20);
  
  ArrayList<Integer> averages = getAverages(data);
  
  String line1 = "Current Cardio Zone: " + getCardioZoneName(cardioZone);
  String line2 = "Current Average Heart Rate: " + averages.get(1);
  String line3 = "Current Average Respitory Rate: " + averages.get(0);
  JOptionPane.showMessageDialog(null,
  line1 + '\n' + line2 + '\n' + line3,
  "Cardio Zone Indication", JOptionPane.INFORMATION_MESSAGE);
}
