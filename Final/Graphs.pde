void initializeGraphs(){
  
}

void drawGraph(float[] data, float x, float y, float w, float h, String title) {
    fill(255);
    rect(x, y, w, h); // Draw background for the graph
    fill(0);
    textAlign(CENTER, CENTER);
    text(title, x + w / 2, y + 20); // Display title at the top

    // Draw X and Y axes
    stroke(0);
    line(x + 40, y, x + 40, y + h); // Y-axis
    line(x, y + h - 40, x + w, y + h - 40); // X-axis

    // Plot data points
    float maxVal = 1500; // Adjust according to expected data range
    for (int i = 1; i < data.length; i++) {
        float x1 = map(i - 1, 0, data.length - 1, x + 40, x + w); // Start after Y-axis offset
        float y1 = map(data[i - 1], 0, maxVal, y + h - 40, y); // Adjust to fit within axes
        float x2 = map(i, 0, data.length - 1, x + 40, x + w);
        float y2 = map(data[i], 0, maxVal, y + h - 40, y);

        stroke(0);
        line(x1, y1, x2, y2); // Draw line between data points
    }
}
