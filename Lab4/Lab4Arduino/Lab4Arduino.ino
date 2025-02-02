/*
   Arduino and MPU6050 Accelerometer and Gyroscope Sensor Tutorial
   by Dejan, https://howtomechatronics.com
*/
#include <Wire.h>
const int MPU = 0x68; // MPU6050 I2C address
const int MF_PIN = 0;
const int LF_PIN = 1;
const int MM_PIN = 2;
const int HEEL_PIN = 3;

const int MF_LED_PIN = 3;
const int LF_LED_PIN = 6;
const int MM_LED_PIN = 9;
const int HEEL_LED_PIN = 10;

float AccX, AccY, AccZ;
float GyroX, GyroY, GyroZ;
float accAngleX, accAngleY, gyroAngleX, gyroAngleY, gyroAngleZ;
float roll, pitch, yaw;
float AccErrorX, AccErrorY, GyroErrorX, GyroErrorY, GyroErrorZ;
float elapsedTime, currentTime, previousTime;
float MF, LF, MM, HEEL;
int c = 0;

void setup() {
  Serial.begin(115200);
  Wire.begin();                      // Initialize comunication
  Wire.beginTransmission(MPU);       // Start communication with MPU6050 // MPU=0x68
  Wire.write(0x6B);                  // Talk to the register 6B
  Wire.write(0x00);                  // Make reset - place a 0 into the 6B register
  Wire.endTransmission(true);        //end the transmission

  // Set LED pins as outputs
  pinMode(MF_LED_PIN, OUTPUT);
  pinMode(LF_LED_PIN, OUTPUT);
  pinMode(MM_LED_PIN, OUTPUT);
  pinMode(HEEL_LED_PIN, OUTPUT);
  /*
  // Configure Accelerometer Sensitivity - Full Scale Range (default +/- 2g)
  Wire.beginTransmission(MPU);
  Wire.write(0x1C);                  //Talk to the ACCEL_CONFIG register (1C hex)
  Wire.write(0x10);                  //Set the register bits as 00010000 (+/- 8g full scale range)
  Wire.endTransmission(true);
  // Configure Gyro Sensitivity - Full Scale Range (default +/- 250deg/s)
  Wire.beginTransmission(MPU);
  Wire.write(0x1B);                   // Talk to the GYRO_CONFIG register (1B hex)
  Wire.write(0x10);                   // Set the register bits as 00010000 (1000deg/s full scale)
  Wire.endTransmission(true);
  delay(20);
  */
  // Call this function if you need to get the IMU error values for your module
  calculate_IMU_error();
  // delay(20);
}

void loop(){
  //Printing output
  readControllerInput();
  printInput();
  controlLEDs();
  delay(150);
}

void readControllerInput(){
  //Reading Force Sensors
  MM = analogRead(MM_PIN);
  MF = analogRead(MF_PIN);
  LF = analogRead(LF_PIN);
  HEEL = analogRead(HEEL_PIN);

  //Reading Accel Sensor
  Wire.beginTransmission(MPU);
  Wire.write(0x3B);
  Wire.endTransmission(false);
  Wire.requestFrom(MPU, 6, true);
  AccX = (Wire.read() << 8 | Wire.read()) / 16384.0 ;
  AccY = (Wire.read() << 8 | Wire.read()) / 16384.0 ;
  AccZ = (Wire.read() << 8 | Wire.read()) / 16384.0 ;

  //Reading Gyro Sensor
  Wire.beginTransmission(MPU);
  Wire.write(0x43);
  Wire.endTransmission(false);
  Wire.requestFrom(MPU, 6, true);
  GyroX = Wire.read() << 8 | Wire.read();
  GyroY = Wire.read() << 8 | Wire.read();
  GyroZ = Wire.read() << 8 | Wire.read();
}

void printInput(){
  //Printing Acc
  Serial.print(AccX);
  pS();
  Serial.print(AccY);
  pS();
  Serial.print(AccZ);
  pS();

  //Printing Gyro
  Serial.print(GyroX);
  pS();
  Serial.print(GyroY);
  pS();
  Serial.print(GyroZ);
  pS();

  //Printing Sensors
  Serial.print(MF);
  pS();
  Serial.print(LF);
  pS();
  Serial.print(MM);
  pS();
  Serial.print(HEEL);
  Serial.println("");
}


//Shorthand for printSpace
void pS(){
  Serial.print(" ");
}


float readAccX(){
  return 0.0;
}
void calculate_IMU_error() {
  // We can call this funtion in the setup section to calculate the accelerometer and gyro data error. From here we will get the error values used in the above equations printed on the Serial Monitor.
  // Note that we should place the IMU flat in order to get the proper values, so that we then can the correct values
  // Read accelerometer values 200 times
  while (c < 200) {
    Wire.beginTransmission(MPU);
    Wire.write(0x3B);
    Wire.endTransmission(false);
    Wire.requestFrom(MPU, 6, true);
    AccX = (Wire.read() << 8 | Wire.read()) / 16384.0 ;
    AccY = (Wire.read() << 8 | Wire.read()) / 16384.0 ;
    AccZ = (Wire.read() << 8 | Wire.read()) / 16384.0 ;
    // Sum all readings
    AccErrorX = AccErrorX + ((atan((AccY) / sqrt(pow((AccX), 2) + pow((AccZ), 2))) * 180 / PI));
    AccErrorY = AccErrorY + ((atan(-1 * (AccX) / sqrt(pow((AccY), 2) + pow((AccZ), 2))) * 180 / PI));
    c++;
  }
  //Divide the sum by 200 to get the error value
  AccErrorX = AccErrorX / 200;
  AccErrorY = AccErrorY / 200;
  c = 0;
  // Read gyro values 200 times
  while (c < 200) {
    Wire.beginTransmission(MPU);
    Wire.write(0x43);
    Wire.endTransmission(false);
    Wire.requestFrom(MPU, 6, true);
    GyroX = Wire.read() << 8 | Wire.read();
    GyroY = Wire.read() << 8 | Wire.read();
    GyroZ = Wire.read() << 8 | Wire.read();
    // Sum all readings
    GyroErrorX = GyroErrorX + (GyroX / 131.0);
    GyroErrorY = GyroErrorY + (GyroY / 131.0);
    GyroErrorZ = GyroErrorZ + (GyroZ / 131.0);
    c++;
  }
  //Divide the sum by 200 to get the error value
  GyroErrorX = GyroErrorX / 200;
  GyroErrorY = GyroErrorY / 200;
  GyroErrorZ = GyroErrorZ / 200;
}

void controlLEDs() {
  // Map FSR readings (0-1023) to LED intensity (0-255)
  int MF_LED_intensity = map(MF, 0, 1023, 0, 255);
  int LF_LED_intensity = map(LF, 0, 1023, 0, 255);
  int MM_LED_intensity = map(MM, 0, 1023, 0, 255);
  int HEEL_LED_intensity = map(HEEL, 0, 1023, 0, 255);

  // Set LED brightness
  analogWrite(MF_LED_PIN, MF_LED_intensity);
  analogWrite(LF_LED_PIN, LF_LED_intensity);
  analogWrite(MM_LED_PIN, MM_LED_intensity);
  analogWrite(HEEL_LED_PIN, HEEL_LED_intensity);
}
