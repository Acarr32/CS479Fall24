#include <Wire.h>

// Pin definitions for Code 1
const int EMG_PIN = A0;
const int THM_PIN = A1;    // Analog 1: thumb FSR - THM
const int IND_PIN = A2;    // Analog 2: index FSR - IND
const int MID_PIN = A3;    // Analog 3: middle FSR - MID
const int FLX_PIN = A4;    // Analog 4: flex sensor - FXS
const int MPU = 0x68;     // MPU6050 I2C address

// Variables for Code 1
float thm, ind, mid;
float flx, vtg;
float AccX, AccY, AccZ;
float GyroX, GyroY, GyroZ;
float AccErrorX, AccErrorY, GyroErrorX, GyroErrorY, GyroErrorZ;
int c = 0;
int smoothedValue = 0;
const int bufferSize = 5;
int buffer[bufferSize];
int bufferIndex = 0;
int InitValue = 0;
bool initialized = false;
int amplitude = 0; // Declare amplitude as a global variable

// Setup function
void setup() {
  Serial.begin(115200);

  Wire.begin();
  Wire.beginTransmission(MPU);
  Wire.write(0x6B); // Wake up MPU6050
  Wire.write(0x00);
  Wire.endTransmission(true);
  calculate_IMU_error();
  Serial.println("Initializing MyoWare sensor...");
  long sum = 0;
  int numSamples = 600; // 3 seconds at 200 Hz
  for (int i = 0; i < numSamples; i++) {
    int rawValue = analogRead(EMG_PIN);
    sum += rawValue;
    Serial.print("Analog Read: ");
    Serial.println(rawValue);
    delay(5);
  }

  InitValue = sum / numSamples;
  initialized = true;
  Serial.print("Initialization complete. InitValue: ");
  Serial.println(InitValue);

  // Initialize buffer
  for (int i = 0; i < bufferSize; i++) buffer[i] = 0;
}

// Main loopln
void loop() {
  // Read and process data from Code 1
  readInput();
  printInput();

  delay(50); // Adjust to balance the output of both functionalities
}

// Reads the input values for Code 1
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
    int rawValue = analogRead(EMG_PIN) - InitValue;
    int rectifiedValue = abs(rawValue);
    smoothedValue = (smoothedValue * 0.9) + (rectifiedValue * 0.1);

    // Store and calculate maximum amplitude
    buffer[bufferIndex] = smoothedValue;
    bufferIndex = (bufferIndex + 1) % bufferSize;

    amplitude = buffer[0]; // Use global variable
    for (int i = 1; i < bufferSize; i++) {
      if (buffer[i] > amplitude) amplitude = buffer[i];
    }
  }
}

// Prints input values for Code 1
void printInput() {
  //OUTPUT PRINT:
  //FSR(Th, Pt, M), Flex (ADC, V), Acc(X, Y, Z), Gyro(X, Y, Z), MyoWare(Smooth, Ampl)

  //Serial.print("FSR(Th, Pt, M): ");
  Serial.print(thm);
  Serial.print(", ");
  Serial.print(ind);
  Serial.print(", ");
  Serial.print(mid);
  Serial.print(", ");
  //Serial.print(" || Flex (ADC, V): ");
  Serial.print(flx);
  Serial.print(", ");
  Serial.print(vtg);
  Serial.print(", ");
  //Serial.print(" || Acc(X, Y, Z): ");
  Serial.print(AccX);
  Serial.print(", ");
  Serial.print(AccY);
  Serial.print(", ");
  Serial.print(AccZ);
  Serial.print(", ");
  //Serial.print(" || Gyro(X, Y, Z): ");
  Serial.print(GyroX);
  Serial.print(", ");
  Serial.print(GyroY);
  Serial.print(", ");
  Serial.print(GyroZ);
  Serial.print(", ");
  //Serial.print(" || MyoWare(Smooth, Ampl): ");
  Serial.print(smoothedValue);
  Serial.print(", ");
  Serial.println(amplitude); // Use global variable
}

// Function to calculate IMU error for Code 1
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
