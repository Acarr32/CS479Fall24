void initializeGraphs(){
  // Graphs dimensions
  graphWidth = width * 2 / 9;
  graphHeight = height / 2;
}

// use graphWidth and grapHeight for graph size
void drawGraphs(){  
  graph1();
  graph2();
  graph3();
  graph4();
}

void graph1(){
  fill(255);
  rect(0, 0, graphWidth, graphHeight);
  fill(0);
  text("FSR graph 1", graphWidth / 2, graphHeight / 2);  
}

void graph2(){
  fill(255);
  rect(graphWidth, 0, graphWidth, graphHeight);
  fill(0);
  text("FSR graph 2", graphWidth * 3 / 2, graphHeight / 2);
}

void graph3(){
  fill(255);
  rect(0, graphHeight, graphWidth, graphHeight);
  fill(0);
  text("FSR graph 3", graphWidth / 2, graphHeight * 3 / 2);
}

void graph4(){
  fill(255);
  rect(graphWidth, graphHeight, graphWidth, graphHeight);
  fill(0);
  text("FSR graph 4", graphWidth * 3 / 2, graphHeight * 3 / 2);
}
