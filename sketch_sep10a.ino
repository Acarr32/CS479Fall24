int counter = 0;
void setup() {
Serial.begin(115200);
delay(500);
}
void loop() {
Serial.println(counter);
counter++;
delay(500);
}
