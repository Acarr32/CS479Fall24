public void InitializeData() {
  hrdata = new ArrayList<ArrayList<Integer>>();
  rrdata = new ArrayList<ArrayList<Integer>>();
  ArrayList<Integer> respirationRates = new ArrayList<Integer>();
  ArrayList<Integer> heartRates = new ArrayList<Integer>();
  rrdata.add(respirationRates);
  hrdata.add(heartRates);
}

void addData() {
  heartRates.add((int)random(60, 100));  // Add heart rate data
  respirationRates.add((int)random(200, 700));  // Add respiration rate data
}

void InputLoop() {
  // Keep only the most recent 25 inputs
  if (heartRates.size() > 25) {
    heartRates.remove(0);
  }
  if (respirationRates.size() > 25) {
    respirationRates.remove(0);
  }

  background(255, 255, 255);  // Clear the background for each frame
  drawGraph();  // Call to render the graph
}
