void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(12, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(10, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
  digitalWrite(12, HIGH);
  delay(500);
  digitalWrite(11, HIGH);
  digitalWrite(12, LOW);
  delay(500);
  digitalWrite(10, HIGH);
  digitalWrite(11, LOW);
  delay(500);
  digitalWrite(10, LOW);


  
}
