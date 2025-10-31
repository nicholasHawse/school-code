const int switchPin = 2; // swithc monitors pin 2
const int ledPin = 13; // led is on pin 13
int buttonState; 
int lightState = 0; // 
void setup() {
  // put your setup code here, to run once:
pinMode(2,INPUT);
pinMode(ledPin,OUTPUT);
Serial.begin(9600);
buttonState= digitalRead(2);

}

void loop() {
  // put your main code here, to run repeatedly:
int  val= digitalRead(2);
if (val != buttonState){
  if (val == LOW){
    if (lightState == 0) {
      lightState = 1;
      digitalWrite(ledPin, HIGH);
      Serial.println("Button Just pressed, light off");
    }
    else{
      lightState = 0;
      digitalWrite(ledPin,LOW);
      Serial.println("Button just pressed light off");
    }
  }
}
buttonState= val;
}