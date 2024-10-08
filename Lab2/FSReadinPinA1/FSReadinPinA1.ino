int fsrPin = A1;     // the FSR and 10K pulldown are connected to a0
int fsrReading;     // the analog reading from the FSR resistor divider
 
void setup(void) {
  Serial.begin(9600);   
}
 
void loop(void) {
  fsrReading = analogRead(fsrPin);  
 
  Serial.println(fsrReading);     // print the raw analog reading
 
  delay(1000);
}