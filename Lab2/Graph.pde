public void InitializePlots(){
  background(255);
  inMenu = false;
  respirationPlot = new GPlot(this);
  heartRatePlot = new GPlot(this);
  
  respirationPlot.setTitleText("Respiration Rate");
  respirationPlot.getXAxis().setAxisLabelText("N-th Recent Sample - 20");
  respirationPlot.getYAxis().setAxisLabelText("Rate (breaths/min)");

  heartRatePlot.setTitleText("Heart Rate");
  heartRatePlot.getXAxis().setAxisLabelText("N-th Recent Sample - 20");
  heartRatePlot.getYAxis().setAxisLabelText("Rate (beats/min)");
}


public void drawGraph() {
    background(255);
    if (data.size() < 2 ||  //<>//
    data.get(0).size() < 25 ||
    data.get(1).size() < 25){
      return;
    }
    
    // Initialize the plots only once
    if (respirationPlot == null) { //<>//
        InitializePlots();
    }
    
    respirationPlot.setPos(50, 40);
    heartRatePlot.setPos(50, 300);

    GPointsArray respirationPoints = new GPointsArray(min(data.get(0).size(), 25));
    for (int i = max(0, data.get(0).size() - 25); i < data.get(0).size(); i++) {
        respirationPoints.add(i - (data.get(0).size() - 25), data.get(0).get(i));
    }
    respirationPlot.setPoints(respirationPoints);
    respirationPlot.defaultDraw();

    GPointsArray heartRatePoints = new GPointsArray(min(data.get(1).size(), 25));
    color[] pointColors = new color[min(data.get(1).size(), 25)];

    for (int i = max(0, data.get(1).size() - 25); i < data.get(1).size(); i++) {
        int heartRate = data.get(1).get(i);
        float percentage = (heartRate - baselineHeartRate) / (float)baselineHeartRate;

        if (percentage < 0.5) {
            pointColors[i - (data.get(1).size() - 25)] = color(173, 216, 230); // Baby Blue
        } else if (percentage < 0.6) {
            pointColors[i - (data.get(1).size() - 25)] = color(0, 0, 255); // Blue
        } else if (percentage < 0.7) {
            pointColors[i - (data.get(1).size() - 25)] = color(34, 139, 34); // Forest Green
        } else if (percentage < 0.8) {
            pointColors[i - (data.get(1).size() - 25)] = color(255, 215, 0); // Mustard Yellow
        } else {
            pointColors[i - (data.get(1).size() - 25)] = color(255, 0, 0); // Red
        }

        heartRatePoints.add(i - (data.get(1).size() - 25), heartRate);
    }
    
    heartRatePlot.setPoints(heartRatePoints);
    heartRatePlot.setPointColors(pointColors); // Set colors for the heart rate points
    heartRatePlot.defaultDraw();
}


public void InputLoop(){  
  addData();
  
  // Keep only the most recent 25 inputs
  if (data.get(0).size() > 25) {
      data.get(0).remove(0);
  }
  if (data.get(1).size() > 25) {
      data.get(1).remove(0);
  }
  
  background(255,255,255); // Clear the background for each frame
  drawGraph(); // Call to render the graph
}
