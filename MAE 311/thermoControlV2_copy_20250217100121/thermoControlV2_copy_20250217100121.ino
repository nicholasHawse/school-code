#include <MAX6675.h>  // Define the pins for MAX6675 thermocouple

const int dataPin   = 7;
const int clockPin  = 6;
const int selectPin = 5;

MAX6675 thermoCouple(selectPin, dataPin, clockPin);

const int redPin = 9;
const int greenPin = 10;
const int bluePin = 11;

int state = 0;

unsigned long previousMillis = 0; // Used for non-blocking timing
unsigned long interval = 1000; // Interval for patternState1
int pattern1Step = 0;

int intensity = 0; // Variable for intensity in patternState2
unsigned long previousMillisPattern2 = 0; // Timing for patternState2

// Flag to track if the temperature has crossed 14°C
bool hasCrossed14 = false;

// Variables for Pattern State 2
unsigned long startMillis = 0;
int stateTwoCount = 0;  
unsigned long stateTwoInterval = 0;
int stateTwoLight = 0; // Intensity variable
const float formulaFactor = 40.0;
const float exponent = 1.732;

void setup() {
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);

  // Start Serial communication for debugging
  Serial.begin(9600);
  SPI.begin();
  thermoCouple.begin();
  thermoCouple.setSPIspeed(4000000);
}

void loop() {
  // Read the temperature from the MAX6675 thermocouple
  int status = thermoCouple.read();
  float temperature = thermoCouple.getTemperature();

  // Debugging: Print the temperature to the Serial Monitor
  Serial.print("Temperature: ");
  Serial.print(temperature);
  Serial.println(" C");

  // Check if the temperature crosses from below 14 to above 14
  if (temperature > 14 && !hasCrossed14) {
    state++; // Increment state
    if (state > 2) state = 0;  // Cycle back to state 0

    // Print the new state for debugging
    Serial.print("State changed to: ");
    Serial.println(state);

    // Set the flag to indicate that the temperature has crossed 14°C
    hasCrossed14 = true;

    // Wait for a short period to avoid triggering the state change too quickly
    delay(500);  // Adjust the delay as necessary
  }

  // Check if the temperature goes below 14°C again, so we can reset the flag
  if (temperature <= 14) {
    hasCrossed14 = false;
  }

  // Handle the states
  switch (state) {
    case 0:
      Serial.println("State 0: LED at low PWM (5)");
      analogWrite(redPin, 5);
      analogWrite(greenPin, 5);
      analogWrite(bluePin, 5);
      break;
    case 1:
      Serial.println("State 1: Running patternState1");
      patternState1();
      break;
    case 2:
      Serial.println("State 2: Running patternState2");
      patternState2();
      break;
  }
}

void patternState1() {
  unsigned long currentMillis = millis();

  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;  // Save the last time we updated

    switch (pattern1Step) {
      case 0:
        // Step 1: Red at 100, Green at 0, Blue at 0 for 1000 ms
        analogWrite(redPin, 100);
        analogWrite(greenPin, 0);
        analogWrite(bluePin, 0);
        pattern1Step = 1;
        interval = 1000;  // Next step interval
        break;
      case 1:
        // Step 2: All LEDs at full brightness for 350 ms
        analogWrite(redPin, 255);
        analogWrite(greenPin, 255);
        analogWrite(bluePin, 255);
        pattern1Step = 2;
        interval = 350;  // Next step interval
        break;
      case 2:
        // Step 3: All LEDs off for 150 ms
        digitalWrite(redPin, 0);
        digitalWrite(greenPin, 0);
        digitalWrite(bluePin, 0);
        pattern1Step = 3;
        interval = 150;  // Next step interval
        break;
      case 3:
        // Step 2: All LEDs at full brightness for 350 ms
        analogWrite(redPin, 255);
        analogWrite(greenPin, 255);
        analogWrite(bluePin, 255);
        pattern1Step = 4;
        interval = 350;  // Next step interval
        break;
      case 4:
        // Step 3: All LEDs off for 150 ms
        digitalWrite(redPin, 0);
        digitalWrite(greenPin, 0);
        digitalWrite(bluePin, 0);
        pattern1Step = 5;
        interval = 150;  // Next step interval
        break;
      case 5:
        // Step 4: Blue at 100, Red and Green at 0 for 1000 ms
        analogWrite(redPin, 0);
        analogWrite(greenPin, 0);
        analogWrite(bluePin, 100);
        pattern1Step = 0;  // Reset to step 0 to repeat the pattern
        interval = 1000;   // Repeat after 1000 ms
        break;
    }
  }
}

void patternState2() {
  unsigned long currentMillis = millis();
  
  // Calculate intensity using the formula
  stateTwoLight = round(pow(((currentMillis - startMillis) / formulaFactor), exponent)); // Calculate intensity

  // Perform different LED patterns based on `stateTwoCount`
  if (stateTwoCount == 1) { // Step 1: Magenta
    analogWrite(redPin, stateTwoLight);
    analogWrite(greenPin, 0);
    analogWrite(bluePin, stateTwoLight);
    stateTwoInterval = 1000; // Set interval for this step
  }
  else if (stateTwoCount == 2) { // Step 2: Red
    analogWrite(redPin, stateTwoLight);
    analogWrite(greenPin, 0);
    analogWrite(bluePin, 0);
    stateTwoInterval = 1000; // Set interval for this step
  }
  else if (stateTwoCount == 3) { // Step 3: Cyan
    analogWrite(redPin, 0);
    analogWrite(greenPin, stateTwoLight);
    analogWrite(bluePin, stateTwoLight);
    stateTwoInterval = 1000; // Set interval for this step
  }
  else { // Reset and loop through steps
    stateTwoCount = 0;
    stateTwoInterval = 0; // Reset interval to zero
  }

  // Check if the interval for the step has passed
  if (currentMillis - startMillis > stateTwoInterval) {
    stateTwoCount++;  // Move to next step
    startMillis = millis(); // Reset the timer for next interval
  }
}
