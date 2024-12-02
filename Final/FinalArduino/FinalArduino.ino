Last login: Sun Dec  1 20:39:59 on ttys000
milkchocolatejr@Alexanders-MacBook-Air-4 ~ % cd Desktop 
milkchocolatejr@Alexanders-MacBook-Air-4 Desktop % cd CS479Fall24 
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git pull
remote: Enumerating objects: 7, done.
remote: Counting objects: 100% (7/7), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 6 (delta 3), reused 0 (delta 0), pack-reused 0 (from 0)
Unpacking objects: 100% (6/6), 3.35 KiB | 380.00 KiB/s, done.
From github.com:Acarr32/CS479Fall24
   dda9ee4..a346618  main       -> origin/main
Updating dda9ee4..a346618
Fast-forward
 README.md | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 README.md
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git branch
  AJ
  lastMain
* main
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git branch -a
  AJ
  lastMain
* main
  remotes/origin/AJ
  remotes/origin/Anna2
  remotes/origin/Eleonora
  remotes/origin/HEAD -> origin/main
  remotes/origin/lastMain
  remotes/origin/main
  remotes/origin/shehriar
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git branch Anna2
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git pull
Already up to date.
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % cd Final 
milkchocolatejr@Alexanders-MacBook-Air-4 Final % ls  
Classes.pde		Functions.pde		Replay.pde
Errors.pde		Graphs.pde		Variables.pde
FileOutput.pde		Main.pde		data
FinalArduino		Popups.pde		sketch.properties
milkchocolatejr@Alexanders-MacBook-Air-4 Final % cd FinalArduino 
milkchocolatejr@Alexanders-MacBook-Air-4 FinalArduino % ls
FinalArduino.ino
milkchocolatejr@Alexanders-MacBook-Air-4 FinalArduino % vim FinalArduino.ino 
milkchocolatejr@Alexanders-MacBook-Air-4 FinalArduino % cd ..
milkchocolatejr@Alexanders-MacBook-Air-4 Final % cd ..
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % ls 
ECGReadingExample.png	Lab1			Lab4
Final			Lab2			README.md
Lab0			Lab3			libraries
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git branch main
fatal: a branch named 'main' already exists
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git checkout Anna2
Switched to branch 'Anna2'
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % ls
ECGReadingExample.png	Lab1			Lab4
Final			Lab2			README.md
Lab0			Lab3			libraries
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git branch -d
fatal: branch name required
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git branch -a
  AJ
* Anna2
  lastMain
  main
  remotes/origin/AJ
  remotes/origin/Anna2
  remotes/origin/Eleonora
  remotes/origin/HEAD -> origin/main
  remotes/origin/lastMain
  remotes/origin/main
  remotes/origin/shehriar
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git branch -d Anna2
error: Cannot delete branch 'Anna2' checked out at '/Users/milkchocolatejr/Desktop/CS479Fall24'
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git checkout main
Switched to branch 'main'
Your branch is up to date with 'origin/main'.
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git branch -d Anna2
Deleted branch Anna2 (was a346618).
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git checkout Anna2
branch 'Anna2' set up to track 'origin/Anna2'.
Switched to a new branch 'Anna2'
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git checkout main  
Switched to branch 'main'
Your branch is up to date with 'origin/main'.
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git branch -d Anna2
warning: deleting branch 'Anna2' that has been merged to
         'refs/remotes/origin/Anna2', but not yet merged to HEAD.
Deleted branch Anna2 (was 8edbd6b).
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git checkout AAnna2     
error: pathspec 'AAnna2' did not match any file(s) known to git
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % git checkout Anna2 
branch 'Anna2' set up to track 'origin/Anna2'.
Switched to a new branch 'Anna2'
milkchocolatejr@Alexanders-MacBook-Air-4 CS479Fall24 % cd Final 
milkchocolatejr@Alexanders-MacBook-Air-4 Final % ls
Classes.pde		Graphs.pde		data
FileOutput.pde		Main.pde		sketch.properties
FinalArduino		Replay.pde
Functions.pde		Variables.pde
milkchocolatejr@Alexanders-MacBook-Air-4 Final % cd FinalArduino 
milkchocolatejr@Alexanders-MacBook-Air-4 FinalArduino % ls
FinalArduino.ino
milkchocolatejr@Alexanders-MacBook-Air-4 FinalArduino % vim FinalArduino.ino 

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
<<<<<<< HEAD
=======
"FinalArduino.ino" 257L, 6729B
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
>>>>>>> main
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
