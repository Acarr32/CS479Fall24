void initializeGraphs(){
  
}

void drawGraphs(){
  
}
void drawGraphGPlot(Data[] data, GPlot plot,
                    float x, float y, float w, float h, 
                    String title, String xAxisTitle, String yAxisTitle) { //<>//
    GPointsArray points = new GPointsArray();
    for (int i = 0; i < data.length; i++) {
        points.add(data[i].getTime(), data[i].getReading()); // Add data to GPointsArray
    }

    plot.setPoints(points);
    plot.beginDraw();
    
    plot.setPos(x, y);
    plot.setOuterDim(w, h);

    plot.setTitleText(title);
    plot.getXAxis().setAxisLabelText(xAxisTitle);
    plot.getYAxis().setAxisLabelText(yAxisTitle);
    
    plot.setLineColor(PLOT_LINE_COLOR);
    plot.setPointColor(PLOT_POINT_COLOR);
    plot.setPointSize(PLOT_POINT_SIZE);
    plot.setGridLineColor(PLOT_GRID_LINE_COLOR); 
    
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


void drawBubbles(){
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
