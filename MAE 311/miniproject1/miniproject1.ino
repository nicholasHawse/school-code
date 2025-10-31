const int redPin = 9;
const int greenPin = 10;
const int bluePin = 11;
const int buttonPin = 2;

// Variables for timing and pattern steps
unsigned long previousMillisPattern2 = 0;
int step = 0;
unsigned long lastChangeTime = 0;  // For keeping track of time for the formula
long startMillis = 0;       
// LED intensity formula constants
const float maxIntensity = 255;
const float formulaFactor = 40.0;
const float exponent = 1.732;
int stateTwoLight = 0;
int state = 0;  
int lastButtonState = HIGH; // Button is not pressed (pull-up resistor mode)
int currentButtonState = HIGH;
unsigned long lastDebounceTime = 0;
unsigned long debounceDelay = 50; // Debounce delay to prevent button bounce
int stateTwoCount = 0;      // State 2 counter
int stateTwoInterval = 0;   // State 2 interval

bool buttonPressed = false;

unsigned long previousMillis = 0; // Used for non-blocking timing
unsigned long interval = 1000; // Interval for patternState1
int pattern1Step = 0;

int intensity = 0; // Variable for intensity in patternState2


void setup() {
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);
  pinMode(buttonPin, INPUT_PULLUP);  // Internal pull-up resistor enabled

  // Start Serial communication for debugging
  Serial.begin(9600);
}

void loop() {
  int reading = digitalRead(buttonPin);
  
  // Debug: Print the raw button state reading
  Serial.print("Button reading: ");
  Serial.println(reading);
  
  // If the button state has changed
  if (reading != lastButtonState) {
    Serial.println("Button state changed");
    lastDebounceTime = millis(); // Reset debounce timer
  }

  // Check if enough time has passed to debounce the button
  if ((millis() - lastDebounceTime) > debounceDelay) {
    // If the button state has actually changed
    if (reading != currentButtonState) {
      currentButtonState = reading;

      // Only process the button press if it's LOW (pressed) and it's not already processed
      if (currentButtonState == LOW && !buttonPressed) {
        state++; // Increment state
        if (state > 2) state = 0;  // Cycle back to state 0
        buttonPressed = true;  // Prevent multiple state changes from holding the button

        // Print the new state for debugging
        Serial.print("State changed to: ");
        Serial.println(state);
      }
    }
  }

  // If the button is released, allow the state change to be processed again
  if (currentButtonState == HIGH) {
    buttonPressed = false;
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

  // Save the current reading for the next loop
  lastButtonState = reading;
}

// State 1: LEDs follow the pattern from Table 1
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

// Function to handle Pattern State 2
void patternState2() {
  unsigned long currentMillis = millis();
  
  // Calculate intensity using formula
  stateTwoLight = round(pow(((currentMillis - startMillis) / formulaFactor), exponent)); // calculate Intensity

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