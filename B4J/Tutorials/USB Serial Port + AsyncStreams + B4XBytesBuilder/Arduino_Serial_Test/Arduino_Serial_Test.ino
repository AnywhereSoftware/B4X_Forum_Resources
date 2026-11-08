int cnt1 = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(500000);

  Serial.println();

  Serial.println("Start");
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.print(F("Complete message ready to use - "));
  Serial.println(cnt1, DEC);

  cnt1++; 
}
