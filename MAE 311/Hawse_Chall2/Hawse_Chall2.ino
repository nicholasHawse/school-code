// This code was written by Nicholas Hawse
//group members include: Nicholas Hawse, Jakobe Griffin
// lab section 13 2/10/25




const int ledPin = 11;          
const int buttonPin = 2;    

int buttonState = 0;           // button state
int lastButtonState = 0;       // Previous button state
unsigned long lastDebounceTime = 0;  // Last time the button was pressed
unsigned long debounceDelay = 50;    

int ledState = 0;              // LED state: 0 = Off, 1 = Fading, 2 = On
int fadeValue = 0;             // Current fade value (0-255)
int fadeDirection = 1;         // Direction of fading (1 for increasing, -1 for decreasing)
int fadeSpeed = 5;             // Speed of fading (higher values = slower fade)

void setup() {
  pinMode(ledPin, OUTPUT);     // LED pin as an output
  pinMode(buttonPin, INPUT);   // button pin as an input
  Serial.begin(9600);          // Start serial communication 
}

void loop() {
  int reading = digitalRead(buttonPin);  // Read the button state
  
  // Debounce logic: if button state changes, reset debounce timer
  if (reading != lastButtonState) {
    lastDebounceTime = millis();  // Reset the debounce timer
  }

  if ((millis() - lastDebounceTime) > debounceDelay) {
    if (reading != buttonState) {  // Button state has changed
      buttonState = reading;
      
      if (buttonState == HIGH) {  // Button was pressed
        ledState = (ledState + 1) % 3;  // Cycle through the LED states
        Serial.print("LED State: ");
        
      }
    }
  }

  lastButtonState = reading;  
  
  // Control LED based on the current state
  switch (ledState) {
    case 0:  
      analogWrite(ledPin, 0);  // Turn off the LED
      break;
      
    case 1:  // LED is fading in and out
      fadeValue += fadeDirection * fadeSpeed;  
      
      
      if (fadeValue <= 0 || fadeValue >= 255) {
        fadeDirection = -fadeDirection;
      }
      
      analogWrite(ledPin, fadeValue);  // Apply fade value to LED
      
      
      delay(10);  
      break;
      
    case 2:  
      analogWrite(ledPin, 255);  // LED on
      break;
  }
}
