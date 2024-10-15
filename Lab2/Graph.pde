void addData() {
  heartrate = (int)random(60, 100);
  heartRates.add(heartrate);
  resprate = (int)random(200, 700);
  respirationRates.add(resprate);
  
  // Simulate a sinusoidal EKG signal
  ekg = (int)(500 + 400 * Math.round(sin(TWO_PI * frequency * timeStep / 60))); // Sinusoidal wave
  ekgs.add(ekg);
  
  // Increment time step
  timeStep++;
}


public void InitializePlots() {
    respirationPlot = new GPlot(this);
    heartRatePlot = new GPlot(this);
    ekgPlot = new GPlot(this);

    // Set titles and axis labels for all plots
    respirationPlot.setTitleText("Respiration Rate");
    respirationPlot.getXAxis().setAxisLabelText("N-th Recent Sample");
    respirationPlot.getYAxis().setAxisLabelText("Rate (breaths/min)");

    heartRatePlot.setTitleText("Heart Rate");
    heartRatePlot.getXAxis().setAxisLabelText("N-th Recent Sample");
    heartRatePlot.getYAxis().setAxisLabelText("Rate (beats/min)");
    
    ekgPlot.setTitleText("EKG");
    ekgPlot.getXAxis().setAxisLabelText("N-th Recent Sample");
    ekgPlot.getYAxis().setAxisLabelText("Voltage (mV)");
}

public void drawGraph() {
    background(47, 79, 79);

    fill(255);
    textAlign(LEFT);
    text("Heart Rate: " + heartrate, 525, 100);
    text("Respiration Rate: " + resprate, 525, 150);

    // Initialize the plots only once
    if (respirationPlot == null || heartRatePlot == null || ekgPlot == null) {
        InitializePlots();
    }

    // Positioning for plots
    respirationPlot.setPos(50, 40);   // Respiration plot
    heartRatePlot.setPos(50, 220);    // Heart rate plot
    ekgPlot.setPos(50, 400);           // EKG plot

    // Draw Respiration plot
    drawRespirationPlot();
    // Draw Heart Rate plot
    drawHeartRatePlot();
    // Draw EKG plot
    drawEkgPlot();
}

void drawRespirationPlot() {
    GPointsArray respirationPoints = new GPointsArray(min(respirationRates.size(), 25));
    for (int i = max(0, respirationRates.size() - 25); i < respirationRates.size(); i++) {
        respirationPoints.add(i - (respirationRates.size() - 25), respirationRates.get(i));
    }
    respirationPlot.setPoints(respirationPoints);
    respirationPlot.defaultDraw();
}

void drawHeartRatePlot() {
    GPointsArray heartRatePoints = new GPointsArray(min(heartRates.size(), 25));
    color[] pointColors = new color[min(heartRates.size(), 25)];

    int colorIndex = 0;
    for (int i = max(0, heartRates.size() - 25); i < heartRates.size(); i++) {
        int heartRate = heartRates.get(i);
        float percentage = (heartRate - baselineHeartRate) / (float)baselineHeartRate;

        // Determine color based on heart rate percentage
        pointColors[colorIndex] = determineHeartRateColor(percentage);
        heartRatePoints.add(colorIndex, heartRate);
        colorIndex++;
    }

    heartRatePlot.setPoints(heartRatePoints);
    heartRatePlot.setPointColors(pointColors);
    heartRatePlot.defaultDraw();
}

color determineHeartRateColor(float percentage) {
    if (percentage < 0.5) return color(173, 216, 230); // Baby Blue
    if (percentage < 0.6) return color(0, 0, 255);     // Blue
    if (percentage < 0.7) return color(34, 139, 34);   // Forest Green
    if (percentage < 0.8) return color(255, 215, 0);   // Mustard Yellow
    return color(255, 0, 0); // Red
}

void drawEkgPlot() {
    GPointsArray ekgPoints = new GPointsArray(min(ekgs.size(), 25));
    for (int i = max(0, ekgs.size() - 25); i < ekgs.size(); i++) {
        ekgPoints.add(i - (ekgs.size() - 25), ekgs.get(i));
    }
    ekgPlot.setPoints(ekgPoints);
    ekgPlot.defaultDraw();
}

void InputLoop() {
    if (heartRates.size() > 25) {
        heartRates.remove(0);
    }
    if (respirationRates.size() > 25) {
        respirationRates.remove(0);
    }
    if (ekgs.size() > 25) {
        ekgs.remove(0);
    }

    background(255, 255, 255);
    drawGraph();
    drawSpin();
}
