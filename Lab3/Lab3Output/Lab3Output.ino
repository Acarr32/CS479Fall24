#include <Wire.h>
#include "Adafruit_MPR121.h"

// Create the MPR121 object
Adafruit_MPR121 cap = Adafruit_MPR121();

// Define an array to store baseline data
int baselineData[12];

// Set a flag to indicate if baseline collection is complete
bool baselineCollected = false;

// Set a flag to track when the last output was all zeros
bool zerosPrinted = false;

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
  Serial.println("Baseline data collected.");
  
  // Print baseline data
  Serial.println("Baseline Data:");
  for (uint8_t i = 0; i < 12; i++) {
    Serial.print(baselineData[i]);
    if (i < 11) {
      Serial.print(" ");
    }
  }
  Serial.println(); // Move to the next line after printing baseline data
}

void loop() {
  if (baselineCollected) {
    bool anyTouch = false; // Flag to check if there is any touch (binary 1)
    
    // Check all pins for touch status
    for (uint8_t i = 0; i < 12; i++) {
      int currentData = cap.filteredData(i);  // Get current data for each pin
      
      // Calculate difference between baseline and current data
      int difference = baselineData[i] - currentData;
      
      // Check if difference exceeds 20 to consider it a touch
      if (difference > 20) {
        anyTouch = true; // Set flag if any pin is touched
        break; // No need to check further if a touch is detected
      }
    }

    // If any touch (binary 1) is detected
    if (anyTouch) {
      // Reset the zerosPrinted flag to allow zero print when no touch happens
      zerosPrinted = false;
      
      // Print the values for each pin
      for (uint8_t i = 0; i < 12; i++) {
        int currentData = cap.filteredData(i);  // Get current data again
        
        // Calculate difference between baseline and current data
        int difference = baselineData[i] - currentData;
        
        // Output 1 if touch detected, 0 otherwise
        if (difference > 20) {
          Serial.print("1");
        } else {
          Serial.print("0");
        }
        
        // Print a space between values, but no space at the end of the line
        if (i < 11) {
          Serial.print(" ");
        }
      }
      // Move to the next line after printing all values
      Serial.println();
    } 
    // If no touch detected (all 0's), print a line of zeros just once
    else if (!zerosPrinted) {
      for (uint8_t i = 0; i < 12; i++) {
        Serial.print("0");
        if (i < 11) {
          Serial.print(" ");
        }
      }
      Serial.println();
      zerosPrinted = true; // Set the flag to avoid printing zeros again until a touch is detected
    }

    // Add a small delay to avoid overwhelming the serial monitor
    delay(100);
  }
}
