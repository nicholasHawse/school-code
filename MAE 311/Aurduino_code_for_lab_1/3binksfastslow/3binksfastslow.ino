void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(13, OUTPUT);
}
// the loop function runs over and over again forever
void loop() {
  for (int i = 1; i <= 3; i++) {
    // turn the pin on:
    digitalWrite(13, HIGH);
    delay(200);
    // turn the pin off:
    digitalWrite(13, LOW);
    delay(200);
  }
for (int i = 1; i <= 3; i++) {
    // turn the pin on:
    digitalWrite(13, HIGH);
    delay(500);
    // turn the pin off:
    digitalWrite(13, LOW);
    delay(500);
  }
  for (int i = 1; i <= 3; i++) {
    // turn the pin on:
    digitalWrite(13, HIGH);
    delay(200);
    // turn the pin off:
    digitalWrite(13, LOW);
    delay(200);
  }
  delay(5000);
}
