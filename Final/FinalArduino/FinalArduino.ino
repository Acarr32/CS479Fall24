#include <Wire.h>

// Analog 0: EMG
const int THM_PIN = 1;    // Analog 1: thumb FSR - THM
const int IND_PIN = 2;    // Analog 2: index FSR - IND
const int MID_PIN = 3;    // Analog 3: middle FSR - MID
const int FLX_PIN = 4;    // Analog 4: flex sensor - FXS

float thm, ind, mid;
float flx, vtg;

void setup(){
  Serial.begin(115200);

}

void loop(){
  readInput();
  printInput();
  delay(200);
}

// Reads the input values
void readInput() {
  // FSR Sensors on thumb, index and middle finger - value
  thm = analogRead(THM_PIN);
  ind = analogRead(IND_PIN);
  mid = analogRead(MID_PIN);

  // Flex Sensor on middle finger - value and voltage
  flx = analogRead(FLX_PIN);
  vtg = flx * (5.0 / 1023.0);
}

// Prints the input in the serial monitor
void printInput() {
  Serial.print("Thumb: ");
  Serial.print(thm);
  Serial.print(" | Index: ");
  Serial.print(ind);
  Serial.print(" | Middle: ");
  Serial.print(mid);
  Serial.print(" || Flex: ");
  Serial.print(flx);
  Serial.print(" | Voltage: ");
  Serial.println(vtg);
}