#include <Wire.h>
#include <SPI.h>
#include <Adafruit_Sensor.h>
#include "Adafruit_BMP3XX.h"

// Pin definitions
const int EMG_PIN = A0;
const int THM_PIN = A1;    // Analog 1: thumb FSR - THM
const int IND_PIN = A2;    // Analog 2: index FSR - IND
const int MID_PIN = A3;    // Analog 3: middle FSR - MID
const int FLX_PIN = A4;    // Analog 4: flex sensor - FXS
const int MPU = 0x68;      // MPU6050 I2C address

// BMP3XX Pin definitions
#define BMP_SCK 13
#define BMP_MISO 12
#define BMP_MOSI 11
#define BMP_CS 10

#define SEALEVELPRESSURE_HPA (1013.25)
Adafruit_BMP3XX bmp;

// Variables
float thm, ind, mid;
float flx, vtg;
float AccX, AccY, AccZ;
float GyroX, GyroY, GyroZ;
float currentAltitude;
float AccErrorX, AccErrorY, GyroErrorX, GyroErrorY, GyroErrorZ;
float baselineAltitude = 0;
float baselineFlx = 0;
int c = 0;
int smoothedValue = 0;
const int bufferSize = 5;
int buffer[bufferSize];
int bufferIndex = 0;
float InitValue = 0;
bool initialized = false;
int amplitude = 0;

// Function prototypes
void calculate_IMU_error();
float initializeAltitude();
void readInput();
void printInput();

void setup() {
  Serial.begin(115200);
  while (!Serial);
  //Serial.println("Adafruit BMP388 / BMP390 test");

  if (! bmp.begin_SPI(BMP_CS)) {  // hardware SPI mode
    Serial.println("Could not find a valid BMP3 sensor, check wiring!");
    while (1);
  }
  // Initialize MPU6050
  Wire.begin();
  Wire.beginTransmission(MPU);
  Wire.write(0x6B); // Wake up MPU6050
  Wire.write(0x00);
  Wire.endTransmission(true);
  calculate_IMU_error();

  // Initialize EMG
  Serial.println("Initializing...");
  long sumEMG = 0;
  long sumAltitude = 0;
  long sumFlx = 0;
  
  int numSamples = 600; // 3 seconds at 200 Hz
  for (int i = 0; i < numSamples; i++) {
    sumEMG += analogRead(EMG_PIN);
    sumFlx += analogRead(FLX_PIN);

    if (!bmp.performReading()) {
      Serial.println("Failed to perform initialization reading :(");
      continue;
    }

    float currentAltitude = bmp.readAltitude(SEALEVELPRESSURE_HPA);
    if (i > 0) sumAltitude += currentAltitude;

    delay(5);
  }
  InitValue = sumEMG / numSamples;
  baselineAltitude = sumAltitude / (numSamples - 1);
  baselineFlx = sumFlx/numSamples;
  initialized = true;

  // Initialize buffer
  for (int i = 0; i < bufferSize; i++) buffer[i] = 0;

  // Initialize BMP3XX
  bmp.setTemperatureOversampling(BMP3_OVERSAMPLING_8X);
  bmp.setPressureOversampling(BMP3_OVERSAMPLING_4X);
  bmp.setIIRFilterCoeff(BMP3_IIR_FILTER_COEFF_3);
  bmp.setOutputDataRate(BMP3_ODR_50_HZ);

  //Serial.println("Initializing altitude...");
  //baselineAltitude = initializeAltitude();
  //Serial.print("Baseline Altitude: ");
  //Serial.print(baselineAltitude);
  //Serial.println(" m");
}

void loop() {
  // Read and process input values
  readInput();
  printInput();
  // Read and adjust altitude
  
  //delay(50); // Adjust delay for sensor sampling balance
}

// Function to calculate IMU error
void calculate_IMU_error() {
  while (c < 200) {
    Wire.beginTransmission(MPU);
    Wire.write(0x3B);
    Wire.endTransmission(false);
    Wire.requestFrom(MPU, 6, true);

    AccX = (Wire.read() << 8 | Wire.read()) / 16384.0;
    AccY = (Wire.read() << 8 | Wire.read()) / 16384.0;
    AccZ = (Wire.read() << 8 | Wire.read()) / 16384.0;

    AccErrorX += (atan((AccY) / sqrt(pow((AccX), 2) + pow((AccZ), 2))) * 180 / PI);
    AccErrorY += (atan(-1 * (AccX) / sqrt(pow((AccY), 2) + pow((AccZ), 2))) * 180 / PI);
    c++;
  }

  AccErrorX /= 200;
  AccErrorY /= 200;
  c = 0;

  while (c < 200) {
    Wire.beginTransmission(MPU);
    Wire.write(0x43);
    Wire.endTransmission(false);
    Wire.requestFrom(MPU, 6, true);

    GyroX = Wire.read() << 8 | Wire.read();
    GyroY = Wire.read() << 8 | Wire.read();
    GyroZ = Wire.read() << 8 | Wire.read();

    GyroErrorX += (GyroX / 131.0);
    GyroErrorY += (GyroY / 131.0);
    GyroErrorZ += (GyroZ / 131.0);
    c++;
  }

  GyroErrorX /= 200;
  GyroErrorY /= 200;
  GyroErrorZ /= 200;
}

// Reads the input values
void readInput() {
  thm = analogRead(THM_PIN);
  ind = analogRead(IND_PIN);
  mid = analogRead(MID_PIN);
  flx = analogRead(FLX_PIN);
  vtg = flx * (5.0 / 1023.0);

  Wire.beginTransmission(MPU);
  Wire.write(0x3B);
  Wire.endTransmission(false);
  Wire.requestFrom(MPU, 6, true);
  AccX = (Wire.read() << 8 | Wire.read()) / 16384.0;
  AccY = (Wire.read() << 8 | Wire.read()) / 16384.0;
  AccZ = (Wire.read() << 8 | Wire.read()) / 16384.0;

  Wire.beginTransmission(MPU);
  Wire.write(0x43);
  Wire.endTransmission(false);
  Wire.requestFrom(MPU, 6, true);
  GyroX = Wire.read() << 8 | Wire.read();
  GyroY = Wire.read() << 8 | Wire.read();
  GyroZ = Wire.read() << 8 | Wire.read();

  if (initialized) {
    int rawEMGValue = analogRead(EMG_PIN) - InitValue;
    int rectifiedValue = abs(rawEMGValue);
    smoothedValue = (smoothedValue * 0.9) + (rectifiedValue * 0.1);

    buffer[bufferIndex] = smoothedValue;
    bufferIndex = (bufferIndex + 1) % bufferSize;

    amplitude = buffer[0];
    for (int i = 1; i < bufferSize; i++) {
      if (buffer[i] > amplitude) amplitude = buffer[i];
    }
  }

  if (bmp.performReading()) {
    currentAltitude = bmp.readAltitude(SEALEVELPRESSURE_HPA) - baselineAltitude;
    //Serial.print("Adjusted Altitude: ");
    //Serial.print(currentAltitude);
    //Serial.println(" m");
  } else {
    Serial.println("Failed to read from BMP3XX sensor");
  }

}

// Prints input values
//FSR (Thumb, Index, Middle) | Flex, VoltFlex | Acc (x,y,z) Gyro (x,y,z) | 
void printInput() {
  Serial.print(thm); //0-1023
  Serial.print(", ");
  Serial.print(ind); //0-1023
  Serial.print(", ");
  Serial.print(mid); //0-1023
  Serial.print(", ");
  Serial.print(flx-baselineFlx); //0-17
  Serial.print(", ");
  Serial.print(vtg);
  Serial.print(", ");
  Serial.print(AccX);
  Serial.print(", ");
  Serial.print(AccY);
  Serial.print(", ");
  Serial.print(AccZ);
  Serial.print(", ");
  Serial.print(GyroX);
  Serial.print(", ");
  Serial.print(GyroY);
  Serial.print(", ");
  Serial.print(GyroZ);
  Serial.print(", ");
  Serial.print(smoothedValue);
  Serial.print(", ");
  Serial.print(amplitude);
  Serial.print(", ");
  Serial.println(currentAltitude); // if you want altitude in integers: Serial.println(currentAltitude);

}

// Function to calculate baseline altitude
float initializeAltitude() {
  float sumAltitude = 0;
  int samples = 16;

  for (int i = 0; i < samples; i++) {
    if (!bmp.performReading()) {
      Serial.println("Failed to perform initialization reading :(");
      continue;
    }

    float currentAltitude = bmp.readAltitude(SEALEVELPRESSURE_HPA);
    if (i > 0) sumAltitude += currentAltitude;

    delay(200);
  }

  return sumAltitude / (samples - 1);
}
