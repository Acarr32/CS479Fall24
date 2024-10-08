public void InitializePlots(){
  respirationPlot = new GPlot(this);
  heartRatePlot = new GPlot(this);
  
  respirationPlot.setTitleText("Respiration Rate");
  respirationPlot.getXAxis().setAxisLabelText("N-th Recent Sample - 20");
  respirationPlot.getYAxis().setAxisLabelText("Rate (breaths/min)");

  heartRatePlot.setTitleText("Heart Rate");
  heartRatePlot.getXAxis().setAxisLabelText("N-th Recent Sample - 20");
  heartRatePlot.getYAxis().setAxisLabelText("Rate (beats/min)");
}


void drawGraph(ArrayList<ArrayList<Integer>> data) {
  if (data.size() < 2) return;

  ArrayList<Integer> respirationRates = data.get(0);
  ArrayList<Integer> heartRates = data.get(1);
  
  respirationPlot.setPos(50, 40);
  heartRatePlot.setPos(50, 300);

  GPointsArray respirationPoints = new GPointsArray(min(respirationRates.size(), 20));
  for (int i = max(0, respirationRates.size() - 20); i < respirationRates.size(); i++) {
    respirationPoints.add(i - (respirationRates.size() - 20), respirationRates.get(i));
  }
  respirationPlot.setPoints(respirationPoints);
  respirationPlot.defaultDraw();

  GPointsArray heartRatePoints = new GPointsArray(min(heartRates.size(), 20));
  color[] pointColors = new color[min(heartRates.size(), 20)];

  for (int i = max(0, heartRates.size() - 20); i < heartRates.size(); i++) {
    int heartRate = heartRates.get(i);
    float percentage = (heartRate - baselineHeartRate) / (float)baselineHeartRate;

    if (percentage < 0.5) {
      pointColors[i - (heartRates.size() - 20)] = color(173, 216, 230); // Baby Blue
    } else if (percentage < 0.6) {
      pointColors[i - (heartRates.size() - 20)] = color(0, 0, 255); // Blue
    } else if (percentage < 0.7) {
      pointColors[i - (heartRates.size() - 20)] = color(34, 139, 34); // Forest Green
    } else if (percentage < 0.8) {
      pointColors[i - (heartRates.size() - 20)] = color(255, 215, 0); // Mustard Yellow
    } else {
      pointColors[i - (heartRates.size() - 20)] = color(255, 0, 0); // Red
    }

    heartRatePoints.add(i - (heartRates.size() - 20), heartRate);
  }
  
  heartRatePlot.setPoints(heartRatePoints);
  heartRatePlot.setPointColors(pointColors); // Set colors for the heart rate points
  heartRatePlot.defaultDraw();
}

void InputLoop(){
  if (!baselineCollected) {
    collectBaseline();
  }
  else {
    ArrayList<Integer> respirationRates = data.get(0);
    ArrayList<Integer> heartRates = data.get(1);
    
    respirationRates.add((int)random(10, 30));
    heartRates.add((int)random(60, 100));
    
    if (respirationRates.size() > 100) {
      respirationRates.remove(0);
      heartRates.remove(0);
    }
    
    background(255);
    drawGraph(data);
  }
}
