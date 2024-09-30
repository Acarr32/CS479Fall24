#include <SparkFun_Bio_Sensor_Hub_Library.h>
#include <Wire.h>
#include <ArrayList.h> 

// No other Address options.
#define DEF_ADDR 0x55

// Reset pin, MFIO pin
const int resPin = 4;
const int mfioPin = 5;
int heartrate = 0;
int confidence = 0;
int oxygen = 0;
int status = 0;

int buzzer_pin = 12;


// Takes address, reset pin, and MFIO pin.
SparkFun_Bio_Sensor_Hub bioHub(resPin, mfioPin); 

bioData body;  
ArrayList<bioData> infoList;


void setup(){

  Serial.begin(115200);

  Wire.begin();
  int result = bioHub.begin();
  int error = bioHub.configBpm(MODE_ONE);
  delay(2000);
}

void loop(){

    // Information from the readBpm function will be saved to our "body"
    // variable.  
    body = bioHub.readBpm();
    if(!body.heartRate){
      Serial.print(heartrate);
      Serial.print(", ");
      Serial.print(confidence);
      Serial.print(", ");
      Serial.print(oxygen);
      Serial.print(", ");
      Serial.println(body.status);
    }
    else{
      heartrate = body.heartRate;
      oxygen = body.oxygen;
      confidence = body.confidence;

      Serial.print(heartrate);
      Serial.print(", ");
      Serial.print(confidence);
      Serial.print(", ");
      Serial.print(oxygen);
      Serial.print(", ");
      Serial.println(body.status);
    }
    if (Serial.available() > 0) {
      char incomingData = Serial.read();
      
      if (incomingData == 'B') { // 'B' stands for Buzz
        buzz();
      }
    }
    delay(1000); // Slowing it down, we don't need to break our necks here.
}

void buzz(){
  tone(buzzer_pin, 100); // Turn on the buzzer
  delay(5000);                   // Keep it on for 1 second (adjust as needed)
  noTone(buzzer_pin);  // Turn off the buzzer
}

