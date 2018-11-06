const int posOne = 8;
const int posTwo = 7;
const int ledPin1 = 2;
const int ledPin2 = 3;

int stateA, stateB;

void setup() {
  // put your setup code here, to run once:
pinMode(posOne, INPUT_PULLUP);
pinMode(posTwo, INPUT_PULLUP);
pinMode(ledPin1, OUTPUT);
pinMode(ledPin2, OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
stateA = digitalRead(posOne);
stateB = digitalRead(posTwo);

if ((stateA == 1) && (stateB==0)){
  digitalWrite(ledPin1,HIGH);
  digitalWrite(ledPin2,LOW);
  Serial.println("stateA");
}
if ((stateB == 1) && (stateA==0)){
  digitalWrite(ledPin2,HIGH);
  digitalWrite(ledPin1,LOW);
  Serial.println("stateB");
}
if ((stateA == 1) && (stateB==1)){
  digitalWrite(ledPin1,LOW);
  digitalWrite(ledPin2,LOW);
  Serial.println("off");
}
}
