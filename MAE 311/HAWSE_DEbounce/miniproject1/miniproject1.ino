const int redPin = 9;
const int greenPin = 10;
const int bluePin = 11;
const int buttonPin = 2;

int state = 0;  
int lastButtonState = HIGH; // Button is not pressed (pull-up resistor mode)
int currentButtonState = HIGH;
unsigned long lastDebounceTime = 0;
unsigned long debounceDelay = 50; // Debounce delay to prevent button bounce

bool buttonPressed = false;

unsigned long previousMillis = 0; // Used for non-blocking timing
unsigned long interval = 1000; // Interval for patternState1
int pattern1Step = 0;

int intensity = 0; // Variable for intensity in patternState2
unsigned long previousMillisPattern2 = 0; // Timing for patternState2

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
