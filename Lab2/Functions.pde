public void InitializeData(){
  data = new ArrayList<ArrayList<Integer>>();
  ArrayList<Integer> respirationRates = new ArrayList<Integer>();
  ArrayList<Integer> heartRates = new ArrayList<Integer>();
  data.add(respirationRates);
  data.add(heartRates);
}

void collectBaseline() {
  ArrayList<Integer> heartRates = data.get(1);
 
  if (millis() - startTime < 3000) {
    heartRates.add((int)random(60, 100));
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
  JOptionPane.showMessageDialog(null, "Current Cardio Zone: " + getCardioZoneName(cardioZone), "Cardio Zone Indication", JOptionPane.INFORMATION_MESSAGE);
}
