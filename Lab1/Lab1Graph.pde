class bioData {
  float heartRate;
  float confidence;
  float oxygen;
  int status;
  
  bioData(float HeartRate, float Confidence, float Oxygen, int Status){
    this.heartRate = HeartRate;
    this.confidence = Confidence;
    this.oxygen = Oxygen;
    this.status = Status;
  }
  
  bioData(){
    this.heartRate = 0.0;
    this.confidence = 0.0;
    this.oxygen = 0.0;
    this.status = -99;
  }
}

void drawGraph(){
}
