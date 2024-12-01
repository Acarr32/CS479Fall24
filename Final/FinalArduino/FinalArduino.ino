         #include <Wire.h>

// Analog 0: EMG
const int THM_PIN = 1;    // Analog 1: thumb FSR - THM
const int IND_PIN = 2;    // Analog 2: index FSR - IND
const int MID_PIN = 3;    // Analog 3: middle FSR - MID
const int FLX_PIN = 4;    // Analog 4: flex sensor - FXS

const int MPU = 0x68; // MPU6050 I2C address

float thm, ind, mid;
float flx, vtg;

float AccX, AccY, AccZ;
float GyroX, GyroY, GyroZ;
float accAngleX, accAngleY, gyroAngleX, gyroAngleY, gyroAngleZ;
float roll, pitch, yaw;
float AccErrorX, AccErrorY, GyroErrorX, GyroErrorY, GyroErrorZ;
float elapsedTime, currentTime, previousTime;
int c = 0;

void setup(){
  Serial.begin(115200);

  // MPU6050 transmission 
  Wire.begin();                     
  Wire.beginTransmission(MPU);
  Wire.write(0x6B);
  Wire.write(0x00);
  Wire.endTransmission(true);

  calculate_IMU_error();
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

// Prints the input in the serial monitor
void printInput() {
  // Serial.print("FSR (Thm, Ind, Mid): ");
  Serial.print(thm);
  Serial.print(", ");
  Serial.print(ind);
  Serial.print(", ");
  Serial.print(mid);
  Serial.print(", ");
  // Serial.print(" || Flex (ADC, V): ");
  Serial.print(flx);
  Serial.print(", ");
  Serial.print(vtg);
  Serial.print(", ");
  // Serial.print(" || Acc (X, Y, Z): ");
  Serial.print(AccX);
  Serial.print(", ");
  Serial.print(AccY);
  Serial.print(", ");
  Serial.print(AccZ);
  Serial.print(", ");
  // Serial.print(" || Gyro (X, Y, Z): ");
  Serial.print(GyroX);
  Serial.print(", ");
  Serial.print(GyroY);
  Serial.print(", ");
  Serial.println(GyroZ);
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
