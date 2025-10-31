const int switchPin = 2; // swithc monitors pin 2
const int ledPin = 13; // led is on pin 13
int buttonState; 
int lightState = 0; 
int blinkState = LOW;
long previousMillis= 0;
long interval = 1000;
unsigned long currentMillis = 0;
// 
void setup() {
  // put your setup code here, to run once:
pinMode(2,INPUT);
pinMode(ledPin,OUTPUT);
Serial.begin(9600);
buttonState= digitalRead(2);

}

void loop() {
  // put your main code here, to run repeatedly:
int  val = digitalRead(2);
delay(10);
int val2 = digitalRead(2);
if (val == val2){
  if (val != buttonState){
    if (val == LOW) {
     if (lightState == 0) {
      lightState = 1;
      Serial.println("blinking");
      currentMillis=0;
      previousMillis=0;
      blinkState= LOW;
     }
      else{
      lightState = 0;
      digitalWrite(ledPin,LOW);
      blinkState = LOW;
      Serial.println("Button just pressed light off");
    }
  }
  }

    }
if (lightState == 1) {
  currentMillis = millis();
  if (currentMillis - previousMillis > interval) {
    previousMillis = currentMillis;
    if(blinkState == LOW)
    blinkState = HIGH;
    else
    blinkState = LOW;
digitalWrite(ledPin,blinkState);
  }
}
buttonState = val;
}
