static final DecimalFormat df = new DecimalFormat("0.00");

void updateMetrics(){
  int metricSpace = 70;
  int metricsPadding = 50;
  
  bioData test = new bioData(0.1, 1.0, 1.1, 3);
  
  data.addEntry(test);
  
  bioData metrics = data.getMetrics();
  
  fill(255,255,255);
  text(df.format(metrics.confidence), width * 2/3 + 260, height/4 + 2*metricSpace - metricsPadding);
  text(df.format(metrics.oxygen), width * 2/3 + 260, height/4 + 3*metricSpace - metricsPadding);
  text(intepretStatus(metrics.status), width * 2/3 + 140, height/4  + 4*metricSpace - metricsPadding);
  
  
  fill(getZone(metrics.heartRate));
  text(df.format(metrics.heartRate), width * 2/3 + 260, height/4 + metricSpace - metricsPadding);
}

color getZone(float heartRate){
  //TODO
  return new color(255,255,255);
}
String intepretStatus(int status){
  switch(status){
    case 0:
      return "No Object Found";
    case 1:
      return "Object Found";
    case 2:
      return "Object Found";
    case 3:
      return "Finger Found";
  }
  return "ERROR";
}

void renderGraph(){
}
