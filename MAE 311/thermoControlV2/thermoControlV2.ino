#include <max6675.h>  // Define the pins for MAX6675 thermocouple
#define MAX6675_CS    10  // Chip Select Pin
#define MAX6675_CLK   13  // Clock Pin
#define MAX6675_DO    12  // Data Output Pin

// Create an instance of the MAX6675 object
MAX6675 thermocouple(MAX6675_CLK, MAX6675_CS, MAX6675_DO);

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

void setup() {
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);

  // Start Serial communication for debugging
  Serial.begin(9600);
}

void loop() {
  // Read the temperature from the MAX6675 thermocouple
  float temperature = thermocouple.readCelsius();

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

  // Update the LED pattern based on timing
  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis; // Save the last time we updated

    switch (pattern1Step) {
      case 0:
        analogWrite(redPin, 0);
        analogWrite(greenPin, 255);
        analogWrite(bluePin, 0);
        pattern1Step = 1;
        interval = 250; // Change interval for next step
        break;
      case 1:
        analogWrite(redPin, 255);
        analogWrite(greenPin, 0);
        analogWrite(bluePin, 255);
        pattern1Step = 2;
        interval = 1000; // Change interval for next step
        break;
      case 2:
        analogWrite(redPin, 255);
        analogWrite(greenPin, 0);
        analogWrite(bluePin, 0);
        pattern1Step = 0;
        interval = 1000; // Change interval for next step
        break;
    }
  }
}

void patternState2() {
  unsigned long currentMillis = millis();

  // Update the LED pattern every 20ms
  if (currentMillis - previousMillisPattern2 >= 20) { // 20ms update
    previousMillisPattern2 = currentMillis; // Save the last time we updated

    // Gradually increase the intensity
    if (intensity < 255) {
      intensity += 5; // Increase intensity gradually
    } else {
      intensity = 0; // Reset intensity when it reaches 255
    }

    // Non-linear intensity adjustment (cubic function)
    int redValue = pow(intensity / 255.0, 3) * 255;
    int greenValue = pow(intensity / 255.0, 3) * 255;
    int blueValue = pow(intensity / 255.0, 3) * 255;

    // Update the LEDs with the calculated non-linear intensity values
    analogWrite(redPin, redValue);
    analogWrite(greenPin, greenValue);
    analogWrite(bluePin, blueValue);
  }
}
