
int red = 9;
int green = 10;
int blue = 11; 

void setup() {
  pinMode(red, OUTPUT);
  pinMode(green, OUTPUT);
  pinMode(blue, OUTPUT);
}
void loop() {
  colorMix(1,0,0);
  delay(500);
  colorMix(1,0,1);
  delay(500);
  colorMix(0,0,1);
  delay(500);
  colorMix(0,1,1);
  delay(500);
  colorMix(0,1,0);
  delay(500);
  colorMix(1,1,0);
  delay(500);
  colorMix(1,1,1);
  delay(500);
  colorMix(0,0,0);
  delay(500);}
void colorMix(bool redColor,bool blueColor,bool greenColor)
{
  digitalWrite(red,redColor);
  digitalWrite(blue,blueColor);
  digitalWrite(green,greenColor);
}