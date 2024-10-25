//Anna Carroll
//Last Updated Oct24,2024
#include <Wire.h>
#include "Adafruit_MPR121.h"

// Create the MPR121 object
Adafruit_MPR121 cap = Adafruit_MPR121();

// Define an array to store baseline data
int baselineData[12];

// Config the last registered input
int myLastTouch[12] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
int currentTouch[12] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};  // Array to store current touch data

// Set a flag to indicate if baseline collection is complete
bool baselineCollected = false;

void setup() {
  Serial.begin(9600);

  // Check if the sensor is properly initialized
  if (!cap.begin(0x5A)) {
    while (1); // Halt if MPR121 is not found
  }

  // Collect baseline data for the first 3 seconds
  unsigned long startTime = millis();
  while (millis() - startTime < 3000) { // Collect for 3 seconds
    for (uint8_t i = 0; i < 12; i++) {
      baselineData[i] = cap.filteredData(i); // Store baseline data
    }
  }
  
  baselineCollected = true; // Set flag after baseline is collected
  //Serial.println("Baseline data collected.");
  
  // Print baseline data---------
  //Serial.println("Baseline Data:");
  for (uint8_t i = 0; i < 12; i++) {
    //Serial.print(baselineData[i]);
    Serial.print("0");
    if (i < 11) {
      Serial.print(" ");
    }
  }//---------------------------
  Serial.println(); // Move to the next line after printing baseline data
}

void loop() {
  if (baselineCollected) {
    bool anyTouch = false; // Flag to check if there is any touch
    
    // Check all pins for touch status
    for (uint8_t i = 0; i < 12; i++) {
      int currentData = cap.filteredData(i);  // Get current data for each pin
      
      // Calculate difference between baseline and current data
      int difference = baselineData[i] - currentData;
      
      // Check if difference exceeds 20 to consider it a touch
      if (difference > 20) {
        currentTouch[i] = 1; // Mark as touch
        anyTouch = true;
      } else {
        currentTouch[i] = 0; // No touch
      }
    }

    // Compare currentTouch array with myLastTouch array
    bool arraysMatch = true;
    for (uint8_t i = 0; i < 12; i++) {
      if (currentTouch[i] != myLastTouch[i]) {
        arraysMatch = false;
        break;
      }
    }

    // If arrays don't match, print the new array and update myLastTouch
    if (!arraysMatch) {
      // Print the new touch data
      for (uint8_t i = 0; i < 12; i++) {
        Serial.print(currentTouch[i]);
        if (i < 11) {
          Serial.print(" ");
        }
      }
      Serial.println();
      
      // Update myLastTouch with the current touch data
      for (uint8_t i = 0; i < 12; i++) {
        myLastTouch[i] = currentTouch[i];
      }
    }

    // Add a small delay to avoid overwhelming the serial monitor
    delay(100);
  }
}
