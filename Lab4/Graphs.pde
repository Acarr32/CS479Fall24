void initializeGraphs(){
  // Graphs dimensions
  graphWidth = width * 2 / 9;
  graphHeight = height / 2;
}

// use graphWidth and grapHeight for graph size
void drawGraphs(){  
  drawGraph(MMarr, 0, 0, graphWidth, graphHeight, "MM Graph");
  drawGraph(MFarr, graphWidth, 0, graphWidth, graphHeight, "MF Graph");
  drawGraph(LFarr, 0, graphHeight, graphWidth, graphHeight, "LF Graph");
  drawGraph(Heelarr, graphWidth, graphHeight, graphWidth, graphHeight, "Heel Graph");
}

void drawGraph(ArrayList<Float> data, float x, float y, float w, float h, String title) {
    fill(255);
    rect(x, y, w, h); // Draw background for the graph
    fill(0);
    textAlign(CENTER, CENTER);
    text(title, x + w / 2, y + 20); // Display title at the top

    // Draw X and Y axes
    stroke(0);
    line(x + 40, y, x + 40, y + h); // Y-axis
    line(x, y + h - 40, x + w, y + h - 40); // X-axis

    // Label X and Y axes
    textAlign(RIGHT, CENTER);
    text("", x + 30, y + h / 2); // Y-axis label
    textAlign(CENTER, BOTTOM);
    text("", x + w / 2, y + h - 20); // X-axis label

    // Plot data points
    float maxVal = 1000; // Adjust according to expected data range
    for (int i = 1; i < data.size(); i++) {
        float x1 = map(i - 1, 0, data.size() - 1, x + 40, x + w); // Start after Y-axis offset
        float y1 = map(data.get(i - 1), 0, maxVal, y + h - 40, y); // Adjust to fit within axes
        float x2 = map(i, 0, data.size() - 1, x + 40, x + w);
        float y2 = map(data.get(i), 0, maxVal, y + h - 40, y);
        
        stroke(0);
        line(x1, y1, x2, y2); // Draw line between data points
    }
}
