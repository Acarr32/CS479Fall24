//Init Variables
int fsrPin = A1; //Pin of Force Sensor 
int fsrReading;  //Force Sensor READING
int ecgPin = A0;


void setup() {
  // initialize serial comms:
  Serial.begin(9600);
  pinMode(10, INPUT); // LO +
  pinMode(11, INPUT); // LO -
}

void loop() {
  
  if((digitalRead(10) == 1)||(digitalRead(11) == 1)){
    Serial.println('!');
  }
  else{
    // send the value of analog input 0:
      Serial.println(analogRead(ecgPin)); //ecg raw print
      //Serial.print(", ");
      //fsrReading = analogRead(fsrPin);
      //Serial.println(fsrReading);     // fsr raw print

  }
  delay(1);
}