void initializeGraphs(){
    fsrPlot = new GPlot(this);
    flexPlot = new GPlot(this);
    heightPlot = new GPlot(this);
    emgPlot = new GPlot(this);
}

void drawGraphs(){
  initializeGraphs();
  
    drawGraphGPlot(fsrData, fsrPlot, width * .025 , height * .025 , width / 3, height / 3, "FSR PLOT" , "Time", "Force Reading");
    drawGraphGPlot(addShell(flexData), flexPlot, (width * .05) + width / 3, height * .025, width / 3, height /3 , "FLEX PLOT" , "Time", "Flex Sensor Read");
    drawGraphGPlot(addShell(heightData), heightPlot, width * .025 , height - height/3 - height *.025 , width / 3, height / 3, "Altitude Plot", "Time", "Altitude Reading");
    drawGraphGPlot(addShell(emgData), emgPlot, (width * .05) + width / 3 , height - height/3 - height *.025 , width / 3, height / 3, "EMG Plot", "Time", "EMG Reading");

}

GPointsArray arrayToPoints(ArrayList<Data> data){
  GPointsArray points = new GPointsArray(data.size());
  for(int i = 0; i < data.size(); i++){
    points.add(data.get(i).getTime(), data.get(i).getReading());
  }
  return points;
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
    if (plot == fsrPlot){
    plot.setYLim(0, 1023); // set y limits
    }
    else if (plot == fsrPlot){
      plot.setYLim(0, 1023); // set y limits
    }
    else if (plot == flexPlot){
      plot.setYLim(-5, 30); // set y limits
    }
    else if (plot == heightPlot){
      plot.setYLim(0, 5); // set y limits
    }
    else if (plot == emgPlot){
      plot.setYLim(0, 500); // set y limits
    }
    // Define a list of colors for different layers (adjust as needed)
    color[] colors = {mossGreen, rustyRed, coralOrange, charcoalGray, seafoamGreen};

    // Add datasets as layers
    for (int i = 0; i < datasets.size(); i++) {
        GPointsArray tempPoints = arrayToPoints(datasets.get(i));
        String layerName = "Layer " + i;
        color layerColor = colors[i % colors.length];
        if(plot.getLayer(layerName) == null){
            plot.addLayer(layerName, tempPoints);
            plot.getLayer(layerName).setLineColor(layerColor);
            plot.getLayer(layerName).setPointColor(layerColor);
        }
        else{
            plot.getLayer(layerName).setPoints(tempPoints);
        }
    }

    // Draw the plot
    plot.beginDraw();
    plot.setGridLineColor(color(50)); // Grid line color
    plot.drawBackground();
    plot.drawBox();
    plot.drawXAxis();
    plot.drawYAxis();
    //plot.setYLim(0, 30); // set y limits
    plot.drawTitle();
    plot.drawGridLines(GPlot.BOTH);
    plot.drawLabels();
    plot.drawPoints();
    plot.drawLines();
    plot.endDraw();
}


void drawBubbles(){ //<>// //<>// //<>// //<>//
  float tempThumb, tempPtr, tempMid;
  
  tempThumb = currValues != null ? currValues.GetThm() : 0; //<>// //<>// //<>// //<>// //<>//
  tempPtr = currValues != null ? currValues.GetPtr() : 0;
  tempMid = currValues != null ? currValues.GetMid() : 0;
  
  drawBubble(thumbX, thumbY, tempThumb);
  drawBubble(pointerX, pointerY, tempPtr);
  drawBubble(middleX, middleY, tempMid);
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
