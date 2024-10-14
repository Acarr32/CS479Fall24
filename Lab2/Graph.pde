void addData() {
  heartrate = (int)random(60, 100); // Change
  heartRates.add(heartrate);
  resprate = (int)random(200, 700);
  respirationRates.add(resprate);
}

public void InitializePlots() {
    respirationPlot = new GPlot(this);  // Initialize respiration plot
    heartRatePlot = new GPlot(this);    // Initialize heart rate plot

    // Set titles and axis labels for both plots
    respirationPlot.setTitleText("Respiration Rate");
    respirationPlot.getXAxis().setAxisLabelText("N-th Recent Sample");
    respirationPlot.getYAxis().setAxisLabelText("Rate (breaths/min)");

    heartRatePlot.setTitleText("Heart Rate");
    heartRatePlot.getXAxis().setAxisLabelText("N-th Recent Sample");
    heartRatePlot.getYAxis().setAxisLabelText("Rate (beats/min)");
}

public void drawGraph() {
    background(47, 79, 79); // Clear the background with a white color
    
    fill(47, 79, 79);
    rect(500, 0 * (buttonHeight + buttonSpacing), buttonWidth, 600);
    fill(255);
    textAlign(LEFT);
    text("Heart Rate: " + heartrate, 525, 100);
    fill(255);
    text("Respiration Rate: " + resprate, 525, 150);
    
    // Initialize the plots only once
    if (respirationPlot == null || heartRatePlot == null) {
        InitializePlots();
    }

    respirationPlot.setPos(50, 40);   // Position for respiration plot
    heartRatePlot.setPos(50, 300);    // Position for heart rate plot

    // Respiration plot
    GPointsArray respirationPoints = new GPointsArray(min(respirationRates.size(), 25));
    for (int i = max(0, respirationRates.size() - 25); i < respirationRates.size(); i++) {
        respirationPoints.add(i - (respirationRates.size() - 25), respirationRates.get(i));
    }
    respirationPlot.setPoints(respirationPoints);
    respirationPlot.defaultDraw();

    // Heart rate plot
    GPointsArray heartRatePoints = new GPointsArray(min(heartRates.size(), 25));
    color[] pointColors = new color[min(heartRates.size(), 25)];

    int colorIndex = 0;  // New index to safely access the pointColors array
    for (int i = max(0, heartRates.size() - 25); i < heartRates.size(); i++) {
        int heartRate = heartRates.get(i);
        float percentage = (heartRate - baselineHeartRate) / (float)baselineHeartRate;

        if (percentage < 0.5) {
            pointColors[colorIndex] = color(173, 216, 230); // Baby Blue
        } else if (percentage < 0.6) {
            pointColors[colorIndex] = color(0, 0, 255); // Blue
        } else if (percentage < 0.7) {
            pointColors[colorIndex] = color(34, 139, 34); // Forest Green
        } else if (percentage < 0.8) {
            pointColors[colorIndex] = color(255, 215, 0); // Mustard Yellow
        } else {
            pointColors[colorIndex] = color(255, 0, 0); // Red
        }

        heartRatePoints.add(colorIndex, heartRate);  // Correctly mapped index
        colorIndex++;  // Increment the index for pointColors array
    }

    heartRatePlot.setPoints(heartRatePoints);
    heartRatePlot.setPointColors(pointColors);  // Set colors for the heart rate points
    heartRatePlot.defaultDraw();
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
  drawSpin();
}
