void initializeGraphs(){
    fsrPlot = new GPlot(this);
    flexPlot = new GPlot(this);
    heightPlot = new GPlot(this);
}
void drawGraphs(){
    drawGraphGPlot(fsrData, fsrPlot, width * .025 , height * .025 , width / 3, height / 3, "FSR PLOT" , "Time", "Force Reading");
    drawGraphGPlot(addShell(flexData), flexPlot, (width * .05) + width / 3, height * .025, width / 3, height /3 , "FLEX PLOT" , "Time", "Flex Sensor Read");
    drawGraphGPlot(addShell(heightData), heightPlot, width * .025 , height - height/3 - height *.025 , width * .7, height / 3, "Altitude Plot", "Time", "Altitude Reading");
}

void drawGraphGPlot(ArrayList<ArrayList<Data>> datasets, GPlot plot,
                             float x, float y, float w, float h, 
                             String title, String xAxisTitle, String yAxisTitle) {
    plot.setPos(x, y);
    plot.setOuterDim(w, h);

    // Set plot titles
    plot.setTitleText(title);
    plot.getXAxis().setAxisLabelText(xAxisTitle);
    plot.getYAxis().setAxisLabelText(yAxisTitle);

    // Define a list of colors for different layers (adjust as needed)
    color[] lineColors = {mossGreen, rustyRed, coralOrange, charcoalGray, seafoamGreen};
    color[] pointColors = {mossGreen, rustyRed, coralOrange, charcoalGray, seafoamGreen};

    // Add datasets as layers
    for (int i = 0; i < datasets.size(); i++) {
        GPointsArray points = new GPointsArray();
        ArrayList<Data> data = datasets.get(i);

        for (int j = 0; j < data.size(); j++) {
            points.add(data.get(j).getTime(), data.get(j).getReading());
        }

        if (i == 0) {
            // Set the main points for the plot
            plot.setPoints(points);
            plot.setLineColor(lineColors[i % lineColors.length]);
            plot.setPointColor(pointColors[i % pointColors.length]);
        } else {
            // Add additional datasets as layers
            String layerName = "Layer " + i;
            plot.addLayer(layerName, points);
            plot.getLayer(layerName).setLineColor(lineColors[i]);
            plot.getLayer(layerName).setPointColor(pointColors[i]);
        }
    }

    // Draw the plot
    plot.beginDraw();
    plot.setGridLineColor(color(50)); // Grid line color
    plot.drawBackground();
    plot.drawBox();
    plot.drawXAxis();
    plot.drawYAxis();
    plot.drawTitle();
    plot.drawGridLines(GPlot.BOTH);
    plot.drawLabels();
    plot.drawPoints();
    plot.drawLines();
    plot.endDraw();
}


 //<>//
void drawBubbles(){
  currPinkyForce = 0;
  currRingForce = 0;
  currMiddleForce = 0;
  currPointerForce =0;
  currThumbForce = 0;
  
  drawBubble(pinkyX, pinkyY, currPinkyForce);
  drawBubble(ringX, ringY, currRingForce);
  drawBubble(middleX, middleY, currMiddleForce);
  drawBubble(pointerX, pointerY, currPointerForce);
  drawBubble(thumbX, thumbY, currThumbForce);
}

void drawBubble(float x, float y, float reading){
  float minSize = 30;
  float maxSize = 200;
  
  float size = map(reading, 0, MAX_FORCE_READING, minSize, maxSize);
  
  // Smooth color gradient
  float t = map(reading, 0, MAX_FORCE_READING, 0, 1);
  color startColor = color(0, 0, 255);
  color endColor = color(255, 0, 0);   
  color bubbleColor = lerpColor(startColor, endColor, t);
  
  // Set the fill color and draw the circle
  fill(bubbleColor);
  noStroke();
  
  circle(x,y, size);
  
}
